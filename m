From: Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 2/2] fm801: Gracefully handle failure of tuner
	auto-detect
Date: Thu, 22 Sep 2011 14:39:52 +0100
Message-ID: <1316698792.4122.31.camel@deadeye>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
	[88.96.1.126]) by alsa0.perex.cz (Postfix) with ESMTP id D3DD924651
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Sep 2011 15:40:02 +0200 (CEST)
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
Cc: Hor Jiun Shyong <jiunshyong@gmail.com>, alsa-devel@alsa-project.org, Dan Carpenter <error27@gmail.com>, 641946@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

Commit 9676001559fce06e37c7dc230ab275f605556176
("ALSA: fm801: add error handling if auto-detect fails") seems to
break systems that were previously working without a tuner.

As a bonus, this should fix init and cleanup for the case where the
tuner is explicitly disabled.

Reported-and-tested-by: Hor Jiun Shyong <jiunshyong@gmail.com>
References: http://bugs.debian.org/641946
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: stable@kernel.org [v3.0+]
---
 sound/pci/fm801.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index 0dd8963..ecce948 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -68,6 +68,7 @@ MODULE_PARM_DESC(enable, "Enable FM801 soundcard.");
 module_param_array(tea575x_tuner, int, NULL, 0444);
 MODULE_PARM_DESC(tea575x_tuner, "TEA575x tuner access method (0 = auto, 1 = SF256-PCS, 2=SF256-PCP, 3=SF64-PCR, 8=disable, +16=tuner-only).");
 
+#define TUNER_DISABLED		(1<<3)
 #define TUNER_ONLY		(1<<4)
 #define TUNER_TYPE_MASK		(~TUNER_ONLY & 0xFFFF)
 
@@ -1150,7 +1151,8 @@ static int snd_fm801_free(struct fm801 *chip)
 
       __end_hw:
 #ifdef CONFIG_SND_FM801_TEA575X_BOOL
-	snd_tea575x_exit(&chip->tea);
+	if (!(chip->tea575x_tuner & TUNER_DISABLED))
+		snd_tea575x_exit(&chip->tea);
 #endif
 	if (chip->irq >= 0)
 		free_irq(chip->irq, chip);
@@ -1250,10 +1252,15 @@ static int __devinit snd_fm801_create(struct snd_card *card,
 		}
 		if (tea575x_tuner == 4) {
 			snd_printk(KERN_ERR "TEA575x radio not found\n");
-			return -ENODEV;
+			chip->tea575x_tuner = TUNER_DISABLED;
 		}
 	}
-	strlcpy(chip->tea.card, snd_fm801_tea575x_gpios[(tea575x_tuner & TUNER_TYPE_MASK) - 1].name, sizeof(chip->tea.card));
+	if (!(chip->tea575x_tuner & TUNER_DISABLED)) {
+		strlcpy(chip->tea.card,
+			snd_fm801_tea575x_gpios[(tea575x_tuner &
+						 TUNER_TYPE_MASK) - 1].name,
+			sizeof(chip->tea.card));
+	}
 #endif
 
 	*rchip = chip;
-- 
1.7.5.4
