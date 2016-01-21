From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/6] ASoC: wm_adsp: Use more generic naming for
	regions and caps definitions
Date: Thu, 21 Jan 2016 17:52:58 +0000
Message-ID: <1453398782-32198-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1453398782-32198-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id B5DCB26062B
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2016 18:53:04 +0100 (CET)
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

The region definition will be shared by most firmwares so give this a
more generic name and whilst we are there improve the naming of the
voice control capabilities array as well.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
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
2.1.4
