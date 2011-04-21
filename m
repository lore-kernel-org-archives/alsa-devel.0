From: Risto Suominen <risto.suominen@gmail.com>
Subject: [PATCH - powermac] Correct lineout detection on
	PowerMac G4 DA
Date: Thu, 21 Apr 2011 21:54:09 +0300
Message-ID: <BANLkTimjCyXougzL1gT+=QoSC2tzMYw+5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 4304A244B3
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Apr 2011 20:54:14 +0200 (CEST)
Received: by bwz10 with SMTP id 10so53764bwz.38
	for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2011 11:54:11 -0700 (PDT)
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Risto Suominen <Risto.Suominen@gmail.com>

Correct lineout (Pro Speaker) detection on PowerMac G4 Digital Audio (Tumbler).

Signed-off-by: Risto Suominen <Risto.Suominen@gmail.com>
---
Kernel version 2.6.32 (probably any 2.6), ALSA 1.0.23.

The patch is available here: too:
http://ristosu.wippiespace.com/pub/alsa-tumbler-1.0.23-p1.diff

--- a/alsa-kernel/ppc/tumbler.c.org	2010-04-16 14:10:10.000000000 +0300
+++ b/alsa-kernel/ppc/tumbler.c	2011-04-15 20:50:30.000000000 +0300
@@ -1000,7 +1000,7 @@ static void device_change_handler(struct
 				   chip->lineout_sw_ctl);
 		if (mix->anded_reset)
 			msleep(10);
-		check_mute(chip, &mix->amp_mute, 1, mix->auto_mute_notify,
+		check_mute(chip, &mix->amp_mute, !IS_G4DA, mix->auto_mute_notify,
 			   chip->speaker_sw_ctl);
 	} else {
 		/* unmute speaker, mute others */
