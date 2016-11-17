From: Alan Young <Alan.Young@IEE.org>
Subject: Re: [PATCH] pcm_dshare: Do not discard slave reported
 delay in status result.
Date: Thu, 17 Nov 2016 14:35:55 +0000
Message-ID: <8e7fb17d-bf2e-bb4b-8c75-7762f773abe6@IEE.org>
References: <5810BDF9.1020204@IEE.org> <s5hinseoygk.wl-tiwai@suse.de>
 <5819F566.2000404@IEE.org> <581A23B9.3050609@IEE.org>
 <ccd82798-b3be-7a4f-444d-47e8d5408324@IEE.org> <s5h4m36xurh.wl-tiwai@suse.de>
 <67297312-c4f9-e47d-4b58-893ddb55d2c8@IEE.org> <s5hbmxew5js.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id D74D22665B0
 for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2016 15:35:56 +0100 (CET)
Received: by mail-wm0-f68.google.com with SMTP id m203so21798303wma.3
 for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2016 06:35:56 -0800 (PST)
In-Reply-To: <s5hbmxew5js.wl-tiwai@suse.de>
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

snd_pcm_dshare_status() gets the underlying status from the slave PCM.
This may contain a delay value that includes elements such as codec and
other transfer delays. Use this as the base for the returned delay
value, adjusted for any frames buffered locally (within the dshare
plugin).

Note: snd_pcm_dshare_delay() is not updated.

Signed-off-by: Alan Young <consult.awy@gmail.com>
---
  src/pcm/pcm_dshare.c | 45 ++++++++++++++++++++++++++++-----------------
  1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/src/pcm/pcm_dshare.c b/src/pcm/pcm_dshare.c
index c5b3178..9b478a7 100644
--- a/src/pcm/pcm_dshare.c
+++ b/src/pcm/pcm_dshare.c
@@ -157,23 +157,14 @@ static void snd_pcm_dshare_sync_area(snd_pcm_t *pcm)
  /*
   *  synchronize hardware pointer (hw_ptr) with ours
   */
-static int snd_pcm_dshare_sync_ptr(snd_pcm_t *pcm)
+static int snd_pcm_dshare_sync_ptr0(snd_pcm_t *pcm, snd_pcm_uframes_t 
slave_hw_ptr)
  {
      snd_pcm_direct_t *dshare = pcm->private_data;
-    snd_pcm_uframes_t slave_hw_ptr, old_slave_hw_ptr, avail;
+    snd_pcm_uframes_t old_slave_hw_ptr, avail;
      snd_pcm_sframes_t diff;

-    switch (snd_pcm_state(dshare->spcm)) {
-    case SND_PCM_STATE_DISCONNECTED:
-        dshare->state = SNDRV_PCM_STATE_DISCONNECTED;
-        return -ENODEV;
-    default:
-        break;
-    }
-    if (dshare->slowptr)
-        snd_pcm_hwsync(dshare->spcm);
      old_slave_hw_ptr = dshare->slave_hw_ptr;
-    slave_hw_ptr = dshare->slave_hw_ptr = *dshare->spcm->hw.ptr;
+    dshare->slave_hw_ptr = slave_hw_ptr;
      diff = slave_hw_ptr - old_slave_hw_ptr;
      if (diff == 0)        /* fast path */
          return 0;
@@ -207,6 +198,24 @@ static int snd_pcm_dshare_sync_ptr(snd_pcm_t *pcm)
      return 0;
  }

+static int snd_pcm_dshare_sync_ptr(snd_pcm_t *pcm)
+{
+    snd_pcm_direct_t *dshare = pcm->private_data;
+
+    switch (snd_pcm_state(dshare->spcm)) {
+    case SND_PCM_STATE_DISCONNECTED:
+        dshare->state = SNDRV_PCM_STATE_DISCONNECTED;
+        return -ENODEV;
+    default:
+        break;
+    }
+
+    if (dshare->slowptr)
+        snd_pcm_hwsync(dshare->spcm);
+
+    return snd_pcm_dshare_sync_ptr0(pcm, *dshare->spcm->hw.ptr);
+}
+
  /*
   *  plugin implementation
   */
@@ -215,22 +224,24 @@ static int snd_pcm_dshare_status(snd_pcm_t *pcm, 
snd_pcm_status_t * status)
  {
      snd_pcm_direct_t *dshare = pcm->private_data;

+    memset(status, 0, sizeof(*status));
+    snd_pcm_status(dshare->spcm, status);
+
      switch (dshare->state) {
      case SNDRV_PCM_STATE_DRAINING:
      case SNDRV_PCM_STATE_RUNNING:
-        snd_pcm_dshare_sync_ptr(pcm);
+        snd_pcm_dshare_sync_ptr0(pcm, status->hw_ptr);
+        status->delay += snd_pcm_mmap_playback_delay(pcm)
+                + status->avail - dshare->spcm->buffer_size;
          break;
      default:
          break;
      }
-    memset(status, 0, sizeof(*status));
-    snd_pcm_status(dshare->spcm, status);
-    status->state = snd_pcm_state(dshare->spcm);
+
      status->trigger_tstamp = dshare->trigger_tstamp;
      status->avail = snd_pcm_mmap_playback_avail(pcm);
      status->avail_max = status->avail > dshare->avail_max ? 
status->avail : dshare->avail_max;
      dshare->avail_max = 0;
-    status->delay = snd_pcm_mmap_playback_delay(pcm);
      return 0;
  }

-- 
2.5.5
