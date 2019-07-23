From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: loader: Use the BAR provided by
	FW" to the asoc tree
Date: Tue, 23 Jul 2019 12:29:13 +0100 (BST)
Message-ID: <20190723112913.F27572742B60@ypsilon.sirena.org.uk>
References: <20190722141402.7194-8-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B69CF8048E
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 13:29:15 +0200 (CEST)
In-Reply-To: <20190722141402.7194-8-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: loader: Use the BAR provided by FW

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

>From 7198879ef57775df3b1a75c62bb9e313c56876d4 Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Mon, 22 Jul 2019 09:13:48 -0500
Subject: [PATCH] ASoC: SOF: loader: Use the BAR provided by FW

Make sure to use the newly introduced function snd_sof_dsp_get_bar_index
that converts the section type to appropriate BAR index.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190722141402.7194-8-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/loader.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/loader.c b/sound/soc/sof/loader.c
index 952a19091c58..e75da8aa7d4a 100644
--- a/sound/soc/sof/loader.c
+++ b/sound/soc/sof/loader.c
@@ -92,7 +92,7 @@ int snd_sof_parse_module_memcpy(struct snd_sof_dev *sdev,
 				struct snd_sof_mod_hdr *module)
 {
 	struct snd_sof_blk_hdr *block;
-	int count;
+	int count, bar;
 	u32 offset;
 	size_t remaining;
 
@@ -128,6 +128,13 @@ int snd_sof_parse_module_memcpy(struct snd_sof_dev *sdev,
 		case SOF_FW_BLK_TYPE_IRAM:
 		case SOF_FW_BLK_TYPE_DRAM:
 			offset = block->offset;
+			bar = snd_sof_dsp_get_bar_index(sdev, block->type);
+			if (bar < 0) {
+				dev_err(sdev->dev,
+					"error: no BAR mapping for block type 0x%x\n",
+					block->type);
+				return bar;
+			}
 			break;
 		default:
 			dev_err(sdev->dev, "error: bad type 0x%x for block 0x%x\n",
@@ -145,7 +152,7 @@ int snd_sof_parse_module_memcpy(struct snd_sof_dev *sdev,
 				block->size);
 			return -EINVAL;
 		}
-		snd_sof_dsp_block_write(sdev, sdev->mmio_bar, offset,
+		snd_sof_dsp_block_write(sdev, bar, offset,
 					block + 1, block->size);
 
 		if (remaining < block->size) {
-- 
2.20.1
