From: David Dillow <dave@thedillows.org>
Subject: [PATCH] sis7019: increase reset delays
Date: Sat, 26 Jun 2010 18:07:57 -0400
Message-ID: <1277590077.2438.9.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from amavis-smtp.knology.net (amavis-smtp.knology.net [75.76.199.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 4566924547
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jun 2010 00:08:04 +0200 (CEST)
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
Cc: tiwai@suse.de, michael.goeke@icachip.de
List-Id: alsa-devel@alsa-project.org

A few boards using this controller are reported to need a little extra
time during their reset cycle.
    
Reported-by: Michael Goeke <michael.goeke@icachip.de>
Signed-off-by: Dave Dillow <dave@thedillows.org>
---

Wow, a horrible maintainer am I. Working on the virtual timing period
reminded me of of another timing issue from two years back that I forgot
to push upstream. This applies on top of the vperiod fixes, but should
not conflict if the ordering is changed.

diff --git a/sound/pci/sis7019.c b/sound/pci/sis7019.c
index 614ff6e..1b8f674 100644
--- a/sound/pci/sis7019.c
+++ b/sound/pci/sis7019.c
@@ -1049,7 +1049,7 @@ static int sis_chip_free(struct sis7019 *sis)
 	/* Reset the chip, and disable all interrputs.
 	 */
 	outl(SIS_GCR_SOFTWARE_RESET, sis->ioport + SIS_GCR);
-	udelay(10);
+	udelay(25);
 	outl(0, sis->ioport + SIS_GCR);
 	outl(0, sis->ioport + SIS_GIER);
 
@@ -1085,7 +1085,7 @@ static int sis_chip_init(struct sis7019 *sis)
 	/* Reset the audio controller
 	 */
 	outl(SIS_GCR_SOFTWARE_RESET, io + SIS_GCR);
-	udelay(10);
+	udelay(25);
 	outl(0, io + SIS_GCR);
 
 	/* Get the AC-link semaphore, and reset the codecs
@@ -1098,7 +1098,7 @@ static int sis_chip_init(struct sis7019 *sis)
 		return -EIO;
 
 	outl(SIS_AC97_CMD_CODEC_COLD_RESET, io + SIS_AC97_CMD);
-	udelay(10);
+	udelay(250);
 
 	count = 0xffff;
 	while ((inw(io + SIS_AC97_STATUS) & SIS_AC97_STATUS_BUSY) && --count)
