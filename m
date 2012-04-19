From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] sound/isa/sc6000.c: add missing
	sc6000_setup_board
Date: Thu, 19 Apr 2012 08:40:40 +0200
Message-ID: <1334817640-15426-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	by alsa0.perex.cz (Postfix) with ESMTP id A97371044B1
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Apr 2012 08:40:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

There seems to be no interaction between *port and the requested region, so
the clearing of *vport should take place if the request_region fails.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
Not tested.  sc6000_setup_board seems rather complicated, so my reasoning
could be completely wrong.

 sound/isa/sc6000.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/isa/sc6000.c b/sound/isa/sc6000.c
index d97d0f3..57679cb 100644
--- a/sound/isa/sc6000.c
+++ b/sound/isa/sc6000.c
@@ -594,7 +594,7 @@ static int __devinit snd_sc6000_probe(struct device *devptr, unsigned int dev)
 		snd_printk(KERN_ERR PFX
 			   "I/O port cannot be iomaped.\n");
 		err = -EBUSY;
-		goto err_unmap1;
+		goto err_unmap0;
 	}
 
 	/* to make it marked as used */
@@ -678,9 +678,10 @@ static int __devinit snd_sc6000_probe(struct device *devptr, unsigned int dev)
 	return 0;
 
 err_unmap2:
-	sc6000_setup_board(*vport, 0);
 	release_region(mss_port[dev], 4);
 err_unmap1:
+	sc6000_setup_board(*vport, 0);
+err_unmap0:
 	release_region(port[dev], 0x10);
 err_exit:
 	snd_card_free(card);
