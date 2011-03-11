From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] intel8x0m: append 'm' to "r_intel8x0"
Date: Fri, 11 Mar 2011 11:41:06 +0100
Message-ID: <1299840066.12153.11.camel@t41.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Appending an 'm' will distinguish it from a similar struct in intel8x0.c

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
 sound/pci/intel8x0m.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/intel8x0m.c b/sound/pci/intel8x0m.c
index e16b3e9..ae31655 100644
--- a/sound/pci/intel8x0m.c
+++ b/sound/pci/intel8x0m.c
@@ -1108,7 +1108,7 @@ struct ich_reg_info {
 static int __devinit snd_intel8x0m_create(struct snd_card *card,
 					 struct pci_dev *pci,
 					 unsigned long device_type,
-					 struct intel8x0m ** r_intel8x0)
+					 struct intel8x0m **r_intel8x0m)
 {
 	struct intel8x0m *chip;
 	int err;
@@ -1124,7 +1124,7 @@ static int __devinit snd_intel8x0m_create(struct snd_card *card,
 	};
 	struct ich_reg_info *tbl;
 
-	*r_intel8x0 = NULL;
+	*r_intel8x0m = NULL;
 
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
@@ -1237,7 +1237,7 @@ static int __devinit snd_intel8x0m_create(struct snd_card *card,
 
 	snd_card_set_dev(card, &pci->dev);
 
-	*r_intel8x0 = chip;
+	*r_intel8x0m = chip;
 	return 0;
 }
 
-- 
1.7.4.1
