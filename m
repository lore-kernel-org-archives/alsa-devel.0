From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 13/13] ALSA: msnd: Fix centralized exiting from
	snd_msnd_attach()
Date: Sun, 04 Jan 2015 14:41:39 +0100
Message-ID: <54A94313.1070207@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <54A9355F.4050102@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 231362605E7
 for <alsa-devel@alsa-project.org>; Sun,  4 Jan 2015 14:41:44 +0100 (CET)
In-Reply-To: <54A9355F.4050102@users.sourceforge.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Julia Lawall <julia.lawall@lip6.fr>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 4 Jan 2015 11:47:17 +0100

Two return statements were used by the snd_msnd_attach() function at source
code places where the Linux coding style recommends an alternative approach.

Let us improve the affected implementation details with adjustments for
corresponding jump targets.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/isa/msnd/msnd_pinnacle.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/sound/isa/msnd/msnd_pinnacle.c b/sound/isa/msnd/msnd_pinnacle.c
index e2e940d..0e66e5e 100644
--- a/sound/isa/msnd/msnd_pinnacle.c
+++ b/sound/isa/msnd/msnd_pinnacle.c
@@ -552,17 +552,16 @@ static int snd_msnd_attach(struct snd_card *card)
 		return err;
 	}
 	if (request_region(chip->io, DSP_NUMIO, card->shortname) == NULL) {
-		free_irq(chip->irq, chip);
-		return -EBUSY;
+		err = -EBUSY;
+		goto free_an_irq;
 	}
 
 	if (!request_mem_region(chip->base, BUFFSIZE, card->shortname)) {
 		printk(KERN_ERR LOGNAME
 			": unable to grab memory region 0x%lx-0x%lx\n",
 			chip->base, chip->base + BUFFSIZE - 1);
-		release_region(chip->io, DSP_NUMIO);
-		free_irq(chip->irq, chip);
-		return -EBUSY;
+		err = -EBUSY;
+		goto release_resource_region;
 	}
 	chip->mappedbase = ioremap_nocache(chip->base, 0x8000);
 	if (!chip->mappedbase) {
@@ -570,7 +569,7 @@ static int snd_msnd_attach(struct snd_card *card)
 			": unable to map memory region 0x%lx-0x%lx\n",
 			chip->base, chip->base + BUFFSIZE - 1);
 		err = -EIO;
-		goto err_release_region;
+		goto release_memory_region;
 	}
 
 	err = snd_msnd_dsp_full_reset(card);
@@ -628,9 +627,11 @@ static int snd_msnd_attach(struct snd_card *card)
 
 io_unmap:
 	iounmap(chip->mappedbase);
-err_release_region:
+release_memory_region:
 	release_mem_region(chip->base, BUFFSIZE);
+release_resource_region:
 	release_region(chip->io, DSP_NUMIO);
+free_an_irq:
 	free_irq(chip->irq, chip);
 	return err;
 }
-- 
2.2.1
