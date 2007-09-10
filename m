From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] [ALSA] Fix CS4270 volume control and optimize
	I2C operations
Date: Mon, 10 Sep 2007 17:19:02 -0500
Message-ID: <11894627422900-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C9041038E6
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Sep 2007 00:19:09 +0200 (CEST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l8AMJ5RM004936
	for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2007 15:19:06 -0700 (MST)
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
Cc: Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

The volume control for the CS4270 ASoC driver was inverted - raising the
volume level with alsamixer would decrease the actual volume.

This patch also improves the performance of the I2C code (used to change
register settings) by only performing an I2C write if the new value is
different from the value that's in the register cache.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch applies to the 'mm' branch of perex/alsa.git.  I would like this
patch to be part of ALSA 1.0.15.

 sound/soc/codecs/cs4270.c |   21 +++++++++++++--------
 1 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 43d50a4..5d601ad 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -294,19 +294,24 @@ static unsigned int cs4270_read_reg_cache(struct snd_soc_codec *codec,
 static int cs4270_i2c_write(struct snd_soc_codec *codec, unsigned int reg,
 			    unsigned int value)
 {
+	u8 *cache = codec->reg_cache;
+
 	if ((reg < CS4270_FIRSTREG) || (reg > CS4270_LASTREG))
 		return -EIO;
 
-	if (i2c_smbus_write_byte_data(codec->control_data, reg, value) == 0) {
+	/* Only perform an I2C operation if the new value is different */
+	if (cache[reg - CS4270_FIRSTREG] != value) {
+		struct i2c_client *client = codec->control_data;
+		if (i2c_smbus_write_byte_data(client, reg, value)) {
+			printk(KERN_ERR "cs4270: I2C write failed\n");
+			return -EIO;
+		}
+
 		/* We've written to the hardware, so update the cache */
-		u8 *cache = codec->reg_cache;
 		cache[reg - CS4270_FIRSTREG] = value;
-		return 0;
-	} else {
-		printk(KERN_ERR "cs4270: I2C write of register %u failed\n",
-			reg);
-		return -EIO;
 	}
+
+	return 0;
 }
 
 /*
@@ -521,7 +526,7 @@ static int cs4270_i2c_detach(struct i2c_client *client)
 /* A list of non-DAPM controls that the CS4270 supports */
 static const struct snd_kcontrol_new cs4270_snd_controls[] = {
 	SOC_DOUBLE_R("Master Playback Volume",
-		CS4270_VOLA, CS4270_VOLB, 0, 0xFF, 0)
+		CS4270_VOLA, CS4270_VOLB, 0, 0xFF, 1)
 };
 
 static struct i2c_driver cs4270_i2c_driver = {
-- 
1.5.2.4
