From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH] hda: warn on spurious response
Date: Sat, 1 Aug 2009 19:18:45 +0800
Message-ID: <20090801111845.GB7323@localhost>
References: <20090801104516.GA3741@localhost> <20090801111714.GA7323@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 592DF2494D
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Aug 2009 13:19:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090801111714.GA7323@localhost>
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
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <jkysela@redhat.com>
List-Id: alsa-devel@alsa-project.org

To help disclose hardware bugs.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/hda_intel.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- sound-2.6.orig/sound/pci/hda/hda_intel.c
+++ sound-2.6/sound/pci/hda/hda_intel.c
@@ -639,7 +639,11 @@ static void azx_update_rirb(struct azx *
 			chip->rirb.res[addr] = res;
 			smp_wmb();
 			chip->rirb.cmds[addr]--;
-		}
+		} else
+			snd_printk(KERN_ERR SFX "spurious response %#x:%#x, "
+				   "last cmd=%#08x\n",
+				   res, res_ex,
+				   chip->last_cmd[addr]);
 	}
 }
