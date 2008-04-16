From: "Risto Suominen" <risto.suominen@gmail.com>
Subject: [PATCH 001a/003] snd-powermac: enable headphone
	detection
Date: Wed, 16 Apr 2008 10:01:12 +0300
Message-ID: <46e1c7760804160001u6702047bwc96124bf1a40b0f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by alsa0.perex.cz (Postfix) with ESMTP id E9E98103815
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Apr 2008 09:01:18 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so662104ana.80
	for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2008 00:01:13 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Risto Suominen <Risto.Suominen@gmail.com>

Enable port change interrupt while initialising AWACS, Screamer, and
Burgundy chipsets.

Signed-off-by: Risto Suominen <Risto.Suominen@gmail.com>
---
Kernel version 2.6.25-rc8 (probably any 2.6)

--- sound/ppc/pmac.c.orig	2008-04-05 17:45:08.000000000 +0300
+++ sound/ppc/pmac.c	2008-04-07 12:18:47.503077312 +0300
@@ -1300,9 +1304,9 @@ int __init snd_pmac_new(struct snd_card

 	snd_pmac_sound_feature(chip, 1);

-	/* reset */
-	if (chip->model == PMAC_AWACS)
-		out_le32(&chip->awacs->control, 0x11);
+	/* reset & enable interrupts */
+	if (chip->model <= PMAC_BURGUNDY)
+		out_le32(&chip->awacs->control, chip->control_mask);

 	/* Powerbooks have odd ways of enabling inputs such as
 	   an expansion-bay CD or sound from an internal modem
