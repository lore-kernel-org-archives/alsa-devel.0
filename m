From: Alan Young <Alan.Young@IEE.org>
Subject: Re: Accurate delay reporting from dshare
Date: Wed, 2 Nov 2016 17:34:49 +0000
Message-ID: <581A23B9.3050609@IEE.org>
References: <5810BDF9.1020204@IEE.org> <s5hinseoygk.wl-tiwai@suse.de>
 <5819F566.2000404@IEE.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 0ED16265654
 for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2016 18:34:51 +0100 (CET)
Received: by mail-wm0-f68.google.com with SMTP id u144so4129631wmu.0
 for <alsa-devel@alsa-project.org>; Wed, 02 Nov 2016 10:34:51 -0700 (PDT)
In-Reply-To: <5819F566.2000404@IEE.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/11/16 14:17, Alan Young wrote:
> I am wondering if the earlier call to snd_pcm_dshare_sync_ptr(pcm), 
> which I guess forms the basis for the result of 
> snd_pcm_mmap_playback_delay(pcm), may be operating on a different set 
> of data (because of an intervening interrupt) to that returned by 
> snd_pcm_status().

How about this for a revised patch. It seems to be working well for me 
(so far). I am not suggesting that this should be considered final yet.

Alan.

diff --git a/src/pcm/pcm_dshare.c b/src/pcm/pcm_dshare.c
index 58e47bb..568448c 100644
--- a/src/pcm/pcm_dshare.c
+++ b/src/pcm/pcm_dshare.c
@@ -157,23 +157,14 @@ static void snd_pcm_dshare_sync_area(snd_pcm_t *pcm)
  /*
   *  synchronize hardware pointer (hw_ptr) with ours
   */
-static int snd_pcm_dshare_sync_ptr(snd_pcm_t *pcm)
+static int snd_pcm_dshare_sync_ptr0(snd_pcm_t *pcm, snd_pcm_uframes_t slave_hw_ptr)
  {
  	snd_pcm_direct_t *dshare = pcm->private_data;
-	snd_pcm_uframes_t slave_hw_ptr, old_slave_hw_ptr, avail;
+	snd_pcm_uframes_t old_slave_hw_ptr, avail;
  	snd_pcm_sframes_t diff;
  	
-	switch (snd_pcm_state(dshare->spcm)) {
-	case SND_PCM_STATE_DISCONNECTED:
-		dshare->state = SNDRV_PCM_STATE_DISCONNECTED;
-		return -ENODEV;
-	default:
-		break;
-	}
-	if (dshare->slowptr)
-		snd_pcm_hwsync(dshare->spcm);
  	old_slave_hw_ptr = dshare->slave_hw_ptr;
-	slave_hw_ptr = dshare->slave_hw_ptr = *dshare->spcm->hw.ptr;
+	dshare->slave_hw_ptr = slave_hw_ptr;
  	diff = slave_hw_ptr - old_slave_hw_ptr;
  	if (diff == 0)		/* fast path */
  		return 0;
@@ -207,6 +198,24 @@ static int snd_pcm_dshare_sync_ptr(snd_pcm_t *pcm)
  	return 0;
  }
  
+static int snd_pcm_dshare_sync_ptr(snd_pcm_t *pcm)
+{
+	snd_pcm_direct_t *dshare = pcm->private_data;
+
+	switch (snd_pcm_state(dshare->spcm)) {
+	case SND_PCM_STATE_DISCONNECTED:
+		dshare->state = SNDRV_PCM_STATE_DISCONNECTED;
+		return -ENODEV;
+	default:
+		break;
+	}
+
+	if (dshare->slowptr)
+		snd_pcm_hwsync(dshare->spcm);
+
+	return snd_pcm_dshare_sync_ptr0(pcm, *dshare->spcm->hw.ptr);
+}
+
  /*
   *  plugin implementation
   */
@@ -215,22 +224,24 @@ static int snd_pcm_dshare_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
  {
  	snd_pcm_direct_t *dshare = pcm->private_data;
  
+	memset(status, 0, sizeof(*status));
+	snd_pcm_status(dshare->spcm, status);
+
  	switch (dshare->state) {
  	case SNDRV_PCM_STATE_DRAINING:
  	case SNDRV_PCM_STATE_RUNNING:
-		snd_pcm_dshare_sync_ptr(pcm);
+		snd_pcm_dshare_sync_ptr0(pcm, status->hw_ptr);
+		status->delay += snd_pcm_mmap_playback_delay(pcm)
+				+ status->avail - dshare->spcm->buffer_size;
  		break;
  	default:
  		break;
  	}
-	memset(status, 0, sizeof(*status));
-	snd_pcm_status(dshare->spcm, status);
-	status->state = snd_pcm_state(dshare->spcm);
+
  	status->trigger_tstamp = dshare->trigger_tstamp;
  	status->avail = snd_pcm_mmap_playback_avail(pcm);
  	status->avail_max = status->avail > dshare->avail_max ? status->avail : dshare->avail_max;
  	dshare->avail_max = 0;
-	status->delay = snd_pcm_mmap_playback_delay(pcm);
  	return 0;
  }
  
