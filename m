From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 3/6] ASoC: wm_adsp: Add debug audio trace
	firmware
Date: Thu, 21 Jan 2016 17:52:59 +0000
Message-ID: <1453398782-32198-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1453398782-32198-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id B87502606C1
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2016 18:53:10 +0100 (CET)
In-Reply-To: <1453398782-32198-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The audio trace firmware allows the capture of arbitrary streams of
audio from the DSP and commonly used for debugging other firmwares. This
patch adds support for this firwmare into the ADSP driver.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
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
2.1.4
