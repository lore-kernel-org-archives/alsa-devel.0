From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 18/34] pcm: remove alloca() from
	snd_spcm_init_duplex()
Date: Thu, 14 Jul 2016 23:07:35 +0900
Message-ID: <1468505271-5769-19-git-send-email-o-takashi@sakamocchi.jp>
References: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id B92CE265BA3
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2016 16:08:09 +0200 (CEST)
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
 src/pcm/pcm_simple.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/src/pcm/pcm_simple.c b/src/pcm/pcm_simple.c
index 3ae24ff..8985987 100644
--- a/src/pcm/pcm_simple.c
+++ b/src/pcm/pcm_simple.c
@@ -218,16 +218,13 @@ int snd_spcm_init_duplex(snd_pcm_t *playback_pcm,
 			 snd_spcm_duplex_type_t duplex_type)
 {
 	int err, i;
-	snd_pcm_hw_params_t *hw_params;
-	snd_pcm_sw_params_t *sw_params;
+	snd_pcm_hw_params_t hw_params = {0};
+	snd_pcm_sw_params_t sw_params = {0};
 	unsigned int rrate;
 	unsigned int xbuffer_time, buffer_time[2];
 	unsigned int period_time[2];
 	snd_pcm_t *pcms[2];
 
-	snd_pcm_hw_params_alloca(&hw_params);
-	snd_pcm_sw_params_alloca(&sw_params);
-
 	assert(playback_pcm);
 	assert(capture_pcm);
 	assert(rate >= 5000 && rate <= 192000);
@@ -247,7 +244,7 @@ int snd_spcm_init_duplex(snd_pcm_t *playback_pcm,
 		buffer_time[i] = xbuffer_time;
 		period_time[i] = i > 0 ? period_time[0] : 0;
 		rrate = rate;
-		err = set_hw_params(pcms[i], hw_params,
+		err = set_hw_params(pcms[i], &hw_params,
 				    &rrate, channels, format, subformat,
 				    &buffer_time[i], &period_time[i], access);
 		if (err < 0)
@@ -266,7 +263,7 @@ int snd_spcm_init_duplex(snd_pcm_t *playback_pcm,
 	 */
       __sw_params:
 	for (i = 0; i < 2; i++) {
-		err = set_sw_params(pcms[i], sw_params, xrun_type);
+		err = set_sw_params(pcms[i], &sw_params, xrun_type);
 		if (err < 0)
 			return err;
 	}
-- 
2.7.4
