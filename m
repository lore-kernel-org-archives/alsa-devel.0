From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] hda-emu: Add idt_set_gpio verb for stac92xx
Date: Thu, 16 Aug 2012 14:25:58 +0200
Message-ID: <1345119958-8259-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 09DAB266033
 for <alsa-devel@alsa-project.org>; Thu, 16 Aug 2012 13:56:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

According to Takashi, this verb is valid and given by Sigmatel.

Also merge two identical arrays and sort the table a little.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 hda-spec.c |   66 ++++++++++++++++++++++++++++--------------------------------
 1 file changed, 31 insertions(+), 35 deletions(-)

diff --git a/hda-spec.c b/hda-spec.c
index dd43ee9..eebaa39 100644
--- a/hda-spec.c
+++ b/hda-spec.c
@@ -155,15 +155,10 @@ static struct xhda_verb_table idt_92hd8xx_verbs[] = {
 /*
  * STAC codecs
  */
-static struct xhda_verb_table stac927x_verbs[] = {
+static struct xhda_verb_table stac92xx_verbs[] = {
 	{ 0xfeb, get_cached_verb, "get_analog_loop" }, /* undocumented */
 	{ 0x7eb, set_cached_verb, "set_analog_loop" },
-	{ } /* terminator */
-};
-
-static struct xhda_verb_table stac9205_verbs[] = {
-	{ 0xfe0, get_cached_verb, "get_analog_loop" }, /* undocumented */
-	{ 0x7e0, set_cached_verb, "set_analog_loop" },
+	{ 0x7e7, set_cached_verb, "idt_set_gpio" },
 	{ } /* terminator */
 };
 
@@ -271,34 +266,35 @@ static struct verb_ext_list extensions[] = {
 	{ .id = 0x111d76e5, .verbs = idt_92hd8xx_verbs },
 	{ .id = 0x111d76e7, .verbs = idt_92hd8xx_verbs },
 
-	{ .id = 0x83847618, .verbs = stac927x_verbs },
-	{ .id = 0x83847619, .verbs = stac927x_verbs },
-	{ .id = 0x83847616, .verbs = stac927x_verbs },
-	{ .id = 0x83847617, .verbs = stac927x_verbs },
-	{ .id = 0x83847614, .verbs = stac927x_verbs },
-	{ .id = 0x83847615, .verbs = stac927x_verbs },
-	{ .id = 0x83847620, .verbs = stac927x_verbs },
-	{ .id = 0x83847621, .verbs = stac927x_verbs },
-	{ .id = 0x83847622, .verbs = stac927x_verbs },
-	{ .id = 0x83847623, .verbs = stac927x_verbs },
-	{ .id = 0x83847624, .verbs = stac927x_verbs },
-	{ .id = 0x83847625, .verbs = stac927x_verbs },
-	{ .id = 0x83847626, .verbs = stac927x_verbs },
-	{ .id = 0x83847627, .verbs = stac927x_verbs },
-	{ .id = 0x83847628, .verbs = stac927x_verbs },
-	{ .id = 0x83847629, .verbs = stac927x_verbs },
-	{ .id = 0x83847645, .verbs = stac927x_verbs },
-	{ .id = 0x83847646, .verbs = stac927x_verbs },
-
-	{ .id = 0x83847698, .verbs = stac9205_verbs },
-	{ .id = 0x838476a0, .verbs = stac9205_verbs },
-	{ .id = 0x838476a1, .verbs = stac9205_verbs },
-	{ .id = 0x838476a2, .verbs = stac9205_verbs },
-	{ .id = 0x838476a3, .verbs = stac9205_verbs },
-	{ .id = 0x838476a4, .verbs = stac9205_verbs },
-	{ .id = 0x838476a5, .verbs = stac9205_verbs },
-	{ .id = 0x838476a6, .verbs = stac9205_verbs },
-	{ .id = 0x838476a7, .verbs = stac9205_verbs },
+	{ .id = 0x83847614, .verbs = stac92xx_verbs },
+	{ .id = 0x83847615, .verbs = stac92xx_verbs },
+	{ .id = 0x83847616, .verbs = stac92xx_verbs },
+	{ .id = 0x83847617, .verbs = stac92xx_verbs },
+	{ .id = 0x83847618, .verbs = stac92xx_verbs },
+	{ .id = 0x83847619, .verbs = stac92xx_verbs },
+	{ .id = 0x83847620, .verbs = stac92xx_verbs },
+	{ .id = 0x83847621, .verbs = stac92xx_verbs },
+	{ .id = 0x83847622, .verbs = stac92xx_verbs },
+	{ .id = 0x83847623, .verbs = stac92xx_verbs },
+	{ .id = 0x83847624, .verbs = stac92xx_verbs },
+	{ .id = 0x83847625, .verbs = stac92xx_verbs },
+	{ .id = 0x83847626, .verbs = stac92xx_verbs },
+	{ .id = 0x83847627, .verbs = stac92xx_verbs },
+	{ .id = 0x83847628, .verbs = stac92xx_verbs },
+	{ .id = 0x83847629, .verbs = stac92xx_verbs },
+	{ .id = 0x83847645, .verbs = stac92xx_verbs },
+	{ .id = 0x83847646, .verbs = stac92xx_verbs },
+
+	{ .id = 0x83847690, .verbs = stac92xx_verbs },
+	{ .id = 0x83847698, .verbs = stac92xx_verbs },
+	{ .id = 0x838476a0, .verbs = stac92xx_verbs },
+	{ .id = 0x838476a1, .verbs = stac92xx_verbs },
+	{ .id = 0x838476a2, .verbs = stac92xx_verbs },
+	{ .id = 0x838476a3, .verbs = stac92xx_verbs },
+	{ .id = 0x838476a4, .verbs = stac92xx_verbs },
+	{ .id = 0x838476a5, .verbs = stac92xx_verbs },
+	{ .id = 0x838476a6, .verbs = stac92xx_verbs },
+	{ .id = 0x838476a7, .verbs = stac92xx_verbs },
 
 	{ .id = 0x11061708, .verbs = vt1708b_verbs },
 	{ .id = 0x11061709, .verbs = vt1708b_verbs },
-- 
1.7.9.5
