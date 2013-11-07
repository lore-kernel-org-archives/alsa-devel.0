From: Joe Perches <joe@perches.com>
Subject: [RFC PATCH] hda_intel: ratelimit "spurious response"
	message
Date: Thu, 07 Nov 2013 11:55:15 -0800
Message-ID: <1383854115.9263.21.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.hostedemail.com (smtprelay0170.hostedemail.com
 [216.40.44.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 9506E2602AD
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2013 20:55:11 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

dmesg here has a 100+ consecutive lines of:

[ 1464.219446] hda-intel 0000:00:14.2: spurious response 0x0:0x0, last cmd=0x170500
[ 1464.219451] hda-intel 0000:00:14.2: spurious response 0x0:0x0, last cmd=0x170500
[ 1464.219454] hda-intel 0000:00:14.2: spurious response 0x0:0x0, last cmd=0x170500
...

Ratelimit the message to reduce the dmesg log noise.

Coalesce the format while at it.

Signed-off-by: Joe Perches <joe@perches.com>
---
 sound/pci/hda/hda_intel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 6e61a01..6e444ca 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -906,12 +906,12 @@ static void azx_update_rirb(struct azx *chip)
 			chip->rirb.res[addr] = res;
 			smp_wmb();
 			chip->rirb.cmds[addr]--;
-		} else
-			snd_printk(KERN_ERR SFX "%s: spurious response %#x:%#x, "
-				   "last cmd=%#08x\n",
+		} else if (printk_ratelimit()) {
+			snd_printk(KERN_ERR SFX "%s: spurious response %#x:%#x, last cmd=%#08x\n",
 				   pci_name(chip->pci),
 				   res, res_ex,
 				   chip->last_cmd[addr]);
+		}
 	}
 }
 
