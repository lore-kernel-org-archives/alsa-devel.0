From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Remove quirk for Toshiba T110
Date: Tue,  8 Nov 2011 20:37:26 +0100
Message-ID: <1320781046-2649-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 246F2103962
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2011 20:37:30 +0100 (CET)
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
Cc: tiwai@suse.de, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

According to the bug reporter, model=auto is needed to make the
internal microphone work.

BugLink: https://bugs.launchpad.net/bugs/819699
Reported-by: Andrej (agno01)
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_conexant.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 5e706e4..0de2119 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -3062,7 +3062,6 @@ static const struct snd_pci_quirk cxt5066_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1993, "Asus U50F", CXT5066_ASUS),
 	SND_PCI_QUIRK(0x1179, 0xff1e, "Toshiba Satellite C650D", CXT5066_IDEAPAD),
 	SND_PCI_QUIRK(0x1179, 0xff50, "Toshiba Satellite P500-PSPGSC-01800T", CXT5066_OLPC_XO_1_5),
-	SND_PCI_QUIRK(0x1179, 0xffe0, "Toshiba Satellite Pro T130-15F", CXT5066_OLPC_XO_1_5),
 	SND_PCI_QUIRK(0x14f1, 0x0101, "Conexant Reference board",
 		      CXT5066_LAPTOP),
 	SND_PCI_QUIRK(0x152d, 0x0833, "OLPC XO-1.5", CXT5066_OLPC_XO_1_5),
-- 
1.7.5.4
