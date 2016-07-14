From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 12/34] pcm: change code formatting for
	snd_pcm_hw_change_timer()
Date: Thu, 14 Jul 2016 23:07:29 +0900
Message-ID: <1468505271-5769-13-git-send-email-o-takashi@sakamocchi.jp>
References: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 6310F265926
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2016 16:08:08 +0200 (CEST)
In-Reply-To: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This commit applies code format according to typical and moderate rule,
for snd_pcm_hw_change_timer().

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_hw.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 5aa987b..0daaccc 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -357,9 +357,19 @@ static int snd_pcm_hw_change_timer(snd_pcm_t *pcm, int enable)
 	
 	if (enable) {
 		snd_timer_params_alloca(&params);
-		err = snd_timer_hw_open(&hw->period_timer, "hw-pcm-period-event", SND_TIMER_CLASS_PCM, SND_TIMER_SCLASS_NONE, hw->card, hw->device, (hw->subdevice << 1) | (pcm->stream & 1), SND_TIMER_OPEN_NONBLOCK | SND_TIMER_OPEN_TREAD);
+		err = snd_timer_hw_open(&hw->period_timer,
+				"hw-pcm-period-event",
+				SND_TIMER_CLASS_PCM, SND_TIMER_SCLASS_NONE,
+				hw->card, hw->device,
+				(hw->subdevice << 1) | (pcm->stream & 1),
+				SND_TIMER_OPEN_NONBLOCK | SND_TIMER_OPEN_TREAD);
 		if (err < 0) {
-			err = snd_timer_hw_open(&hw->period_timer, "hw-pcm-period-event", SND_TIMER_CLASS_PCM, SND_TIMER_SCLASS_NONE, hw->card, hw->device, (hw->subdevice << 1) | (pcm->stream & 1), SND_TIMER_OPEN_NONBLOCK);
+			err = snd_timer_hw_open(&hw->period_timer,
+				"hw-pcm-period-event",
+				SND_TIMER_CLASS_PCM, SND_TIMER_SCLASS_NONE,
+				hw->card, hw->device,
+				(hw->subdevice << 1) | (pcm->stream & 1),
+				SND_TIMER_OPEN_NONBLOCK);
 			return err;
 		}
 		if (snd_timer_poll_descriptors_count(hw->period_timer) != 1) {
@@ -368,7 +378,8 @@ static int snd_pcm_hw_change_timer(snd_pcm_t *pcm, int enable)
 		}
 		hw->period_timer_pfd.events = POLLIN;
  		hw->period_timer_pfd.revents = 0;
-		snd_timer_poll_descriptors(hw->period_timer, &hw->period_timer_pfd, 1);
+		snd_timer_poll_descriptors(hw->period_timer,
+					   &hw->period_timer_pfd, 1);
 		hw->period_timer_need_poll = 0;
 		suspend = 1<<SND_TIMER_EVENT_MSUSPEND;
 		resume = 1<<SND_TIMER_EVENT_MRESUME;
@@ -377,10 +388,12 @@ static int snd_pcm_hw_change_timer(snd_pcm_t *pcm, int enable)
 		 */
 		{
 			int ver = 0;
-			ioctl(hw->period_timer_pfd.fd, SNDRV_TIMER_IOCTL_PVERSION, &ver);
-			/* In older versions, check via poll before read() is needed
-                         * because of the confliction between TIMER_START and
-                         * FIONBIO ioctls.
+			ioctl(hw->period_timer_pfd.fd,
+			      SNDRV_TIMER_IOCTL_PVERSION, &ver);
+			/*
+			 * In older versions, check via poll before read() is
+			 * needed because of the confliction between
+			 * TIMER_START and FIONBIO ioctls.
                          */
 			if (ver < SNDRV_PROTOCOL_VERSION(2, 0, 4))
 				hw->period_timer_need_poll = 1;
-- 
2.7.4
