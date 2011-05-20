From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 1/2] ASoC: tlv320aic3x: Don't sync first two
	registers from register cache
Date: Fri, 20 May 2011 16:52:37 +0300
Message-ID: <1305899558-21719-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 70A90103842
	for <alsa-devel@alsa-project.org>;
	Fri, 20 May 2011 15:51:19 +0200 (CEST)
Received: by eyg5 with SMTP id 5so1296110eyg.38
	for <alsa-devel@alsa-project.org>; Fri, 20 May 2011 06:51:19 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

There is no need to sync first two registers from cache to hw after a reset.
First one is used to select page for register access and this driver is
normally accessing page 0 only. Second one does a software reset which is
obviously unneeded after hardware or previous software reset command.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index c3d96fc..9047bb1 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1114,7 +1114,7 @@ static int aic3x_set_power(struct snd_soc_codec *codec, int power)
 
 		/* Sync reg_cache with the hardware */
 		codec->cache_only = 0;
-		for (i = 0; i < ARRAY_SIZE(aic3x_reg); i++)
+		for (i = AIC3X_SAMPLE_RATE_SEL_REG; i < ARRAY_SIZE(aic3x_reg); i++)
 			snd_soc_write(codec, i, cache[i]);
 		if (aic3x->model == AIC3X_MODEL_3007)
 			aic3x_init_3007(codec);
-- 
1.7.4.4
