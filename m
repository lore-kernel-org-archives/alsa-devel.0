From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH] snd-ice1712: enable suspend on unknown ICE1724
	cards
Date: Sun, 11 Nov 2012 22:10:13 +0100
Message-ID: <201211112210.13837.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail-1.atlantis.sk [80.94.52.57])
 by alsa0.perex.cz (Postfix) with ESMTP id 267D4261723
 for <alsa-devel@alsa-project.org>; Sun, 11 Nov 2012 22:10:36 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Assume that unknown ICE1724-based cards are AC97-only that can suspend
without any additional card-specific code.

This fixes suspend on Gainward Hollywood@Home 7.1.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 sound/pci/ice1712/ice1724.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index 5cc3fa5..aebd584 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -2363,6 +2363,8 @@ static int __devinit snd_vt1724_read_eeprom(struct snd_ice1712 *ice,
 	}
 	printk(KERN_WARNING "ice1724: No matching model found for ID 0x%x\n",
 	       ice->eeprom.subvendor);
+	/* assume AC97-only card which can suspend without additional code */
+	ice->pm_suspend_enabled = 1;
 
  found:
 	ice->eeprom.size = snd_vt1724_read_i2c(ice, dev, 0x04);
-- 
Ondrej Zary
