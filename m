From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/4] snd-meastro3: Add amp_gpio quirk for
	Compaq EVO N600C
Date: Wed, 21 Apr 2010 11:04:06 -0400
Message-ID: <1271862249-22612-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.versatel.nl (smtp4.versatel.nl [62.58.50.91])
	by alsa0.perex.cz (Postfix) with ESMTP id 4AA2B244C1
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Apr 2010 16:58:50 +0200 (CEST)
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
Cc: Hans de Goede <hdegoede@redhat.com>
List-Id: alsa-devel@alsa-project.org

Without this quirk sound stops working after suspend resume. With this quirk,
one still needs to manually unmute the master volume control after a suspend /
/ resume cycle. That is fixed in another patch in this set.

Note that this patch was submitted to the alsa bug tracker a long time ago:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4319

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/pci/maestro3.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/maestro3.c b/sound/pci/maestro3.c
index 75283fb..491a2fc 100644
--- a/sound/pci/maestro3.c
+++ b/sound/pci/maestro3.c
@@ -884,6 +884,7 @@ static struct pci_device_id snd_m3_ids[] = {
 MODULE_DEVICE_TABLE(pci, snd_m3_ids);
 
 static struct snd_pci_quirk m3_amp_quirk_list[] __devinitdata = {
+	SND_PCI_QUIRK(0x0E11, 0x0094, "Compaq Evo N600c", 0x0c),
 	SND_PCI_QUIRK(0x10f7, 0x833e, "Panasonic CF-28", 0x0d),
 	SND_PCI_QUIRK(0x10f7, 0x833d, "Panasonic CF-72", 0x0d),
 	SND_PCI_QUIRK(0x1033, 0x80f1, "NEC LM800J/7", 0x03),
-- 
1.7.0.1
