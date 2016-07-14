From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 17/34] pcm: remove alloca() from snd_spcm_init()
Date: Thu, 14 Jul 2016 23:07:34 +0900
Message-ID: <1468505271-5769-18-git-send-email-o-takashi@sakamocchi.jp>
References: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 2BC7F2659BF
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
index ce11083..3ae24ff 100644
--- a/src/pcm/pcm_simple.c
+++ b/src/pcm/pcm_simple.c
@@ -164,14 +164,11 @@ int snd_spcm_init(snd_pcm_t *pcm,
 		  snd_spcm_xrun_type_t xrun_type)
 {
 	int err;
-	snd_pcm_hw_params_t *hw_params;
-	snd_pcm_sw_params_t *sw_params;
+	snd_pcm_hw_params_t hw_params = {0};
+	snd_pcm_sw_params_t sw_params = {0};
 	unsigned int rrate;
 	unsigned int buffer_time;
 
-	snd_pcm_hw_params_alloca(&hw_params);
-	snd_pcm_sw_params_alloca(&sw_params);
-
 	assert(pcm);
 	assert(rate >= 5000 && rate <= 192000);
 	assert(channels >= 1 && channels <= 512);
@@ -180,13 +177,13 @@ int snd_spcm_init(snd_pcm_t *pcm,
 	err = set_buffer_time(latency, &buffer_time);
 	if (err < 0)
 		return err;
-	err = set_hw_params(pcm, hw_params,
+	err = set_hw_params(pcm, &hw_params,
 			    &rrate, channels, format, subformat,
 			    &buffer_time, NULL, access);
 	if (err < 0)
 		return err;
 
-	err = set_sw_params(pcm, sw_params, xrun_type);
+	err = set_sw_params(pcm, &sw_params, xrun_type);
 	if (err < 0)
 		return err;
 
-- 
2.7.4
