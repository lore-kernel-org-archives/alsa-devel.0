From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 04/34] pcm: remove alloca() from
	snd_pcm_get_params
Date: Thu, 14 Jul 2016 23:07:21 +0900
Message-ID: <1468505271-5769-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id C69F926584E
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2016 16:08:06 +0200 (CEST)
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
 src/pcm/pcm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 23655e6..f832399 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -8476,17 +8476,16 @@ int snd_pcm_get_params(snd_pcm_t *pcm,
                        snd_pcm_uframes_t *buffer_size,
                        snd_pcm_uframes_t *period_size)
 {
-	snd_pcm_hw_params_t *hw;
+	snd_pcm_hw_params_t params = {0};
 	int err;
 
 	assert(pcm);
-	snd_pcm_hw_params_alloca(&hw);
-	err = snd_pcm_hw_params_current(pcm, hw);
+	err = snd_pcm_hw_params_current(pcm, &params);
 	if (err < 0)
 	        return err;
-	err = INTERNAL(snd_pcm_hw_params_get_buffer_size)(hw, buffer_size);
+	err = INTERNAL(snd_pcm_hw_params_get_buffer_size)(&params, buffer_size);
 	if (err < 0)
 		return err;
-	return INTERNAL(snd_pcm_hw_params_get_period_size)(hw, period_size,
+	return INTERNAL(snd_pcm_hw_params_get_period_size)(&params, period_size,
 							   NULL);
 }
-- 
2.7.4
