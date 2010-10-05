From: Luke Yelavich <themuso@ubuntu.com>
Subject: [PATCH] ALSA: hda - Add a quirk for MacBookPro 7,
	1 with a CS4206 codec
Date: Tue,  5 Oct 2010 12:08:17 +1100
Message-ID: <1286240897-3969-1-git-send-email-themuso@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nskntmtas03p.mx.bigpond.com (nskntmtas03p.mx.bigpond.com
	[61.9.168.143]) by alsa0.perex.cz (Postfix) with ESMTP id ABCB4103822
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Oct 2010 03:08:23 +0200 (CEST)
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
Cc: stable@kernel.org
List-Id: alsa-devel@alsa-project.org

From: Luke Yelavich <luke.yelavich@canonical.com>

BugLink: https://bugs.launchpad.net/bugs/647389

Add an SSID for MacBookPro 7,1 (10de,cb89) to use CS420X_MBP55.

Cc: stable@kernel.org
Signed-off-by: Luke Yelavich <luke.yelavich@canonical.com>
---
 sound/pci/hda/patch_cirrus.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index 5c00106..d9a3dbc 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -1140,6 +1140,7 @@ static const char *cs420x_models[CS420X_MODELS] = {
 static struct snd_pci_quirk cs420x_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x10de, 0x0ac0, "MacBookPro 5,3", CS420X_MBP53),
 	SND_PCI_QUIRK(0x10de, 0xcb79, "MacBookPro 5,5", CS420X_MBP55),
+	SND_PCI_QUIRK(0x10de, 0xcb89, "MacBookPro 7,1", CS420X_MBP55),
 	SND_PCI_QUIRK(0x8086, 0x7270, "IMac 27 Inch", CS420X_IMAC27),
 	{} /* terminator */
 };
-- 
1.7.1
