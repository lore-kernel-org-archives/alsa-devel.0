From: "Peer Chen" <pchen@nvidia.com>
Subject: [Patch] Audio: Add nvidia HD Audio controllers of
	MCP67 support to hda_intel.c
Date: Tue, 31 Oct 2006 16:03:42 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B0C42D5A3@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com
List-Id: alsa-devel@alsa-project.org

Add the support for HD audio controllers of MCP51,MCP55,MCP61,MCP65 &
MCP67.
The following hda_intel.c patch is based on kernel 2.6.18.

Signed-off by: Peer Chen <pchen@nvidia.com>
===================================

--- hda_intel.c.orig	2006-10-30 14:13:08.000000000 +0800
+++ hda_intel.c	2006-10-31 13:44:36.000000000 +0800
@@ -1640,8 +1640,14 @@ static struct pci_device_id azx_ids[] = 
 	{ 0x1106, 0x3288, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_VIA
}, /* VIA VT8251/VT8237A */
 	{ 0x1039, 0x7502, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_SIS
}, /* SIS966 */
 	{ 0x10b9, 0x5461, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ULI
}, /* ULI M5461 */
-	{ 0x10de, 0x026c, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_NVIDIA }, /* NVIDIA 026c */
-	{ 0x10de, 0x0371, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_NVIDIA }, /* NVIDIA 0371 */
+	{ 0x10de, 0x026c, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_NVIDIA }, /* NVIDIA MCP51 */
+	{ 0x10de, 0x0371, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_NVIDIA }, /* NVIDIA MCP55 */
+	{ 0x10de, 0x03e4, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_NVIDIA }, /* NVIDIA MCP61 */
+	{ 0x10de, 0x03f0, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_NVIDIA }, /* NVIDIA MCP61 */
+	{ 0x10de, 0x044a, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_NVIDIA }, /* NVIDIA MCP65 */
+	{ 0x10de, 0x044b, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_NVIDIA }, /* NVIDIA MCP65 */
+	{ 0x10de, 0x055c, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_NVIDIA }, /* NVIDIA MCP67 */
+	{ 0x10de, 0x055d, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_NVIDIA }, /* NVIDIA MCP67 */
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, azx_ids);
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
