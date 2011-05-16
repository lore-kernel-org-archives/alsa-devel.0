From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Use one dmic only for Dell Studio
	1558
Date: Mon, 16 May 2011 12:18:23 +0200
Message-ID: <4DD0F9EF.6010604@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080400010105080501090504"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 61173103810
	for <alsa-devel@alsa-project.org>;
	Mon, 16 May 2011 12:18:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080400010105080501090504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

There are no signs of a dmic at node 0x0b, so the user is left with
an additional internal mic which does not exist. This commit removes
that non-existing mic.

Codec info at http://bugs.launchpad.net/bugs/731706.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------080400010105080501090504
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Use-one-dmic-only-for-Dell-Studio-1558.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Use-one-dmic-only-for-Dell-Studio-1558.patch"

>From 2eea04a7904dcc6071c96f70ca9991cd32bbd34b Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Mon, 16 May 2011 12:09:29 +0200
Subject: [PATCH] ALSA: HDA: Use one dmic only for Dell Studio 1558

There are no signs of a dmic at node 0x0b, so the user is left with
an additional internal mic which does not exist. This commit removes
that non-existing mic.

Cc: stable@kernel.org (2.6.32+)
BugLink: http://bugs.launchpad.net/bugs/731706
Reported-by: James Page <james.page@canonical.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_sigmatel.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index a2884bb..38f4317 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -1604,7 +1604,7 @@ static const struct snd_pci_quirk stac92hd73xx_cfg_tbl[] = {
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x02fe,
 				"Dell Studio XPS 1645", STAC_DELL_M6_BOTH),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0413,
-				"Dell Studio 1558", STAC_DELL_M6_BOTH),
+				"Dell Studio 1558", STAC_DELL_M6_DMIC),
 	{} /* terminator */
 };
 
-- 
1.7.4.1


--------------080400010105080501090504
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080400010105080501090504--
