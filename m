From: jeeja.kp@intel.com
Subject: [PATCH v3 10/13] ASoC: Intel: Skylake: Add supply
	widget in bxt_da_max machine
Date: Thu,  8 Dec 2016 13:41:21 +0530
Message-ID: <1481184684-9620-11-git-send-email-jeeja.kp@intel.com>
References: <1481184684-9620-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 716CB2667B2
 for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2016 09:01:47 +0100 (CET)
In-Reply-To: <1481184684-9620-1-git-send-email-jeeja.kp@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Maxim codec needs clock to be configured before the SSP startup, so we
need to model the MLCK from SSP5 and turn it on before SSP port is
enabled, so model this in DSP widget parsing.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 34 +++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index bff80b4..c702967 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -43,6 +43,36 @@ enum {
 	BXT_DPCM_AUDIO_HDMI3_PB,
 };
 
+static struct snd_soc_dai *skl_get_dai_widget(struct snd_soc_dapm_widget *w)
+{
+	struct snd_soc_dapm_path *p = NULL;
+
+	snd_soc_dapm_widget_for_each_sink_path(w, p) {
+		if (p->sink->id == snd_soc_dapm_dai_in)
+			return p->sink->priv;
+
+		return skl_get_dai_widget(p->sink);
+	}
+
+	return NULL;
+}
+
+static int ssp_set_clk(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *k, int  event)
+{
+	struct snd_soc_dai *cpu_dai = NULL;
+
+	cpu_dai = skl_get_dai_widget(w);
+	if (!cpu_dai)
+		return -EIO;
+
+	/* Enable/Disable the SSP clk */
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		return snd_soc_dai_set_tristate(cpu_dai, 0);
+	else
+		return snd_soc_dai_set_tristate(cpu_dai, 1);
+}
+
 static const struct snd_kcontrol_new broxton_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
@@ -57,6 +87,9 @@ static const struct snd_soc_dapm_widget broxton_widgets[] = {
 	SND_SOC_DAPM_SPK("HDMI1", NULL),
 	SND_SOC_DAPM_SPK("HDMI2", NULL),
 	SND_SOC_DAPM_SPK("HDMI3", NULL),
+	SND_SOC_DAPM_SUPPLY("ssp5 mclk", SND_SOC_NOPM, 0, 0,
+			ssp_set_clk, SND_SOC_DAPM_PRE_PMU |
+			SND_SOC_DAPM_POST_PMD),
 };
 
 static const struct snd_soc_dapm_route broxton_map[] = {
@@ -76,6 +109,7 @@ static const struct snd_soc_dapm_route broxton_map[] = {
 	/* CODEC BE connections */
 	{"HiFi Playback", NULL, "ssp5 Tx"},
 	{"ssp5 Tx", NULL, "codec0_out"},
+	{ "codec0_out", NULL, "ssp5 mclk"},
 
 	{"Playback", NULL, "ssp1 Tx"},
 	{"ssp1 Tx", NULL, "codec1_out"},
-- 
2.5.0
