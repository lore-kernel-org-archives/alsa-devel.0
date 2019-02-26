From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Reorder some functions for
	improved clarity" to the asoc tree
Date: Tue, 26 Feb 2019 12:06:29 +0000 (GMT)
Message-ID: <20190226120629.2282E11284E3@debutante.sirena.org.uk>
References: <20190222100421.894-2-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5C548F8967B
 for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2019 13:06:30 +0100 (CET)
In-Reply-To: <20190222100421.894-2-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: stuarth@opensource.cirrus.com, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Reorder some functions for improved clarity

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

>From 1e38f069c7d74109cfb5cff04e7fb7a24fea1ea6 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Fri, 22 Feb 2019 10:04:18 +0000
Subject: [PATCH] ASoC: wm_adsp: Reorder some functions for improved clarity

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 81 +++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 40 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index bd3241aacdb6..852ab3f70689 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3246,6 +3246,47 @@ static void wm_adsp_remove_padding(u32 *buf, int nwords, int data_word_size)
 	}
 }
 
+static int wm_adsp_buffer_populate(struct wm_adsp_compr_buf *buf)
+{
+	const struct wm_adsp_fw_caps *caps = wm_adsp_fw[buf->dsp->fw].caps;
+	struct wm_adsp_buffer_region *region;
+	u32 offset = 0;
+	int i, ret;
+
+	for (i = 0; i < caps->num_regions; ++i) {
+		region = &buf->regions[i];
+
+		region->offset = offset;
+		region->mem_type = caps->region_defs[i].mem_type;
+
+		ret = wm_adsp_buffer_read(buf, caps->region_defs[i].base_offset,
+					  &region->base_addr);
+		if (ret < 0)
+			return ret;
+
+		ret = wm_adsp_buffer_read(buf, caps->region_defs[i].size_offset,
+					  &offset);
+		if (ret < 0)
+			return ret;
+
+		region->cumulative_size = offset;
+
+		adsp_dbg(buf->dsp,
+			 "region=%d type=%d base=%08x off=%08x size=%08x\n",
+			 i, region->mem_type, region->base_addr,
+			 region->offset, region->cumulative_size);
+	}
+
+	return 0;
+}
+
+static void wm_adsp_buffer_clear(struct wm_adsp_compr_buf *buf)
+{
+	buf->irq_count = 0xFFFFFFFF;
+	buf->read_index = -1;
+	buf->avail = 0;
+}
+
 static int wm_adsp_legacy_host_buf_addr(struct wm_adsp_compr_buf *buf)
 {
 	struct wm_adsp_alg_region *alg_region;
@@ -3343,46 +3384,6 @@ static int wm_adsp_buffer_locate(struct wm_adsp_compr_buf *buf)
 	return 0;
 }
 
-static int wm_adsp_buffer_populate(struct wm_adsp_compr_buf *buf)
-{
-	const struct wm_adsp_fw_caps *caps = wm_adsp_fw[buf->dsp->fw].caps;
-	struct wm_adsp_buffer_region *region;
-	u32 offset = 0;
-	int i, ret;
-
-	for (i = 0; i < caps->num_regions; ++i) {
-		region = &buf->regions[i];
-
-		region->offset = offset;
-		region->mem_type = caps->region_defs[i].mem_type;
-
-		ret = wm_adsp_buffer_read(buf, caps->region_defs[i].base_offset,
-					  &region->base_addr);
-		if (ret < 0)
-			return ret;
-
-		ret = wm_adsp_buffer_read(buf, caps->region_defs[i].size_offset,
-					  &offset);
-		if (ret < 0)
-			return ret;
-
-		region->cumulative_size = offset;
-
-		adsp_dbg(buf->dsp,
-			 "region=%d type=%d base=%08x off=%08x size=%08x\n",
-			 i, region->mem_type, region->base_addr,
-			 region->offset, region->cumulative_size);
-	}
-
-	return 0;
-}
-
-static void wm_adsp_buffer_clear(struct wm_adsp_compr_buf *buf)
-{
-	buf->irq_count = 0xFFFFFFFF;
-	buf->read_index = -1;
-	buf->avail = 0;
-}
 
 static int wm_adsp_buffer_init(struct wm_adsp *dsp)
 {
-- 
2.20.1
