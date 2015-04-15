From: Scott Wood <scottwood@freescale.com>
Subject: [PATCH] ALSA: intel8x0: Check pci_iomap() success for
	DEVICE_ALI
Date: Wed, 15 Apr 2015 18:16:47 -0500
Message-ID: <1429139807-7059-1-git-send-email-scottwood@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0107.outbound.protection.outlook.com [157.56.110.107])
 by alsa0.perex.cz (Postfix) with ESMTP id F10B1260588
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2015 01:17:03 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Scott Wood <scottwood@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

DEVICE_ALI previously would jump to port_inited after calling
pci_iomap(), bypassing the check for bmaddr being NULL.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 sound/pci/intel8x0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index 2c5484e..dfb77a5 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -3101,13 +3101,13 @@ static int snd_intel8x0_create(struct snd_card *card,
 		chip->bmaddr = pci_iomap(pci, 3, 0);
 	else
 		chip->bmaddr = pci_iomap(pci, 1, 0);
+
+ port_inited:
 	if (!chip->bmaddr) {
 		dev_err(card->dev, "Controller space ioremap problem\n");
 		snd_intel8x0_free(chip);
 		return -EIO;
 	}
-
- port_inited:
 	chip->bdbars_count = bdbars[device_type];
 
 	/* initialize offsets */
-- 
2.1.0
