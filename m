From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ALSA: azt3328: Remove unnecessary
	synchronize_irq() before free_irq()
Date: Sat, 21 Nov 2015 12:01:22 +0100
Message-ID: <1448103682-17172-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-188.synserver.de (smtp-out-098.synserver.de
 [212.40.185.98])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B7D02606F6
 for <alsa-devel@alsa-project.org>; Sat, 21 Nov 2015 12:05:02 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Calling synchronize_irq() right before free_irq() is quite useless. On one
hand the IRQ can easily fire again before free_irq() is entered, on the
other hand free_irq() itself calls synchronize_irq() internally (in a race
condition free way) before any state associated with the IRQ is freed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/pci/azt3328.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/pci/azt3328.c b/sound/pci/azt3328.c
index 07a4acc..5e2ef0b 100644
--- a/sound/pci/azt3328.c
+++ b/sound/pci/azt3328.c
@@ -2294,8 +2294,6 @@ snd_azf3328_free(struct snd_azf3328 *chip)
 	snd_azf3328_timer_stop(chip->timer);
 	snd_azf3328_gameport_free(chip);
 
-	if (chip->irq >= 0)
-		synchronize_irq(chip->irq);
 __end_hw:
 	if (chip->irq >= 0)
 		free_irq(chip->irq, chip);
-- 
2.1.4
