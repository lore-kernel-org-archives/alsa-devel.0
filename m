From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Rename memory fields in
	wm_adsp_buffer" to the asoc tree
Date: Fri, 19 Oct 2018 13:33:45 +0100 (BST)
Message-ID: <20181019123345.55FCE1122548@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1802A267950
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2018 14:33:47 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Rename memory fields in wm_adsp_buffer

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

>From 2a2aefa41ce48ace8e1e963cb10c3f5ff43aa994 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.cirrus.com>
Date: Fri, 19 Oct 2018 13:25:15 +0100
Subject: [PATCH] ASoC: wm_adsp: Rename memory fields in wm_adsp_buffer

The wm_adsp_buffer struct is the control header of a circular
buffer used to transfer data from the firmware over the
control interface to an ALSA compressed stream.

The original names of the fields pointing to the data buffer
were based on ADSP2V2 memory layout where they correspond to
{XM, XM, YM}. But this circular buffer could be used on other
types of DSP core that have different memory region types.
Also the names and description of the size fields were not
very clear. The field names and descriptions have been changed
to be generic and not imply any particular memory types.

This patch updates the wm_adsp driver to the new field names.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index f61656070225..7ae10c632614 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -311,12 +311,12 @@ struct wm_adsp_alg_xm_struct {
 };
 
 struct wm_adsp_buffer {
-	__be32 X_buf_base;		/* XM base addr of first X area */
-	__be32 X_buf_size;		/* Size of 1st X area in words */
-	__be32 X_buf_base2;		/* XM base addr of 2nd X area */
-	__be32 X_buf_brk;		/* Total X size in words */
-	__be32 Y_buf_base;		/* YM base addr of Y area */
-	__be32 wrap;			/* Total size X and Y in words */
+	__be32 buf1_base;		/* Base addr of first buffer area */
+	__be32 buf1_size;		/* Size of buf1 area in DSP words */
+	__be32 buf2_base;		/* Base addr of 2nd buffer area */
+	__be32 buf1_buf2_size;		/* Size of buf1+buf2 in DSP words */
+	__be32 buf3_base;		/* Base addr of buf3 area */
+	__be32 buf_total_size;		/* Size of buf1+buf2+buf3 in DSP words */
 	__be32 high_water_mark;		/* Point at which IRQ is asserted */
 	__be32 irq_count;		/* bits 1-31 count IRQ assertions */
 	__be32 irq_ack;			/* acked IRQ count, bit 0 enables IRQ */
@@ -393,18 +393,18 @@ struct wm_adsp_buffer_region_def {
 static const struct wm_adsp_buffer_region_def default_regions[] = {
 	{
 		.mem_type = WMFW_ADSP2_XM,
-		.base_offset = HOST_BUFFER_FIELD(X_buf_base),
-		.size_offset = HOST_BUFFER_FIELD(X_buf_size),
+		.base_offset = HOST_BUFFER_FIELD(buf1_base),
+		.size_offset = HOST_BUFFER_FIELD(buf1_size),
 	},
 	{
 		.mem_type = WMFW_ADSP2_XM,
-		.base_offset = HOST_BUFFER_FIELD(X_buf_base2),
-		.size_offset = HOST_BUFFER_FIELD(X_buf_brk),
+		.base_offset = HOST_BUFFER_FIELD(buf2_base),
+		.size_offset = HOST_BUFFER_FIELD(buf1_buf2_size),
 	},
 	{
 		.mem_type = WMFW_ADSP2_YM,
-		.base_offset = HOST_BUFFER_FIELD(Y_buf_base),
-		.size_offset = HOST_BUFFER_FIELD(wrap),
+		.base_offset = HOST_BUFFER_FIELD(buf3_base),
+		.size_offset = HOST_BUFFER_FIELD(buf_total_size),
 	},
 };
 
-- 
2.19.0.rc2
