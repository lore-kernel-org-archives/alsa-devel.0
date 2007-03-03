From: Ben Dooks <ben-alsa@fluff.org>
Subject: [PATCH] intel8x0: add NVidia MPC55 support
Date: Sat, 3 Mar 2007 19:09:01 +0000
Message-ID: <20070303190901.GA22328@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
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


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add the PCI-ID for the NVidia MPC55 HDA audio controller
to the intel8x0 driver.

Tested with 2 channel audio only.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

diff -urNp -X linux-2.6.20/Documentation/dontdiff linux-2.6.20/sound/pci/intel8x0.c linux-2.6.20-bjd1/sound/pci/intel8x0.c
--- linux-2.6.20/sound/pci/intel8x0.c	2007-02-04 18:44:54.000000000 +0000
+++ linux-2.6.20-bjd1/sound/pci/intel8x0.c	2007-03-03 18:55:22.000000000 +0000
@@ -434,6 +434,7 @@ static struct pci_device_id snd_intel8x0
 	{ 0x10de, 0x00da, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_NFORCE },	/* NFORCE3 */
 	{ 0x10de, 0x00ea, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_NFORCE },	/* CK8S */
 	{ 0x10de, 0x026b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_NFORCE },	/* MCP51 */
+	{ 0x10de, 0x0371, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_NFORCE },	/* MCP55 */
 	{ 0x1022, 0x746d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL },	/* AMD8111 */
 	{ 0x1022, 0x7445, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL },	/* AMD768 */
 	{ 0x10b9, 0x5455, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_ALI },   /* Ali5455 */





--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2620-alsa-intel8x0-mpc55.patch"

diff -urNp -X linux-2.6.20/Documentation/dontdiff linux-2.6.20/sound/pci/intel8x0.c linux-2.6.20-bjd1/sound/pci/intel8x0.c
--- linux-2.6.20/sound/pci/intel8x0.c	2007-02-04 18:44:54.000000000 +0000
+++ linux-2.6.20-bjd1/sound/pci/intel8x0.c	2007-03-03 18:55:22.000000000 +0000
@@ -434,6 +434,7 @@ static struct pci_device_id snd_intel8x0
 	{ 0x10de, 0x00da, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_NFORCE },	/* NFORCE3 */
 	{ 0x10de, 0x00ea, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_NFORCE },	/* CK8S */
 	{ 0x10de, 0x026b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_NFORCE },	/* MCP51 */
+	{ 0x10de, 0x0371, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_NFORCE },	/* MCP55 */
 	{ 0x1022, 0x746d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL },	/* AMD8111 */
 	{ 0x1022, 0x7445, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL },	/* AMD768 */
 	{ 0x10b9, 0x5455, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_ALI },   /* Ali5455 */

--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--LQksG6bCIzRHxTLp--
