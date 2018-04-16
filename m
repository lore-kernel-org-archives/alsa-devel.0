From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Add definitions for mclk_direction values" to the asoc tree
Date: Mon, 16 Apr 2018 18:15:24 +0100
Message-ID: <E1f87iu-0002wh-VJ@debutante>
References: <20180404041939.23317-4-k.marinushkin@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180404041939.23317-4-k.marinushkin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Pan Xiuli <xiuli.pan@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.orgMark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>alsa-devel@alsa-project.orgTakashi Iwai <tiwai@suse.de>Pan Xiuli <xiuli.pan@linux.intel.com>Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>linux-kernel@vger.kernel.orgLiam Girdwood <liam.r.girdwood@linux.intel.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Add definitions for mclk_direction values

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From e590522a06adce8ca2eb47e77d80616cd1542d91 Mon Sep 17 00:00:00 2001
From: Kirill Marinushkin <k.marinushkin@gmail.com>
Date: Wed, 4 Apr 2018 06:19:39 +0200
Subject: [PATCH] ASoC: topology: Add definitions for mclk_direction values

Current comment makes not clear the direction of mclk. Previously, similar
description caused a misunderstanding for bclk_master and fsync_master.

This commit solves the potential confusion the same way it is solved for
bclk_master and fsync_master.

Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Pan Xiuli <xiuli.pan@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/uapi/sound/asoc.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index f3c4b46e39d8..b901cdbe532a 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -144,6 +144,10 @@
 #define SND_SOC_TPLG_DAI_CLK_GATE_GATED	1
 #define SND_SOC_TPLG_DAI_CLK_GATE_CONT		2
 
+/* DAI mclk_direction */
+#define SND_SOC_TPLG_MCLK_CO            0 /* for codec, mclk is output */
+#define SND_SOC_TPLG_MCLK_CI            1 /* for codec, mclk is input */
+
 /* DAI physical PCM data formats.
  * Add new formats to the end of the list.
  */
@@ -334,7 +338,7 @@ struct snd_soc_tplg_hw_config {
 	__u8 invert_fsync;	/* 1 for inverted frame clock, 0 for normal */
 	__u8 bclk_master;	/* SND_SOC_TPLG_BCLK_ value */
 	__u8 fsync_master;	/* SND_SOC_TPLG_FSYNC_ value */
-	__u8 mclk_direction;    /* 0 for input, 1 for output */
+	__u8 mclk_direction;    /* SND_SOC_TPLG_MCLK_ value */
 	__le16 reserved;	/* for 32bit alignment */
 	__le32 mclk_rate;	/* MCLK or SYSCLK freqency in Hz */
 	__le32 bclk_rate;	/* BCLK freqency in Hz */
-- 
2.17.0
