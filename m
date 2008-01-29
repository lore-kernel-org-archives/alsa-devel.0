From: Tobin Davis <tdavis@dsl-only.net>
Subject: HDA-Intel - Add support for Intel SCH
Date: Tue, 29 Jan 2008 13:55:12 -0800
Message-ID: <1201643712.23892.106.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-VghL8G3T3g18Wyocr79f"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F0602467D
	for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2008 22:55:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Developers <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--=-VghL8G3T3g18Wyocr79f
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds support for Intel's SCH mobile chipset.


Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-VghL8G3T3g18Wyocr79f
Content-Disposition: attachment; filename=hda-sch.patch
Content-Type: text/x-patch; name=hda-sch.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- a/pci/hda/hda_intel.c	2008-01-29 13:33:41.000000000 -0800
+++ b/pci/hda/hda_intel.c	2008-01-29 13:50:05.000000000 -0800
@@ -97,6 +97,7 @@
 			 "{Intel, ICH8},"
 			 "{Intel, ICH9},"
 			 "{Intel, ICH10},"
+ 			 "{Intel, SCH},"
 			 "{ATI, SB450},"
 			 "{ATI, SB600},"
 			 "{ATI, RS600},"
@@ -375,6 +376,7 @@
 /* driver types */
 enum {
 	AZX_DRIVER_ICH,
+	AZX_DRIVER_SCH,
 	AZX_DRIVER_ATI,
 	AZX_DRIVER_ATIHDMI,
 	AZX_DRIVER_VIA,
@@ -385,6 +387,7 @@
 
 static char *driver_short_names[] __devinitdata = {
 	[AZX_DRIVER_ICH] = "HDA Intel",
+	[AZX_DRIVER_SCH] = "HDA Intel MID",
 	[AZX_DRIVER_ATI] = "HDA ATI SB",
 	[AZX_DRIVER_ATIHDMI] = "HDA ATI HDMI",
 	[AZX_DRIVER_VIA] = "HDA VIA VT82xx",
@@ -1978,6 +1981,7 @@
 	{ 0x8086, 0x293f, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ICH }, /* ICH9 */
 	{ 0x8086, 0x3a3e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ICH }, /* ICH10 */
 	{ 0x8086, 0x3a6e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ICH }, /* ICH10 */
+ 	{ 0x8086, 0x811b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_SCH }, /* SCH*/
 	{ 0x1002, 0x437b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ATI }, /* ATI SB450 */
 	{ 0x1002, 0x4383, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ATI }, /* ATI SB600 */
 	{ 0x1002, 0x793b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ATIHDMI }, /* ATI RS600 HDMI */

--=-VghL8G3T3g18Wyocr79f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-VghL8G3T3g18Wyocr79f--
