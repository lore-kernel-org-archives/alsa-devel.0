From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm_adsp: Add missing const from region
	definitions
Date: Mon, 1 Feb 2016 15:22:34 +0000
Message-ID: <1454340154-16544-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id B1495260481
 for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2016 16:22:38 +0100 (CET)
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

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 653dbff..28d3851 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -325,7 +325,7 @@ struct wm_adsp_buffer_region_def {
 	unsigned int size_offset;
 };
 
-static struct wm_adsp_buffer_region_def default_regions[] = {
+static const struct wm_adsp_buffer_region_def default_regions[] = {
 	{
 		.mem_type = WMFW_ADSP2_XM,
 		.base_offset = HOST_BUFFER_FIELD(X_buf_base),
@@ -347,7 +347,7 @@ struct wm_adsp_fw_caps {
 	u32 id;
 	struct snd_codec_desc desc;
 	int num_regions;
-	struct wm_adsp_buffer_region_def *region_defs;
+	const struct wm_adsp_buffer_region_def *region_defs;
 };
 
 static const struct wm_adsp_fw_caps ctrl_caps[] = {
-- 
2.1.4
