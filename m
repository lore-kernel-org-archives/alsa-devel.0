From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix ymfpci port parameter handling
Date: Thu, 23 Oct 2003 09:37:44 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0310230935090.295-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


- fix detection of omitted (default) joystick_port parameter
- make fm_port and mpu_port handling consistent with joystick_port


Index: alsa-kernel/pci/ymfpci/ymfpci.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ymfpci/ymfpci.c,v
retrieving revision 1.29
diff -u -r1.29 ymfpci.c
--- alsa-kernel/pci/ymfpci/ymfpci.c	14 Oct 2003 13:59:21 -0000	1.29
+++ alsa-kernel/pci/ymfpci/ymfpci.c	23 Oct 2003 07:14:43 -0000
@@ -44,10 +44,10 @@
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;	/* Enable this card */
-static long fm_port[SNDRV_CARDS];
-static long mpu_port[SNDRV_CARDS];
+static long fm_port[SNDRV_CARDS] = { [0 ... SNDRV_CARDS-1] = -1 };
+static long mpu_port[SNDRV_CARDS] = { [0 ... SNDRV_CARDS-1] = -1 };
 #ifdef SUPPORT_JOYSTICK
-static long joystick_port[SNDRV_CARDS];
+static long joystick_port[SNDRV_CARDS] = { [0 ... SNDRV_CARDS-1] = -1 };
 #endif
 static int rear_switch[SNDRV_CARDS];

@@ -128,18 +128,18 @@
 	legacy_ctrl2 = 0x0800;	/* SBEN = 0, SMOD = 01, LAD = 0 */

 	if (pci_id->device >= 0x0010) { /* YMF 744/754 */
-		if (fm_port[dev] <= 0) {
+		if (fm_port[dev] < 0) {
 			fm_port[dev] = pci_resource_start(pci, 1);
 		}
-		if (fm_port[dev] > 0 &&
+		if (fm_port[dev] >= 0 &&
 		    (fm_res = request_region(fm_port[dev], 4, "YMFPCI OPL3")) != NULL) {
 			legacy_ctrl |= YMFPCI_LEGACY_FMEN;
 			pci_write_config_word(pci, PCIR_DSXG_FMBASE, fm_port[dev]);
 		}
-		if (mpu_port[dev] <= 0) {
+		if (mpu_port[dev] < 0) {
 			mpu_port[dev] = pci_resource_start(pci, 1) + 0x20;
 		}
-		if (mpu_port[dev] > 0 &&
+		if (mpu_port[dev] >= 0 &&
 		    (mpu_res = request_region(mpu_port[dev], 2, "YMFPCI MPU401")) != NULL) {
 			legacy_ctrl |= YMFPCI_LEGACY_MEN;
 			pci_write_config_word(pci, PCIR_DSXG_MPU401BASE, mpu_port[dev]);




-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
