From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Add DMIC token for unmute gain
	ramp time" to the asoc tree
Date: Thu, 13 Jun 2019 20:05:58 +0100 (BST)
Message-ID: <20190613190558.D05F4440049@finisterre.sirena.org.uk>
References: <20190612170148.15327-4-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 50672F89755
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 21:05:59 +0200 (CEST)
In-Reply-To: <20190612170148.15327-4-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: Add DMIC token for unmute gain ramp time

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 7df43911e92aa2137ae77ae60efaa9d6656df3fe Mon Sep 17 00:00:00 2001
From: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Date: Wed, 12 Jun 2019 12:01:47 -0500
Subject: [PATCH] ASoC: SOF: Add DMIC token for unmute gain ramp time

The settling time of DMIC DC level is both platform and used
microphone model specific. The unmute gain ramp is used to conceal
most of the large DC level seen in beginning of capture. This patch
adds into the DMIC DAI IPC struct a new field called unmute_ramp_time
and a new token SOF_TKN_INTEL_DMIC_UNMUTE_RAMP_TIME. The value is the
ramp length in milliseconds (ms).

The ABI minor version is incremented for this backwards compatible
change.

Signed-off-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/sof/dai-intel.h   | 3 ++-
 include/uapi/sound/sof/abi.h    | 2 +-
 include/uapi/sound/sof/tokens.h | 1 +
 sound/soc/sof/topology.c        | 4 ++++
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/sound/sof/dai-intel.h b/include/sound/sof/dai-intel.h
index 4bd83f7adddf..4bb8ee138ba7 100644
--- a/include/sound/sof/dai-intel.h
+++ b/include/sound/sof/dai-intel.h
@@ -167,9 +167,10 @@ struct sof_ipc_dai_dmic_params {
 
 	uint32_t wake_up_time;      /**< Time from clock start to data (us) */
 	uint32_t min_clock_on_time; /**< Min. time that clk is kept on (us) */
+	uint32_t unmute_ramp_time;  /**< Length of logarithmic gain ramp (ms) */
 
 	/* reserved for future use */
-	uint32_t reserved[6];
+	uint32_t reserved[5];
 
 	/**< variable number of pdm controller config */
 	struct sof_ipc_dai_dmic_pdm_ctrl pdm[0];
diff --git a/include/uapi/sound/sof/abi.h b/include/uapi/sound/sof/abi.h
index 92eee681bc62..4a9c24434f42 100644
--- a/include/uapi/sound/sof/abi.h
+++ b/include/uapi/sound/sof/abi.h
@@ -26,7 +26,7 @@
 
 /* SOF ABI version major, minor and patch numbers */
 #define SOF_ABI_MAJOR 3
-#define SOF_ABI_MINOR 7
+#define SOF_ABI_MINOR 8
 #define SOF_ABI_PATCH 0
 
 /* SOF ABI version number. Format within 32bit word is MMmmmppp */
diff --git a/include/uapi/sound/sof/tokens.h b/include/uapi/sound/sof/tokens.h
index 53ea94bf1c08..dc1b27daaac6 100644
--- a/include/uapi/sound/sof/tokens.h
+++ b/include/uapi/sound/sof/tokens.h
@@ -85,6 +85,7 @@
 #define SOF_TKN_INTEL_DMIC_NUM_PDM_ACTIVE	605
 #define SOF_TKN_INTEL_DMIC_SAMPLE_RATE		608
 #define SOF_TKN_INTEL_DMIC_FIFO_WORD_LENGTH	609
+#define SOF_TKN_INTEL_DMIC_UNMUTE_RAMP_TIME_MS  610
 
 /* DMIC PDM */
 #define SOF_TKN_INTEL_DMIC_PDM_CTRL_ID		700
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index bbad8053b1bc..8e00f829bfdb 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -779,6 +779,10 @@ static const struct sof_topology_token dmic_tokens[] = {
 	{SOF_TKN_INTEL_DMIC_FIFO_WORD_LENGTH,
 		SND_SOC_TPLG_TUPLE_TYPE_SHORT, get_token_u16,
 		offsetof(struct sof_ipc_dai_dmic_params, fifo_bits), 0},
+	{SOF_TKN_INTEL_DMIC_UNMUTE_RAMP_TIME_MS,
+		SND_SOC_TPLG_TUPLE_TYPE_WORD, get_token_u32,
+		offsetof(struct sof_ipc_dai_dmic_params, unmute_ramp_time), 0},
+
 };
 
 /*
-- 
2.20.1
