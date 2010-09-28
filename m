From: Luke Yelavich <themuso@ubuntu.com>
Subject: [PATCH] ALSA: hda - Add quirk for another Acer laptop
	with a CX20585 codec
Date: Tue, 28 Sep 2010 12:04:06 +1000
Message-ID: <1285639446-29419-1-git-send-email-themuso@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nschwmtas01p.mx.bigpond.com (nschwmtas01p.mx.bigpond.com
	[61.9.189.137]) by alsa0.perex.cz (Postfix) with ESMTP id E2C9210387C
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Sep 2010 04:04:12 +0200 (CEST)
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
Cc: Luke Yelavich <luke.yelavich@canonical.com>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

From: Luke Yelavich <luke.yelavich@canonical.com>

BugLink: https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/647374

Set another Acer laptop (SSID 1025:043d) to use CXT5066_IDEAPAD

Cc: stable@kernel.org
Signed-off-by: Luke Yelavich <luke.yelavich@canonical.com>
---
 sound/pci/hda/patch_conexant.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index a6c68cb..80cc74b 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -3094,6 +3094,7 @@ static const char *cxt5066_models[CXT5066_MODELS] = {
 
 static struct snd_pci_quirk cxt5066_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x040a, "Acer", CXT5066_IDEAPAD),
+	SND_PCI_QUIRK(0x1025, 0x043d, "Acer", CXT5066_IDEAPAD),
 	SND_PCI_QUIRK(0x1028, 0x02d8, "Dell Vostro", CXT5066_DELL_VOSTRO),
 	SND_PCI_QUIRK(0x1028, 0x02f5, "Dell",
 		      CXT5066_DELL_LAPTOP),
-- 
1.7.1
