From: Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: [PATCH] ASoC: topology: Modify clock gating parameter parsing to switch
Date: Mon, 16 Apr 2018 19:56:44 +0200
Message-ID: <20180416175644.30081-1-k.marinushkin@gmail.com>
References: <20180416165206.GE20726@sirena.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180416165206.GE20726@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Kirill Marinushkin <k.marinushkin@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Pan Xiuli <xiuli.pan@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This improves the coding style of this piece of code.

Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Pan Xiuli <xiuli.pan@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org
---
 sound/soc/soc-topology.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 04f834e6a6b5..802bad7ddcb4 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1982,11 +1982,19 @@ static void set_link_hw_format(struct snd_soc_dai_link *link,
 		link->dai_fmt = hw_config->fmt & SND_SOC_DAIFMT_FORMAT_MASK;
 
 		/* clock gating */
-		if (hw_config->clock_gated == SND_SOC_TPLG_DAI_CLK_GATE_GATED)
+		switch (hw_config->clock_gated) {
+		case SND_SOC_TPLG_DAI_CLK_GATE_GATED:
 			link->dai_fmt |= SND_SOC_DAIFMT_GATED;
-		else if (hw_config->clock_gated ==
-			 SND_SOC_TPLG_DAI_CLK_GATE_CONT)
+			break;
+
+		case SND_SOC_TPLG_DAI_CLK_GATE_CONT:
 			link->dai_fmt |= SND_SOC_DAIFMT_CONT;
+			break;
+
+		default:
+			/* ignore the value */
+			break;
+		}
 
 		/* clock signal polarity */
 		invert_bclk = hw_config->invert_bclk;
-- 
2.13.6
