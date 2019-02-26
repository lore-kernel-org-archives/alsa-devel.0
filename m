From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Factor out stripping padding
	from ADSP data" to the asoc tree
Date: Tue, 26 Feb 2019 12:06:31 +0000 (GMT)
Message-ID: <20190226120631.5C6AB11284E3@debutante.sirena.org.uk>
References: <20190222100421.894-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7CF2EF8968D
 for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2019 13:06:37 +0100 (CET)
In-Reply-To: <20190222100421.894-1-ckeepax@opensource.cirrus.com>
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

   ASoC: wm_adsp: Factor out stripping padding from ADSP data

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

>From cc7d6ce90216d101ae16f330fe05bd38e0e64cde Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Fri, 22 Feb 2019 10:04:17 +0000
Subject: [PATCH] ASoC: wm_adsp: Factor out stripping padding from ADSP data

In preparation for more refactoring add a helper function to strip the
padding from ADSP data.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 12ef85e85c29..bd3241aacdb6 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3231,6 +3231,21 @@ static inline int wm_adsp_buffer_write(struct wm_adsp_compr_buf *buf,
 				       buf->host_buf_ptr + field_offset, data);
 }
 
+static void wm_adsp_remove_padding(u32 *buf, int nwords, int data_word_size)
+{
+	u8 *pack_in = (u8 *)buf;
+	u8 *pack_out = (u8 *)buf;
+	int i, j;
+
+	/* Remove the padding bytes from the data read from the DSP */
+	for (i = 0; i < nwords; i++) {
+		for (j = 0; j < data_word_size; j++)
+			*pack_out++ = *pack_in++;
+
+		pack_in += sizeof(*buf) - data_word_size;
+	}
+}
+
 static int wm_adsp_legacy_host_buf_addr(struct wm_adsp_compr_buf *buf)
 {
 	struct wm_adsp_alg_region *alg_region;
@@ -3666,11 +3681,9 @@ EXPORT_SYMBOL_GPL(wm_adsp_compr_pointer);
 static int wm_adsp_buffer_capture_block(struct wm_adsp_compr *compr, int target)
 {
 	struct wm_adsp_compr_buf *buf = compr->buf;
-	u8 *pack_in = (u8 *)compr->raw_buf;
-	u8 *pack_out = (u8 *)compr->raw_buf;
 	unsigned int adsp_addr;
 	int mem_type, nwords, max_read;
-	int i, j, ret;
+	int i, ret;
 
 	/* Calculate read parameters */
 	for (i = 0; i < wm_adsp_fw[buf->dsp->fw].caps->num_regions; ++i)
@@ -3702,13 +3715,7 @@ static int wm_adsp_buffer_capture_block(struct wm_adsp_compr *compr, int target)
 	if (ret < 0)
 		return ret;
 
-	/* Remove the padding bytes from the data read from the DSP */
-	for (i = 0; i < nwords; i++) {
-		for (j = 0; j < WM_ADSP_DATA_WORD_SIZE; j++)
-			*pack_out++ = *pack_in++;
-
-		pack_in += sizeof(*(compr->raw_buf)) - WM_ADSP_DATA_WORD_SIZE;
-	}
+	wm_adsp_remove_padding(compr->raw_buf, nwords, WM_ADSP_DATA_WORD_SIZE);
 
 	/* update read index to account for words read */
 	buf->read_index += nwords;
-- 
2.20.1
