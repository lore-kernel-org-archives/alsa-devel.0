From: Ondrej Zary <linux@rainbow-software.org>
Subject: [RFC PATCH 2/3] tea575x-tuner: remove dev_nr
Date: Sat, 19 Mar 2011 16:33:01 +0100
Message-ID: <201103191633.06935.linux@rainbow-software.org>
References: <201103121919.05657.linux@rainbow-software.org>
	<201103141128.01259.linux@rainbow-software.org>
	<33b29bfb135fbe2ddcba88d342d67526.squirrel@webmail.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail1-out1.atlantis.sk [80.94.52.55])
	by alsa0.perex.cz (Postfix) with ESMTP id 447E31037EA
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2011 16:33:14 +0100 (CET)
In-Reply-To: <33b29bfb135fbe2ddcba88d342d67526.squirrel@webmail.xs4all.nl>
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
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-media@vger.kernel.org, jirislaby@gmail.com, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Remove unused dev_nr from struct tea575x_tuner.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

--- linux-2.6.38-rc4-/include/sound/tea575x-tuner.h	2011-03-19 16:00:53.000000000 +0100
+++ linux-2.6.38-rc4/include/sound/tea575x-tuner.h	2011-03-19 16:01:12.000000000 +0100
@@ -37,7 +37,6 @@ struct snd_tea575x_ops {
 struct snd_tea575x {
 	struct snd_card *card;
 	struct video_device *vd;	/* video device */
-	int dev_nr;			/* requested device number + 1 */
 	bool tea5759;			/* 5759 chip is present */
 	bool mute;			/* Device is muted? */
 	bool stereo;			/* receiving stereo */
--- linux-2.6.38-rc4-/sound/pci/fm801.c	2011-02-08 01:03:55.000000000 +0100
+++ linux-2.6.38-rc4/sound/pci/fm801.c	2011-03-19 16:02:33.000000000 +0100
@@ -1453,7 +1453,6 @@ static int __devinit snd_fm801_create(st
 #ifdef TEA575X_RADIO
 	if ((tea575x_tuner & TUNER_TYPE_MASK) > 0 &&
 	    (tea575x_tuner & TUNER_TYPE_MASK) < 4) {
-		chip->tea.dev_nr = tea575x_tuner >> 16;
 		chip->tea.card = card;
 		chip->tea.freq_fixup = 10700;
 		chip->tea.private_data = chip;


-- 
Ondrej Zary
