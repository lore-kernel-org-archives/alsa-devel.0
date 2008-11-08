From: Michel Marti <mma@objectxp.com>
Subject: [PATCH v2] ALSA: hda - Add another HP model (6730s)
	for AD1884A.
Date: Sat,  8 Nov 2008 11:33:32 +0100
Message-ID: <1226140412-28801-1-git-send-email-mma@objectxp.com>
References: <1226139218-28605-1-git-send-email-mma@objectxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from automatix.objectxp.com (automatix.objectxp.com [62.2.156.210])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A3CA24417
	for <alsa-devel@alsa-project.org>; Sat,  8 Nov 2008 11:33:32 +0100 (CET)
In-Reply-To: <1226139218-28605-1-git-send-email-mma@objectxp.com>
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
Cc: Michel Marti <mma@objectxp.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Michel Marti <mma@objectxp.com>
---
Please ignore my previous patch. I just realized that 'AD1884A_LAPTOP'
is more appropriate for this device (it *is* a laptop).

 sound/pci/hda/patch_analog.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index d3fd432..400df85 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -3861,6 +3861,7 @@ static const char *ad1884a_models[AD1884A_MODELS] = {
 static struct snd_pci_quirk ad1884a_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x3030, "HP", AD1884A_MOBILE),
 	SND_PCI_QUIRK(0x103c, 0x3056, "HP", AD1884A_MOBILE),
+	SND_PCI_QUIRK(0x103c, 0x3614, "HP 6730s", AD1884A_LAPTOP),
 	SND_PCI_QUIRK(0x17aa, 0x20ac, "Thinkpad X300", AD1884A_THINKPAD),
 	{}
 };
-- 
1.5.6.5
