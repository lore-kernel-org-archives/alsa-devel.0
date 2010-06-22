From: Luke Yelavich <themuso@ubuntu.com>
Subject: [PATCH] ALSA: hda - Add Macbook 5,2 quirk
Date: Tue, 22 Jun 2010 11:04:19 +1000
Message-ID: <1277168659-8894-1-git-send-email-themuso@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nschwmtas05p.mx.bigpond.com (nschwmtas05p.mx.bigpond.com
	[61.9.189.149]) by alsa0.perex.cz (Postfix) with ESMTP id 506CD24552
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jun 2010 03:04:21 +0200 (CEST)
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

BugLink: https://bugs.launchpad.net/bugs/463178

Set Macbook 5,2 (106b:4a00) hardware to use ALC885_MB5

Cc: <stable@kernel.org>
Signed-off-by: Luke Yelavich <luke.yelavich@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f1ce7d7..b145306 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9486,6 +9486,7 @@ static struct snd_pci_quirk alc882_ssid_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x106b, 0x3e00, "iMac 24 Aluminum", ALC885_IMAC24),
 	SND_PCI_QUIRK(0x106b, 0x4900, "iMac 9,1 Aluminum", ALC885_IMAC91),
 	SND_PCI_QUIRK(0x106b, 0x3f00, "Macbook 5,1", ALC885_MB5),
+	SND_PCI_QUIRK(0x106b, 0x4a00, "Macbook 5,2", ALC885_MB5),
 	/* FIXME: HP jack sense seems not working for MBP 5,1 or 5,2,
 	 * so apparently no perfect solution yet
 	 */
-- 
1.7.0.4
