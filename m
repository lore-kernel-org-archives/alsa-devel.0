From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: wm_adsp: Use __leXX for little
	endian data
Date: Mon, 20 Apr 2015 13:52:44 +0100
Message-ID: <1429534365-13439-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2B6B226587C
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 14:59:34 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, fengguang.wu@intel.com, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Using uXX for little endian data, was triggering some warnings through
sparse:

sound/soc/codecs/wm_adsp.c:716:26: sparse: cast to restricted __le16
sound/soc/codecs/wm_adsp.c:736:23: sparse: cast to restricted __le16
sound/soc/codecs/wm_adsp.c:739:23: sparse: cast to restricted __le32

Correct this by changing the casts to use __leXX instead of uXX.

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 00289bf..53fc7f8 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -713,7 +713,7 @@ static int wm_coeff_parse_string(int bytes, const u8 **pos, const u8 **str)
 		length = **pos;
 		break;
 	case 2:
-		length = le16_to_cpu(*((u16 *)*pos));
+		length = le16_to_cpu(*((__le16 *)*pos));
 		break;
 	default:
 		return 0;
@@ -733,10 +733,10 @@ static int wm_coeff_parse_int(int bytes, const u8 **pos)
 
 	switch (bytes) {
 	case 2:
-		val = le16_to_cpu(*((u16 *)*pos));
+		val = le16_to_cpu(*((__le16 *)*pos));
 		break;
 	case 4:
-		val = le32_to_cpu(*((u32 *)*pos));
+		val = le32_to_cpu(*((__le32 *)*pos));
 		break;
 	default:
 		break;
-- 
1.7.2.5
