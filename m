From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] opti-miro: remove snd_card pointer from
	snd_miro structure
Date: Sat, 21 Nov 2009 01:01:18 +0100
Message-ID: <20091121010118.a3646fcc.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9153641975930438852=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240]) by alsa0.perex.cz (Postfix) with ESMTP id 460C124133
	for <alsa-devel@alsa-project.org>; Sat, 21 Nov 2009 00:59:54 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

--===============9153641975930438852==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Remove the snd_card pointer from the snd_miro structure and
do some small code improvements.

Also, move Opti chipset detection before detection of the
ACI mixer, so the mci_base value is set in one place only.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 sound/isa/opti9xx/miro.c |   55 ++++++++++++++++++++--------------------------
 1 files changed, 24 insertions(+), 31 deletions(-)

diff --git a/sound/isa/opti9xx/miro.c b/sound/isa/opti9xx/miro.c
index b8170ad..db4a4fb 100644
--- a/sound/isa/opti9xx/miro.c
+++ b/sound/isa/opti9xx/miro.c
@@ -110,7 +110,6 @@ struct snd_miro {
 	unsigned long pwd_reg;
 
 	spinlock_t lock;
-	struct snd_card *card;
 	struct snd_pcm *pcm;
 
 	long wss_base;
@@ -132,8 +131,6 @@ struct snd_miro {
 	struct mutex aci_mutex;
 };
 
-static void snd_miro_proc_init(struct snd_miro * miro);
-
 static char * snd_opti9xx_names[] = {
 	"unkown",
 	"82C928", "82C929",
@@ -457,11 +454,9 @@ static int snd_miro_put_double(struct snd_kcontrol *kcontrol,
 	right = ucontrol->value.integer.value[1];
 
 	setreg_right = (kcontrol->private_value >> 8) & 0xff;
-	if (setreg_right == ACI_SET_MASTER) {
-		setreg_left = setreg_right + 1;
-	} else {
-		setreg_left = setreg_right + 8;
-	}
+	setreg_left = setreg_right + 8;
+	if (setreg_right == ACI_SET_MASTER)
+		setreg_left -= 7;
 
 	getreg_right = kcontrol->private_value & 0xff;
 	getreg_left = getreg_right + 1;
@@ -667,17 +662,15 @@ static int __devinit snd_set_aci_init_values(struct snd_miro *miro)
 	return 0;
 }
 
-static int __devinit snd_miro_mixer(struct snd_miro *miro)
+static int __devinit snd_miro_mixer(struct snd_card *card,
+				    struct snd_miro *miro)
 {
-	struct snd_card *card;
 	unsigned int idx;
 	int err;
 
-	if (snd_BUG_ON(!miro || !miro->card))
+	if (snd_BUG_ON(!miro || !card))
 		return -EINVAL;
 
-	card = miro->card;
-
 	switch (miro->hardware) {
 	case OPTi9XX_HW_82C924:
 		strcpy(card->mixername, "ACI & OPTi924");
@@ -950,11 +943,12 @@ static void snd_miro_proc_read(struct snd_info_entry * entry,
 	snd_iprintf(buffer, "  preamp  : 0x%x\n", miro->aci_preamp);
 }
 
-static void __devinit snd_miro_proc_init(struct snd_miro * miro)
+static void __devinit snd_miro_proc_init(struct snd_card *card,
+					 struct snd_miro *miro)
 {
 	struct snd_info_entry *entry;
 
-	if (! snd_card_proc_new(miro->card, "miro", &entry))
+	if (!snd_card_proc_new(card, "miro", &entry))
 		snd_info_set_text_ops(entry, miro, snd_miro_proc_read);
 }
 
@@ -971,20 +965,18 @@ static int __devinit snd_miro_configure(struct snd_miro *chip)
 	unsigned char mpu_irq_bits;
 	unsigned long flags;
 
+	snd_miro_write_mask(chip, OPTi9XX_MC_REG(1), 0x80, 0x80);
+	snd_miro_write_mask(chip, OPTi9XX_MC_REG(2), 0x20, 0x20); /* OPL4 */
+	snd_miro_write_mask(chip, OPTi9XX_MC_REG(5), 0x02, 0x02);
+
 	switch (chip->hardware) {
 	case OPTi9XX_HW_82C924:
 		snd_miro_write_mask(chip, OPTi9XX_MC_REG(6), 0x02, 0x02);
-		snd_miro_write_mask(chip, OPTi9XX_MC_REG(1), 0x80, 0x80);
-		snd_miro_write_mask(chip, OPTi9XX_MC_REG(2), 0x20, 0x20); /* OPL4 */
 		snd_miro_write_mask(chip, OPTi9XX_MC_REG(3), 0xf0, 0xff);
-		snd_miro_write_mask(chip, OPTi9XX_MC_REG(5), 0x02, 0x02);
 		break;
 	case OPTi9XX_HW_82C929:
 		/* untested init commands for OPTi929 */
-		snd_miro_write_mask(chip, OPTi9XX_MC_REG(1), 0x80, 0x80);
-		snd_miro_write_mask(chip, OPTi9XX_MC_REG(2), 0x20, 0x20); /* OPL4 */
 		snd_miro_write_mask(chip, OPTi9XX_MC_REG(4), 0x00, 0x0c);
-		snd_miro_write_mask(chip, OPTi9XX_MC_REG(5), 0x02, 0x02);
 		break;
 	default:
 		snd_printk(KERN_ERR "chip %d not supported\n", chip->hardware);
@@ -1156,7 +1148,6 @@ static int __devinit snd_card_miro_aci_detect(struct snd_card *card,
 
 	/* get ACI port from OPTi9xx MC 4 */
 
-	miro->mc_base = 0xf8c;
 	regval=inb(miro->mc_base + 4);
 	miro->aci_port = (regval & 0x10) ? 0x344: 0x354;
 
@@ -1232,7 +1223,13 @@ static int __devinit snd_miro_probe(struct device *devptr, unsigned int n)
 
 	card->private_free = snd_card_miro_free;
 	miro = card->private_data;
-	miro->card = card;
+
+	error = snd_card_miro_detect(card, miro);
+	if (error < 0) {
+		snd_card_free(card);
+		snd_printk(KERN_ERR "unable to detect OPTi9xx chip\n");
+		return -ENODEV;
+	}
 
 	if ((error = snd_card_miro_aci_detect(card, miro)) < 0) {
 		snd_card_free(card);
@@ -1241,13 +1238,8 @@ static int __devinit snd_miro_probe(struct device *devptr, unsigned int n)
 	}
 
 	/* init proc interface */
-	snd_miro_proc_init(miro);
+	snd_miro_proc_init(card, miro);
 
-	if ((error = snd_card_miro_detect(card, miro)) < 0) {
-		snd_card_free(card);
-		snd_printk(KERN_ERR "unable to detect OPTi9xx chip\n");
-		return -ENODEV;
-	}
 
 	if (! miro->res_mc_base &&
 	    (miro->res_mc_base = request_region(miro->mc_base, miro->mc_base_size,
@@ -1341,7 +1333,8 @@ static int __devinit snd_miro_probe(struct device *devptr, unsigned int n)
 
 	miro->pcm = pcm;
 
-	if ((error = snd_miro_mixer(miro)) < 0) {
+	error = snd_miro_mixer(card, miro);
+	if (error < 0) {
 		snd_card_free(card);
 		return error;
 	}
-- 
1.6.4


----------------------------------------------------------------------
Wygraj pobyt w Alpach dla ca³ej rodziny
Kliknij >>> http://link.interia.pl/f2446


--===============9153641975930438852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============9153641975930438852==--
