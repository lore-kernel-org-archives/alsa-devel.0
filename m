From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 07/21] ASoC: SOF: loader: Use the BAR provided
	by FW
Date: Mon, 22 Jul 2019 09:13:48 -0500
Message-ID: <20190722141402.7194-8-pierre-louis.bossart@linux.intel.com>
References: <20190722141402.7194-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A4BD3F8048E
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 16:14:17 +0200 (CEST)
In-Reply-To: <20190722141402.7194-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Daniel Baluta <daniel.baluta@nxp.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Daniel Baluta <daniel.baluta@nxp.com>

Make sure to use the newly introduced function snd_sof_dsp_get_bar_index
that converts the section type to appropriate BAR index.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
