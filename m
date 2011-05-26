From: Dan Carpenter <error27@gmail.com>
Subject: [patch] ALSA: fm801: add error handling if auto-detect
	fails
Date: Thu, 26 May 2011 11:47:35 +0300
Message-ID: <20110526084735.GC14591@shale.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id BB2D8243BD
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 10:48:03 +0200 (CEST)
Received: by bwz10 with SMTP id 10so255634bwz.38
	for <alsa-devel@alsa-project.org>; Thu, 26 May 2011 01:48:03 -0700 (PDT)
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
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org, Ondrej Zary <linux@rainbow-software.org>
List-Id: alsa-devel@alsa-project.org

In the original code if auto detect failed and tea575x_tuner == 4
then we copy bogus information to chip->tea.card.  I've changed the
autodetect code to cleanup and return -ENODEV on error instead.

I made the previous chunk return on error as well.  Potentially the
hardware should limp along without the radio?  I don't know this
hardware well enough to say.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
Compile tested only.

diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index eacd490..a7ec703 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -1234,9 +1234,12 @@ static int __devinit snd_fm801_create(struct snd_card *card,
 	sprintf(chip->tea.bus_info, "PCI:%s", pci_name(pci));
 	if ((tea575x_tuner & TUNER_TYPE_MASK) > 0 &&
 	    (tea575x_tuner & TUNER_TYPE_MASK) < 4) {
-		if (snd_tea575x_init(&chip->tea))
+		if (snd_tea575x_init(&chip->tea)) {
 			snd_printk(KERN_ERR "TEA575x radio not found\n");
-	} else if ((tea575x_tuner & TUNER_TYPE_MASK) == 0)
+			snd_fm801_free(chip);
+			return -ENODEV;
+		}
+	} else if ((tea575x_tuner & TUNER_TYPE_MASK) == 0) {
 		/* autodetect tuner connection */
 		for (tea575x_tuner = 1; tea575x_tuner <= 3; tea575x_tuner++) {
 			chip->tea575x_tuner = tea575x_tuner;
@@ -1246,6 +1249,12 @@ static int __devinit snd_fm801_create(struct snd_card *card,
 				break;
 			}
 		}
+		if (tea575x_tuner == 4) {
+			snd_printk(KERN_ERR "TEA575x radio not found\n");
+			snd_fm801_free(chip);
+			return -ENODEV;
+		}
+	}
 	strlcpy(chip->tea.card, snd_fm801_tea575x_gpios[(tea575x_tuner & TUNER_TYPE_MASK) - 1].name, sizeof(chip->tea.card));
 #endif
 
