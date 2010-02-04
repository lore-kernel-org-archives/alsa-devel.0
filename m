From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: [PATCH] ALSA: cosmetic: make hda intel interrupt name
	consistent with others
Date: Thu,  4 Feb 2010 22:26:37 +0200
Message-ID: <1265315197-19729-1-git-send-email-maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f221.google.com (mail-bw0-f221.google.com
	[209.85.218.221])
	by alsa0.perex.cz (Postfix) with ESMTP id 92A2310387B
	for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2010 21:26:54 +0100 (CET)
Received: by bwz21 with SMTP id 21so2586710bwz.4
	for <alsa-devel@alsa-project.org>; Thu, 04 Feb 2010 12:26:53 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Maxim Levitsky <maximlevitsky@gmail.com>
List-Id: alsa-devel@alsa-project.org

This renames the interrupt name in /proc/interrupt.
HDA Intel -> hda_intel

This also eliminates space from the name, probably helping some
parsers.
Don't think anybody depends on this name in userspace

---
 sound/pci/hda/hda_intel.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 11ce655..0adea96 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2058,7 +2058,7 @@ static int azx_acquire_irq(struct azx *chip, int do_disconnect)
 {
 	if (request_irq(chip->pci->irq, azx_interrupt,
 			chip->msi ? 0 : IRQF_SHARED,
-			"HDA Intel", chip)) {
+			"hda_intel", chip)) {
 		printk(KERN_ERR "hda-intel: unable to grab IRQ %d, "
 		       "disabling device\n", chip->pci->irq);
 		if (do_disconnect)
-- 
1.6.3.3
