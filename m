From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCHv2 2/2] fm801: introduce
	fm801_ac97_is_ready()/fm801_ac97_is_valid() helpers
Date: Tue, 29 Apr 2014 10:56:04 +0300
Message-ID: <1398758165-15671-3-git-send-email-andy.shevchenko@gmail.com>
References: <1398758165-15671-1-git-send-email-andy.shevchenko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gw03.mail.saunalahti.fi (gw03.mail.saunalahti.fi
 [195.197.172.111])
 by alsa0.perex.cz (Postfix) with ESMTP id F30A02625FD
 for <alsa-devel@alsa-project.org>; Tue, 29 Apr 2014 09:55:51 +0200 (CEST)
In-Reply-To: <1398758165-15671-1-git-send-email-andy.shevchenko@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: alsa-devel@alsa-project.org

The introduced functios check AC97 if it's ready for communication and
read data is valid.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 sound/pci/fm801.c | 79 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 42 insertions(+), 37 deletions(-)

diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index 5be910c..e8910d0 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -224,6 +224,30 @@ MODULE_DEVICE_TABLE(pci, snd_fm801_ids);
  *  common I/O routines
  */
 
+static bool fm801_ac97_is_ready(struct fm801 *chip, unsigned int iterations)
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
+static bool fm801_ac97_is_valid(struct fm801 *chip, unsigned int iterations)
+{
+	unsigned int idx;
+
+	for (idx = 0; idx < iterations; idx++) {
+		if (fm801_readw(chip, AC97_CMD) & FM801_AC97_VALID)
+			return true;
+		udelay(10);
+	}
+	return false;
+}
+
 static int snd_fm801_update_bits(struct fm801 *chip, unsigned short reg,
 				 unsigned short mask, unsigned short value)
 {
@@ -246,72 +270,53 @@ static void snd_fm801_codec_write(struct snd_ac97 *ac97,
 				  unsigned short val)
 {
 	struct fm801 *chip = ac97->private_data;
-	int idx;
 
 	/*
 	 *  Wait until the codec interface is not ready..
 	 */
-	for (idx = 0; idx < 100; idx++) {
-		if (!(fm801_readw(chip, AC97_CMD) & FM801_AC97_BUSY))
-			goto ok1;
-		udelay(10);
+	if (!fm801_ac97_is_ready(chip, 100)) {
+		dev_err(chip->card->dev, "AC'97 interface is busy (1)\n");
+		return;
 	}
-	dev_err(chip->card->dev, "AC'97 interface is busy (1)\n");
-	return;
 
- ok1:
 	/* write data and address */
 	fm801_writew(chip, AC97_DATA, val);
 	fm801_writew(chip, AC97_CMD, reg | (ac97->addr << FM801_AC97_ADDR_SHIFT));
 	/*
 	 *  Wait until the write command is not completed..
-         */
-	for (idx = 0; idx < 1000; idx++) {
-		if (!(fm801_readw(chip, AC97_CMD) & FM801_AC97_BUSY))
-			return;
-		udelay(10);
-	}
-	dev_err(chip->card->dev, "AC'97 interface #%d is busy (2)\n", ac97->num);
+	 */
+	if (!fm801_ac97_is_ready(chip, 1000))
+		dev_err(chip->card->dev, "AC'97 interface #%d is busy (2)\n",
+		ac97->num);
 }
 
 static unsigned short snd_fm801_codec_read(struct snd_ac97 *ac97, unsigned short reg)
 {
 	struct fm801 *chip = ac97->private_data;
-	int idx;
 
 	/*
 	 *  Wait until the codec interface is not ready..
 	 */
-	for (idx = 0; idx < 100; idx++) {
-		if (!(fm801_readw(chip, AC97_CMD) & FM801_AC97_BUSY))
-			goto ok1;
-		udelay(10);
+	if (!fm801_ac97_is_ready(chip, 100)) {
+		dev_err(chip->card->dev, "AC'97 interface is busy (1)\n");
+		return 0;
 	}
-	dev_err(chip->card->dev, "AC'97 interface is busy (1)\n");
-	return 0;
 
- ok1:
 	/* read command */
 	fm801_writew(chip, AC97_CMD,
 		     reg | (ac97->addr << FM801_AC97_ADDR_SHIFT) | FM801_AC97_READ);
-	for (idx = 0; idx < 100; idx++) {
-		if (!(fm801_readw(chip, AC97_CMD) & FM801_AC97_BUSY))
-			goto ok2;
-		udelay(10);
+	if (!fm801_ac97_is_ready(chip, 100)) {
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
+	if (!fm801_ac97_is_valid(chip, 1000)) {
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
