From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 2/2] fm801: introduce __is_ready()/__is_valid()
	helpers
Date: Mon, 28 Apr 2014 11:00:30 +0300
Message-ID: <1398672030-29565-2-git-send-email-andy.shevchenko@gmail.com>
References: <1398672030-29565-1-git-send-email-andy.shevchenko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gw01.mail.saunalahti.fi (gw01.mail.saunalahti.fi
 [195.197.172.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 9937E2608ED
 for <alsa-devel@alsa-project.org>; Mon, 28 Apr 2014 10:00:15 +0200 (CEST)
In-Reply-To: <1398672030-29565-1-git-send-email-andy.shevchenko@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: alsa-devel@alsa-project.org

The introduced functios check AC97 if it's ready for communication and
read data is valid.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 sound/pci/fm801.c | 86 +++++++++++++++++++++++++++----------------------------
 1 file changed, 42 insertions(+), 44 deletions(-)

diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index 8418484..4417409 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -224,6 +224,30 @@ MODULE_DEVICE_TABLE(pci, snd_fm801_ids);
  *  common I/O routines
  */
 
+static inline bool __is_ready(struct fm801 *chip, unsigned int iterations)
+{
+	unsigned int idx;
+
+	for (idx = 0; idx < iterations; idx++) {
+		if (!(fm801_readw(chip, AC97_CMD) & FM801_AC97_BUSY))
+			return true;
+		udelay(10);
+	}
+	return false;
+}
+
+static inline bool __is_valid(struct fm801 *chip, unsigned int iterations)
+{
+	unsigned int idx;
+
+	for (idx = 0; idx < iterations; idx++) {
+		if (!(fm801_readw(chip, AC97_CMD) & FM801_AC97_VALID))
+			return true;
+		udelay(10);
+	}
+	return false;
+}
+
 static int snd_fm801_update_bits(struct fm801 *chip, unsigned short reg,
 				 unsigned short mask, unsigned short value)
 {
@@ -246,32 +270,19 @@ static void snd_fm801_codec_write(struct snd_ac97 *ac97,
 				  unsigned short val)
 {
 	struct fm801 *chip = ac97->private_data;
-	int idx;
 
-	/*
-	 *  Wait until the codec interface is not ready..
-	 */
-	for (idx = 0; idx < 100; idx++) {
-		if (!(fm801_readw(chip, AC97_CMD) & FM801_AC97_BUSY))
-			goto ok1;
-		udelay(10);
+	if (!__is_ready(chip, 100)) {
+		dev_err(chip->card->dev, "AC'97 interface is busy (1)\n");
+		return;
 	}
-	dev_err(chip->card->dev, "AC'97 interface is busy (1)\n");
-	return;
 
- ok1:
 	/* write data and address */
 	fm801_writew(val, chip, AC97_DATA);
 	fm801_writew(reg | (ac97->addr << FM801_AC97_ADDR_SHIFT), chip, AC97_CMD);
-	/*
-	 *  Wait until the write command is not completed..
-         */
-	for (idx = 0; idx < 1000; idx++) {
-		if (!(fm801_readw(chip, AC97_CMD) & FM801_AC97_BUSY))
-			return;
-		udelay(10);
-	}
-	dev_err(chip->card->dev, "AC'97 interface #%d is busy (2)\n", ac97->num);
+
+	if (!__is_ready(chip, 1000))
+		dev_err(chip->card->dev, "AC'97 interface #%d is busy (2)\n",
+		ac97->num);
 }
 
 static unsigned short snd_fm801_codec_read(struct snd_ac97 *ac97, unsigned short reg)
@@ -279,39 +290,26 @@ static unsigned short snd_fm801_codec_read(struct snd_ac97 *ac97, unsigned short
 	struct fm801 *chip = ac97->private_data;
 	int idx;
 
-	/*
-	 *  Wait until the codec interface is not ready..
-	 */
-	for (idx = 0; idx < 100; idx++) {
-		if (!(fm801_readw(chip, AC97_CMD) & FM801_AC97_BUSY))
-			goto ok1;
-		udelay(10);
+	if (!__is_ready(chip, 100)) {
+		dev_err(chip->card->dev, "AC'97 interface is busy (1)\n");
+		return 0;
 	}
-	dev_err(chip->card->dev, "AC'97 interface is busy (1)\n");
-	return 0;
 
- ok1:
 	/* read command */
 	fm801_writew(reg | (ac97->addr << FM801_AC97_ADDR_SHIFT) |
 		     FM801_AC97_READ, chip, AC97_CMD);
-	for (idx = 0; idx < 100; idx++) {
-		if (!(fm801_readw(chip, AC97_CMD) & FM801_AC97_BUSY))
-			goto ok2;
-		udelay(10);
+	if (!__is_ready(chip, 100)) {
+		dev_err(chip->card->dev, "AC'97 interface #%d is busy (2)\n",
+			ac97->num);
+		return 0;
 	}
-	dev_err(chip->card->dev, "AC'97 interface #%d is busy (2)\n", ac97->num);
-	return 0;
 
- ok2:
-	for (idx = 0; idx < 1000; idx++) {
-		if (fm801_readw(chip, AC97_CMD) & FM801_AC97_VALID)
-			goto ok3;
-		udelay(10);
+	if (!__is_valid(chip, 1000)) {
+		dev_err(chip->card->dev,
+			"AC'97 interface #%d is not valid (2)\n", ac97->num);
+		return 0;
 	}
-	dev_err(chip->card->dev, "AC'97 interface #%d is not valid (2)\n", ac97->num);
-	return 0;
 
- ok3:
 	return fm801_readw(chip, AC97_DATA);
 }
 
-- 
1.8.3.101.g727a46b
