From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Convert WM8995 to direct regcache usage
Date: Thu, 10 Nov 2011 17:16:30 +0000
Message-ID: <1320945390-16869-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2DE49243ED
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 18:16:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Large code size increase due to the addition of readability information
and the reformatting of the defaults table.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8995.c |  717 ++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 608 insertions(+), 109 deletions(-)

diff --git a/sound/soc/codecs/wm8995.c b/sound/soc/codecs/wm8995.c
index 4d109b1..3774acb 100644
--- a/sound/soc/codecs/wm8995.c
+++ b/sound/soc/codecs/wm8995.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/regmap.h>
 #include <linux/spi/spi.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
@@ -43,88 +44,331 @@ static const char *wm8995_supply_names[WM8995_NUM_SUPPLIES] = {
 	"MICVDD"
 };
 
-static const u16 wm8995_reg_defs[WM8995_MAX_REGISTER + 1] = {
-	[0]     = 0x8995, [5]     = 0x0100, [16]    = 0x000b, [17]    = 0x000b,
-	[24]    = 0x02c0, [25]    = 0x02c0, [26]    = 0x02c0, [27]    = 0x02c0,
-	[28]    = 0x000f, [32]    = 0x0005, [33]    = 0x0005, [40]    = 0x0003,
-	[41]    = 0x0013, [48]    = 0x0004, [56]    = 0x09f8, [64]    = 0x1f25,
-	[69]    = 0x0004, [82]    = 0xaaaa, [84]    = 0x2a2a, [146]   = 0x0060,
-	[256]   = 0x0002, [257]   = 0x8004, [520]   = 0x0010, [528]   = 0x0083,
-	[529]   = 0x0083, [548]   = 0x0c80, [580]   = 0x0c80, [768]   = 0x4050,
-	[769]   = 0x4000, [771]   = 0x0040, [772]   = 0x0040, [773]   = 0x0040,
-	[774]   = 0x0004, [775]   = 0x0100, [784]   = 0x4050, [785]   = 0x4000,
-	[787]   = 0x0040, [788]   = 0x0040, [789]   = 0x0040, [1024]  = 0x00c0,
-	[1025]  = 0x00c0, [1026]  = 0x00c0, [1027]  = 0x00c0, [1028]  = 0x00c0,
-	[1029]  = 0x00c0, [1030]  = 0x00c0, [1031]  = 0x00c0, [1056]  = 0x0200,
-	[1057]  = 0x0010, [1058]  = 0x0200, [1059]  = 0x0010, [1088]  = 0x0098,
-	[1089]  = 0x0845, [1104]  = 0x0098, [1105]  = 0x0845, [1152]  = 0x6318,
-	[1153]  = 0x6300, [1154]  = 0x0fca, [1155]  = 0x0400, [1156]  = 0x00d8,
-	[1157]  = 0x1eb5, [1158]  = 0xf145, [1159]  = 0x0b75, [1160]  = 0x01c5,
-	[1161]  = 0x1c58, [1162]  = 0xf373, [1163]  = 0x0a54, [1164]  = 0x0558,
-	[1165]  = 0x168e, [1166]  = 0xf829, [1167]  = 0x07ad, [1168]  = 0x1103,
-	[1169]  = 0x0564, [1170]  = 0x0559, [1171]  = 0x4000, [1184]  = 0x6318,
-	[1185]  = 0x6300, [1186]  = 0x0fca, [1187]  = 0x0400, [1188]  = 0x00d8,
-	[1189]  = 0x1eb5, [1190]  = 0xf145, [1191]  = 0x0b75, [1192]  = 0x01c5,
-	[1193]  = 0x1c58, [1194]  = 0xf373, [1195]  = 0x0a54, [1196]  = 0x0558,
-	[1197]  = 0x168e, [1198]  = 0xf829, [1199]  = 0x07ad, [1200]  = 0x1103,
-	[1201]  = 0x0564, [1202]  = 0x0559, [1203]  = 0x4000, [1280]  = 0x00c0,
-	[1281]  = 0x00c0, [1282]  = 0x00c0, [1283]  = 0x00c0, [1312]  = 0x0200,
-	[1313]  = 0x0010, [1344]  = 0x0098, [1345]  = 0x0845, [1408]  = 0x6318,
-	[1409]  = 0x6300, [1410]  = 0x0fca, [1411]  = 0x0400, [1412]  = 0x00d8,
-	[1413]  = 0x1eb5, [1414]  = 0xf145, [1415]  = 0x0b75, [1416]  = 0x01c5,
-	[1417]  = 0x1c58, [1418]  = 0xf373, [1419]  = 0x0a54, [1420]  = 0x0558,
-	[1421]  = 0x168e, [1422]  = 0xf829, [1423]  = 0x07ad, [1424]  = 0x1103,
-	[1425]  = 0x0564, [1426]  = 0x0559, [1427]  = 0x4000, [1568]  = 0x0002,
-	[1792]  = 0xa100, [1793]  = 0xa101, [1794]  = 0xa101, [1795]  = 0xa101,
-	[1796]  = 0xa101, [1797]  = 0xa101, [1798]  = 0xa101, [1799]  = 0xa101,
-	[1800]  = 0xa101, [1801]  = 0xa101, [1802]  = 0xa101, [1803]  = 0xa101,
-	[1804]  = 0xa101, [1805]  = 0xa101, [1825]  = 0x0055, [1848]  = 0x3fff,
-	[1849]  = 0x1fff, [2049]  = 0x0001, [2050]  = 0x0069, [2056]  = 0x0002,
-	[2057]  = 0x0003, [2058]  = 0x0069, [12288] = 0x0001, [12289] = 0x0001,
-	[12291] = 0x0006, [12292] = 0x0040, [12293] = 0x0001, [12294] = 0x000f,
-	[12295] = 0x0006, [12296] = 0x0001, [12297] = 0x0003, [12298] = 0x0104,
-	[12300] = 0x0060, [12301] = 0x0011, [12302] = 0x0401, [12304] = 0x0050,
-	[12305] = 0x0003, [12306] = 0x0100, [12308] = 0x0051, [12309] = 0x0003,
-	[12310] = 0x0104, [12311] = 0x000a, [12312] = 0x0060, [12313] = 0x003b,
-	[12314] = 0x0502, [12315] = 0x0100, [12316] = 0x2fff, [12320] = 0x2fff,
-	[12324] = 0x2fff, [12328] = 0x2fff, [12332] = 0x2fff, [12336] = 0x2fff,
-	[12340] = 0x2fff, [12344] = 0x2fff, [12348] = 0x2fff, [12352] = 0x0001,
-	[12353] = 0x0001, [12355] = 0x0006, [12356] = 0x0040, [12357] = 0x0001,
-	[12358] = 0x000f, [12359] = 0x0006, [12360] = 0x0001, [12361] = 0x0003,
-	[12362] = 0x0104, [12364] = 0x0060, [12365] = 0x0011, [12366] = 0x0401,
-	[12368] = 0x0050, [12369] = 0x0003, [12370] = 0x0100, [12372] = 0x0060,
-	[12373] = 0x003b, [12374] = 0x0502, [12375] = 0x0100, [12376] = 0x2fff,
-	[12380] = 0x2fff, [12384] = 0x2fff, [12388] = 0x2fff, [12392] = 0x2fff,
-	[12396] = 0x2fff, [12400] = 0x2fff, [12404] = 0x2fff, [12408] = 0x2fff,
-	[12412] = 0x2fff, [12416] = 0x0001, [12417] = 0x0001, [12419] = 0x0006,
-	[12420] = 0x0040, [12421] = 0x0001, [12422] = 0x000f, [12423] = 0x0006,
-	[12424] = 0x0001, [12425] = 0x0003, [12426] = 0x0106, [12428] = 0x0061,
-	[12429] = 0x0011, [12430] = 0x0401, [12432] = 0x0050, [12433] = 0x0003,
-	[12434] = 0x0102, [12436] = 0x0051, [12437] = 0x0003, [12438] = 0x0106,
-	[12439] = 0x000a, [12440] = 0x0061, [12441] = 0x003b, [12442] = 0x0502,
-	[12443] = 0x0100, [12444] = 0x2fff, [12448] = 0x2fff, [12452] = 0x2fff,
-	[12456] = 0x2fff, [12460] = 0x2fff, [12464] = 0x2fff, [12468] = 0x2fff,
-	[12472] = 0x2fff, [12476] = 0x2fff, [12480] = 0x0001, [12481] = 0x0001,
-	[12483] = 0x0006, [12484] = 0x0040, [12485] = 0x0001, [12486] = 0x000f,
-	[12487] = 0x0006, [12488] = 0x0001, [12489] = 0x0003, [12490] = 0x0106,
-	[12492] = 0x0061, [12493] = 0x0011, [12494] = 0x0401, [12496] = 0x0050,
-	[12497] = 0x0003, [12498] = 0x0102, [12500] = 0x0061, [12501] = 0x003b,
-	[12502] = 0x0502, [12503] = 0x0100, [12504] = 0x2fff, [12508] = 0x2fff,
-	[12512] = 0x2fff, [12516] = 0x2fff, [12520] = 0x2fff, [12524] = 0x2fff,
-	[12528] = 0x2fff, [12532] = 0x2fff, [12536] = 0x2fff, [12540] = 0x2fff,
-	[12544] = 0x0060, [12546] = 0x0601, [12548] = 0x0050, [12550] = 0x0100,
-	[12552] = 0x0001, [12554] = 0x0104, [12555] = 0x0100, [12556] = 0x2fff,
-	[12560] = 0x2fff, [12564] = 0x2fff, [12568] = 0x2fff, [12572] = 0x2fff,
-	[12576] = 0x2fff, [12580] = 0x2fff, [12584] = 0x2fff, [12588] = 0x2fff,
-	[12592] = 0x2fff, [12596] = 0x2fff, [12600] = 0x2fff, [12604] = 0x2fff,
-	[12608] = 0x0061, [12610] = 0x0601, [12612] = 0x0050, [12614] = 0x0102,
-	[12616] = 0x0001, [12618] = 0x0106, [12619] = 0x0100, [12620] = 0x2fff,
-	[12624] = 0x2fff, [12628] = 0x2fff, [12632] = 0x2fff, [12636] = 0x2fff,
-	[12640] = 0x2fff, [12644] = 0x2fff, [12648] = 0x2fff, [12652] = 0x2fff,
-	[12656] = 0x2fff, [12660] = 0x2fff, [12664] = 0x2fff, [12668] = 0x2fff,
-	[12672] = 0x0060, [12674] = 0x0601, [12676] = 0x0061, [12678] = 0x0601,
-	[12680] = 0x0050, [12682] = 0x0300, [12684] = 0x0001, [12686] = 0x0304,
-	[12688] = 0x0040, [12690] = 0x000f, [12692] = 0x0001, [12695] = 0x0100
+static struct reg_default wm8995_reg_defaults[] = {
+	{ 0, 0x8995 },
+	{ 5, 0x0100 },
+	{ 16, 0x000b },
+	{ 17, 0x000b },
+	{ 24, 0x02c0 },
+	{ 25, 0x02c0 },
+	{ 26, 0x02c0 },
+	{ 27, 0x02c0 },
+	{ 28, 0x000f },
+	{ 32, 0x0005 },
+	{ 33, 0x0005 },
+	{ 40, 0x0003 },
+	{ 41, 0x0013 },
+	{ 48, 0x0004 },
+	{ 56, 0x09f8 },
+	{ 64, 0x1f25 },
+	{ 69, 0x0004 },
+	{ 82, 0xaaaa },
+	{ 84, 0x2a2a },
+	{ 146, 0x0060 },
+	{ 256, 0x0002 },
+	{ 257, 0x8004 },
+	{ 520, 0x0010 },
+	{ 528, 0x0083 },
+	{ 529, 0x0083 },
+	{ 548, 0x0c80 },
+	{ 580, 0x0c80 },
+	{ 768, 0x4050 },
+	{ 769, 0x4000 },
+	{ 771, 0x0040 },
+	{ 772, 0x0040 },
+	{ 773, 0x0040 },
+	{ 774, 0x0004 },
+	{ 775, 0x0100 },
+	{ 784, 0x4050 },
+	{ 785, 0x4000 },
+	{ 787, 0x0040 },
+	{ 788, 0x0040 },
+	{ 789, 0x0040 },
+	{ 1024, 0x00c0 },
+	{ 1025, 0x00c0 },
+	{ 1026, 0x00c0 },
+	{ 1027, 0x00c0 },
+	{ 1028, 0x00c0 },
+	{ 1029, 0x00c0 },
+	{ 1030, 0x00c0 },
+	{ 1031, 0x00c0 },
+	{ 1056, 0x0200 },
+	{ 1057, 0x0010 },
+	{ 1058, 0x0200 },
+	{ 1059, 0x0010 },
+	{ 1088, 0x0098 },
+	{ 1089, 0x0845 },
+	{ 1104, 0x0098 },
+	{ 1105, 0x0845 },
+	{ 1152, 0x6318 },
+	{ 1153, 0x6300 },
+	{ 1154, 0x0fca },
+	{ 1155, 0x0400 },
+	{ 1156, 0x00d8 },
+	{ 1157, 0x1eb5 },
+	{ 1158, 0xf145 },
+	{ 1159, 0x0b75 },
+	{ 1160, 0x01c5 },
+	{ 1161, 0x1c58 },
+	{ 1162, 0xf373 },
+	{ 1163, 0x0a54 },
+	{ 1164, 0x0558 },
+	{ 1165, 0x168e },
+	{ 1166, 0xf829 },
+	{ 1167, 0x07ad },
+	{ 1168, 0x1103 },
+	{ 1169, 0x0564 },
+	{ 1170, 0x0559 },
+	{ 1171, 0x4000 },
+	{ 1184, 0x6318 },
+	{ 1185, 0x6300 },
+	{ 1186, 0x0fca },
+	{ 1187, 0x0400 },
+	{ 1188, 0x00d8 },
+	{ 1189, 0x1eb5 },
+	{ 1190, 0xf145 },
+	{ 1191, 0x0b75 },
+	{ 1192, 0x01c5 },
+	{ 1193, 0x1c58 },
+	{ 1194, 0xf373 },
+	{ 1195, 0x0a54 },
+	{ 1196, 0x0558 },
+	{ 1197, 0x168e },
+	{ 1198, 0xf829 },
+	{ 1199, 0x07ad },
+	{ 1200, 0x1103 },
+	{ 1201, 0x0564 },
+	{ 1202, 0x0559 },
+	{ 1203, 0x4000 },
+	{ 1280, 0x00c0 },
+	{ 1281, 0x00c0 },
+	{ 1282, 0x00c0 },
+	{ 1283, 0x00c0 },
+	{ 1312, 0x0200 },
+	{ 1313, 0x0010 },
+	{ 1344, 0x0098 },
+	{ 1345, 0x0845 },
+	{ 1408, 0x6318 },
+	{ 1409, 0x6300 },
+	{ 1410, 0x0fca },
+	{ 1411, 0x0400 },
+	{ 1412, 0x00d8 },
+	{ 1413, 0x1eb5 },
+	{ 1414, 0xf145 },
+	{ 1415, 0x0b75 },
+	{ 1416, 0x01c5 },
+	{ 1417, 0x1c58 },
+	{ 1418, 0xf373 },
+	{ 1419, 0x0a54 },
+	{ 1420, 0x0558 },
+	{ 1421, 0x168e },
+	{ 1422, 0xf829 },
+	{ 1423, 0x07ad },
+	{ 1424, 0x1103 },
+	{ 1425, 0x0564 },
+	{ 1426, 0x0559 },
+	{ 1427, 0x4000 },
+	{ 1568, 0x0002 },
+	{ 1792, 0xa100 },
+	{ 1793, 0xa101 },
+	{ 1794, 0xa101 },
+	{ 1795, 0xa101 },
+	{ 1796, 0xa101 },
+	{ 1797, 0xa101 },
+	{ 1798, 0xa101 },
+	{ 1799, 0xa101 },
+	{ 1800, 0xa101 },
+	{ 1801, 0xa101 },
+	{ 1802, 0xa101 },
+	{ 1803, 0xa101 },
+	{ 1804, 0xa101 },
+	{ 1805, 0xa101 },
+	{ 1825, 0x0055 },
+	{ 1848, 0x3fff },
+	{ 1849, 0x1fff },
+	{ 2049, 0x0001 },
+	{ 2050, 0x0069 },
+	{ 2056, 0x0002 },
+	{ 2057, 0x0003 },
+	{ 2058, 0x0069 },
+	{ 12288, 0x0001 },
+	{ 12289, 0x0001 },
+	{ 12291, 0x0006 },
+	{ 12292, 0x0040 },
+	{ 12293, 0x0001 },
+	{ 12294, 0x000f },
+	{ 12295, 0x0006 },
+	{ 12296, 0x0001 },
+	{ 12297, 0x0003 },
+	{ 12298, 0x0104 },
+	{ 12300, 0x0060 },
+	{ 12301, 0x0011 },
+	{ 12302, 0x0401 },
+	{ 12304, 0x0050 },
+	{ 12305, 0x0003 },
+	{ 12306, 0x0100 },
+	{ 12308, 0x0051 },
+	{ 12309, 0x0003 },
+	{ 12310, 0x0104 },
+	{ 12311, 0x000a },
+	{ 12312, 0x0060 },
+	{ 12313, 0x003b },
+	{ 12314, 0x0502 },
+	{ 12315, 0x0100 },
+	{ 12316, 0x2fff },
+	{ 12320, 0x2fff },
+	{ 12324, 0x2fff },
+	{ 12328, 0x2fff },
+	{ 12332, 0x2fff },
+	{ 12336, 0x2fff },
+	{ 12340, 0x2fff },
+	{ 12344, 0x2fff },
+	{ 12348, 0x2fff },
+	{ 12352, 0x0001 },
+	{ 12353, 0x0001 },
+	{ 12355, 0x0006 },
+	{ 12356, 0x0040 },
+	{ 12357, 0x0001 },
+	{ 12358, 0x000f },
+	{ 12359, 0x0006 },
+	{ 12360, 0x0001 },
+	{ 12361, 0x0003 },
+	{ 12362, 0x0104 },
+	{ 12364, 0x0060 },
+	{ 12365, 0x0011 },
+	{ 12366, 0x0401 },
+	{ 12368, 0x0050 },
+	{ 12369, 0x0003 },
+	{ 12370, 0x0100 },
+	{ 12372, 0x0060 },
+	{ 12373, 0x003b },
+	{ 12374, 0x0502 },
+	{ 12375, 0x0100 },
+	{ 12376, 0x2fff },
+	{ 12380, 0x2fff },
+	{ 12384, 0x2fff },
+	{ 12388, 0x2fff },
+	{ 12392, 0x2fff },
+	{ 12396, 0x2fff },
+	{ 12400, 0x2fff },
+	{ 12404, 0x2fff },
+	{ 12408, 0x2fff },
+	{ 12412, 0x2fff },
+	{ 12416, 0x0001 },
+	{ 12417, 0x0001 },
+	{ 12419, 0x0006 },
+	{ 12420, 0x0040 },
+	{ 12421, 0x0001 },
+	{ 12422, 0x000f },
+	{ 12423, 0x0006 },
+	{ 12424, 0x0001 },
+	{ 12425, 0x0003 },
+	{ 12426, 0x0106 },
+	{ 12428, 0x0061 },
+	{ 12429, 0x0011 },
+	{ 12430, 0x0401 },
+	{ 12432, 0x0050 },
+	{ 12433, 0x0003 },
+	{ 12434, 0x0102 },
+	{ 12436, 0x0051 },
+	{ 12437, 0x0003 },
+	{ 12438, 0x0106 },
+	{ 12439, 0x000a },
+	{ 12440, 0x0061 },
+	{ 12441, 0x003b },
+	{ 12442, 0x0502 },
+	{ 12443, 0x0100 },
+	{ 12444, 0x2fff },
+	{ 12448, 0x2fff },
+	{ 12452, 0x2fff },
+	{ 12456, 0x2fff },
+	{ 12460, 0x2fff },
+	{ 12464, 0x2fff },
+	{ 12468, 0x2fff },
+	{ 12472, 0x2fff },
+	{ 12476, 0x2fff },
+	{ 12480, 0x0001 },
+	{ 12481, 0x0001 },
+	{ 12483, 0x0006 },
+	{ 12484, 0x0040 },
+	{ 12485, 0x0001 },
+	{ 12486, 0x000f },
+	{ 12487, 0x0006 },
+	{ 12488, 0x0001 },
+	{ 12489, 0x0003 },
+	{ 12490, 0x0106 },
+	{ 12492, 0x0061 },
+	{ 12493, 0x0011 },
+	{ 12494, 0x0401 },
+	{ 12496, 0x0050 },
+	{ 12497, 0x0003 },
+	{ 12498, 0x0102 },
+	{ 12500, 0x0061 },
+	{ 12501, 0x003b },
+	{ 12502, 0x0502 },
+	{ 12503, 0x0100 },
+	{ 12504, 0x2fff },
+	{ 12508, 0x2fff },
+	{ 12512, 0x2fff },
+	{ 12516, 0x2fff },
+	{ 12520, 0x2fff },
+	{ 12524, 0x2fff },
+	{ 12528, 0x2fff },
+	{ 12532, 0x2fff },
+	{ 12536, 0x2fff },
+	{ 12540, 0x2fff },
+	{ 12544, 0x0060 },
+	{ 12546, 0x0601 },
+	{ 12548, 0x0050 },
+	{ 12550, 0x0100 },
+	{ 12552, 0x0001 },
+	{ 12554, 0x0104 },
+	{ 12555, 0x0100 },
+	{ 12556, 0x2fff },
+	{ 12560, 0x2fff },
+	{ 12564, 0x2fff },
+	{ 12568, 0x2fff },
+	{ 12572, 0x2fff },
+	{ 12576, 0x2fff },
+	{ 12580, 0x2fff },
+	{ 12584, 0x2fff },
+	{ 12588, 0x2fff },
+	{ 12592, 0x2fff },
+	{ 12596, 0x2fff },
+	{ 12600, 0x2fff },
+	{ 12604, 0x2fff },
+	{ 12608, 0x0061 },
+	{ 12610, 0x0601 },
+	{ 12612, 0x0050 },
+	{ 12614, 0x0102 },
+	{ 12616, 0x0001 },
+	{ 12618, 0x0106 },
+	{ 12619, 0x0100 },
+	{ 12620, 0x2fff },
+	{ 12624, 0x2fff },
+	{ 12628, 0x2fff },
+	{ 12632, 0x2fff },
+	{ 12636, 0x2fff },
+	{ 12640, 0x2fff },
+	{ 12644, 0x2fff },
+	{ 12648, 0x2fff },
+	{ 12652, 0x2fff },
+	{ 12656, 0x2fff },
+	{ 12660, 0x2fff },
+	{ 12664, 0x2fff },
+	{ 12668, 0x2fff },
+	{ 12672, 0x0060 },
+	{ 12674, 0x0601 },
+	{ 12676, 0x0061 },
+	{ 12678, 0x0601 },
+	{ 12680, 0x0050 },
+	{ 12682, 0x0300 },
+	{ 12684, 0x0001 },
+	{ 12686, 0x0304 },
+	{ 12688, 0x0040 },
+	{ 12690, 0x000f },
+	{ 12692, 0x0001 },
+	{ 12695, 0x0100 },
 };
 
 struct fll_config {
@@ -134,7 +378,7 @@ struct fll_config {
 };
 
 struct wm8995_priv {
-	enum snd_soc_control_type control_type;
+	struct regmap *regmap;
 	int sysclk[2];
 	int mclk[2];
 	int aifclk[2];
@@ -156,7 +400,7 @@ static int wm8995_regulator_event_##n(struct notifier_block *nb, \
 	struct wm8995_priv *wm8995 = container_of(nb, struct wm8995_priv, \
 				     disable_nb[n]); \
 	if (event & REGULATOR_EVENT_DISABLE) { \
-		wm8995->codec->cache_sync = 1; \
+		regcache_mark_dirty(wm8995->regmap);	\
 	} \
 	return 0; \
 }
@@ -949,31 +1193,244 @@ static const struct snd_soc_dapm_route wm8995_intercon[] = {
 	{ "SPK2R", NULL, "SPK2R Driver" }
 };
 
-static int wm8995_volatile(struct snd_soc_codec *codec, unsigned int reg)
+static bool wm8995_readable(struct device *dev, unsigned int reg)
 {
-	/* out of bounds registers are generally considered
-	 * volatile to support register banks that are partially
-	 * owned by something else for e.g. a DSP
-	 */
-	if (reg > WM8995_MAX_CACHED_REGISTER)
-		return 1;
-
 	switch (reg) {
 	case WM8995_SOFTWARE_RESET:
+	case WM8995_POWER_MANAGEMENT_1:
+	case WM8995_POWER_MANAGEMENT_2:
+	case WM8995_POWER_MANAGEMENT_3:
+	case WM8995_POWER_MANAGEMENT_4:
+	case WM8995_POWER_MANAGEMENT_5:
+	case WM8995_LEFT_LINE_INPUT_1_VOLUME:
+	case WM8995_RIGHT_LINE_INPUT_1_VOLUME:
+	case WM8995_LEFT_LINE_INPUT_CONTROL:
+	case WM8995_DAC1_LEFT_VOLUME:
+	case WM8995_DAC1_RIGHT_VOLUME:
+	case WM8995_DAC2_LEFT_VOLUME:
+	case WM8995_DAC2_RIGHT_VOLUME:
+	case WM8995_OUTPUT_VOLUME_ZC_1:
+	case WM8995_MICBIAS_1:
+	case WM8995_MICBIAS_2:
+	case WM8995_LDO_1:
+	case WM8995_LDO_2:
+	case WM8995_ACCESSORY_DETECT_MODE1:
+	case WM8995_ACCESSORY_DETECT_MODE2:
+	case WM8995_HEADPHONE_DETECT1:
+	case WM8995_HEADPHONE_DETECT2:
+	case WM8995_MIC_DETECT_1:
+	case WM8995_MIC_DETECT_2:
+	case WM8995_CHARGE_PUMP_1:
+	case WM8995_CLASS_W_1:
+	case WM8995_DC_SERVO_1:
+	case WM8995_DC_SERVO_2:
+	case WM8995_DC_SERVO_3:
+	case WM8995_DC_SERVO_5:
+	case WM8995_DC_SERVO_6:
+	case WM8995_DC_SERVO_7:
 	case WM8995_DC_SERVO_READBACK_0:
+	case WM8995_ANALOGUE_HP_1:
+	case WM8995_ANALOGUE_HP_2:
+	case WM8995_CHIP_REVISION:
+	case WM8995_CONTROL_INTERFACE_1:
+	case WM8995_CONTROL_INTERFACE_2:
+	case WM8995_WRITE_SEQUENCER_CTRL_1:
+	case WM8995_WRITE_SEQUENCER_CTRL_2:
+	case WM8995_AIF1_CLOCKING_1:
+	case WM8995_AIF1_CLOCKING_2:
+	case WM8995_AIF2_CLOCKING_1:
+	case WM8995_AIF2_CLOCKING_2:
+	case WM8995_CLOCKING_1:
+	case WM8995_CLOCKING_2:
+	case WM8995_AIF1_RATE:
+	case WM8995_AIF2_RATE:
+	case WM8995_RATE_STATUS:
+	case WM8995_FLL1_CONTROL_1:
+	case WM8995_FLL1_CONTROL_2:
+	case WM8995_FLL1_CONTROL_3:
+	case WM8995_FLL1_CONTROL_4:
+	case WM8995_FLL1_CONTROL_5:
+	case WM8995_FLL2_CONTROL_1:
+	case WM8995_FLL2_CONTROL_2:
+	case WM8995_FLL2_CONTROL_3:
+	case WM8995_FLL2_CONTROL_4:
+	case WM8995_FLL2_CONTROL_5:
+	case WM8995_AIF1_CONTROL_1:
+	case WM8995_AIF1_CONTROL_2:
+	case WM8995_AIF1_MASTER_SLAVE:
+	case WM8995_AIF1_BCLK:
+	case WM8995_AIF1ADC_LRCLK:
+	case WM8995_AIF1DAC_LRCLK:
+	case WM8995_AIF1DAC_DATA:
+	case WM8995_AIF1ADC_DATA:
+	case WM8995_AIF2_CONTROL_1:
+	case WM8995_AIF2_CONTROL_2:
+	case WM8995_AIF2_MASTER_SLAVE:
+	case WM8995_AIF2_BCLK:
+	case WM8995_AIF2ADC_LRCLK:
+	case WM8995_AIF2DAC_LRCLK:
+	case WM8995_AIF2DAC_DATA:
+	case WM8995_AIF2ADC_DATA:
+	case WM8995_AIF1_ADC1_LEFT_VOLUME:
+	case WM8995_AIF1_ADC1_RIGHT_VOLUME:
+	case WM8995_AIF1_DAC1_LEFT_VOLUME:
+	case WM8995_AIF1_DAC1_RIGHT_VOLUME:
+	case WM8995_AIF1_ADC2_LEFT_VOLUME:
+	case WM8995_AIF1_ADC2_RIGHT_VOLUME:
+	case WM8995_AIF1_DAC2_LEFT_VOLUME:
+	case WM8995_AIF1_DAC2_RIGHT_VOLUME:
+	case WM8995_AIF1_ADC1_FILTERS:
+	case WM8995_AIF1_ADC2_FILTERS:
+	case WM8995_AIF1_DAC1_FILTERS_1:
+	case WM8995_AIF1_DAC1_FILTERS_2:
+	case WM8995_AIF1_DAC2_FILTERS_1:
+	case WM8995_AIF1_DAC2_FILTERS_2:
+	case WM8995_AIF1_DRC1_1:
+	case WM8995_AIF1_DRC1_2:
+	case WM8995_AIF1_DRC1_3:
+	case WM8995_AIF1_DRC1_4:
+	case WM8995_AIF1_DRC1_5:
+	case WM8995_AIF1_DRC2_1:
+	case WM8995_AIF1_DRC2_2:
+	case WM8995_AIF1_DRC2_3:
+	case WM8995_AIF1_DRC2_4:
+	case WM8995_AIF1_DRC2_5:
+	case WM8995_AIF1_DAC1_EQ_GAINS_1:
+	case WM8995_AIF1_DAC1_EQ_GAINS_2:
+	case WM8995_AIF1_DAC1_EQ_BAND_1_A:
+	case WM8995_AIF1_DAC1_EQ_BAND_1_B:
+	case WM8995_AIF1_DAC1_EQ_BAND_1_PG:
+	case WM8995_AIF1_DAC1_EQ_BAND_2_A:
+	case WM8995_AIF1_DAC1_EQ_BAND_2_B:
+	case WM8995_AIF1_DAC1_EQ_BAND_2_C:
+	case WM8995_AIF1_DAC1_EQ_BAND_2_PG:
+	case WM8995_AIF1_DAC1_EQ_BAND_3_A:
+	case WM8995_AIF1_DAC1_EQ_BAND_3_B:
+	case WM8995_AIF1_DAC1_EQ_BAND_3_C:
+	case WM8995_AIF1_DAC1_EQ_BAND_3_PG:
+	case WM8995_AIF1_DAC1_EQ_BAND_4_A:
+	case WM8995_AIF1_DAC1_EQ_BAND_4_B:
+	case WM8995_AIF1_DAC1_EQ_BAND_4_C:
+	case WM8995_AIF1_DAC1_EQ_BAND_4_PG:
+	case WM8995_AIF1_DAC1_EQ_BAND_5_A:
+	case WM8995_AIF1_DAC1_EQ_BAND_5_B:
+	case WM8995_AIF1_DAC1_EQ_BAND_5_PG:
+	case WM8995_AIF1_DAC2_EQ_GAINS_1:
+	case WM8995_AIF1_DAC2_EQ_GAINS_2:
+	case WM8995_AIF1_DAC2_EQ_BAND_1_A:
+	case WM8995_AIF1_DAC2_EQ_BAND_1_B:
+	case WM8995_AIF1_DAC2_EQ_BAND_1_PG:
+	case WM8995_AIF1_DAC2_EQ_BAND_2_A:
+	case WM8995_AIF1_DAC2_EQ_BAND_2_B:
+	case WM8995_AIF1_DAC2_EQ_BAND_2_C:
+	case WM8995_AIF1_DAC2_EQ_BAND_2_PG:
+	case WM8995_AIF1_DAC2_EQ_BAND_3_A:
+	case WM8995_AIF1_DAC2_EQ_BAND_3_B:
+	case WM8995_AIF1_DAC2_EQ_BAND_3_C:
+	case WM8995_AIF1_DAC2_EQ_BAND_3_PG:
+	case WM8995_AIF1_DAC2_EQ_BAND_4_A:
+	case WM8995_AIF1_DAC2_EQ_BAND_4_B:
+	case WM8995_AIF1_DAC2_EQ_BAND_4_C:
+	case WM8995_AIF1_DAC2_EQ_BAND_4_PG:
+	case WM8995_AIF1_DAC2_EQ_BAND_5_A:
+	case WM8995_AIF1_DAC2_EQ_BAND_5_B:
+	case WM8995_AIF1_DAC2_EQ_BAND_5_PG:
+	case WM8995_AIF2_ADC_LEFT_VOLUME:
+	case WM8995_AIF2_ADC_RIGHT_VOLUME:
+	case WM8995_AIF2_DAC_LEFT_VOLUME:
+	case WM8995_AIF2_DAC_RIGHT_VOLUME:
+	case WM8995_AIF2_ADC_FILTERS:
+	case WM8995_AIF2_DAC_FILTERS_1:
+	case WM8995_AIF2_DAC_FILTERS_2:
+	case WM8995_AIF2_DRC_1:
+	case WM8995_AIF2_DRC_2:
+	case WM8995_AIF2_DRC_3:
+	case WM8995_AIF2_DRC_4:
+	case WM8995_AIF2_DRC_5:
+	case WM8995_AIF2_EQ_GAINS_1:
+	case WM8995_AIF2_EQ_GAINS_2:
+	case WM8995_AIF2_EQ_BAND_1_A:
+	case WM8995_AIF2_EQ_BAND_1_B:
+	case WM8995_AIF2_EQ_BAND_1_PG:
+	case WM8995_AIF2_EQ_BAND_2_A:
+	case WM8995_AIF2_EQ_BAND_2_B:
+	case WM8995_AIF2_EQ_BAND_2_C:
+	case WM8995_AIF2_EQ_BAND_2_PG:
+	case WM8995_AIF2_EQ_BAND_3_A:
+	case WM8995_AIF2_EQ_BAND_3_B:
+	case WM8995_AIF2_EQ_BAND_3_C:
+	case WM8995_AIF2_EQ_BAND_3_PG:
+	case WM8995_AIF2_EQ_BAND_4_A:
+	case WM8995_AIF2_EQ_BAND_4_B:
+	case WM8995_AIF2_EQ_BAND_4_C:
+	case WM8995_AIF2_EQ_BAND_4_PG:
+	case WM8995_AIF2_EQ_BAND_5_A:
+	case WM8995_AIF2_EQ_BAND_5_B:
+	case WM8995_AIF2_EQ_BAND_5_PG:
+	case WM8995_DAC1_MIXER_VOLUMES:
+	case WM8995_DAC1_LEFT_MIXER_ROUTING:
+	case WM8995_DAC1_RIGHT_MIXER_ROUTING:
+	case WM8995_DAC2_MIXER_VOLUMES:
+	case WM8995_DAC2_LEFT_MIXER_ROUTING:
+	case WM8995_DAC2_RIGHT_MIXER_ROUTING:
+	case WM8995_AIF1_ADC1_LEFT_MIXER_ROUTING:
+	case WM8995_AIF1_ADC1_RIGHT_MIXER_ROUTING:
+	case WM8995_AIF1_ADC2_LEFT_MIXER_ROUTING:
+	case WM8995_AIF1_ADC2_RIGHT_MIXER_ROUTING:
+	case WM8995_DAC_SOFTMUTE:
+	case WM8995_OVERSAMPLING:
+	case WM8995_SIDETONE:
+	case WM8995_GPIO_1:
+	case WM8995_GPIO_2:
+	case WM8995_GPIO_3:
+	case WM8995_GPIO_4:
+	case WM8995_GPIO_5:
+	case WM8995_GPIO_6:
+	case WM8995_GPIO_7:
+	case WM8995_GPIO_8:
+	case WM8995_GPIO_9:
+	case WM8995_GPIO_10:
+	case WM8995_GPIO_11:
+	case WM8995_GPIO_12:
+	case WM8995_GPIO_13:
+	case WM8995_GPIO_14:
+	case WM8995_PULL_CONTROL_1:
+	case WM8995_PULL_CONTROL_2:
 	case WM8995_INTERRUPT_STATUS_1:
 	case WM8995_INTERRUPT_STATUS_2:
+	case WM8995_INTERRUPT_RAW_STATUS_2:
 	case WM8995_INTERRUPT_STATUS_1_MASK:
 	case WM8995_INTERRUPT_STATUS_2_MASK:
 	case WM8995_INTERRUPT_CONTROL:
+	case WM8995_LEFT_PDM_SPEAKER_1:
+	case WM8995_RIGHT_PDM_SPEAKER_1:
+	case WM8995_PDM_SPEAKER_1_MUTE_SEQUENCE:
+	case WM8995_LEFT_PDM_SPEAKER_2:
+	case WM8995_RIGHT_PDM_SPEAKER_2:
+	case WM8995_PDM_SPEAKER_2_MUTE_SEQUENCE:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool wm8995_volatile(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case WM8995_SOFTWARE_RESET:
+	case WM8995_DC_SERVO_READBACK_0:
+	case WM8995_INTERRUPT_STATUS_1:
+	case WM8995_INTERRUPT_STATUS_2:
+	case WM8995_INTERRUPT_CONTROL:
 	case WM8995_ACCESSORY_DETECT_MODE1:
 	case WM8995_ACCESSORY_DETECT_MODE2:
 	case WM8995_HEADPHONE_DETECT1:
 	case WM8995_HEADPHONE_DETECT2:
-		return 1;
+	case WM8995_RATE_STATUS:
+		return true;
+	default:
+		return false;
 	}
-
-	return 0;
 }
 
 static int wm8995_aif_mute(struct snd_soc_dai *dai, int mute)
@@ -1528,7 +1985,7 @@ static int wm8995_set_bias_level(struct snd_soc_codec *codec,
 			if (ret)
 				return ret;
 
-			ret = snd_soc_cache_sync(codec);
+			ret = regcache_sync(wm8995->regmap);
 			if (ret) {
 				dev_err(codec->dev,
 					"Failed to sync cache: %d\n", ret);
@@ -1594,7 +2051,7 @@ static int wm8995_probe(struct snd_soc_codec *codec)
 	wm8995 = snd_soc_codec_get_drvdata(codec);
 	wm8995->codec = codec;
 
-	ret = snd_soc_codec_set_cache_io(codec, 16, 16, wm8995->control_type);
+	ret = snd_soc_codec_set_cache_io(codec, 16, 16, SND_SOC_REGMAP);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache i/o: %d\n", ret);
 		return ret;
@@ -1783,11 +2240,18 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8995 = {
 	.suspend = wm8995_suspend,
 	.resume = wm8995_resume,
 	.set_bias_level = wm8995_set_bias_level,
-	.reg_cache_size = ARRAY_SIZE(wm8995_reg_defs),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_default = wm8995_reg_defs,
-	.volatile_register = wm8995_volatile,
-	.compress_type = SND_SOC_RBTREE_COMPRESSION
+};
+
+static struct regmap_config wm8995_regmap = {
+	.reg_bits = 16,
+	.val_bits = 16,
+
+	.max_register = WM8995_MAX_REGISTER,
+	.reg_defaults = wm8995_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm8995_reg_defaults),
+	.volatile_reg = wm8995_volatile,
+	.readable_reg = wm8995_readable,
+	.cache_type = REGCACHE_RBTREE,
 };
 
 #if defined(CONFIG_SPI_MASTER)
@@ -1800,21 +2264,37 @@ static int __devinit wm8995_spi_probe(struct spi_device *spi)
 	if (!wm8995)
 		return -ENOMEM;
 
-	wm8995->control_type = SND_SOC_SPI;
 	spi_set_drvdata(spi, wm8995);
 
+	wm8995->regmap = regmap_init_spi(spi, &wm8995_regmap);
+	if (IS_ERR(wm8995->regmap)) {
+		ret = PTR_ERR(wm8995->regmap);
+		dev_err(&spi->dev, "Failed to register regmap: %d\n", ret);
+		goto err_alloc;
+	}
+
 	ret = snd_soc_register_codec(&spi->dev,
 				     &soc_codec_dev_wm8995, wm8995_dai,
 				     ARRAY_SIZE(wm8995_dai));
 	if (ret < 0)
-		kfree(wm8995);
+		goto err_regmap;
+
+	return ret;
+
+err_regmap:
+	regmap_exit(wm8995->regmap);
+err_alloc:
+	kfree(wm8995);
+
 	return ret;
 }
 
 static int __devexit wm8995_spi_remove(struct spi_device *spi)
 {
+	struct wm8995_priv *wm8995 = spi_get_drvdata(spi);
 	snd_soc_unregister_codec(&spi->dev);
-	kfree(spi_get_drvdata(spi));
+	regmap_exit(wm8995->regmap);
+	kfree(wm8995);
 	return 0;
 }
 
@@ -1839,21 +2319,40 @@ static __devinit int wm8995_i2c_probe(struct i2c_client *i2c,
 	if (!wm8995)
 		return -ENOMEM;
 
-	wm8995->control_type = SND_SOC_I2C;
 	i2c_set_clientdata(i2c, wm8995);
 
+	wm8995->regmap = regmap_init_i2c(i2c, &wm8995_regmap);
+	if (IS_ERR(wm8995->regmap)) {
+		ret = PTR_ERR(wm8995->regmap);
+		dev_err(&i2c->dev, "Failed to register regmap: %d\n", ret);
+		goto err_alloc;
+	}
+
 	ret = snd_soc_register_codec(&i2c->dev,
 				     &soc_codec_dev_wm8995, wm8995_dai,
 				     ARRAY_SIZE(wm8995_dai));
-	if (ret < 0)
-		kfree(wm8995);
+	if (ret < 0) {
+		dev_err(&i2c->dev, "Failed to register CODEC: %d\n", ret);
+		goto err_regmap;
+	}
+
+	return ret;
+
+err_regmap:
+	regmap_exit(wm8995->regmap);
+err_alloc:
+	kfree(wm8995);
+
 	return ret;
 }
 
 static __devexit int wm8995_i2c_remove(struct i2c_client *client)
 {
+	struct wm8995_priv *wm8995 = i2c_get_clientdata(client);
+
 	snd_soc_unregister_codec(&client->dev);
-	kfree(i2c_get_clientdata(client));
+	regmap_exit(wm8995->regmap);
+	kfree(wm8995);
 	return 0;
 }
 
-- 
1.7.7.2
