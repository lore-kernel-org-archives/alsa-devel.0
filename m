From: Tobin Davis <tdavis@dsl-only.net>
Subject: Add support for Evesham Voyager C530RD laptops
Date: Fri, 17 Nov 2006 15:01:27 -0800
Message-ID: <1163804487.5390.86.camel@razman>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-yFR3oPjK5SB+kkb9mogN"
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


--=-yFR3oPjK5SB+kkb9mogN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds support for the Evesham Voyager C530RD series laptops.
So far, only playback has been tested, but microphone should also work.

Signed off by:
-- 
Tobin Davis <tdavis@dsl-only.net>

--=-yFR3oPjK5SB+kkb9mogN
Content-Disposition: attachment; filename=Evesham.patch
Content-Type: text/x-patch; name=Evesham.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -r 21f48c206e92 pci/hda/patch_realtek.c
--- a/pci/hda/patch_realtek.c	Thu Nov 16 17:24:20 2006 +0100
+++ b/pci/hda/patch_realtek.c	Fri Nov 17 15:01:08 2006 -0800
@@ -5478,6 +5478,8 @@ static struct hda_board_config alc883_cf
 	{ .pci_subvendor = 0x161f, .pci_subdevice = 0x2054,
 	  .modelname = "medion", .config = ALC883_MEDION },
 	{ .modelname = "laptop-eapd", .config = ALC883_LAPTOP_EAPD },
+	{ .pci_subvendor = 0x1071, .pci_subdevice = 0x8258,
+	  .config = ALC883_LAPTOP_EAPD }, /* Evesham Voyager C530RD */
 	{ .pci_subvendor = 0x1558, .pci_subdevice = 0,
 	  .config = ALC883_LAPTOP_EAPD }, /* Clevo */
 	{ .modelname = "auto", .config = ALC883_AUTO },

--=-yFR3oPjK5SB+kkb9mogN
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-yFR3oPjK5SB+kkb9mogN
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-yFR3oPjK5SB+kkb9mogN--
