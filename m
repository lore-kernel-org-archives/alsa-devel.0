From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 15/17] ASoC: wm8995: Replace usage deprecated
	MUX/ENUM macros
Date: Mon, 14 Apr 2014 21:31:10 +0200
Message-ID: <1397503872-20864-16-git-send-email-lars@metafoo.de>
References: <1397503872-20864-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-027.synserver.de (smtp-out-046.synserver.de
 [212.40.185.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 1137C2656C4
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 21:31:34 +0200 (CEST)
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

SND_SOC_DAPM_VIRT_MUX and SOC_DAPM_ENUM_VIRT are deprecated and merely an alias
for SND_SOC_DAPM_MUX and SOC_DAPM_ENUM. Replace the deprecated macros so we can
eventually remove their definition.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8995.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8995.c b/sound/soc/codecs/wm8995.c
index d3152cf..863a2c3 100644
--- a/sound/soc/codecs/wm8995.c
+++ b/sound/soc/codecs/wm8995.c
@@ -885,10 +885,10 @@ static const char *adc_mux_text[] = {
 static SOC_ENUM_SINGLE_VIRT_DECL(adc_enum, adc_mux_text);
 
 static const struct snd_kcontrol_new adcl_mux =
-	SOC_DAPM_ENUM_VIRT("ADCL Mux", adc_enum);
+	SOC_DAPM_ENUM("ADCL Mux", adc_enum);
 
 static const struct snd_kcontrol_new adcr_mux =
-	SOC_DAPM_ENUM_VIRT("ADCR Mux", adc_enum);
+	SOC_DAPM_ENUM("ADCR Mux", adc_enum);
 
 static const char *spk_src_text[] = {
 	"DAC1L", "DAC1R", "DAC2L", "DAC2R"
@@ -948,10 +948,8 @@ static const struct snd_soc_dapm_widget wm8995_dapm_widgets[] = {
 	SND_SOC_DAPM_AIF_OUT("AIF1ADC2R", "AIF1 Capture",
 		0, WM8995_POWER_MANAGEMENT_3, 10, 0),
 
-	SND_SOC_DAPM_VIRT_MUX("ADCL Mux", SND_SOC_NOPM, 1, 0,
-		&adcl_mux),
-	SND_SOC_DAPM_VIRT_MUX("ADCR Mux", SND_SOC_NOPM, 0, 0,
-		&adcr_mux),
+	SND_SOC_DAPM_MUX("ADCL Mux", SND_SOC_NOPM, 1, 0, &adcl_mux),
+	SND_SOC_DAPM_MUX("ADCR Mux", SND_SOC_NOPM, 0, 0, &adcr_mux),
 
 	SND_SOC_DAPM_ADC("DMIC2L", NULL, WM8995_POWER_MANAGEMENT_3, 5, 0),
 	SND_SOC_DAPM_ADC("DMIC2R", NULL, WM8995_POWER_MANAGEMENT_3, 4, 0),
-- 
1.8.0
