From: Peter Korsgaard <peter@korsgaard.com>
Subject: [PATCH] ASoC: tlv320aic32x4: aic32x4_set_dai_fmt():
	drop unneded register access
Date: Tue, 24 Jun 2014 23:40:08 +0200
Message-ID: <1403646008-19930-1-git-send-email-peter@korsgaard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f173.google.com (mail-we0-f173.google.com
 [74.125.82.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 95CA726532C
 for <alsa-devel@alsa-project.org>; Tue, 24 Jun 2014 23:40:15 +0200 (CEST)
Received: by mail-we0-f173.google.com with SMTP id t60so1055166wes.18
 for <alsa-devel@alsa-project.org>; Tue, 24 Jun 2014 14:40:15 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@linaro.org
Cc: Peter Korsgaard <peter@korsgaard.com>
List-Id: alsa-devel@alsa-project.org

There's no point in reading the IFACE2 register when the result isn't used,
so drop it.

Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
---
 sound/soc/codecs/tlv320aic32x4.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 89e41d2..630367f 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -336,7 +336,6 @@ static int aic32x4_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 
 	iface_reg_1 = snd_soc_read(codec, AIC32X4_IFACE1);
 	iface_reg_1 = iface_reg_1 & ~(3 << 6 | 3 << 2);
-	iface_reg_2 = snd_soc_read(codec, AIC32X4_IFACE2);
 	iface_reg_2 = 0;
 	iface_reg_3 = snd_soc_read(codec, AIC32X4_IFACE3);
 	iface_reg_3 = iface_reg_3 & ~(1 << 3);
-- 
2.0.0
