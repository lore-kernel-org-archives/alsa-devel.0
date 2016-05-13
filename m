From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 3/5] ASoC: wm_adsp: Specifically propagate
	voice trigger event to caller
Date: Fri, 13 May 2016 16:45:17 +0100
Message-ID: <1463154319-10070-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1463154319-10070-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 1510F26070F
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 17:45:14 +0200 (CEST)
In-Reply-To: <1463154319-10070-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lee.jones@linaro.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The DSP uses an IRQ to indicate data is available on the compressed
stream. For voice trigger use-cases the first such IRQ can be considered
an indication that the user has spoken the key phrase triggering the
firmware. Provide a means for the ADSP code to communicate back to the
calling driver whether an IRQ should be considered as trigger event or
not.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 5 +++++
 sound/soc/codecs/wm_adsp.h | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index a07bd7c..378ec30 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -394,6 +394,7 @@ static const struct {
 	int compr_direction;
 	int num_caps;
 	const struct wm_adsp_fw_caps *caps;
+	bool voice_trigger;
 } wm_adsp_fw[WM_ADSP_NUM_FW] = {
 	[WM_ADSP_FW_MBC_VSS] =  { .file = "mbc-vss" },
 	[WM_ADSP_FW_HIFI] =     { .file = "hifi" },
@@ -406,6 +407,7 @@ static const struct {
 		.compr_direction = SND_COMPRESS_CAPTURE,
 		.num_caps = ARRAY_SIZE(ctrl_caps),
 		.caps = ctrl_caps,
+		.voice_trigger = true,
 	},
 	[WM_ADSP_FW_ASR] =      { .file = "asr" },
 	[WM_ADSP_FW_TRACE] =    {
@@ -2998,6 +3000,9 @@ int wm_adsp_compr_handle_irq(struct wm_adsp *dsp)
 		goto out;
 	}
 
+	if (wm_adsp_fw[dsp->fw].voice_trigger && buf->irq_count == 2)
+		ret = WM_ADSP_COMPR_VOICE_TRIGGER;
+
 out_notify:
 	if (compr && compr->stream)
 		snd_compr_fragment_elapsed(compr->stream);
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index feb61e2..be3b5bc 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -19,6 +19,10 @@
 
 #include "wmfw.h"
 
+/* Return values for wm_adsp_compr_handle_irq */
+#define WM_ADSP_COMPR_OK                 0
+#define WM_ADSP_COMPR_VOICE_TRIGGER      1
+
 struct wm_adsp_region {
 	int type;
 	unsigned int base;
-- 
2.1.4
