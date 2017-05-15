From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ALSA: ak411x: Use array instead of
	offsetof()
Date: Mon, 15 May 2017 11:29:05 +0200
Message-ID: <20170515092905.20381-3-tiwai@suse.de>
References: <20170515092905.20381-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A5FA626739D
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 11:29:12 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 3D832AB9F
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 09:29:12 +0000 (UTC)
In-Reply-To: <20170515092905.20381-1-tiwai@suse.de>
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

The ak4113, ak4114 and ak4117 i2c drivers have some tricky codes to
access the struct fields in the callback.  This can be simplified by
replacing the struct fields with the array.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/ak4113.h   | 13 +++++++++----
 include/sound/ak4114.h   | 13 +++++++++----
 include/sound/ak4117.h   | 13 +++++++++----
 sound/i2c/other/ak4113.c | 23 +++++++++++------------
 sound/i2c/other/ak4114.c | 23 +++++++++++------------
 sound/i2c/other/ak4117.c | 23 +++++++++++------------
 6 files changed, 60 insertions(+), 48 deletions(-)

diff --git a/include/sound/ak4113.h b/include/sound/ak4113.h
index 58c145620c3c..b2d09fd09559 100644
--- a/include/sound/ak4113.h
+++ b/include/sound/ak4113.h
@@ -281,6 +281,14 @@ typedef void (ak4113_write_t)(void *private_data, unsigned char addr,
 		unsigned char data);
 typedef unsigned char (ak4113_read_t)(void *private_data, unsigned char addr);
 
