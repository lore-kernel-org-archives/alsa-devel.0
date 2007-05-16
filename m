From: Tobin Davis <tdavis@dsl-only.net>
Subject: HDA:  Add more systems to Sigmatel codec.
Date: Wed, 16 May 2007 11:42:58 -0700
Message-ID: <1179340978.4415.232.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-UqUNP2L890JE04yyHmyj"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D9A32438C
	for <alsa-devel@alsa-project.org>;
	Wed, 16 May 2007 20:43:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Developers <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--=-UqUNP2L890JE04yyHmyj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds more Dell systems and a Panasonic laptop with Stac9200
codecs.


Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-UqUNP2L890JE04yyHmyj
Content-Disposition: attachment; filename=Dell-640M.patch
Content-Type: text/x-patch; name=Dell-640M.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 5bd948503866 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Tue May 15 11:47:48 2007 +0200
+++ b/pci/hda/patch_sigmatel.c	Wed May 16 11:41:23 2007 -0700
@@ -469,6 +474,14 @@ static struct snd_pci_quirk stac9200_cfg
 		      "Dell Precision M90", STAC_REF),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01d6,
 		      "unknown Dell", STAC_REF),
+        SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01d8,
+                      "Dell Inspiron 640m", STAC_REF),
+        SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01f5,
+                      "Dell Inspiron 1501", STAC_REF),
+
+        /* Panasonic */
+        SND_PCI_QUIRK(0x10f7, 0x8338, "Panasonic CF-74", STAC_REF),
+
 	{} /* terminator */
 };
 

--=-UqUNP2L890JE04yyHmyj
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-UqUNP2L890JE04yyHmyj--
