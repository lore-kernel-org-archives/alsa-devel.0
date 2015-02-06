From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v5 04/10] ALSA: usb: update trigger timestamp
	on first non-zero URB submitted
Date: Fri,  6 Feb 2015 15:55:53 -0600
Message-ID: <1423259759-4100-5-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1423259759-4100-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 0016A265347
 for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2015 22:56:20 +0100 (CET)
In-Reply-To: <1423259759-4100-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The first URBs are submitted during the prepare stage. When .trigger is
called, the ALSA core saves a trigger tstamp that doesn't correspond to
the actual time when the samples are submitted. The trigger_tstamp is
now updated when the first data are submitted to avoid any time offsets.

A usb-specific trigger_tstamp_pending_update flag is used for now,
at some point the flag would need to move to the ALSA core, USB
is not the only interface where silent block transfers are programmed
as part of the prepare stage, with actual data enabled when .trigger
is called.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/usb/card.h | 2 ++
 sound/usb/pcm.c  | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index 97acb90..ef580b4 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -153,6 +153,8 @@ struct snd_usb_substream {
 		int channel;
 		int byte_idx;
 	} dsd_dop;
+
+	bool trigger_tstamp_pending_update; /* trigger timestamp being updated from initial estimate */
 };
 
 struct snd_usb_stream {
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 0d8aba5..b4ef410 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1464,6 +1464,14 @@ static void prepare_playback_urb(struct snd_usb_substream *subs,
 	subs->last_frame_number = usb_get_current_frame_number(subs->dev);
 	subs->last_frame_number &= 0xFF; /* keep 8 LSBs */
 
+	if (subs->trigger_tstamp_pending_update) {
+		/* this is the first actual URB submitted,
+		 * update trigger timestamp to reflect actual start time
+		 */
+		snd_pcm_gettime(runtime, &runtime->trigger_tstamp);
+		subs->trigger_tstamp_pending_update = false;
+	}
+
 	spin_unlock_irqrestore(&subs->lock, flags);
 	urb->transfer_buffer_length = bytes;
 	if (period_elapsed)
@@ -1550,6 +1558,7 @@ static int snd_usb_substream_playback_trigger(struct snd_pcm_substream *substrea
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
+		subs->trigger_tstamp_pending_update = true;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		subs->data_endpoint->prepare_data_urb = prepare_playback_urb;
 		subs->data_endpoint->retire_data_urb = retire_playback_urb;
-- 
1.9.1
