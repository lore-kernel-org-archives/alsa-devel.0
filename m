From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 4/4] ASoC: Intel: skl-hda-dsp-generic: add dmic
	dapm widget and route
Date: Fri,  9 Aug 2019 18:22:36 -0500
Message-ID: <20190809232236.21182-5-pierre-louis.bossart@linux.intel.com>
References: <20190809232236.21182-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4469DF804AB
 for <alsa-devel@alsa-project.org>; Sat, 10 Aug 2019 01:22:45 +0200 (CEST)
In-Reply-To: <20190809232236.21182-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Keyon Jie <yang.jie@linux.intel.com>

Adding DAPM MIC endpoint widget "SoC DMIC" and route, to enable
DMIC DAPM support with hda generic machine.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/skl_hda_dsp_generic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/intel/boards/skl_hda_dsp_generic.c b/sound/soc/intel/boards/skl_hda_dsp_generic.c
index 9ed68eb4f058..1778acdc367c 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_generic.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_generic.c
@@ -23,6 +23,7 @@ static const struct snd_soc_dapm_widget skl_hda_widgets[] = {
 	SND_SOC_DAPM_MIC("Alt Analog In", NULL),
 	SND_SOC_DAPM_SPK("Digital Out", NULL),
 	SND_SOC_DAPM_MIC("Digital In", NULL),
+	SND_SOC_DAPM_MIC("SoC DMIC", NULL),
 };
 
 static const struct snd_soc_dapm_route skl_hda_map[] = {
@@ -41,6 +42,9 @@ static const struct snd_soc_dapm_route skl_hda_map[] = {
 	{ "Codec Input Pin2", NULL, "Digital In" },
 	{ "Codec Input Pin3", NULL, "Alt Analog In" },
 
+	/* digital mics */
+	{"DMic", NULL, "SoC DMIC"},
+
 	/* CODEC BE connections */
 	{ "Analog Codec Playback", NULL, "Analog CPU Playback" },
 	{ "Analog CPU Playback", NULL, "codec0_out" },
-- 
2.20.1
