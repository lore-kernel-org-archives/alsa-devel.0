From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: hda - unlock on error in azx_interrupt()
Date: Fri, 18 May 2012 10:36:11 +0300
Message-ID: <20120518073611.GA4136@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcsinet15.oracle.com (rcsinet15.oracle.com [148.87.113.117])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D267103FDA
	for <alsa-devel@alsa-project.org>;
	Fri, 18 May 2012 09:36:25 +0200 (CEST)
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

There is an spin_unlock() missing on this error path.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This was added recently in a82d51ed2 "ALSA: hda - Support
VGA-switcheroo".  I don't have the hardware so I haven't tested it.

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index bbf953f..2b6392b 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1268,8 +1268,10 @@ static irqreturn_t azx_interrupt(int irq, void *dev_id)
 
 	spin_lock(&chip->reg_lock);
 
-	if (chip->disabled)
+	if (chip->disabled) {
+		spin_unlock(&chip->reg_lock);
 		return IRQ_NONE;
+	}
 
 	status = azx_readl(chip, INTSTS);
 	if (status == 0) {
