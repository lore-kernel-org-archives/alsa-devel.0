From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 10/34] pcm: remove alloca() from
	snd_pcm_direct_set_timer_params
Date: Thu, 14 Jul 2016 23:07:27 +0900
Message-ID: <1468505271-5769-11-git-send-email-o-takashi@sakamocchi.jp>
References: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 71100265960
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
 src/pcm/pcm_direct.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index 50d5539..c3925cc 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -1358,21 +1358,20 @@ int snd_pcm_direct_initialize_secondary_slave(snd_pcm_direct_t *dmix,
 
 int snd_pcm_direct_set_timer_params(snd_pcm_direct_t *dmix)
 {
-	snd_timer_params_t *params;
+	snd_timer_params_t params = {0};
 	unsigned int filter;
 	int ret;
 
-	snd_timer_params_alloca(&params);
-	snd_timer_params_set_auto_start(params, 1);
+	snd_timer_params_set_auto_start(&params, 1);
 	if (dmix->type != SND_PCM_TYPE_DSNOOP)
-		snd_timer_params_set_early_event(params, 1);
-	snd_timer_params_set_ticks(params, 1);
+		snd_timer_params_set_early_event(&params, 1);
+	snd_timer_params_set_ticks(&params, 1);
 	if (dmix->tread) {
 		filter = (1<<SND_TIMER_EVENT_TICK) |
 			 dmix->timer_events;
-		snd_timer_params_set_filter(params, filter);
+		snd_timer_params_set_filter(&params, filter);
 	}
-	ret = snd_timer_params(dmix->timer, params);
+	ret = snd_timer_params(dmix->timer, &params);
 	if (ret < 0) {
 		SNDERR("unable to set timer parameters");
 		return ret;
-- 
2.7.4
