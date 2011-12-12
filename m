From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Set position fix to LPIB for an
	Atom/Poulsbo based device
Date: Mon, 12 Dec 2011 14:01:17 +0800
Message-ID: <1323669677-7832-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id D173E24422
	for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2011 07:01:35 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: 825709@bugs.launchpad.net, "3.0+" <stable@kernel.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

For the Asus 1101HA, reporting position by reading the DMA position
buffer map seems unstable and often wrong. The reporter says that
position_fix=LPIB works much better (although not 100%, but this is
probably due to other issues).

The controller chip is an Intel Poulsbo 8086:811b (rev 07) controller,
and complete alsa-info is available here:
https://launchpadlibrarian.net/86691768/alsa-info.txt.1TNwyE5Ea7

Cc: stable@kernel.org (3.0+)
BugLink: http://bugs.launchpad.net/bugs/825709
Tested-by: Stefano Lodi
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_intel.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index d1582dd..0746ab4 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2506,6 +2506,7 @@ static struct snd_pci_quirk position_fix_list[] __devinitdata = {
 	SND_PCI_QUIRK(0x1043, 0x813d, "ASUS P5AD2", POS_FIX_LPIB),
 	SND_PCI_QUIRK(0x1043, 0x81b3, "ASUS", POS_FIX_LPIB),
 	SND_PCI_QUIRK(0x1043, 0x81e7, "ASUS M2V", POS_FIX_LPIB),
+	SND_PCI_QUIRK(0x1043, 0x83ce, "ASUS 1101HA", POS_FIX_LPIB),
 	SND_PCI_QUIRK(0x104d, 0x9069, "Sony VPCS11V9E", POS_FIX_LPIB),
 	SND_PCI_QUIRK(0x1297, 0x3166, "Shuttle", POS_FIX_LPIB),
 	SND_PCI_QUIRK(0x1458, 0xa022, "ga-ma770-ud3", POS_FIX_LPIB),
-- 
1.7.5.4
