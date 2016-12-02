From: jeeja.kp@intel.com
Subject: [PATCH 08/12] ASoC: Intel: Skylake: Add supply widget
	in skl_nau_max machine
Date: Fri,  2 Dec 2016 23:11:45 +0530
Message-ID: <1480700509-23380-9-git-send-email-jeeja.kp@intel.com>
References: <1480700509-23380-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id BE99A267826
 for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2016 18:32:12 +0100 (CET)
In-Reply-To: <1480700509-23380-1-git-send-email-jeeja.kp@intel.com>
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
need to model the MLCK from SSP0 and turn it on before SSP port is
enabled, so model this in DSP widget parsing.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/boards/skl_nau88l25_max98357a.c | 34 +++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index 25db5be..06abdf1 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -100,6 +100,36 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 	return ret;
 }
 
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
 static const struct snd_kcontrol_new skylake_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
@@ -113,6 +143,9 @@ static const struct snd_soc_dapm_widget skylake_widgets[] = {
 	SND_SOC_DAPM_MIC("SoC DMIC", NULL),
 	SND_SOC_DAPM_SPK("DP", NULL),
 	SND_SOC_DAPM_SPK("HDMI", NULL),
+	SND_SOC_DAPM_SUPPLY("ssp0 mclk", SND_SOC_NOPM, 0, 0,
+			ssp_set_clk, SND_SOC_DAPM_PRE_PMU |
+			SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
 			platform_clock_control, SND_SOC_DAPM_PRE_PMU |
 			SND_SOC_DAPM_POST_PMD),
@@ -136,6 +169,7 @@ static const struct snd_soc_dapm_route skylake_map[] = {
 	/* CODEC BE connections */
 	{ "HiFi Playback", NULL, "ssp0 Tx" },
 	{ "ssp0 Tx", NULL, "codec0_out" },
+	{ "codec0_out", NULL, "ssp0 mclk"},
 
 	{ "Playback", NULL, "ssp1 Tx" },
 	{ "ssp1 Tx", NULL, "codec1_out" },
-- 
2.5.0
