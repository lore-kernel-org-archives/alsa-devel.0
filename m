From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 2/2] ASoC: rt5663: Update the HW default values
	based on the shipping version
Date: Mon, 10 Jul 2017 11:14:57 +0800
Message-ID: <1499656497-3986-2-git-send-email-oder_chiou@realtek.com>
References: <1499656497-3986-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id E2CC72669CD
 for <alsa-devel@alsa-project.org>; Mon, 10 Jul 2017 05:15:03 +0200 (CEST)
In-Reply-To: <1499656497-3986-1-git-send-email-oder_chiou@realtek.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, albertchen@realtek.com, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch update the HW default values based on the shipping version.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5663.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 52ecca4..0349c30 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -471,7 +471,7 @@ static const struct reg_default rt5663_reg[] = {
 	{ 0x0006, 0x1000 },
 	{ 0x000a, 0x0000 },
 	{ 0x0010, 0x000f },
-	{ 0x0015, 0x42c1 },
+	{ 0x0015, 0x42f1 },
 	{ 0x0016, 0x0000 },
 	{ 0x0018, 0x000b },
 	{ 0x0019, 0xafaf },
@@ -514,7 +514,7 @@ static const struct reg_default rt5663_reg[] = {
 	{ 0x008a, 0x0000 },
 	{ 0x008b, 0x0000 },
 	{ 0x008c, 0x0003 },
-	{ 0x008e, 0x0004 },
+	{ 0x008e, 0x0008 },
 	{ 0x008f, 0x1000 },
 	{ 0x0090, 0x0646 },
 	{ 0x0091, 0x0e3e },
@@ -525,7 +525,7 @@ static const struct reg_default rt5663_reg[] = {
 	{ 0x0098, 0x0000 },
 	{ 0x009a, 0x0000 },
 	{ 0x009f, 0x0000 },
-	{ 0x00ae, 0x2000 },
+	{ 0x00ae, 0x6000 },
 	{ 0x00af, 0x0000 },
 	{ 0x00b6, 0x0000 },
 	{ 0x00b7, 0x0000 },
@@ -543,7 +543,7 @@ static const struct reg_default rt5663_reg[] = {
 	{ 0x00d9, 0x08f9 },
 	{ 0x00db, 0x0008 },
 	{ 0x00dc, 0x00c0 },
-	{ 0x00dd, 0x6724 },
+	{ 0x00dd, 0x6729 },
 	{ 0x00de, 0x3131 },
 	{ 0x00df, 0x0008 },
 	{ 0x00e0, 0x4000 },
@@ -583,7 +583,7 @@ static const struct reg_default rt5663_reg[] = {
 	{ 0x0116, 0x0000 },
 	{ 0x0117, 0x0f00 },
 	{ 0x0118, 0x0006 },
-	{ 0x0125, 0x2224 },
+	{ 0x0125, 0x2424 },
 	{ 0x0126, 0x5550 },
 	{ 0x0127, 0x0400 },
 	{ 0x0128, 0x7711 },
@@ -601,8 +601,8 @@ static const struct reg_default rt5663_reg[] = {
 	{ 0x0145, 0x0002 },
 	{ 0x0146, 0x0000 },
 	{ 0x0160, 0x0e80 },
-	{ 0x0161, 0x0020 },
-	{ 0x0162, 0x0080 },
+	{ 0x0161, 0x0080 },
+	{ 0x0162, 0x0200 },
 	{ 0x0163, 0x0800 },
 	{ 0x0164, 0x0000 },
 	{ 0x0165, 0x0000 },
@@ -681,8 +681,8 @@ static const struct reg_default rt5663_reg[] = {
 	{ 0x0251, 0x0000 },
 	{ 0x0252, 0x028a },
 	{ 0x02fa, 0x0000 },
-	{ 0x02fb, 0x0000 },
-	{ 0x02fc, 0x0000 },
+	{ 0x02fb, 0x00a4 },
+	{ 0x02fc, 0x0300 },
 	{ 0x0300, 0x0000 },
 	{ 0x03d0, 0x0000 },
 	{ 0x03d1, 0x0000 },
-- 
2.7.4
