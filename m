From: Priit Laes <amd@store20.com>
Subject: [2.6 patch] Fix sound on Samsung Q1
Date: Wed, 24 Jan 2007 01:01:41 +0200
Message-ID: <1169593302.30189.3.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-d2p+SNqulc2GeoRB4YA9"
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


--=-d2p+SNqulc2GeoRB4YA9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Patch below makes sound working on Samsung Q1 device out of the box ;)

--=-d2p+SNqulc2GeoRB4YA9
Content-Description: 
Content-Disposition: inline; filename=samsung-q1-hda-sound.patch
Content-Type: text/x-patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Samsung Q1 (Microsoft Origami) snd-hda-intel board fix.

Signed-off-by: Priit Laes <amd <at> store20.com>
--- sound/pci/hda/patch_analog.c.orig	2007-01-24 04:39:04.000000000 +0000
+++ sound/pci/hda/patch_analog.c	2007-01-24 05:41:04.000000000 +0000
@@ -812,6 +812,8 @@ static struct hda_board_config ad1986a_c
 	  .config = AD1986A_LAPTOP_EAPD }, /* Samsung R65-T2300 Charis */
 	{ .pci_subvendor = 0x144d, .pci_subdevice = 0xc026,
 	  .config = AD1986A_LAPTOP_EAPD }, /* Samsung X10-T2300 Culesa */
+	{ .pci_subvendor = 0x144d, .pci_subdevice = 0xc027,
+	  .config = AD1986A_LAPTOP_EAPD }, /* Samsung Q1 (Microsoft Origami) */
 	{ .pci_subvendor = 0x1043, .pci_subdevice = 0x1153,
 	  .config = AD1986A_LAPTOP_EAPD }, /* ASUS M9 */
 	{ .pci_subvendor = 0x1043, .pci_subdevice = 0x1213,

--=-d2p+SNqulc2GeoRB4YA9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-d2p+SNqulc2GeoRB4YA9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-d2p+SNqulc2GeoRB4YA9--
