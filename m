From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/17] ASoC: max98090: Replace usage deprecated
	MUX/ENUM macros
Date: Mon, 14 Apr 2014 21:30:59 +0200
Message-ID: <1397503872-20864-5-git-send-email-lars@metafoo.de>
References: <1397503872-20864-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-027.synserver.de (smtp-out-046.synserver.de
 [212.40.185.46])
 by alsa0.perex.cz (Postfix) with ESMTP id E1DC32656B1
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 21:31:21 +0200 (CEST)
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
 sound/soc/codecs/max98090.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 49d1238..810d42f 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -875,7 +875,7 @@ static const char *dmic_mux_text[] = { "ADC", "DMIC" };
 static SOC_ENUM_SINGLE_VIRT_DECL(dmic_mux_enum, dmic_mux_text);
 
 static const struct snd_kcontrol_new max98090_dmic_mux =
-	SOC_DAPM_ENUM_VIRT("DMIC Mux", dmic_mux_enum);
+	SOC_DAPM_ENUM("DMIC Mux", dmic_mux_enum);
 
 static const char *max98090_micpre_text[] = { "Off", "On" };
 
@@ -1175,8 +1175,7 @@ static const struct snd_soc_dapm_widget max98090_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX("MIC2 Mux", SND_SOC_NOPM,
 		0, 0, &max98090_mic2_mux),
 
-	SND_SOC_DAPM_VIRT_MUX("DMIC Mux", SND_SOC_NOPM,
-		0, 0, &max98090_dmic_mux),
+	SND_SOC_DAPM_MUX("DMIC Mux", SND_SOC_NOPM, 0, 0, &max98090_dmic_mux),
 
 	SND_SOC_DAPM_PGA_E("MIC1 Input", M98090_REG_MIC1_INPUT_LEVEL,
 		M98090_MIC_PA1EN_SHIFT, 0, NULL, 0, max98090_micinput_event,
-- 
1.8.0
