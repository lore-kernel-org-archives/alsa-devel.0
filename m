From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH] Fix buffer position for ATI SB4x0
Date: Thu, 29 May 2008 11:10:22 -0300
Message-ID: <20080529111022.102bf250@gaivota>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 57D4D10385A
	for <alsa-devel@alsa-project.org>;
	Thu, 29 May 2008 16:10:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

ATI SB4x0 doesn't need any fix at position.

This patch solves the issue of receiving several clicks during capture on those
devices.

Tested with a Gateway Notebook MX-6453.

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>

diff -r 33d7308ade64 pci/hda/hda_intel.c
--- a/pci/hda/hda_intel.c	Fri May 23 17:36:59 2008 -0300
+++ b/pci/hda/hda_intel.c	Thu May 29 11:04:56 2008 -0300
@@ -1860,6 +1860,7 @@
 	SND_PCI_QUIRK(0x1028, 0x01cc, "Dell D820", POS_FIX_NONE),
 	SND_PCI_QUIRK(0x1028, 0x01de, "Dell Precision 390", POS_FIX_NONE),
 	SND_PCI_QUIRK(0x1043, 0x813d, "ASUS P5AD2", POS_FIX_NONE),
+	SND_PCI_QUIRK(0x1002, 0x437b, "ATI SB4x0 HDA", POS_FIX_NONE),
 	{}
 };
