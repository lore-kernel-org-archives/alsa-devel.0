From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: [PATCH] [snd-hda-intel] fix sound on some Asus W6A
	chips
Date: Tue, 08 Aug 2006 18:49:49 +0200
Message-ID: <m2oduv41g2.fsf@vador.mandriva.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
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
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: danny@mailmij.org, Thomas Backlund <tmb@mandriva.org>
List-Id: alsa-devel@alsa-project.org

--=-=-=

This patch adds support in ALSA snd-hda-intel driver for Asus W6A
motherboard as reported in MDV Bugzilla #19962

(see http://qa.mandriva.com/show_bug.cgi?id=19962)

Signed-off by: danny@mailmij.org
Signed-off by: Thomas Backlund <tmb@mandriva.org>
Signed-off by: Thierry Vignaud <tvignaud@mandriva.com>

 sound/pci/hda/patch_realtek.c |    1 	1 +	0 -	0 !
 1 files changed, 1 insertion(+)

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline;
	filename=DA93_alsa_hda_intel_Realtek_Asus_W6A.patch

Index: linux-2.6.17/sound/pci/hda/patch_realtek.c
===================================================================
--- linux-2.6.17.orig/sound/pci/hda/patch_realtek.c	2006-08-08 12:20:22.000000000 +0200
+++ linux-2.6.17/sound/pci/hda/patch_realtek.c	2006-08-08 13:43:41.000000000 +0200
@@ -2240,6 +2240,7 @@ static struct hda_board_config alc880_cf
 	{ .pci_subvendor = 0x1043, .pci_subdevice = 0x1113, .config = ALC880_ASUS_DIG },
 	{ .pci_subvendor = 0x1043, .pci_subdevice = 0x1173, .config = ALC880_ASUS_DIG },
 	{ .pci_subvendor = 0x1043, .pci_subdevice = 0x1993, .config = ALC880_ASUS },
+	{ .pci_subvendor = 0x1043, .pci_subdevice = 0x10c2, .config = ALC880_ASUS_DIG }, /* Asus W6A */
 	{ .pci_subvendor = 0x1043, .pci_subdevice = 0x10c3, .config = ALC880_ASUS_DIG },
 	{ .pci_subvendor = 0x1043, .pci_subdevice = 0x1133, .config = ALC880_ASUS },
 	{ .pci_subvendor = 0x1043, .pci_subdevice = 0x1123, .config = ALC880_ASUS_DIG },

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-=-=--
