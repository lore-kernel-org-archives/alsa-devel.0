From: <MR.Swami.Reddy@ti.com>
Subject: [PATCH v2] ASoC: lm49453: Update lm49453_reg_defs
	values as per LM49453 HW revision-B
Date: Fri, 7 Dec 2012 17:06:54 +0530
Message-ID: <1354880214-6552-1-git-send-email-MR.Swami.Reddy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 747A2261654
 for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2012 12:19:46 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: vishwas.a.deshpande@ti.com, alsa-devel@alsa-project.org, M R Swami Reddy <mr.swami.reddy@ti.com>
List-Id: alsa-devel@alsa-project.org

Update lm49453_reg_defs values as per LM49453 HW revision-B

Signed-off-by: M R Swami Reddy <mr.swami.reddy@ti.com>
---

 sound/soc/codecs/lm49453.c |   61 +++++++++++---------------------------------
 1 files changed, 15 insertions(+), 46 deletions(-)

diff --git a/sound/soc/codecs/lm49453.c b/sound/soc/codecs/lm49453.c
index 99b0a9d..808e50a 100644
--- a/sound/soc/codecs/lm49453.c
+++ b/sound/soc/codecs/lm49453.c
@@ -111,9 +111,9 @@ static struct reg_default lm49453_reg_defs[] = {
 	{ 101, 0x00 },
 	{ 102, 0x00 },
 	{ 103, 0x01 },
-	{ 105, 0x01 },
-	{ 106, 0x00 },
-	{ 107, 0x01 },
+	{ 104, 0x01 },
+	{ 105, 0x00 },
+	{ 106, 0x01 },
 	{ 107, 0x00 },
 	{ 108, 0x00 },
 	{ 109, 0x00 },
@@ -163,56 +163,25 @@ static struct reg_default lm49453_reg_defs[] = {
 	{ 184, 0x00 },
 	{ 185, 0x00 },
 	{ 186, 0x00 },
-	{ 189, 0x00 },
+	{ 187, 0x00 },
 	{ 188, 0x00 },
-	{ 194, 0x00 },
-	{ 195, 0x00 },
-	{ 196, 0x00 },
-	{ 197, 0x00 },
-	{ 200, 0x00 },
-	{ 201, 0x00 },
-	{ 202, 0x00 },
-	{ 203, 0x00 },
-	{ 204, 0x00 },
-	{ 205, 0x00 },
-	{ 208, 0x00 },
+	{ 189, 0x00 },
+	{ 208, 0x06 },
 	{ 209, 0x00 },
-	{ 210, 0x00 },
-	{ 211, 0x00 },
-	{ 213, 0x00 },
-	{ 214, 0x00 },
-	{ 215, 0x00 },
-	{ 216, 0x00 },
-	{ 217, 0x00 },
-	{ 218, 0x00 },
-	{ 219, 0x00 },
+	{ 210, 0x08 },
+	{ 211, 0x54 },
+	{ 212, 0x14 },
+	{ 213, 0x0d },
+	{ 214, 0x0d },
+	{ 215, 0x14 },
+	{ 216, 0x60 },
 	{ 221, 0x00 },
 	{ 222, 0x00 },
+	{ 223, 0x00 },
 	{ 224, 0x00 },
-	{ 225, 0x00 },
-	{ 226, 0x00 },
-	{ 227, 0x00 },
-	{ 228, 0x00 },
-	{ 229, 0x00 },
-	{ 230, 0x13 },
-	{ 231, 0x00 },
-	{ 232, 0x80 },
-	{ 233, 0x0C },
-	{ 234, 0xDD },
-	{ 235, 0x00 },
-	{ 236, 0x04 },
-	{ 237, 0x00 },
-	{ 238, 0x00 },
-	{ 239, 0x00 },
-	{ 240, 0x00 },
-	{ 241, 0x00 },
-	{ 242, 0x00 },
-	{ 243, 0x00 },
-	{ 244, 0x00 },
-	{ 245, 0x00 },
 	{ 248, 0x00 },
 	{ 249, 0x00 },
-	{ 254, 0x00 },
+	{ 250, 0x00 },
 	{ 255, 0x00 },
 };
 
