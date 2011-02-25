From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: [PATCH 20/21]sound:pci:hda:patch_realtek.c remove one
	to many l's in the word.
Date: Thu, 24 Feb 2011 22:16:02 -0800
Message-ID: <1298614562-4230-1-git-send-email-justinmattock@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B3D8210380C
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2011 07:16:21 +0100 (CET)
Received: by ywg4 with SMTP id 4so385496ywg.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Feb 2011 22:16:21 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: trivial@kernel.org
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Justin P. Mattock" <justinmattock@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch below removes an extra "l" in the word.

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

---
 sound/pci/hda/patch_realtek.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3328a25..c5208c9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4705,7 +4705,7 @@ static struct snd_pci_quirk alc880_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x1558, 0x5401, "ASUS", ALC880_ASUS_DIG2),
 	SND_PCI_QUIRK(0x1565, 0x8202, "Biostar", ALC880_5ST_DIG),
 	SND_PCI_QUIRK(0x1584, 0x9050, "Uniwill", ALC880_UNIWILL_DIG),
-	SND_PCI_QUIRK(0x1584, 0x9054, "Uniwlll", ALC880_F1734),
+	SND_PCI_QUIRK(0x1584, 0x9054, "Uniwill", ALC880_F1734),
 	SND_PCI_QUIRK(0x1584, 0x9070, "Uniwill", ALC880_UNIWILL),
 	SND_PCI_QUIRK(0x1584, 0x9077, "Uniwill P53", ALC880_UNIWILL_P53),
 	SND_PCI_QUIRK(0x161f, 0x203d, "W810", ALC880_W810),
-- 
1.7.4.1
