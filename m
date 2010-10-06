From: Luke Yelavich <themuso@ubuntu.com>
Subject: [PATCH] ALSA: hda - Add another HP DV6 quirk
Date: Wed,  6 Oct 2010 15:45:46 +1100
Message-ID: <1286340346-16518-1-git-send-email-themuso@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nschwmtas01p.mx.bigpond.com (nschwmtas01p.mx.bigpond.com
	[61.9.189.137]) by alsa0.perex.cz (Postfix) with ESMTP id 14F5524395
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Oct 2010 06:45:52 +0200 (CEST)
Received: from nschwotgx03p.mx.bigpond.com ([124.189.85.102])
	by nschwmtas01p.mx.bigpond.com with ESMTP id
	<20101006044547.ZPRF24965.nschwmtas01p.mx.bigpond.com@nschwotgx03p.mx.bigpond.com>
	for <alsa-devel@alsa-project.org>; Wed, 6 Oct 2010 04:45:47 +0000
Received: from strigy.yelavich.home ([124.189.85.102])
	by nschwotgx03p.mx.bigpond.com with ESMTP id
	<20101006044547.OZHE16083.nschwotgx03p.mx.bigpond.com@strigy.yelavich.home>
	for <alsa-devel@alsa-project.org>; Wed, 6 Oct 2010 04:45:47 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Luke Yelavich <luke.yelavich@canonical.com>

BugLink: https://bugs.launchpad.net/bugs/653420

Add another HP DV6 notebook (103c:363e) to use STAC_HP_DV5.

Signed-off-by: Luke Yelavich <luke.yelavich@canonical.com>
---
 sound/pci/hda/patch_sigmatel.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index d8dfafe..f3577ed 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -1750,6 +1750,8 @@ static struct snd_pci_quirk stac92hd71bxx_cfg_tbl[] = {
 		      "HP dv6", STAC_HP_DV5), /* HP dv6-1110ax */
 	SND_PCI_QUIRK_MASK(PCI_VENDOR_ID_HP, 0xfff0, 0x7010,
 		      "HP", STAC_HP_DV5),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x363e,
+	              "HP DV6", STAC_HP_DV5),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0233,
 				"unknown Dell", STAC_DELL_M4_1),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0234,
-- 
1.7.1