+enum {
+	AK4113_PARITY_ERRORS,
+	AK4113_V_BIT_ERRORS,
+	AK4113_QCRC_ERRORS,
+	AK4113_CCRC_ERRORS,
+	AK4113_NUM_ERRORS
+};
+
 struct ak4113 {
 	struct snd_card *card;
 	ak4113_write_t *write;
@@ -292,10 +300,7 @@ struct ak4113 {
 	unsigned char regmap[AK4113_WRITABLE_REGS];
 	struct snd_kcontrol *kctls[AK4113_CONTROLS];
 	struct snd_pcm_substream *substream;
-	unsigned long parity_errors;
-	unsigned long v_bit_errors;
-	unsigned long qcrc_errors;
-	unsigned long ccrc_errors;
+	unsigned long errors[AK4113_NUM_ERRORS];
 	unsigned char rcs0;
 	unsigned char rcs1;
 	unsigned char rcs2;
diff --git a/include/sound/ak4114.h b/include/sound/ak4114.h
index b6feb7e225f2..39df064c82fc 100644
--- a/include/sound/ak4114.h
+++ b/include/sound/ak4114.h
@@ -163,6 +163,14 @@
 typedef void (ak4114_write_t)(void *private_data, unsigned char addr, unsigned char data);
 typedef unsigned char (ak4114_read_t)(void *private_data, unsigned char addr);
 
+enum {
+	AK4114_PARITY_ERRORS,
+	AK4114_V_BIT_ERRORS,
+	AK4114_QCRC_ERRORS,
+	AK4114_CCRC_ERRORS,
+	AK4114_NUM_ERRORS
+};
+
 struct ak4114 {
 	struct snd_card *card;
 	ak4114_write_t * write;
@@ -176,10 +184,7 @@ struct ak4114 {
 	struct snd_kcontrol *kctls[AK4114_CONTROLS];
 	struct snd_pcm_substream *playback_substream;
 	struct snd_pcm_substream *capture_substream;
-	unsigned long parity_errors;
-	unsigned long v_bit_errors;
-	unsigned long qcrc_errors;
-	unsigned long ccrc_errors;
+	unsigned long errors[AK4114_NUM_ERRORS];
 	unsigned char rcs0;
 	unsigned char rcs1;
 	struct delayed_work work;
diff --git a/include/sound/ak4117.h b/include/sound/ak4117.h
index 1e8178171baf..5fab517cfe46 100644
--- a/include/sound/ak4117.h
+++ b/include/sound/ak4117.h
@@ -155,6 +155,14 @@
 typedef void (ak4117_write_t)(void *private_data, unsigned char addr, unsigned char data);
 typedef unsigned char (ak4117_read_t)(void *private_data, unsigned char addr);
 
+enum {
+	AK4117_PARITY_ERRORS,
+	AK4117_V_BIT_ERRORS,
+	AK4117_QCRC_ERRORS,
+	AK4117_CCRC_ERRORS,
+	AK4117_NUM_ERRORS
+};
+
 struct ak4117 {
 	struct snd_card *card;
 	ak4117_write_t * write;
@@ -165,10 +173,7 @@ struct ak4117 {
 	unsigned char regmap[5];
 	struct snd_kcontrol *kctls[AK4117_CONTROLS];
 	struct snd_pcm_substream *substream;
-	unsigned long parity_errors;
-	unsigned long v_bit_errors;
-	unsigned long qcrc_errors;
-	unsigned long ccrc_errors;
+	unsigned long errors[AK4117_NUM_ERRORS];
 	unsigned char rcs0;
 	unsigned char rcs1;
 	unsigned char rcs2;
diff --git a/sound/i2c/other/ak4113.c b/sound/i2c/other/ak4113.c
index 2183e9ebaa6d..4099e6062d3c 100644
--- a/sound/i2c/other/ak4113.c
+++ b/sound/i2c/other/ak4113.c
@@ -199,12 +199,11 @@ static int snd_ak4113_in_error_get(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_value *ucontrol)
 {
 	struct ak4113 *chip = snd_kcontrol_chip(kcontrol);
-	long *ptr;
 
 	spin_lock_irq(&chip->lock);
-	ptr = (long *)(((char *)chip) + kcontrol->private_value);
-	ucontrol->value.integer.value[0] = *ptr;
-	*ptr = 0;
+	ucontrol->value.integer.value[0] =
+		chip->errors[kcontrol->private_value];
+	chip->errors[kcontrol->private_value] = 0;
 	spin_unlock_irq(&chip->lock);
 	return 0;
 }
@@ -373,7 +372,7 @@ static struct snd_kcontrol_new snd_ak4113_iec958_controls[] = {
 		SNDRV_CTL_ELEM_ACCESS_VOLATILE,
 	.info =		snd_ak4113_in_error_info,
 	.get =		snd_ak4113_in_error_get,
-	.private_value = offsetof(struct ak4113, parity_errors),
+	.private_value = AK4113_PARITY_ERRORS,
 },
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -382,7 +381,7 @@ static struct snd_kcontrol_new snd_ak4113_iec958_controls[] = {
 		SNDRV_CTL_ELEM_ACCESS_VOLATILE,
 	.info =		snd_ak4113_in_error_info,
 	.get =		snd_ak4113_in_error_get,
-	.private_value = offsetof(struct ak4113, v_bit_errors),
+	.private_value = AK4113_V_BIT_ERRORS,
 },
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -391,7 +390,7 @@ static struct snd_kcontrol_new snd_ak4113_iec958_controls[] = {
 		SNDRV_CTL_ELEM_ACCESS_VOLATILE,
 	.info =		snd_ak4113_in_error_info,
 	.get =		snd_ak4113_in_error_get,
-	.private_value = offsetof(struct ak4113, ccrc_errors),
+	.private_value = AK4113_CCRC_ERRORS,
 },
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -400,7 +399,7 @@ static struct snd_kcontrol_new snd_ak4113_iec958_controls[] = {
 		SNDRV_CTL_ELEM_ACCESS_VOLATILE,
 	.info =		snd_ak4113_in_error_info,
 	.get =		snd_ak4113_in_error_get,
-	.private_value = offsetof(struct ak4113, qcrc_errors),
+	.private_value = AK4113_QCRC_ERRORS,
 },
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -551,13 +550,13 @@ int snd_ak4113_check_rate_and_errors(struct ak4113 *ak4113, unsigned int flags)
 	rcs2 = reg_read(ak4113, AK4113_REG_RCS2);
 	spin_lock_irqsave(&ak4113->lock, _flags);
 	if (rcs0 & AK4113_PAR)
-		ak4113->parity_errors++;
+		ak4113->errors[AK4113_PARITY_ERRORS]++;
 	if (rcs0 & AK4113_V)
-		ak4113->v_bit_errors++;
+		ak4113->errors[AK4113_V_BIT_ERRORS]++;
 	if (rcs2 & AK4113_CCRC)
-		ak4113->ccrc_errors++;
+		ak4113->errors[AK4113_CCRC_ERRORS]++;
 	if (rcs2 & AK4113_QCRC)
-		ak4113->qcrc_errors++;
+		ak4113->errors[AK4113_QCRC_ERRORS]++;
 	c0 = (ak4113->rcs0 & (AK4113_QINT | AK4113_CINT | AK4113_STC |
 				AK4113_AUDION | AK4113_AUTO | AK4113_UNLCK)) ^
 		(rcs0 & (AK4113_QINT | AK4113_CINT | AK4113_STC |
diff --git a/sound/i2c/other/ak4114.c b/sound/i2c/other/ak4114.c
index d53c9bb36281..7fb1aeb46915 100644
--- a/sound/i2c/other/ak4114.c
+++ b/sound/i2c/other/ak4114.c
@@ -194,12 +194,11 @@ static int snd_ak4114_in_error_get(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_value *ucontrol)
 {
 	struct ak4114 *chip = snd_kcontrol_chip(kcontrol);
-	long *ptr;
 
 	spin_lock_irq(&chip->lock);
-	ptr = (long *)(((char *)chip) + kcontrol->private_value);
-	ucontrol->value.integer.value[0] = *ptr;
-	*ptr = 0;
+	ucontrol->value.integer.value[0] =
+		chip->errors[kcontrol->private_value];
+	chip->errors[kcontrol->private_value] = 0;
 	spin_unlock_irq(&chip->lock);
 	return 0;
 }
@@ -341,7 +340,7 @@ static struct snd_kcontrol_new snd_ak4114_iec958_controls[] = {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
 	.info =		snd_ak4114_in_error_info,
 	.get =		snd_ak4114_in_error_get,
-	.private_value = offsetof(struct ak4114, parity_errors),
+	.private_value = AK4114_PARITY_ERRORS,
 },
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -349,7 +348,7 @@ static struct snd_kcontrol_new snd_ak4114_iec958_controls[] = {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
 	.info =		snd_ak4114_in_error_info,
 	.get =		snd_ak4114_in_error_get,
-	.private_value = offsetof(struct ak4114, v_bit_errors),
+	.private_value = AK4114_V_BIT_ERRORS,
 },
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -357,7 +356,7 @@ static struct snd_kcontrol_new snd_ak4114_iec958_controls[] = {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
 	.info =		snd_ak4114_in_error_info,
 	.get =		snd_ak4114_in_error_get,
-	.private_value = offsetof(struct ak4114, ccrc_errors),
+	.private_value = AK4114_CCRC_ERRORS,
 },
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -365,7 +364,7 @@ static struct snd_kcontrol_new snd_ak4114_iec958_controls[] = {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
 	.info =		snd_ak4114_in_error_info,
 	.get =		snd_ak4114_in_error_get,
-	.private_value = offsetof(struct ak4114, qcrc_errors),
+	.private_value = AK4114_QCRC_ERRORS,
 },
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -581,13 +580,13 @@ int snd_ak4114_check_rate_and_errors(struct ak4114 *ak4114, unsigned int flags)
 	rcs0 = reg_read(ak4114, AK4114_REG_RCS0);
 	spin_lock_irqsave(&ak4114->lock, _flags);
 	if (rcs0 & AK4114_PAR)
-		ak4114->parity_errors++;
+		ak4114->errors[AK4114_PARITY_ERRORS]++;
 	if (rcs1 & AK4114_V)
-		ak4114->v_bit_errors++;
+		ak4114->errors[AK4114_V_BIT_ERRORS]++;
 	if (rcs1 & AK4114_CCRC)
-		ak4114->ccrc_errors++;
+		ak4114->errors[AK4114_CCRC_ERRORS]++;
 	if (rcs1 & AK4114_QCRC)
-		ak4114->qcrc_errors++;
+		ak4114->errors[AK4114_QCRC_ERRORS]++;
 	c0 = (ak4114->rcs0 & (AK4114_QINT | AK4114_CINT | AK4114_PEM | AK4114_AUDION | AK4114_AUTO | AK4114_UNLCK)) ^
                      (rcs0 & (AK4114_QINT | AK4114_CINT | AK4114_PEM | AK4114_AUDION | AK4114_AUTO | AK4114_UNLCK));
 	c1 = (ak4114->rcs1 & 0xf0) ^ (rcs1 & 0xf0);
diff --git a/sound/i2c/other/ak4117.c b/sound/i2c/other/ak4117.c
index 0702f0552d19..3ab099fb8c15 100644
--- a/sound/i2c/other/ak4117.c
+++ b/sound/i2c/other/ak4117.c
@@ -168,12 +168,11 @@ static int snd_ak4117_in_error_get(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_value *ucontrol)
 {
 	struct ak4117 *chip = snd_kcontrol_chip(kcontrol);
-	long *ptr;
 
 	spin_lock_irq(&chip->lock);
-	ptr = (long *)(((char *)chip) + kcontrol->private_value);
-	ucontrol->value.integer.value[0] = *ptr;
-	*ptr = 0;
+	ucontrol->value.integer.value[0] =
+		       chip->errors[kcontrol->private_value];
+	chip->errors[kcontrol->private_value] = 0;
 	spin_unlock_irq(&chip->lock);
 	return 0;
 }
@@ -328,7 +327,7 @@ static struct snd_kcontrol_new snd_ak4117_iec958_controls[] = {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
 	.info =		snd_ak4117_in_error_info,
 	.get =		snd_ak4117_in_error_get,
-	.private_value = offsetof(struct ak4117, parity_errors),
+	.private_value = AK4117_PARITY_ERRORS,
 },
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -336,7 +335,7 @@ static struct snd_kcontrol_new snd_ak4117_iec958_controls[] = {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
 	.info =		snd_ak4117_in_error_info,
 	.get =		snd_ak4117_in_error_get,
-	.private_value = offsetof(struct ak4117, v_bit_errors),
+	.private_value = AK4117_V_BIT_ERRORS,
 },
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -344,7 +343,7 @@ static struct snd_kcontrol_new snd_ak4117_iec958_controls[] = {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
 	.info =		snd_ak4117_in_error_info,
 	.get =		snd_ak4117_in_error_get,
-	.private_value = offsetof(struct ak4117, ccrc_errors),
+	.private_value = AK4117_CCRC_ERRORS,
 },
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -352,7 +351,7 @@ static struct snd_kcontrol_new snd_ak4117_iec958_controls[] = {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
 	.info =		snd_ak4117_in_error_info,
 	.get =		snd_ak4117_in_error_get,
-	.private_value = offsetof(struct ak4117, qcrc_errors),
+	.private_value = AK4117_QCRC_ERRORS,
 },
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -470,13 +469,13 @@ int snd_ak4117_check_rate_and_errors(struct ak4117 *ak4117, unsigned int flags)
 	// printk(KERN_DEBUG "AK IRQ: rcs0 = 0x%x, rcs1 = 0x%x, rcs2 = 0x%x\n", rcs0, rcs1, rcs2);
 	spin_lock_irqsave(&ak4117->lock, _flags);
 	if (rcs0 & AK4117_PAR)
-		ak4117->parity_errors++;
+		ak4117->errors[AK4117_PARITY_ERRORS]++;
 	if (rcs0 & AK4117_V)
-		ak4117->v_bit_errors++;
+		ak4117->errors[AK4117_V_BIT_ERRORS]++;
 	if (rcs2 & AK4117_CCRC)
-		ak4117->ccrc_errors++;
+		ak4117->errors[AK4117_CCRC_ERRORS]++;
 	if (rcs2 & AK4117_QCRC)
-		ak4117->qcrc_errors++;
+		ak4117->errors[AK4117_QCRC_ERRORS]++;
 	c0 = (ak4117->rcs0 & (AK4117_QINT | AK4117_CINT | AK4117_STC | AK4117_AUDION | AK4117_AUTO | AK4117_UNLCK)) ^
                      (rcs0 & (AK4117_QINT | AK4117_CINT | AK4117_STC | AK4117_AUDION | AK4117_AUTO | AK4117_UNLCK));
 	c1 = (ak4117->rcs1 & (AK4117_DTSCD | AK4117_NPCM | AK4117_PEM | 0x0f)) ^
-- 
2.12.2
