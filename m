From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Remove unused function
	check_vdac_to_outmix from rt5631
Date: Thu, 29 Sep 2011 17:32:47 +0100
Message-ID: <1317313968-18966-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1317313968-18966-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BCD2324654
	for <alsa-devel@Alsa-project.org>;
	Thu, 29 Sep 2011 18:32:51 +0200 (CEST)
In-Reply-To: <1317313968-18966-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@Alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/rt5631.c |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index 7e1f894..86e69f4 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -343,20 +343,6 @@ static int check_dacr_to_spkmixr(struct snd_soc_dapm_widget *source,
 	return !(reg & RT5631_M_DAC_R_TO_SPKMIXER_R);
 }
 
-static int check_vdac_to_outmix(struct snd_soc_dapm_widget *source,
-			 struct snd_soc_dapm_widget *sink)
-{
-	unsigned int reg, ret = 1;
-
-	reg = snd_soc_read(source->codec, RT5631_OUTMIXER_L_CTRL);
-	if (reg & RT5631_M_VDAC_TO_OUTMIXER_L) {
-		reg = snd_soc_read(source->codec, RT5631_OUTMIXER_R_CTRL);
-		if (reg & RT5631_M_VDAC_TO_OUTMIXER_R)
-			ret = 0;
-	}
-	return ret;
-}
-
 static int check_adcl_select(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
-- 
1.7.6.3
