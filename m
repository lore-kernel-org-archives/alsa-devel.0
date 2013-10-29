From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 08/10] ALSA: ak4114: Fix wrong register array
	size
Date: Tue, 29 Oct 2013 17:00:31 +0100
Message-ID: <1383062433-9388-9-git-send-email-tiwai@suse.de>
References: <1383062433-9388-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 091EC2616EF
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 16:57:49 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A5D05A60D0
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 16:57:48 +0100 (CET)
In-Reply-To: <1383062433-9388-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The size of the register cache array is actually 6 instead of 7,
as it caches up to AK4114_REG_INT1_MASK.  This resulted in unexpected
access out of array range, although most of them aren't so serious
(just reading one more byte on the stack at snd_ak4114_create()).

Also, the check of cache size was wrongly done by checking with
sizeof() instead of ARRAY_SIZE().  Fixed this together.

(And yes, hardcoded numbers are bad, but I keep the coding style as is
 for making it clear what this patch actually does.)

Spotted by coverity among several CIDs, e.g. 711621.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/ak4114.h   | 4 ++--
 sound/i2c/other/ak4114.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/sound/ak4114.h b/include/sound/ak4114.h
index 3ce69fd92523..52f02a60dba7 100644
--- a/include/sound/ak4114.h
+++ b/include/sound/ak4114.h
@@ -170,7 +170,7 @@ struct ak4114 {
 	void * private_data;
 	unsigned int init: 1;
 	spinlock_t lock;
-	unsigned char regmap[7];
+	unsigned char regmap[6];
 	unsigned char txcsb[5];
 	struct snd_kcontrol *kctls[AK4114_CONTROLS];
 	struct snd_pcm_substream *playback_substream;
@@ -189,7 +189,7 @@ struct ak4114 {
 
 int snd_ak4114_create(struct snd_card *card,
 		      ak4114_read_t *read, ak4114_write_t *write,
-		      const unsigned char pgm[7], const unsigned char txcsb[5],
+		      const unsigned char pgm[6], const unsigned char txcsb[5],
 		      void *private_data, struct ak4114 **r_ak4114);
 void snd_ak4114_reg_write(struct ak4114 *ak4114, unsigned char reg, unsigned char mask, unsigned char val);
 void snd_ak4114_reinit(struct ak4114 *ak4114);
diff --git a/sound/i2c/other/ak4114.c b/sound/i2c/other/ak4114.c
index 5bf4fca19e48..15ae0250eace 100644
--- a/sound/i2c/other/ak4114.c
+++ b/sound/i2c/other/ak4114.c
@@ -60,7 +60,7 @@ static void reg_dump(struct ak4114 *ak4114)
 
 	printk(KERN_DEBUG "AK4114 REG DUMP:\n");
 	for (i = 0; i < 0x20; i++)
-		printk(KERN_DEBUG "reg[%02x] = %02x (%02x)\n", i, reg_read(ak4114, i), i < sizeof(ak4114->regmap) ? ak4114->regmap[i] : 0);
+		printk(KERN_DEBUG "reg[%02x] = %02x (%02x)\n", i, reg_read(ak4114, i), i < ARRAY_SIZE(ak4114->regmap) ? ak4114->regmap[i] : 0);
 }
 #endif
 
@@ -81,7 +81,7 @@ static int snd_ak4114_dev_free(struct snd_device *device)
 
 int snd_ak4114_create(struct snd_card *card,
 		      ak4114_read_t *read, ak4114_write_t *write,
-		      const unsigned char pgm[7], const unsigned char txcsb[5],
+		      const unsigned char pgm[6], const unsigned char txcsb[5],
 		      void *private_data, struct ak4114 **r_ak4114)
 {
 	struct ak4114 *chip;
@@ -101,7 +101,7 @@ int snd_ak4114_create(struct snd_card *card,
 	chip->private_data = private_data;
 	INIT_DELAYED_WORK(&chip->work, ak4114_stats);
 
-	for (reg = 0; reg < 7; reg++)
+	for (reg = 0; reg < 6; reg++)
 		chip->regmap[reg] = pgm[reg];
 	for (reg = 0; reg < 5; reg++)
 		chip->txcsb[reg] = txcsb[reg];
@@ -142,7 +142,7 @@ static void ak4114_init_regs(struct ak4114 *chip)
 	/* release reset, but leave powerdown */
 	reg_write(chip, AK4114_REG_PWRDN, (old | AK4114_RST) & ~AK4114_PWN);
 	udelay(200);
-	for (reg = 1; reg < 7; reg++)
+	for (reg = 1; reg < 6; reg++)
 		reg_write(chip, reg, chip->regmap[reg]);
 	for (reg = 0; reg < 5; reg++)
 		reg_write(chip, reg + AK4114_REG_TXCSB0, chip->txcsb[reg]);
-- 
1.8.4.1
