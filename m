From: Eric Nelson <eric.nelson@boundarydevices.com>
Subject: [RFC PATCH 6/6] ASoC: sgtl5000: Don't disable
	regulators in SND_SOC_BIAS_OFF
Date: Thu, 26 Feb 2015 15:54:33 -0700
Message-ID: <1424991273-10081-7-git-send-email-eric.nelson@boundarydevices.com>
References: <1424991273-10081-1-git-send-email-eric.nelson@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f170.google.com (mail-pd0-f170.google.com
 [209.85.192.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AD5D264EAA
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 23:54:54 +0100 (CET)
Received: by pdjp10 with SMTP id p10so16379915pdj.3
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 14:54:53 -0800 (PST)
In-Reply-To: <1424991273-10081-1-git-send-email-eric.nelson@boundarydevices.com>
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
Cc: fabio.estevam@freescale.com, lars@metafoo.de, tiwai@suse.de, Eric Nelson <eric.nelson@boundarydevices.com>, lgirdwood@gmail.com, broonie@kernel.org, rmk+kernel@arm.linux.org.uk, jean-michel.hautbois@vodalys.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org

Disabling the SGTL5000 through regulators would certainly save
power than simply disabling the reference voltages as described
in the data sheet, but won't properly restore things on resume.

As patch 1 in the series shows, no user of this driver has support
for active regulators yet, so this hasn't shown up.

This patch is much more conservative and simply disables the
reference bias currents.

Signed-off-by: Eric Nelson <eric.nelson@boundarydevices.com>
---
 sound/soc/codecs/sgtl5000.c | 32 +++++---------------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 5f7dd5d..d4d793f 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -767,36 +767,14 @@ static int sgtl5000_set_bias_level(struct snd_soc_codec *codec,
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 	case SND_SOC_BIAS_PREPARE:
-		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
-			ret = regulator_bulk_enable(
-						sgtl5000->num_supplies,
-						sgtl5000->supplies);
-			if (ret)
-				return ret;
-			udelay(10);
-
-			regcache_cache_only(sgtl5000->regmap, false);
-
-			ret = regcache_sync(sgtl5000->regmap);
-			if (ret != 0) {
-				dev_err(codec->dev,
-					"Failed to restore cache: %d\n", ret);
-
-				regcache_cache_only(sgtl5000->regmap, true);
-				regulator_bulk_disable(sgtl5000->num_supplies,
-						       sgtl5000->supplies);
-
-				return ret;
-			}
-		}
-
+		snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
+				    SGTL5000_REFTOP_POWERUP,
+				    SGTL5000_REFTOP_POWERUP);
 		break;
 	case SND_SOC_BIAS_OFF:
-		regcache_cache_only(sgtl5000->regmap, true);
-		regulator_bulk_disable(sgtl5000->num_supplies,
-				       sgtl5000->supplies);
+		snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
+				    SGTL5000_REFTOP_POWERUP, 0);
 		break;
 	}
 
-- 
1.9.1
