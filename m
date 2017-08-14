From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH] arizona: anc: Correct setting of
	FCx_MIC_MODE_SEL
Date: Mon, 14 Aug 2017 15:45:57 +0100
Message-ID: <20170814144557.6875-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id C95C1267368
 for <alsa-devel@alsa-project.org>; Mon, 14 Aug 2017 16:46:01 +0200 (CEST)
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
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, sapthagiri.baratam@incubesol.com
List-Id: alsa-devel@alsa-project.org

From: Sapthagiri Baratam <sapthagiri.baratam@cirrus.com>

The mask rather than the shift is accidentally passed to the
SOC_ENUM_SINGLE macro which results in the wrong bits being set for this
control, change to using the shift to correct this.

Signed-off-by: Sapthagiri Baratam <sapthagiri.baratam@cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/arizona.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 0a734d910850..a1149f6a8450 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -710,7 +710,7 @@ const struct soc_enum arizona_anc_input_src[] = {
 			ARRAY_SIZE(arizona_anc_input_src_text),
 			arizona_anc_input_src_text),
 	SOC_ENUM_SINGLE(ARIZONA_FCL_ADC_REFORMATTER_CONTROL,
-			ARIZONA_FCL_MIC_MODE_SEL,
+			ARIZONA_FCL_MIC_MODE_SEL_SHIFT,
 			ARRAY_SIZE(arizona_anc_channel_src_text),
 			arizona_anc_channel_src_text),
 	SOC_ENUM_SINGLE(ARIZONA_ANC_SRC,
@@ -718,7 +718,7 @@ const struct soc_enum arizona_anc_input_src[] = {
 			ARRAY_SIZE(arizona_anc_input_src_text),
 			arizona_anc_input_src_text),
 	SOC_ENUM_SINGLE(ARIZONA_FCR_ADC_REFORMATTER_CONTROL,
-			ARIZONA_FCR_MIC_MODE_SEL,
+			ARIZONA_FCR_MIC_MODE_SEL_SHIFT,
 			ARRAY_SIZE(arizona_anc_channel_src_text),
 			arizona_anc_channel_src_text),
 };
-- 
2.11.0
