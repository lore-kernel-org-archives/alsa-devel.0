From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 04/10] ALSA: usb: update trigger timestamp
	on first non-zero URB submitted
Date: Fri, 30 Jan 2015 17:55:57 -0600
Message-ID: <1422662163-7391-5-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1422662163-7391-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DAD6261B19
 for <alsa-devel@alsa-project.org>; Sat, 31 Jan 2015 00:56:33 +0100 (CET)
In-Reply-To: <1422662163-7391-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/usb/pcm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 0d8aba5..7c36fc1 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1464,6 +1464,14 @@ static void prepare_playback_urb(struct snd_usb_substream *subs,
 	subs->last_frame_number = usb_get_current_frame_number(subs->dev);
 	subs->last_frame_number &= 0xFF; /* keep 8 LSBs */
 
+	if (runtime->trigger_tstamp_pending_update == 1) {
+		/* this is the first actual URB submitted,
+		 * update trigger timestamp to reflect actual start time
+		 */
+		snd_pcm_gettime(runtime, &runtime->trigger_tstamp);
+		runtime->trigger_tstamp_pending_update = 0;
+	}
+
 	spin_unlock_irqrestore(&subs->lock, flags);
 	urb->transfer_buffer_length = bytes;
 	if (period_elapsed)
@@ -1550,6 +1558,7 @@ static int snd_usb_substream_playback_trigger(struct snd_pcm_substream *substrea
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
+		substream->runtime->trigger_tstamp_pending_update = 1;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		subs->data_endpoint->prepare_data_urb = prepare_playback_urb;
 		subs->data_endpoint->retire_data_urb = retire_playback_urb;
-- 
1.9.1
