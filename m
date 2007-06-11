From: Tobin Davis <gruemaster@email.uophx.edu>
Subject: hda-codec - Add HP Pavillion quirk to Realtek code.
Date: Mon, 11 Jun 2007 09:47:07 -0700
Message-ID: <1181580427.5053.62.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=-olQ+q5duMi/7H2+aexDH"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ONLPEXCVWL06.OLS.Phoenix.edu (users.apollogrp.edu
	[204.17.31.62]) by alsa0.perex.cz (Postfix) with ESMTP id 7483F24486
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2007 18:47:15 +0200 (CEST)
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


--=-olQ+q5duMi/7H2+aexDH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds the HP Pavillion a1589L desktop system to the ALC883
configuration table.



Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-olQ+q5duMi/7H2+aexDH
Content-Disposition: attachment; filename=HP-Pavillon.patch
Content-Type: text/x-patch; name=HP-Pavillon.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r d2662f0d43b1 pci/hda/patch_realtek.c
--- a/pci/hda/patch_realtek.c	Thu May 31 09:09:20 2007 +0200
+++ b/pci/hda/patch_realtek.c	Mon Jun 11 09:43:18 2007 -0700
@@ -6373,6 +6376,7 @@ static const char *alc883_models[ALC883_
 
 static struct snd_pci_quirk alc883_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x1019, 0x6668, "ECS", ALC883_3ST_6ch_DIG),
+	SND_PCI_QUIRK(0x103c, 0x2a3d, "HP Pavillion", ALC883_6ST_DIG),
 	SND_PCI_QUIRK(0x108e, 0x534d, NULL, ALC883_3ST_6ch),
 	SND_PCI_QUIRK(0x1558, 0, "Clevo laptop", ALC883_LAPTOP_EAPD),
 	SND_PCI_QUIRK(0x105b, 0x6668, "Foxconn", ALC883_6ST_DIG),

--=-olQ+q5duMi/7H2+aexDH
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-olQ+q5duMi/7H2+aexDH--
