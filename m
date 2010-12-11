From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCH v2 04/16] ASoC: twl6040: Set default gains to
	minimun value
Date: Fri, 10 Dec 2010 21:05:35 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCEA4E225D3@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 15EC510380C
	for <alsa-devel@alsa-project.org>; Sat, 11 Dec 2010 04:05:37 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>

Updated default values to improve power consumption.

Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
---
 sound/soc/codecs/twl6040.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index b575fd3..27d6d53 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -86,19 +86,19 @@ static const u8 twl6040_reg[TWL6040_CACHEREGNUM] = {
 	0x1B, /* TWL6040_LINEGAIN	0x0F	*/
 	0x00, /* TWL6040_HSLCTL		0x10	*/
 	0x00, /* TWL6040_HSRCTL		0x11	*/
-	0x00, /* TWL6040_HSGAIN		0x12	*/
-	0x00, /* TWL6040_EARCTL		0x13	*/
+	0xFF, /* TWL6040_HSGAIN		0x12	*/
+	0x1E, /* TWL6040_EARCTL		0x13	*/
 	0x00, /* TWL6040_HFLCTL		0x14	*/
-	0x00, /* TWL6040_HFLGAIN	0x15	*/
+	0x1D, /* TWL6040_HFLGAIN	0x15	*/
 	0x00, /* TWL6040_HFRCTL		0x16	*/
-	0x00, /* TWL6040_HFRGAIN	0x17	*/
+	0x1D, /* TWL6040_HFRGAIN	0x17	*/
 	0x00, /* TWL6040_VIBCTLL	0x18	*/
 	0x00, /* TWL6040_VIBDATL	0x19	*/
 	0x00, /* TWL6040_VIBCTLR	0x1A	*/
 	0x00, /* TWL6040_VIBDATR	0x1B	*/
 	0x00, /* TWL6040_HKCTL1		0x1C	*/
 	0x00, /* TWL6040_HKCTL2		0x1D	*/
-	0x00, /* TWL6040_GPOCTL		0x1E	*/
+	0x02, /* TWL6040_GPOCTL		0x1E	*/
 	0x00, /* TWL6040_ALB		0x1F	*/
 	0x00, /* TWL6040_DLB		0x20	*/
 	0x00, /* not used		0x21	*/
-- 
1.7.0.4
