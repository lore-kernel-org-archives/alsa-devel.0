From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Refactor firmware status
	reading" to the asoc tree
Date: Tue, 19 Mar 2019 13:13:10 +0000 (GMT)
Message-ID: <20190319131311.0167611288DF@debutante.sirena.org.uk>
References: <20190319115215.22960-8-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ADA42F896FD
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 14:13:12 +0100 (CET)
In-Reply-To: <20190319115215.22960-8-ckeepax@opensource.cirrus.com>
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
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, david.rhodes@cirrus.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Refactor firmware status reading

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

>From 4049ce86fc9b0512d4f624bb8b63c8f513fb66d1 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Tue, 19 Mar 2019 11:52:10 +0000
Subject: [PATCH] ASoC: wm_adsp: Refactor firmware status reading

In preparation for further additions refactor the reading of the
firmware status.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 43 ++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 8800ffcc4f8c..fb252762f23c 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -788,49 +788,42 @@ static unsigned int wm_adsp_region_to_reg(struct wm_adsp_region const *mem,
 	}
 }
 
-static void wm_adsp2_show_fw_status(struct wm_adsp *dsp)
+static void wm_adsp_read_fw_status(struct wm_adsp *dsp,
+				   int noffs, unsigned int *offs)
 {
-	unsigned int scratch[4];
-	unsigned int addr = dsp->base + ADSP2_SCRATCH0;
 	unsigned int i;
 	int ret;
 
-	for (i = 0; i < ARRAY_SIZE(scratch); ++i) {
-		ret = regmap_read(dsp->regmap, addr + i, &scratch[i]);
+	for (i = 0; i < noffs; ++i) {
+		ret = regmap_read(dsp->regmap, dsp->base + offs[i], &offs[i]);
 		if (ret) {
 			adsp_err(dsp, "Failed to read SCRATCH%u: %d\n", i, ret);
 			return;
 		}
 	}
+}
+
+static void wm_adsp2_show_fw_status(struct wm_adsp *dsp)
+{
+	unsigned int offs[] = {
+		ADSP2_SCRATCH0, ADSP2_SCRATCH1, ADSP2_SCRATCH2, ADSP2_SCRATCH3,
+	};
+
+	wm_adsp_read_fw_status(dsp, ARRAY_SIZE(offs), offs);
 
 	adsp_dbg(dsp, "FW SCRATCH 0:0x%x 1:0x%x 2:0x%x 3:0x%x\n",
-		 scratch[0], scratch[1], scratch[2], scratch[3]);
+		 offs[0], offs[1], offs[2], offs[3]);
 }
 
 static void wm_adsp2v2_show_fw_status(struct wm_adsp *dsp)
 {
-	unsigned int scratch[2];
-	int ret;
+	unsigned int offs[] = { ADSP2V2_SCRATCH0_1, ADSP2V2_SCRATCH2_3 };
 
-	ret = regmap_read(dsp->regmap, dsp->base + ADSP2V2_SCRATCH0_1,
-			  &scratch[0]);
-	if (ret) {
-		adsp_err(dsp, "Failed to read SCRATCH0_1: %d\n", ret);
-		return;
-	}
-
-	ret = regmap_read(dsp->regmap, dsp->base + ADSP2V2_SCRATCH2_3,
-			  &scratch[1]);
-	if (ret) {
-		adsp_err(dsp, "Failed to read SCRATCH2_3: %d\n", ret);
-		return;
-	}
+	wm_adsp_read_fw_status(dsp, ARRAY_SIZE(offs), offs);
 
 	adsp_dbg(dsp, "FW SCRATCH 0:0x%x 1:0x%x 2:0x%x 3:0x%x\n",
-		 scratch[0] & 0xFFFF,
-		 scratch[0] >> 16,
-		 scratch[1] & 0xFFFF,
-		 scratch[1] >> 16);
+		 offs[0] & 0xFFFF, offs[0] >> 16,
+		 offs[1] & 0xFFFF, offs[1] >> 16);
 }
 
 static inline struct wm_coeff_ctl *bytes_ext_to_ctl(struct soc_bytes_ext *ext)
-- 
2.20.1
