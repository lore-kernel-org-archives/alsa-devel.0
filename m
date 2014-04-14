From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 07/17] ASoC: rt5640: Replace usage deprecated
	MUX/ENUM macros
Date: Mon, 14 Apr 2014 21:31:02 +0200
Message-ID: <1397503872-20864-8-git-send-email-lars@metafoo.de>
References: <1397503872-20864-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-027.synserver.de (smtp-out-046.synserver.de
 [212.40.185.46])
 by alsa0.perex.cz (Postfix) with ESMTP id B53672656B7
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 21:31:24 +0200 (CEST)
In-Reply-To: <1397503872-20864-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, =?UTF-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Jerry Wong <jerry.wong@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org

SND_SOC_DAPM_VALUE_MUX and SOC_DAPM_VALUE_ENUM are deprecated and merely an
alias for SND_SOC_DAPM_MUX and SOC_DAPM_ENUM. Replace the deprecated macros so
we can eventually remove their definition.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/rt5640.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 6674372..f27297a 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -873,7 +873,7 @@ static SOC_VALUE_ENUM_SINGLE_DECL(rt5640_dac_l2_enum,
 				  0x3, rt5640_dac_l2_src, rt5640_dac_l2_values);
 
 static const struct snd_kcontrol_new rt5640_dac_l2_mux =
-	SOC_DAPM_VALUE_ENUM("DAC2 left channel source", rt5640_dac_l2_enum);
+	SOC_DAPM_ENUM("DAC2 left channel source", rt5640_dac_l2_enum);
 
 static const char * const rt5640_dac_r2_src[] = {
 	"IF2",
@@ -908,7 +908,7 @@ static SOC_VALUE_ENUM_SINGLE_DECL(rt5640_dai_iis_map_enum,
 				  rt5640_dai_iis_map_values);
 
 static const struct snd_kcontrol_new rt5640_dai_mux =
-	SOC_DAPM_VALUE_ENUM("DAI select", rt5640_dai_iis_map_enum);
+	SOC_DAPM_ENUM("DAI select", rt5640_dai_iis_map_enum);
 
 /* SDI select */
 static const char * const rt5640_sdi_sel[] = {
-- 
1.8.0
