From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Add debug audio trace
	firmware" to the asoc tree
Date: Fri, 29 Jan 2016 01:16:41 +0100
Message-ID: <E1aOwjx-0005Xt-2j@finisterre>
References: <1453398782-32198-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EAD7261546
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2016 01:16:53 +0100 (CET)
In-Reply-To: <1453398782-32198-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

   ASoC: wm_adsp: Add debug audio trace firmware

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

>From 7ce4283ca405d459c186960ed39d41ec0e6fb2bf Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Thu, 21 Jan 2016 17:52:59 +0000
Subject: [PATCH] ASoC: wm_adsp: Add debug audio trace firmware

The audio trace firmware allows the capture of arbitrary streams of
audio from the DSP and commonly used for debugging other firmwares. This
patch adds support for this firwmare into the ADSP driver.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 0392c58..a81f568 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -367,6 +367,24 @@ static const struct wm_adsp_fw_caps ctrl_caps[] = {
 	},
 };
 
+static const struct wm_adsp_fw_caps trace_caps[] = {
+	{
+		.id = SND_AUDIOCODEC_BESPOKE,
+		.desc = {
+			.max_ch = 8,
+			.sample_rates = {
+				4000, 8000, 11025, 12000, 16000, 22050,
+				24000, 32000, 44100, 48000, 64000, 88200,
+				96000, 176400, 192000
+			},
+			.num_sample_rates = 15,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+		.num_regions = ARRAY_SIZE(default_regions),
+		.region_defs = default_regions,
+	},
+};
+
 static const struct {
 	const char *file;
 	int compr_direction;
@@ -386,7 +404,12 @@ static const struct {
 		.caps = ctrl_caps,
 	},
 	[WM_ADSP_FW_ASR] =      { .file = "asr" },
-	[WM_ADSP_FW_TRACE] =    { .file = "trace" },
+	[WM_ADSP_FW_TRACE] =    {
+		.file = "trace",
+		.compr_direction = SND_COMPRESS_CAPTURE,
+		.num_caps = ARRAY_SIZE(trace_caps),
+		.caps = trace_caps,
+	},
 	[WM_ADSP_FW_SPK_PROT] = { .file = "spk-prot" },
 	[WM_ADSP_FW_MISC] =     { .file = "misc" },
 };
-- 
2.6.4
