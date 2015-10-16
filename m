From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH RESEND] ASoC: rt298: correct index default value
Date: Fri, 16 Oct 2015 15:21:32 +0800
Message-ID: <1444980092-8801-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 55FD326058E
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 09:21:47 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, john.lin@realtek.com, ramesh.babu@intel.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Some of the default value on rt298_index_def are incorrect. Change
them to the correct value.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
This patch is base on topic/rt298 branch.
---
 sound/soc/codecs/rt298.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index ff126a7..8c5cb7e 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -50,24 +50,24 @@ struct rt298_priv {
 };
 
 static struct reg_default rt298_index_def[] = {
-	{ 0x01, 0xaaaa },
-	{ 0x02, 0x8aaa },
+	{ 0x01, 0xa5a8 },
+	{ 0x02, 0x8e95 },
 	{ 0x03, 0x0002 },
-	{ 0x04, 0xaf01 },
-	{ 0x08, 0x000d },
-	{ 0x09, 0xd810 },
-	{ 0x0a, 0x0120 },
+	{ 0x04, 0xaf67 },
+	{ 0x08, 0x200f },
+	{ 0x09, 0xd010 },
+	{ 0x0a, 0x0100 },
 	{ 0x0b, 0x0000 },
 	{ 0x0d, 0x2800 },
-	{ 0x0f, 0x0000 },
-	{ 0x19, 0x0a17 },
+	{ 0x0f, 0x0022 },
+	{ 0x19, 0x0217 },
 	{ 0x20, 0x0020 },
 	{ 0x33, 0x0208 },
 	{ 0x46, 0x0300 },
-	{ 0x49, 0x0004 },
-	{ 0x4f, 0x50e9 },
-	{ 0x50, 0x2000 },
-	{ 0x63, 0x2902 },
+	{ 0x49, 0x4004 },
+	{ 0x4f, 0x50c9 },
+	{ 0x50, 0x3000 },
+	{ 0x63, 0x1b02 },
 	{ 0x67, 0x1111 },
 	{ 0x68, 0x1016 },
 	{ 0x69, 0x273f },
-- 
1.8.1.1.439.g50a6b54
