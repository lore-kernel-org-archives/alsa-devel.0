From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: [PATCH resent] ALSA: emu10k1: Deletion of unnecessary checks
 before three function calls
Date: Mon, 03 Nov 2014 15:10:40 +0100
Message-ID: <54578CE0.1090201@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>	<alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>	<530A086E.8010901@users.sourceforge.net>	<alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>	<530A72AA.3000601@users.sourceforge.net>	<alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>	<530B5FB6.6010207@users.sourceforge.net>	<alpine.DEB.2.10.1402241710370.2074@hadrien>	<530C5E18.1020800@users.sourceforge.net>	<alpine.DEB.2.10.1402251014170.2080@hadrien>	<530CD2C4.4050903@users.sourceforge.net>	<alpine.DEB.2.10.1402251840450.7035@hadrien>	<530CF8FF.8080600@users.sourceforge.net>	<alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>	<530DD06F.4090703@users.sourceforge.net>	<alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>	<5317A59D.4@users.so
 urceforge.net>	<54567788.9060008@users.sourceforge.net> <s5ha94839dx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020403040306060201090104"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5ha94839dx.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, trivial@kernel.org, Coccinelle <cocci@systeme.lip6.fr>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020403040306060201090104
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

> Your patch can't be applied cleanly due to your MUA breaking the
> lines.  Please fix your MUA setup, or use an attachment if it's
> impossible, and resend the patch.

Thanks for your feedback.

Does this example show a conflict between long comments like
"snd_emu10k1_ctl_private_free( ... *kctl)" after patch ranges and line length
limitation for email eventually?


> Also, try to align the subject line with the relevant commits.  See
> "git log sound/pci/emu10k1"

I have attached my update suggestion with a slightly different commit title as
before. Is this variant acceptable?

Regards,
Markus

--------------020403040306060201090104
Content-Type: text/x-patch;
 name="0001-ALSA-emu10k1-Deletion-of-unnecessary-checks-before-t.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-emu10k1-Deletion-of-unnecessary-checks-before-t.pa";
 filename*1="tch"

>From 23bb7bd1325b7c9cc81761db3ebf3ea19f85338d Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 3 Nov 2014 14:54:36 +0100
Subject: [PATCH] ALSA: emu10k1: Deletion of unnecessary checks before three
 function calls

The functions kfree(), release_firmware() and snd_util_memhdr_free() test
whether their argument is NULL and then return immediately. Thus the test
around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/emu10k1/emu10k1_main.c | 9 +++------
 sound/pci/emu10k1/emufx.c        | 3 +--
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index 2292697..b4458a6 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -1289,10 +1289,8 @@ static int snd_emu10k1_free(struct snd_emu10k1 *emu)
 	}
 	if (emu->emu1010.firmware_thread)
 		kthread_stop(emu->emu1010.firmware_thread);
-	if (emu->firmware)
-		release_firmware(emu->firmware);
-	if (emu->dock_fw)
-		release_firmware(emu->dock_fw);
+	release_firmware(emu->firmware);
+	release_firmware(emu->dock_fw);
 	if (emu->irq >= 0)
 		free_irq(emu->irq, emu);
 	/* remove reserved page */
@@ -1301,8 +1299,7 @@ static int snd_emu10k1_free(struct snd_emu10k1 *emu)
 			(struct snd_util_memblk *)emu->reserved_page);
 		emu->reserved_page = NULL;
 	}
-	if (emu->memhdr)
-		snd_util_memhdr_free(emu->memhdr);
+	snd_util_memhdr_free(emu->memhdr);
 	if (emu->silent_page.area)
 		snd_dma_free_pages(&emu->silent_page);
 	if (emu->ptb_pages.area)
diff --git a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
index 745f062..eb5c0ab 100644
--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -777,8 +777,7 @@ static void snd_emu10k1_ctl_private_free(struct snd_kcontrol *kctl)
 	kctl->private_value = 0;
 	list_del(&ctl->list);
 	kfree(ctl);
-	if (kctl->tlv.p)
-		kfree(kctl->tlv.p);
+	kfree(kctl->tlv.p);
 }
 
 static int snd_emu10k1_add_controls(struct snd_emu10k1 *emu,
-- 
2.1.3


--------------020403040306060201090104--
