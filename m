From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: [PATCH] via82xx: add __devinitdata
Date: Tue, 3 Oct 2006 14:21:50 +0200
Message-ID: <20061003122150.GA21376@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

add __devinitdata to struct whitelist, since it's used within
a __devinit function.
Add const attribute to iterator variable, too.

Compile-tested (no section warnings etc.) and run-tested
on vt8233, 2.6.18-mm3 (hopefully applies well to current ALSA).

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.18-mm3.orig/sound/pci/via82xx.c linux-2.6.18-mm3/sound/pci/via82xx.c
--- linux-2.6.18-mm3.orig/sound/pci/via82xx.c	2006-10-11 12:00:07.000000000 +0200
+++ linux-2.6.18-mm3.my/sound/pci/via82xx.c	2006-10-11 14:02:23.000000000 +0200
@@ -2360,7 +2360,7 @@
 
 static int __devinit check_dxs_list(struct pci_dev *pci, int revision)
 {
-	static struct dxs_whitelist whitelist[] = {
+	static struct dxs_whitelist whitelist[] __devinitdata = {
 		{ .subvendor = 0x1005, .subdevice = 0x4710, .action = VIA_DXS_ENABLE }, /* Avance Logic Mobo */
 		{ .subvendor = 0x1019, .subdevice = 0x0996, .action = VIA_DXS_48K },
 		{ .subvendor = 0x1019, .subdevice = 0x0a81, .action = VIA_DXS_NO_VRA }, /* ECS K7VTA3 v8.0 */
@@ -2421,7 +2421,7 @@
 		{ .subvendor = 0x4005, .subdevice = 0x4710, .action = VIA_DXS_SRC },	/* MSI K7T266 Pro2 (MS-6380 V2.0) BIOS 3.7 */
 		{ } /* terminator */
 	};
-	struct dxs_whitelist *w;
+	const struct dxs_whitelist *w;
 	unsigned short subsystem_vendor;
 	unsigned short subsystem_device;
 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
