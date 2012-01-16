From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Fix internal microphone on Dell
	Studio 16 XPS 1645
Date: Mon, 16 Jan 2012 10:52:20 +0100
Message-ID: <1326707540-6220-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id F3EDD245B9
	for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2012 10:52:26 +0100 (CET)
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
Cc: stable@kernel.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

More than one user reports that changing the model from "both" to
"dmic" makes their Internal Mic work.

Cc: stable@kernel.org
Tested-by: Martin Ling <martin-launchpad@earth.li>
BugLink: https://bugs.launchpad.net/bugs/795823
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_sigmatel.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 87e684f..3556408 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -1596,7 +1596,7 @@ static const struct snd_pci_quirk stac92hd73xx_cfg_tbl[] = {
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x02bd,
 				"Dell Studio 1557", STAC_DELL_M6_DMIC),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x02fe,
-				"Dell Studio XPS 1645", STAC_DELL_M6_BOTH),
+				"Dell Studio XPS 1645", STAC_DELL_M6_DMIC),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0413,
 				"Dell Studio 1558", STAC_DELL_M6_DMIC),
 	{} /* terminator */
-- 
1.7.5.4
