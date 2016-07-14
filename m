From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 13/34] pcm: remove alloca() from
	snd_pcm_hw_change_timer()
Date: Thu, 14 Jul 2016 23:07:30 +0900
Message-ID: <1468505271-5769-14-git-send-email-o-takashi@sakamocchi.jp>
References: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 7231B2659A9
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

Both of alloca() and automatic variables keeps storages on stack, while
the former generates more instructions than the latter. It's better to use
the latter if the size of storage is computable at pre-compile or compile
time; i.e. just for structures.

This commit obsolete usages of alloca() with automatic variables.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_hw.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 0daaccc..864d5fa 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -351,12 +351,11 @@ static void snd_pcm_hw_close_timer(snd_pcm_hw_t *hw)
 static int snd_pcm_hw_change_timer(snd_pcm_t *pcm, int enable)
 {
 	snd_pcm_hw_t *hw = pcm->private_data;
-	snd_timer_params_t *params;
+	snd_timer_params_t params = {0};
 	unsigned int suspend, resume;
 	int err;
 	
 	if (enable) {
-		snd_timer_params_alloca(&params);
 		err = snd_timer_hw_open(&hw->period_timer,
 				"hw-pcm-period-event",
 				SND_TIMER_CLASS_PCM, SND_TIMER_SCLASS_NONE,
@@ -406,11 +405,11 @@ static int snd_pcm_hw_change_timer(snd_pcm_t *pcm, int enable)
 				resume = 1<<SND_TIMER_EVENT_MCONTINUE;
 			}
 		}
-		snd_timer_params_set_auto_start(params, 1);
-		snd_timer_params_set_ticks(params, 1);
-		snd_timer_params_set_filter(params, (1<<SND_TIMER_EVENT_TICK) |
+		snd_timer_params_set_auto_start(&params, 1);
+		snd_timer_params_set_ticks(&params, 1);
+		snd_timer_params_set_filter(&params, (1<<SND_TIMER_EVENT_TICK) |
 					    suspend | resume);
-		err = snd_timer_params(hw->period_timer, params);
+		err = snd_timer_params(hw->period_timer, &params);
 		if (err < 0) {
 			snd_pcm_hw_close_timer(hw);
 			return err;
-- 
2.7.4
