From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/4] ALSA: fm801: explicitly free IRQ line
Date: Fri, 18 Dec 2015 21:14:10 +0200
Message-ID: <1450466053-52170-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id E1AB62605B4
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 20:14:18 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Otherwise we will have a warning on ->remove() since device is a PCI one.

WARNING: CPU: 4 PID: 1411 at /home/andy/prj/linux/fs/proc/generic.c:575 remove_proc_entry+0x137/0x160()
remove_proc_entry: removing non-empty directory 'irq/21', leaking at least 'snd_fm801'

Fixes: 5618955c4269 (ALSA: fm801: move to pcim_* and devm_* functions)
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
The patch series has been tested on SF64-PCR card.
 sound/pci/fm801.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index 1fdd92b6..f57847c 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -1165,6 +1165,8 @@ static int snd_fm801_free(struct fm801 *chip)
 	cmdw |= 0x00c3;
 	fm801_writew(chip, IRQ_MASK, cmdw);
 
+	devm_free_irq(&chip->pci->dev, chip->irq, chip);
+
       __end_hw:
 #ifdef CONFIG_SND_FM801_TEA575X_BOOL
 	if (!(chip->tea575x_tuner & TUNER_DISABLED)) {
-- 
2.6.4
