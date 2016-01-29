From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Use more generic naming for
	regions and caps definitions" to the asoc tree
Date: Fri, 29 Jan 2016 01:16:42 +0100
Message-ID: <E1aOwjy-0005YM-MF@finisterre>
References: <1453398782-32198-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EC0B126154E
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2016 01:16:54 +0100 (CET)
In-Reply-To: <1453398782-32198-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Use more generic naming for regions and caps definitions

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From e6d00f3403c439b8d1e6f9f09d5ae3048aa726e4 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Thu, 21 Jan 2016 17:52:58 +0000
Subject: [PATCH] ASoC: wm_adsp: Use more generic naming for regions and caps
 definitions

The region definition will be shared by most firmwares so give this a
more generic name and whilst we are there improve the naming of the
voice control capabilities array as well.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 33806d4..0392c58 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -328,7 +328,7 @@ struct wm_adsp_buffer_region_def {
 	unsigned int size_offset;
 };
 
-static struct wm_adsp_buffer_region_def ez2control_regions[] = {
+static struct wm_adsp_buffer_region_def default_regions[] = {
 	{
 		.mem_type = WMFW_ADSP2_XM,
 		.base_offset = HOST_BUFFER_FIELD(X_buf_base),
@@ -353,7 +353,7 @@ struct wm_adsp_fw_caps {
 	struct wm_adsp_buffer_region_def *region_defs;
 };
 
-static const struct wm_adsp_fw_caps ez2control_caps[] = {
+static const struct wm_adsp_fw_caps ctrl_caps[] = {
 	{
 		.id = SND_AUDIOCODEC_BESPOKE,
 		.desc = {
@@ -362,8 +362,8 @@ static const struct wm_adsp_fw_caps ez2control_caps[] = {
 			.num_sample_rates = 1,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE,
 		},
-		.num_regions = ARRAY_SIZE(ez2control_regions),
-		.region_defs = ez2control_regions,
+		.num_regions = ARRAY_SIZE(default_regions),
+		.region_defs = default_regions,
 	},
 };
 
@@ -382,8 +382,8 @@ static const struct {
 	[WM_ADSP_FW_CTRL] =     {
 		.file = "ctrl",
 		.compr_direction = SND_COMPRESS_CAPTURE,
-		.num_caps = ARRAY_SIZE(ez2control_caps),
-		.caps = ez2control_caps,
+		.num_caps = ARRAY_SIZE(ctrl_caps),
+		.caps = ctrl_caps,
 	},
 	[WM_ADSP_FW_ASR] =      { .file = "asr" },
 	[WM_ADSP_FW_TRACE] =    { .file = "trace" },
-- 
2.6.4
