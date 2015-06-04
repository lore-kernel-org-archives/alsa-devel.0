From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 14/22] ASoC: tas2552: Clean up the Digital -
	Analog DAPM route definition
Date: Thu, 4 Jun 2015 15:22:38 +0300
Message-ID: <1433420571-5421-15-git-send-email-peter.ujfalusi@ti.com>
References: <1433420571-5421-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 27E1C2664C0
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 14:23:29 +0200 (CEST)
In-Reply-To: <1433420571-5421-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, dmurphy@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The strings should be: 'static const char * const tas2552_input_texts[]'
SOC_DAPM_ENUM should have "Route" in place of xname and no need to have it
as an array.
Also align the parameters.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tas2552.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index 432aa54fe707..264df631b130 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -83,17 +83,15 @@ struct tas2552_data {
 	unsigned int tdm_delay;
 };
 
-/* Input mux controls */
-static const char *tas2552_input_texts[] = {
-	"Digital", "Analog"
-};
 
+/* Input mux controls */
+static const char * const tas2552_input_texts[] = {
+	"Digital", "Analog" };
 static SOC_ENUM_SINGLE_DECL(tas2552_input_mux_enum, TAS2552_CFG_3, 7,
 			    tas2552_input_texts);
 
-static const struct snd_kcontrol_new tas2552_input_mux_control[] = {
-	SOC_DAPM_ENUM("Input selection", tas2552_input_mux_enum)
-};
+static const struct snd_kcontrol_new tas2552_input_mux_control =
+	SOC_DAPM_ENUM("Route", tas2552_input_mux_enum);
 
 static const struct snd_soc_dapm_widget tas2552_dapm_widgets[] =
 {
@@ -101,7 +99,7 @@ static const struct snd_soc_dapm_widget tas2552_dapm_widgets[] =
 
 	/* MUX Controls */
 	SND_SOC_DAPM_MUX("Input selection", SND_SOC_NOPM, 0, 0,
-				tas2552_input_mux_control),
+			 &tas2552_input_mux_control),
 
 	SND_SOC_DAPM_AIF_IN("DAC IN", "DAC Playback", 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_DAC("DAC", NULL, SND_SOC_NOPM, 0, 0),
-- 
2.4.2
