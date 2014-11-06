From: <bardliao@realtek.com>
Subject: [PATCH 2/4] ASoC:rt5670:correct the incorrect default
	values
Date: Thu, 6 Nov 2014 12:23:52 +0800
Message-ID: <1415247834-14278-2-git-send-email-bardliao@realtek.com>
References: <1415247834-14278-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 21EFB26070A
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 05:24:36 +0100 (CET)
In-Reply-To: <1415247834-14278-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, mengdong.lin@intel.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

The patch corrects the incorrect default register values.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5670.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 97359b3..7592814 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -102,18 +102,18 @@ static const struct reg_default rt5670_reg[] = {
 	{ 0x4c, 0x5380 },
 	{ 0x4f, 0x0073 },
 	{ 0x52, 0x00d3 },
-	{ 0x53, 0xf0f0 },
+	{ 0x53, 0xf000 },
 	{ 0x61, 0x0000 },
 	{ 0x62, 0x0001 },
 	{ 0x63, 0x00c3 },
 	{ 0x64, 0x0000 },
-	{ 0x65, 0x0000 },
+	{ 0x65, 0x0001 },
 	{ 0x66, 0x0000 },
 	{ 0x6f, 0x8000 },
 	{ 0x70, 0x8000 },
 	{ 0x71, 0x8000 },
 	{ 0x72, 0x8000 },
-	{ 0x73, 0x1110 },
+	{ 0x73, 0x7770 },
 	{ 0x74, 0x0e00 },
 	{ 0x75, 0x1505 },
 	{ 0x76, 0x0015 },
@@ -127,21 +127,21 @@ static const struct reg_default rt5670_reg[] = {
 	{ 0x83, 0x0000 },
 	{ 0x84, 0x0000 },
 	{ 0x85, 0x0000 },
-	{ 0x86, 0x0008 },
+	{ 0x86, 0x0004 },
 	{ 0x87, 0x0000 },
 	{ 0x88, 0x0000 },
 	{ 0x89, 0x0000 },
 	{ 0x8a, 0x0000 },
 	{ 0x8b, 0x0000 },
-	{ 0x8c, 0x0007 },
+	{ 0x8c, 0x0003 },
 	{ 0x8d, 0x0000 },
 	{ 0x8e, 0x0004 },
 	{ 0x8f, 0x1100 },
 	{ 0x90, 0x0646 },
 	{ 0x91, 0x0c06 },
 	{ 0x93, 0x0000 },
-	{ 0x94, 0x0000 },
-	{ 0x95, 0x0000 },
+	{ 0x94, 0x1270 },
+	{ 0x95, 0x1000 },
 	{ 0x97, 0x0000 },
 	{ 0x98, 0x0000 },
 	{ 0x99, 0x0000 },
@@ -152,11 +152,11 @@ static const struct reg_default rt5670_reg[] = {
 	{ 0x9e, 0x0400 },
 	{ 0xae, 0x7000 },
 	{ 0xaf, 0x0000 },
-	{ 0xb0, 0x6000 },
+	{ 0xb0, 0x7000 },
 	{ 0xb1, 0x0000 },
 	{ 0xb2, 0x0000 },
 	{ 0xb3, 0x001f },
-	{ 0xb4, 0x2206 },
+	{ 0xb4, 0x220c },
 	{ 0xb5, 0x1f00 },
 	{ 0xb6, 0x0000 },
 	{ 0xb7, 0x0000 },
@@ -173,25 +173,25 @@ static const struct reg_default rt5670_reg[] = {
 	{ 0xcf, 0x1813 },
 	{ 0xd0, 0x0690 },
 	{ 0xd1, 0x1c17 },
-	{ 0xd3, 0xb320 },
+	{ 0xd3, 0xa220 },
 	{ 0xd4, 0x0000 },
 	{ 0xd6, 0x0400 },
 	{ 0xd9, 0x0809 },
 	{ 0xda, 0x0000 },
 	{ 0xdb, 0x0001 },
 	{ 0xdc, 0x0049 },
-	{ 0xdd, 0x0009 },
+	{ 0xdd, 0x0024 },
 	{ 0xe6, 0x8000 },
 	{ 0xe7, 0x0000 },
-	{ 0xec, 0xb300 },
+	{ 0xec, 0xa200 },
 	{ 0xed, 0x0000 },
-	{ 0xee, 0xb300 },
+	{ 0xee, 0xa200 },
 	{ 0xef, 0x0000 },
 	{ 0xf8, 0x0000 },
 	{ 0xf9, 0x0000 },
 	{ 0xfa, 0x8010 },
 	{ 0xfb, 0x0033 },
-	{ 0xfc, 0x0080 },
+	{ 0xfc, 0x0100 },
 };
 
 static bool rt5670_volatile_register(struct device *dev, unsigned int reg)
-- 
1.8.1.1.439.g50a6b54
