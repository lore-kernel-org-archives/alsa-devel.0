From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 03/10] ASoC: Tweak tlv320aicx reg_cache_size
Date: Wed, 11 Jun 2008 13:47:08 +0100
Message-ID: <1213188435-1986-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1213188435-1986-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2DE092482B
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jun 2008 14:47:18 +0200 (CEST)
In-Reply-To: <1213188435-1986-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

ASoC codec drivers frequently set the register cache size using sizeof()
rather than ARRAY_SIZE(). For tlv320aicx either is correct since the
registers are 8 bit but update to use ARRAY_SIZE() for clarity.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/codecs/tlv320aic3x.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index dc8a38d..528c26a 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1021,7 +1021,7 @@ static int aic3x_init(struct snd_soc_device *socdev)
 	codec->set_bias_level = aic3x_set_bias_level;
 	codec->dai = &aic3x_dai;
 	codec->num_dai = 1;
-	codec->reg_cache_size = sizeof(aic3x_reg);
+	codec->reg_cache_size = ARRAY_SIZE(aic3x_reg);
 	codec->reg_cache = kmemdup(aic3x_reg, sizeof(aic3x_reg), GFP_KERNEL);
 	if (codec->reg_cache == NULL)
 		return -ENOMEM;
-- 
1.5.5.3
