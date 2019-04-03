From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 5/7] ASoC: cs42l51: change mic bias DAPM
Date: Wed, 3 Apr 2019 15:23:35 +0200
Message-ID: <1554297817-14154-6-git-send-email-olivier.moysan@st.com>
References: <1554297817-14154-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554297817-14154-1-git-send-email-olivier.moysan@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com, apatard@mandriva.com
List-Id: alsa-devel@alsa-project.org

Use SND_SOC_DAPM_SUPPLY for mic bias DAPM
instead of deprecated SND_SOC_DAPM_MICBIAS.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/codecs/cs42l51.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 397b68901d1c..33298a7a8aab 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -206,7 +206,8 @@ static const struct snd_kcontrol_new cs42l51_adcr_mux_controls =
 	SOC_DAPM_ENUM("Route", cs42l51_adcr_mux_enum);
 
 static const struct snd_soc_dapm_widget cs42l51_dapm_widgets[] = {
-	SND_SOC_DAPM_MICBIAS("Mic Bias", CS42L51_MIC_POWER_CTL, 1, 1),
+	SND_SOC_DAPM_SUPPLY("Mic Bias", CS42L51_MIC_POWER_CTL, 1, 1, NULL,
+			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_PGA_E("Left PGA", CS42L51_POWER_CTL1, 3, 1, NULL, 0,
 		cs42l51_pdn_event, SND_SOC_DAPM_PRE_POST_PMD),
 	SND_SOC_DAPM_PGA_E("Right PGA", CS42L51_POWER_CTL1, 4, 1, NULL, 0,
-- 
2.7.4
