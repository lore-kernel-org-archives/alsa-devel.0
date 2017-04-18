From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: cs35l35: Correct some register defaults
Date: Tue, 18 Apr 2017 18:32:52 +0100
Message-ID: <1492536772-10066-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EB7C266BC1
 for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2017 19:32:00 +0200 (CEST)
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
Cc: brian.austin@cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Correct some minor errors in the register defaults.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs35l35.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
index 88c48e2..f8aef58 100644
--- a/sound/soc/codecs/cs35l35.c
+++ b/sound/soc/codecs/cs35l35.c
@@ -50,7 +50,7 @@ static const struct reg_default cs35l35_reg[] = {
 	{CS35L35_PWRCTL2,		0x11},
 	{CS35L35_PWRCTL3,		0x00},
 	{CS35L35_CLK_CTL1,		0x04},
-	{CS35L35_CLK_CTL2,		0x10},
+	{CS35L35_CLK_CTL2,		0x12},
 	{CS35L35_CLK_CTL3,		0xCF},
 	{CS35L35_SP_FMT_CTL1,		0x20},
 	{CS35L35_SP_FMT_CTL2,		0x00},
@@ -70,7 +70,7 @@ static const struct reg_default cs35l35_reg[] = {
 	{CS35L35_BST_RAMP_CTL,		0x85},
 	{CS35L35_BST_CONV_COEF_1,	0x24},
 	{CS35L35_BST_CONV_COEF_2,	0x24},
-	{CS35L35_BST_CONV_SLOPE_COMP,	0x47},
+	{CS35L35_BST_CONV_SLOPE_COMP,	0x4E},
 	{CS35L35_BST_CONV_SW_FREQ,	0x04},
 	{CS35L35_CLASS_H_CTL,		0x0B},
 	{CS35L35_CLASS_H_HEADRM_CTL,	0x0B},
@@ -78,9 +78,9 @@ static const struct reg_default cs35l35_reg[] = {
 	{CS35L35_CLASS_H_FET_DRIVE_CTL, 0x41},
 	{CS35L35_CLASS_H_VP_CTL,	0xC5},
 	{CS35L35_VPBR_CTL,		0x0A},
-	{CS35L35_VPBR_VOL_CTL,		0x09},
+	{CS35L35_VPBR_VOL_CTL,		0x90},
 	{CS35L35_VPBR_TIMING_CTL,	0x6A},
-	{CS35L35_VPBR_MODE_VOL_CTL,	0x40},
+	{CS35L35_VPBR_MODE_VOL_CTL,	0x00},
 	{CS35L35_SPKR_MON_CTL,		0xC0},
 	{CS35L35_IMON_SCALE_CTL,	0x30},
 	{CS35L35_AUDIN_RXLOC_CTL,	0x00},
-- 
2.1.4
