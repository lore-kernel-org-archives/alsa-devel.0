From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: skl-hda-dsp-generic: add dmic
	dapm widget and route" to the asoc tree
Date: Mon, 12 Aug 2019 14:09:49 +0100 (BST)
Message-ID: <20190812130949.A1E202740CBD@ypsilon.sirena.org.uk>
References: <20190809232236.21182-5-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5C840F805E1
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2019 15:09:58 +0200 (CEST)
In-Reply-To: <20190809232236.21182-5-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Keyon Jie <yang.jie@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: skl-hda-dsp-generic: add dmic dapm widget and route

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 79631210fc413546d0ed73632ff904ded5192cc9 Mon Sep 17 00:00:00 2001
From: Keyon Jie <yang.jie@linux.intel.com>
Date: Fri, 9 Aug 2019 18:22:36 -0500
Subject: [PATCH] ASoC: Intel: skl-hda-dsp-generic: add dmic dapm widget and
 route

Adding DAPM MIC endpoint widget "SoC DMIC" and route, to enable
DMIC DAPM support with hda generic machine.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190809232236.21182-5-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
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
