From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Intel: ssp: BCLK delay parameter"
	to the asoc tree
Date: Tue, 23 Jul 2019 12:29:11 +0100 (BST)
Message-ID: <20190723112911.B33922742B60@ypsilon.sirena.org.uk>
References: <20190722141402.7194-22-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4663BF8045D
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 13:29:13 +0200 (CEST)
In-Reply-To: <20190722141402.7194-22-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Janusz Jankowski <janusz.jankowski@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: Intel: ssp: BCLK delay parameter

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

>From 6298b78742be6593d372ed1b5bfa5397e1393595 Mon Sep 17 00:00:00 2001
From: Janusz Jankowski <janusz.jankowski@linux.intel.com>
Date: Mon, 22 Jul 2019 09:14:02 -0500
Subject: [PATCH] ASoC: SOF: Intel: ssp: BCLK delay parameter

Some codecs require BCLK to be on for some time, before sending
any data. SOF can enable BCLK and then wait for guaranteed time,
before starting DMA on SSP start.

Signed-off-by: Janusz Jankowski <janusz.jankowski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190722141402.7194-22-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/sof/dai-intel.h   | 3 +++
 include/uapi/sound/sof/abi.h    | 2 +-
 include/uapi/sound/sof/tokens.h | 1 +
 sound/soc/sof/topology.c        | 3 +++
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/sound/sof/dai-intel.h b/include/sound/sof/dai-intel.h
index 4bb8ee138ba7..a81afd3fbd41 100644
--- a/include/sound/sof/dai-intel.h
+++ b/include/sound/sof/dai-intel.h
@@ -76,6 +76,9 @@ struct sof_ipc_dai_ssp_params {
 	uint16_t tdm_per_slot_padding_flag;
 	uint32_t clks_control;
 	uint32_t quirks;
+	uint32_t bclk_delay;	/* guaranteed time (ms) for which BCLK
+				 * will be driven, before sending data
+				 */
 } __packed;
 
 /* HDA Configuration Request - SOF_IPC_DAI_HDA_CONFIG */
diff --git a/include/uapi/sound/sof/abi.h b/include/uapi/sound/sof/abi.h
index 4a9c24434f42..dff70a42445a 100644
--- a/include/uapi/sound/sof/abi.h
+++ b/include/uapi/sound/sof/abi.h
@@ -26,7 +26,7 @@
 
 /* SOF ABI version major, minor and patch numbers */
 #define SOF_ABI_MAJOR 3
-#define SOF_ABI_MINOR 8
+#define SOF_ABI_MINOR 9
 #define SOF_ABI_PATCH 0
 
 /* SOF ABI version number. Format within 32bit word is MMmmmppp */
diff --git a/include/uapi/sound/sof/tokens.h b/include/uapi/sound/sof/tokens.h
index dc1b27daaac6..6435240cef13 100644
--- a/include/uapi/sound/sof/tokens.h
+++ b/include/uapi/sound/sof/tokens.h
@@ -75,6 +75,7 @@
 #define SOF_TKN_INTEL_SSP_FRAME_PULSE_WIDTH	503
 #define SOF_TKN_INTEL_SSP_QUIRKS		504
 #define SOF_TKN_INTEL_SSP_TDM_PADDING_PER_SLOT	505
+#define SOF_TKN_INTEL_SSP_BCLK_DELAY		506
 
 /* DMIC */
 #define SOF_TKN_INTEL_DMIC_DRIVER_VERSION	600
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 432ae343f960..12b7d900b9c2 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -748,6 +748,9 @@ static const struct sof_topology_token ssp_tokens[] = {
 		get_token_u16,
 		offsetof(struct sof_ipc_dai_ssp_params,
 			 tdm_per_slot_padding_flag), 0},
+	{SOF_TKN_INTEL_SSP_BCLK_DELAY, SND_SOC_TPLG_TUPLE_TYPE_WORD,
+		get_token_u32,
+		offsetof(struct sof_ipc_dai_ssp_params, bclk_delay), 0},
 
 };
 
-- 
2.20.1
