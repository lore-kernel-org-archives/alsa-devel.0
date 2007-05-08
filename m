From: Dmitry Torokhov <dtor@insightbb.com>
Subject: [PATCH] ppc-beep - switch to using
	input_dev->dev.parent
Date: Tue, 8 May 2007 00:22:23 -0400
Message-ID: <200705080022.23538.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from asav11.insightbb.com (gateway.insightbb.com [74.128.0.19])
	by alsa0.perex.cz (Postfix) with ESMTP id 57E5624337
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2007 06:53:55 +0200 (CEST)
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
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

In preparation for struct class_device -> struct device input
core conversion, switch to using input_dev->dev.parent when
specifying device position in sysfs tree.

Also, do not access input_dev->private directly, use helpers.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 sound/ppc/beep.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

Index: work/sound/ppc/beep.c
===================================================================
--- work.orig/sound/ppc/beep.c
+++ work/sound/ppc/beep.c
@@ -118,7 +118,7 @@ static int snd_pmac_beep_event(struct in
 	default: return -1;
 	}
 
-	chip = dev->private;
+	chip = input_get_drvdata(dev);
 	if (! chip || (beep = chip->beep) == NULL)
 		return -1;
 
@@ -239,8 +239,8 @@ int __init snd_pmac_attach_beep(struct s
 	input_dev->evbit[0] = BIT(EV_SND);
 	input_dev->sndbit[0] = BIT(SND_BELL) | BIT(SND_TONE);
 	input_dev->event = snd_pmac_beep_event;
-	input_dev->private = chip;
-	input_dev->cdev.dev = &chip->pdev->dev;
+	input_dev->dev.parent = &chip->pdev->dev;
+	input_set_drvdata(input_dev, chip);
 
 	beep->dev = input_dev;
 	beep->buf = dmabuf;
@@ -251,8 +251,8 @@ int __init snd_pmac_attach_beep(struct s
 	err = snd_ctl_add(chip->card, beep_ctl);
 	if (err < 0)
 		goto fail1;
- 
- 	chip->beep = beep;
+
+	chip->beep = beep;
 
 	err = input_register_device(beep->dev);
 	if (err)
