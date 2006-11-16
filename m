From: Tobin Davis <tdavis@dsl-only.net>
Subject: Change Gigabyte K8N51 from 6stack to 6stack-digout
Date: Thu, 16 Nov 2006 00:45:32 -0800
Message-ID: <1163666732.21193.230.camel@razman>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-T2goNrNTj67RcUJOAQ/Y"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-T2goNrNTj67RcUJOAQ/Y
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch moves the entry for the Gigabyte K8N51 from the 6stack
grouping to the 6stack-digout grouping, allowing for S/PDIF output
functionality.

Signed off by:
-- 
Tobin Davis <tdavis@dsl-only.net>

--=-T2goNrNTj67RcUJOAQ/Y
Content-Disposition: attachment; filename=K8N51.patch
Content-Type: text/x-patch; name=K8N51.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -r b426d16acf44 pci/hda/patch_realtek.c
--- a/pci/hda/patch_realtek.c	Tue Nov 14 13:04:32 2006 +0100
+++ b/pci/hda/patch_realtek.c	Thu Nov 16 00:42:13 2006 -0800
@@ -2427,7 +2427,6 @@ static struct hda_board_config alc880_cf
 	{ .pci_subvendor = 0x1043, .pci_subdevice = 0x8196, .config = ALC880_6ST }, /* ASUS P5GD1-HVM */
 	{ .pci_subvendor = 0x1043, .pci_subdevice = 0x81b4, .config = ALC880_6ST },
 	{ .pci_subvendor = 0x1019, .pci_subdevice = 0xa884, .config = ALC880_6ST }, /* Acer APFV */
-	{ .pci_subvendor = 0x1458, .pci_subdevice = 0xa102, .config = ALC880_6ST }, /* Gigabyte K8N51 */
 
 	{ .modelname = "6stack-digout", .config = ALC880_6ST_DIG },
 	{ .pci_subvendor = 0x2668, .pci_subdevice = 0x8086, .config = ALC880_6ST_DIG },
@@ -2441,6 +2440,7 @@ static struct hda_board_config alc880_cf
 	{ .pci_subvendor = 0x1297, .pci_subdevice = 0xc790, .config = ALC880_6ST_DIG }, /* Shuttle ST20G5 */
 	{ .pci_subvendor = 0x1509, .pci_subdevice = 0x925d, .config = ALC880_6ST_DIG }, /* FIC P4M-915GD1 */
 	{ .pci_subvendor = 0x1695, .pci_subdevice = 0x4012, .config = ALC880_5ST_DIG }, /* Epox EP-5LDA+ GLi */
+	{ .pci_subvendor = 0x1458, .pci_subdevice = 0xa102, .config = ALC880_6ST_DIG }, /* Gigabyte K8N51 */
 
 	{ .modelname = "asus", .config = ALC880_ASUS },
 	{ .pci_subvendor = 0x1043, .pci_subdevice = 0x1964, .config = ALC880_ASUS_DIG },

--=-T2goNrNTj67RcUJOAQ/Y
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-T2goNrNTj67RcUJOAQ/Y
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-T2goNrNTj67RcUJOAQ/Y--
