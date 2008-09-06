From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH] ice1712/aureon.c: fix coding style
Date: Sun, 7 Sep 2008 01:19:00 +0400
Message-ID: <20080906211900.GA6211@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155])
	by alsa0.perex.cz (Postfix) with ESMTP id ACB1B1037EB
	for <alsa-devel@alsa-project.org>;
	Sat,  6 Sep 2008 23:20:35 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so1005374fgg.44
	for <alsa-devel@alsa-project.org>; Sat, 06 Sep 2008 14:20:34 -0700 (PDT)
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
To: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

before:
total: 304 errors, 137 warnings, 2259 lines checked

after:
total: 0 errors, 121 warnings, 2284 lines checked

Compile tested, size is different because of include was changed,
but without that change md5sum is different because of cmp cx,dx/cmp
dx,cx swap and __LINE__ was changed in printk function. 

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 sound/pci/ice1712/aureon.c |  677 +++++++++++++++++++++++---------------------
 1 files changed, 351 insertions(+), 326 deletions(-)

diff --git a/sound/pci/ice1712/aureon.c b/sound/pci/ice1712/aureon.c
index a137fc1..110d16e 100644
--- a/sound/pci/ice1712/aureon.c
+++ b/sound/pci/ice1712/aureon.c
@@ -44,10 +44,9 @@
  *       not working: prety much everything else, at least i could verify that
  *                    we have no digital output, no capture, pretty bad clicks and poops
  *                    on mixer switch and other coll stuff.
- *
- */      
+ */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -131,7 +130,7 @@ static void aureon_pca9554_write(struct snd_ice1712 *ice, unsigned char reg,
 	snd_ice1712_gpio_write(ice, tmp);
 	udelay(50);
 
-	/* 
+	/*
 	 * send i2c stop condition and start condition
 	 * to obtain sane state
 	 */
@@ -152,10 +151,16 @@ static void aureon_pca9554_write(struct snd_ice1712 *ice, unsigned char reg,
 	 * skipping ack cycles inbetween
 	 */
 	for (j = 0; j < 3; j++) {
-		switch(j) {
-		case 0: val = dev; break;
-		case 1: val = reg; break;
-		case 2: val = data; break;
+		switch (j) {
+		case 0:
+			val = dev;
+			break;
+		case 1:
+			val = reg;
+			break;
+		case 2:
+			val = data;
+			break;
 		}
 		for (i = 7; i >= 0; i--) {
 			tmp &= ~AUREON_SPI_CLK;
@@ -171,7 +176,7 @@ static void aureon_pca9554_write(struct snd_ice1712 *ice, unsigned char reg,
 			snd_ice1712_gpio_write(ice, tmp);
 			udelay(40);
 		}
-                tmp &= ~AUREON_SPI_CLK;
+		tmp &= ~AUREON_SPI_CLK;
 		snd_ice1712_gpio_write(ice, tmp);
 		udelay(40);
 		tmp |= AUREON_SPI_CLK;
@@ -203,7 +208,7 @@ static int aureon_universe_inmux_info(struct snd_kcontrol *kcontrol,
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	uinfo->value.enumerated.items = 3;
-	if(uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
+	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
 		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
 	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
 	return 0;
@@ -231,12 +236,12 @@ static int aureon_universe_inmux_put(struct snd_kcontrol *kcontrol,
 		return -EINVAL;
 	snd_ice1712_save_gpio_status(ice);
 	oval = spec->pca9554_out;
-	if ((change = (oval != nval))) {
+	change = (oval != nval);
+	if (change) {
 		aureon_pca9554_write(ice, PCA9554_OUT, nval);
 		spec->pca9554_out = nval;
 	}
 	snd_ice1712_restore_gpio_status(ice);
-	
 	return change;
 }
 
@@ -256,7 +261,7 @@ static void aureon_ac97_write(struct snd_ice1712 *ice, unsigned short reg,
 	udelay(10);
 	tmp &= ~AUREON_AC97_ADDR;
 	snd_ice1712_gpio_write(ice, tmp);
-	udelay(10);	
+	udelay(10);
 
 	/* Send low-order byte to XILINX chip */
 	tmp &= ~AUREON_AC97_DATA_MASK;
@@ -269,7 +274,7 @@ static void aureon_ac97_write(struct snd_ice1712 *ice, unsigned short reg,
 	tmp &= ~AUREON_AC97_DATA_LOW;
 	snd_ice1712_gpio_write(ice, tmp);
 	udelay(10);
-	
+
 	/* Send high-order byte to XILINX chip */
 	tmp &= ~AUREON_AC97_DATA_MASK;
 	tmp |= (val >> 8) & AUREON_AC97_DATA_MASK;
@@ -282,7 +287,7 @@ static void aureon_ac97_write(struct snd_ice1712 *ice, unsigned short reg,
 	tmp &= ~AUREON_AC97_DATA_HIGH;
 	snd_ice1712_gpio_write(ice, tmp);
 	udelay(10);
-	
+
 	/* Instruct XILINX chip to parse the data to the STAC9744 chip */
 	tmp |= AUREON_AC97_COMMIT;
 	snd_ice1712_gpio_write(ice, tmp);
@@ -290,7 +295,7 @@ static void aureon_ac97_write(struct snd_ice1712 *ice, unsigned short reg,
 	tmp &= ~AUREON_AC97_COMMIT;
 	snd_ice1712_gpio_write(ice, tmp);
 	udelay(10);
-	
+
 	/* Store the data in out private buffer */
 	spec->stac9744[(reg & 0x7F) >> 1] = val;
 }
@@ -304,7 +309,7 @@ static unsigned short aureon_ac97_read(struct snd_ice1712 *ice, unsigned short r
 /*
  * Initialize STAC9744 chip
  */
-static int aureon_ac97_init (struct snd_ice1712 *ice)
+static int aureon_ac97_init(struct snd_ice1712 *ice)
 {
 	struct aureon_spec *spec = ice->spec;
 	int i;
@@ -335,20 +340,21 @@ static int aureon_ac97_init (struct snd_ice1712 *ice)
 	tmp = (snd_ice1712_gpio_read(ice) | AUREON_AC97_RESET) & ~AUREON_AC97_DATA_MASK;
 	snd_ice1712_gpio_write(ice, tmp);
 	udelay(3);
-	
+
 	tmp &= ~AUREON_AC97_RESET;
 	snd_ice1712_gpio_write(ice, tmp);
 	udelay(3);
-	
+
 	tmp |= AUREON_AC97_RESET;
 	snd_ice1712_gpio_write(ice, tmp);
 	udelay(3);
-	
+
 	memset(&spec->stac9744, 0, sizeof(spec->stac9744));
-	for (i=0; ac97_defaults[i] != (unsigned short)-1; i+=2)
+	for (i = 0; ac97_defaults[i] != (unsigned short)-1; i += 2)
 		spec->stac9744[(ac97_defaults[i]) >> 1] = ac97_defaults[i+1];
-		
-	aureon_ac97_write(ice, AC97_MASTER, 0x0000); // Unmute AC'97 master volume permanently - muting is done by WM8770
+
+	/* Unmute AC'97 master volume permanently - muting is done by WM8770 */
+	aureon_ac97_write(ice, AC97_MASTER, 0x0000);
 
 	return 0;
 }
@@ -388,7 +394,7 @@ static int aureon_ac97_vol_put(struct snd_kcontrol *kcontrol, struct snd_ctl_ele
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	unsigned short ovol, nvol;
 	int change;
-	
+
 	snd_ice1712_save_gpio_status(ice);
 
 	ovol = aureon_ac97_read(ice, kcontrol->private_value & 0x7F);
@@ -396,13 +402,14 @@ static int aureon_ac97_vol_put(struct snd_kcontrol *kcontrol, struct snd_ctl_ele
 	if (kcontrol->private_value & AUREON_AC97_STEREO)
 		nvol |= ((0x1F - ucontrol->value.integer.value[1]) << 8) & 0x1F00;
 	nvol |= ovol & ~0x1F1F;
-	
-	if ((change = (ovol != nvol)))
+
+	change = (ovol != nvol);
+	if (change)
 		aureon_ac97_write(ice, kcontrol->private_value & 0x7F, nvol);
 
 	snd_ice1712_restore_gpio_status(ice);
 
-	return change;		
+	return change;
 }
 
 /*
@@ -416,7 +423,8 @@ static int aureon_ac97_mute_get(struct snd_kcontrol *kcontrol, struct snd_ctl_el
 
 	mutex_lock(&ice->gpio_mutex);
 
-	ucontrol->value.integer.value[0] = aureon_ac97_read(ice, kcontrol->private_value & 0x7F) & 0x8000 ? 0 : 1;
+	ucontrol->value.integer.value[0] = aureon_ac97_read(ice,
+			kcontrol->private_value & 0x7F) & 0x8000 ? 0 : 1;
 
 	mutex_unlock(&ice->gpio_mutex);
 	return 0;
@@ -429,13 +437,14 @@ static int aureon_ac97_mute_put(struct snd_kcontrol *kcontrol, struct snd_ctl_el
 	int change;
 
 	snd_ice1712_save_gpio_status(ice);
-	
+
 	ovol = aureon_ac97_read(ice, kcontrol->private_value & 0x7F);
-	nvol = (ucontrol->value.integer.value[0] ? 0x0000 : 0x8000) | (ovol & ~	0x8000);
-	
-	if ((change = (ovol != nvol)))
+	nvol = (ucontrol->value.integer.value[0] ? 0x0000 : 0x8000) | (ovol & ~0x8000);
+
+	change = (ovol != nvol);
+	if (change)
 		aureon_ac97_write(ice, kcontrol->private_value & 0x7F, nvol);
-		
+
 	snd_ice1712_restore_gpio_status(ice);
 
 	return change;
@@ -465,13 +474,14 @@ static int aureon_ac97_micboost_put(struct snd_kcontrol *kcontrol, struct snd_ct
 	int change;
 
 	snd_ice1712_save_gpio_status(ice);
-	
+
 	ovol = aureon_ac97_read(ice, AC97_MIC);
 	nvol = (ucontrol->value.integer.value[0] ? 0x0000 : 0x0020) | (ovol & ~0x0020);
-	
-	if ((change = (ovol != nvol)))
+
+	change = (ovol != nvol);
+	if (change)
 		aureon_ac97_write(ice, AC97_MIC, nvol);
-		
+
 	snd_ice1712_restore_gpio_status(ice);
 
 	return change;
@@ -493,16 +503,15 @@ static void aureon_spi_write(struct snd_ice1712 *ice, unsigned int cs, unsigned
 		snd_ice1712_gpio_set_mask(ice, ~(PRODIGY_SPI_MOSI|PRODIGY_SPI_CLK|PRODIGY_WM_CS));
 		mosi = PRODIGY_SPI_MOSI;
 		clk = PRODIGY_SPI_CLK;
-	}
-	else {
+	} else {
 		snd_ice1712_gpio_set_mask(ice, ~(AUREON_WM_RW|AUREON_SPI_MOSI|AUREON_SPI_CLK|
 						 AUREON_WM_CS|AUREON_CS8415_CS));
 		mosi = AUREON_SPI_MOSI;
 		clk = AUREON_SPI_CLK;
-		
+
 		tmp |= AUREON_WM_RW;
 	}
-	
+
 	tmp &= ~cs;
 	snd_ice1712_gpio_write(ice, tmp);
 	udelay(1);
@@ -534,7 +543,9 @@ static void aureon_spi_write(struct snd_ice1712 *ice, unsigned int cs, unsigned
 /*
  * Read data in SPI mode
  */
-static void aureon_spi_read(struct snd_ice1712 *ice, unsigned int cs, unsigned int data, int bits, unsigned char *buffer, int size) {
+static void aureon_spi_read(struct snd_ice1712 *ice, unsigned int cs,
+		unsigned int data, int bits, unsigned char *buffer, int size)
+{
 	int i, j;
 	unsigned int tmp;
 
@@ -544,7 +555,7 @@ static void aureon_spi_read(struct snd_ice1712 *ice, unsigned int cs, unsigned i
 	snd_ice1712_gpio_write(ice, tmp);
 	udelay(1);
 
-	for (i=bits-1; i>=0; i--) {
+	for (i = bits-1; i >= 0; i--) {
 		if (data & (1 << i))
 			tmp |= AUREON_SPI_MOSI;
 		else
@@ -561,9 +572,9 @@ static void aureon_spi_read(struct snd_ice1712 *ice, unsigned int cs, unsigned i
 		udelay(1);
 	}
 
-	for (j=0; j<size; j++) {
+	for (j = 0; j < size; j++) {
 		unsigned char outdata = 0;
-		for (i=7; i>=0; i--) {
+		for (i = 7; i >= 0; i--) {
 			tmp = snd_ice1712_gpio_read(ice);
 			outdata <<= 1;
 			outdata |= (tmp & AUREON_SPI_MISO) ? 1 : 0;
@@ -584,19 +595,24 @@ static void aureon_spi_read(struct snd_ice1712 *ice, unsigned int cs, unsigned i
 	snd_ice1712_gpio_write(ice, tmp);
 }
 
-static unsigned char aureon_cs8415_get(struct snd_ice1712 *ice, int reg) {
+static unsigned char aureon_cs8415_get(struct snd_ice1712 *ice, int reg)
+{
 	unsigned char val;
 	aureon_spi_write(ice, AUREON_CS8415_CS, 0x2000 | reg, 16);
 	aureon_spi_read(ice, AUREON_CS8415_CS, 0x21, 8, &val, 1);
 	return val;
 }
 
-static void aureon_cs8415_read(struct snd_ice1712 *ice, int reg, unsigned char *buffer, int size) {
+static void aureon_cs8415_read(struct snd_ice1712 *ice, int reg,
+				unsigned char *buffer, int size)
+{
 	aureon_spi_write(ice, AUREON_CS8415_CS, 0x2000 | reg, 16);
 	aureon_spi_read(ice, AUREON_CS8415_CS, 0x21, 8, buffer, size);
 }
 
-static void aureon_cs8415_put(struct snd_ice1712 *ice, int reg, unsigned char val) {
+static void aureon_cs8415_put(struct snd_ice1712 *ice, int reg,
+						unsigned char val)
+{
 	aureon_spi_write(ice, AUREON_CS8415_CS, 0x200000 | (reg << 8) | val, 24);
 }
 
@@ -654,18 +670,20 @@ static int aureon_ac97_mmute_get(struct snd_kcontrol *kcontrol, struct snd_ctl_e
 	return 0;
 }
 
-static int aureon_ac97_mmute_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol) {
+static int aureon_ac97_mmute_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+{
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	unsigned short ovol, nvol;
 	int change;
-	
+
 	snd_ice1712_save_gpio_status(ice);
-	
+
 	ovol = wm_get(ice, WM_OUT_MUX1);
 	nvol = (ovol & ~0x02) | (ucontrol->value.integer.value[0] ? 0x02 : 0x00);
-	if ((change = (ovol != nvol)))
+	change = (ovol != nvol);
+	if (change)
 		wm_put(ice, WM_OUT_MUX1, nvol);
-		
+
 	snd_ice1712_restore_gpio_status(ice);
 
 	return change;
@@ -702,12 +720,12 @@ static const unsigned char wm_vol[256] = {
 static void wm_set_vol(struct snd_ice1712 *ice, unsigned int index, unsigned short vol, unsigned short master)
 {
 	unsigned char nvol;
-	
+
 	if ((master & WM_VOL_MUTE) || (vol & WM_VOL_MUTE))
 		nvol = 0;
 	else
 		nvol = 127 - wm_vol[(((vol & ~WM_VOL_MUTE) * (master & ~WM_VOL_MUTE)) / 127) & WM_VOL_MAX];
-	
+
 	wm_put(ice, index, nvol);
 	wm_put_nocache(ice, index, 0x180 | nvol);
 }
@@ -736,7 +754,8 @@ static int wm_pcm_mute_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_va
 	snd_ice1712_save_gpio_status(ice);
 	oval = wm_get(ice, WM_MUTE);
 	nval = (oval & ~0x10) | (ucontrol->value.integer.value[0] ? 0 : 0x10);
-	if ((change = (nval != oval)))
+	change = (oval != nval);
+	if (change)
 		wm_put(ice, WM_MUTE, nval);
 	snd_ice1712_restore_gpio_status(ice);
 
@@ -760,7 +779,7 @@ static int wm_master_vol_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	struct aureon_spec *spec = ice->spec;
 	int i;
-	for (i=0; i<2; i++)
+	for (i = 0; i < 2; i++)
 		ucontrol->value.integer.value[i] =
 			spec->master[i] & ~WM_VOL_MUTE;
 	return 0;
@@ -849,7 +868,8 @@ static int wm_vol_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *
 /*
  * WM8770 mute control
  */
-static int wm_mute_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo) {
+static int wm_mute_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
+{
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
 	uinfo->count = kcontrol->private_value >> 8;
 	uinfo->value.integer.min = 0;
@@ -862,7 +882,7 @@ static int wm_mute_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	struct aureon_spec *spec = ice->spec;
 	int voices, ofs, i;
-	
+
 	voices = kcontrol->private_value >> 8;
 	ofs = kcontrol->private_value & 0xFF;
 
@@ -907,7 +927,7 @@ static int wm_master_mute_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	struct aureon_spec *spec = ice->spec;
-	
+
 	ucontrol->value.integer.value[0] =
 		(spec->master[0] & WM_VOL_MUTE) ? 0 : 1;
 	ucontrol->value.integer.value[1] =
@@ -1083,21 +1103,21 @@ static int wm_adc_vol_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_val
 static int wm_adc_mux_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	static const char * const texts[] = {
-		"CD",		//AIN1
-		"Aux",		//AIN2
-		"Line",		//AIN3
-		"Mic",		//AIN4
-		"AC97"		//AIN5
+		"CD",		/* AIN1 */
+		"Aux",		/* AIN2 */
+		"Line",		/* AIN3 */
+		"Mic",		/* AIN4 */
+		"AC97"		/* AIN5 */
 	};
 	static const char * const universe_texts[] = {
-		"Aux1",		//AIN1
-		"CD",		//AIN2
-		"Phono",	//AIN3
-		"Line",		//AIN4
-		"Aux2",		//AIN5
-		"Mic",		//AIN6
-		"Aux3",		//AIN7
-		"AC97"		//AIN8
+		"Aux1",		/* AIN1 */
+		"CD",		/* AIN2 */
+		"Phono",	/* AIN3 */
+		"Line",		/* AIN4 */
+		"Aux2",		/* AIN5 */
+		"Mic",		/* AIN6 */
+		"Aux3",		/* AIN7 */
+		"AC97"		/* AIN8 */
 	};
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 
@@ -1108,8 +1128,7 @@ static int wm_adc_mux_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_in
 		if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
 			uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
 		strcpy(uinfo->value.enumerated.name, universe_texts[uinfo->value.enumerated.item]);
-	}
-	else {
+	} else {
 		uinfo->value.enumerated.items = 5;
 		if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
 			uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
@@ -1156,8 +1175,8 @@ static int aureon_cs8415_mux_info(struct snd_kcontrol *kcontrol, struct snd_ctl_
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	static const char * const aureon_texts[] = {
-		"CD",		//RXP0
-		"Optical"	//RXP1
+		"CD",		/* RXP0 */
+		"Optical"	/* RXP1 */
 	};
 	static const char * const prodigy_texts[] = {
 		"CD",
@@ -1180,10 +1199,10 @@ static int aureon_cs8415_mux_get(struct snd_kcontrol *kcontrol, struct snd_ctl_e
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	struct aureon_spec *spec = ice->spec;
 
-	//snd_ice1712_save_gpio_status(ice);
-	//val = aureon_cs8415_get(ice, CS8415_CTRL2);
+	/* snd_ice1712_save_gpio_status(ice); */
+	/* val = aureon_cs8415_get(ice, CS8415_CTRL2); */
 	ucontrol->value.enumerated.item[0] = spec->cs8415_mux;
-	//snd_ice1712_restore_gpio_status(ice);
+	/* snd_ice1712_restore_gpio_status(ice); */
 	return 0;
 }
 
@@ -1206,7 +1225,7 @@ static int aureon_cs8415_mux_put(struct snd_kcontrol *kcontrol, struct snd_ctl_e
 	return change;
 }
 
-static int aureon_cs8415_rate_info (struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
+static int aureon_cs8415_rate_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 1;
@@ -1215,7 +1234,7 @@ static int aureon_cs8415_rate_info (struct snd_kcontrol *kcontrol, struct snd_ct
 	return 0;
 }
 
-static int aureon_cs8415_rate_get (struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+static int aureon_cs8415_rate_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	unsigned char ratio;
@@ -1229,7 +1248,7 @@ static int aureon_cs8415_rate_get (struct snd_kcontrol *kcontrol, struct snd_ctl
  */
 #define aureon_cs8415_mute_info		snd_ctl_boolean_mono_info
 
-static int aureon_cs8415_mute_get (struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+static int aureon_cs8415_mute_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	snd_ice1712_save_gpio_status(ice);
@@ -1238,7 +1257,7 @@ static int aureon_cs8415_mute_get (struct snd_kcontrol *kcontrol, struct snd_ctl
 	return 0;
 }
 
-static int aureon_cs8415_mute_put (struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+static int aureon_cs8415_mute_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	unsigned char oval, nval;
@@ -1249,7 +1268,8 @@ static int aureon_cs8415_mute_put (struct snd_kcontrol *kcontrol, struct snd_ctl
 		nval = oval & ~0x20;
 	else
 		nval = oval | 0x20;
-	if ((change = (oval != nval)))
+	change = (oval != nval);
+	if (change)
 		aureon_cs8415_put(ice, CS8415_CTRL1, nval);
 	snd_ice1712_restore_gpio_status(ice);
 	return change;
@@ -1258,15 +1278,17 @@ static int aureon_cs8415_mute_put (struct snd_kcontrol *kcontrol, struct snd_ctl
 /*
  * CS8415A Q-Sub info
  */
-static int aureon_cs8415_qsub_info (struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo) {
+static int aureon_cs8415_qsub_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
+{
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
 	uinfo->count = 10;
 	return 0;
 }
 
-static int aureon_cs8415_qsub_get (struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol) {
+static int aureon_cs8415_qsub_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+{
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
-	
+
 	snd_ice1712_save_gpio_status(ice);
 	aureon_cs8415_read(ice, CS8415_QSUB, ucontrol->value.bytes.data, 10);
 	snd_ice1712_restore_gpio_status(ice);
@@ -1274,18 +1296,21 @@ static int aureon_cs8415_qsub_get (struct snd_kcontrol *kcontrol, struct snd_ctl
 	return 0;
 }
 
-static int aureon_cs8415_spdif_info (struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo) {
+static int aureon_cs8415_spdif_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
+{
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
 	uinfo->count = 1;
 	return 0;
 }
 
-static int aureon_cs8415_mask_get (struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol) {
+static int aureon_cs8415_mask_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+{
 	memset(ucontrol->value.iec958.status, 0xFF, 24);
 	return 0;
 }
 
-static int aureon_cs8415_spdif_get (struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol) {
+static int aureon_cs8415_spdif_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+{
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 
 	snd_ice1712_save_gpio_status(ice);
@@ -1311,9 +1336,9 @@ static int aureon_set_headphone_amp(struct snd_ice1712 *ice, int enable)
 	else
 		if (ice->eeprom.subvendor != VT1724_SUBDEVICE_PRODIGY71LT &&
 		    ice->eeprom.subvendor != VT1724_SUBDEVICE_PRODIGY71XT)
-			tmp &= ~ AUREON_HP_SEL;
+			tmp &= ~AUREON_HP_SEL;
 		else
-			tmp &= ~ PRODIGY_HP_SEL;
+			tmp &= ~PRODIGY_HP_SEL;
 	if (tmp != tmp2) {
 		snd_ice1712_gpio_write(ice, tmp);
 		return 1;
@@ -1325,7 +1350,7 @@ static int aureon_get_headphone_amp(struct snd_ice1712 *ice)
 {
 	unsigned int tmp = snd_ice1712_gpio_read(ice);
 
-	return ( tmp & AUREON_HP_SEL )!= 0;
+	return (tmp & AUREON_HP_SEL) != 0;
 }
 
 #define aureon_hpamp_info	snd_ctl_boolean_mono_info
@@ -1343,7 +1368,7 @@ static int aureon_hpamp_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_v
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 
-	return aureon_set_headphone_amp(ice,ucontrol->value.integer.value[0]);
+	return aureon_set_headphone_amp(ice, ucontrol->value.integer.value[0]);
 }
 
 /*
@@ -1390,7 +1415,7 @@ static int aureon_oversampling_info(struct snd_kcontrol *k, struct snd_ctl_elem_
 		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
 	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
 
-        return 0;
+	return 0;
 }
 
 static int aureon_oversampling_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -1434,7 +1459,7 @@ static struct snd_kcontrol_new aureon_dac_controls[] __devinitdata = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
-			   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
+				SNDRV_CTL_ELEM_ACCESS_TLV_READ),
 		.name = "Master Playback Volume",
 		.info = wm_master_vol_info,
 		.get = wm_master_vol_get,
@@ -1452,7 +1477,7 @@ static struct snd_kcontrol_new aureon_dac_controls[] __devinitdata = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
-			   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
+				SNDRV_CTL_ELEM_ACCESS_TLV_READ),
 		.name = "Front Playback Volume",
 		.info = wm_vol_info,
 		.get = wm_vol_get,
@@ -1471,7 +1496,7 @@ static struct snd_kcontrol_new aureon_dac_controls[] __devinitdata = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
-			   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
+				SNDRV_CTL_ELEM_ACCESS_TLV_READ),
 		.name = "Rear Playback Volume",
 		.info = wm_vol_info,
 		.get = wm_vol_get,
@@ -1490,7 +1515,7 @@ static struct snd_kcontrol_new aureon_dac_controls[] __devinitdata = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
-			   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
+				SNDRV_CTL_ELEM_ACCESS_TLV_READ),
 		.name = "Center Playback Volume",
 		.info = wm_vol_info,
 		.get = wm_vol_get,
@@ -1509,7 +1534,7 @@ static struct snd_kcontrol_new aureon_dac_controls[] __devinitdata = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
-			   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
+				SNDRV_CTL_ELEM_ACCESS_TLV_READ),
 		.name = "LFE Playback Volume",
 		.info = wm_vol_info,
 		.get = wm_vol_get,
@@ -1528,7 +1553,7 @@ static struct snd_kcontrol_new aureon_dac_controls[] __devinitdata = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
-			   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
+				SNDRV_CTL_ELEM_ACCESS_TLV_READ),
 		.name = "Side Playback Volume",
 		.info = wm_vol_info,
 		.get = wm_vol_get,
@@ -1539,23 +1564,23 @@ static struct snd_kcontrol_new aureon_dac_controls[] __devinitdata = {
 };
 
 static struct snd_kcontrol_new wm_controls[] __devinitdata = {
- 	{
- 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "PCM Playback Switch",
 		.info = wm_pcm_mute_info,
 		.get = wm_pcm_mute_get,
 		.put = wm_pcm_mute_put
- 	},
- 	{
- 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
-			   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
+				SNDRV_CTL_ELEM_ACCESS_TLV_READ),
 		.name = "PCM Playback Volume",
 		.info = wm_pcm_vol_info,
 		.get = wm_pcm_vol_get,
 		.put = wm_pcm_vol_put,
 		.tlv = { .p = db_scale_wm_pcm }
- 	},
+	},
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Capture Switch",
@@ -1566,7 +1591,7 @@ static struct snd_kcontrol_new wm_controls[] __devinitdata = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
-			   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
+				SNDRV_CTL_ELEM_ACCESS_TLV_READ),
 		.name = "Capture Volume",
 		.info = wm_adc_vol_info,
 		.get = wm_adc_vol_get,
@@ -1605,232 +1630,232 @@ static struct snd_kcontrol_new wm_controls[] __devinitdata = {
 };
 
 static struct snd_kcontrol_new ac97_controls[] __devinitdata = {
- 	{
- 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "AC97 Playback Switch",
 		.info = aureon_ac97_mmute_info,
 		.get = aureon_ac97_mmute_get,
 		.put = aureon_ac97_mmute_put,
 		.private_value = AC97_MASTER
- 	},
- 	{
- 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
-			   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
- 		.name = "AC97 Playback Volume",
- 		.info = aureon_ac97_vol_info,
- 		.get = aureon_ac97_vol_get,
- 		.put = aureon_ac97_vol_put,
- 		.private_value = AC97_MASTER|AUREON_AC97_STEREO,
+				SNDRV_CTL_ELEM_ACCESS_TLV_READ),
+		.name = "AC97 Playback Volume",
+		.info = aureon_ac97_vol_info,
+		.get = aureon_ac97_vol_get,
+		.put = aureon_ac97_vol_put,
+		.private_value = AC97_MASTER|AUREON_AC97_STEREO,
 		.tlv = { .p = db_scale_ac97_master }
- 	},
- 	{
- 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
- 		.name = "CD Playback Switch",
- 		.info = aureon_ac97_mute_info,
- 		.get = aureon_ac97_mute_get,
- 		.put = aureon_ac97_mute_put,
- 		.private_value = AC97_CD
- 	},
- 	{
- 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "CD Playback Switch",
+		.info = aureon_ac97_mute_info,
+		.get = aureon_ac97_mute_get,
+		.put = aureon_ac97_mute_put,
+		.private_value = AC97_CD
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
-			   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
- 		.name = "CD Playback Volume",
- 		.info = aureon_ac97_vol_info,
- 		.get = aureon_ac97_vol_get,
- 		.put = aureon_ac97_vol_put,
- 		.private_value = AC97_CD|AUREON_AC97_STEREO,
+				SNDRV_CTL_ELEM_ACCESS_TLV_READ),
+		.name = "CD Playback Volume",
+		.info = aureon_ac97_vol_info,
+		.get = aureon_ac97_vol_get,
+		.put = aureon_ac97_vol_put,
+		.private_value = AC97_CD|AUREON_AC97_STEREO,
 		.tlv = { .p = db_scale_ac97_gain }
- 	},
- 	{
- 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
- 		.name = "Aux Playback Switch",
- 		.info = aureon_ac97_mute_info,
- 		.get = aureon_ac97_mute_get,
- 		.put = aureon_ac97_mute_put,
- 		.private_value = AC97_AUX,
- 	},
- 	{
- 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Aux Playback Switch",
+		.info = aureon_ac97_mute_info,
+		.get = aureon_ac97_mute_get,
+		.put = aureon_ac97_mute_put,
+		.private_value = AC97_AUX,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
-			   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
- 		.name = "Aux Playback Volume",
- 		.info = aureon_ac97_vol_info,
- 		.get = aureon_ac97_vol_get,
- 		.put = aureon_ac97_vol_put,
- 		.private_value = AC97_AUX|AUREON_AC97_STEREO,
+				SNDRV_CTL_ELEM_ACCESS_TLV_READ),
+		.name = "Aux Playback Volume",
+		.info = aureon_ac97_vol_info,
+		.get = aureon_ac97_vol_get,
+		.put = aureon_ac97_vol_put,
+		.private_value = AC97_AUX|AUREON_AC97_STEREO,
 		.tlv = { .p = db_scale_ac97_gain }
- 	},
- 	{
- 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
- 		.name = "Line Playback Switch",
- 		.info = aureon_ac97_mute_info,
- 		.get = aureon_ac97_mute_get,
- 		.put = aureon_ac97_mute_put,
- 		.private_value = AC97_LINE
- 	},
- 	{
- 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Line Playback Switch",
+		.info = aureon_ac97_mute_info,
+		.get = aureon_ac97_mute_get,
+		.put = aureon_ac97_mute_put,
+		.private_value = AC97_LINE
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
-			   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
- 		.name = "Line Playback Volume",
- 		.info = aureon_ac97_vol_info,
- 		.get = aureon_ac97_vol_get,
- 		.put = aureon_ac97_vol_put,
- 		.private_value = AC97_LINE|AUREON_AC97_STEREO,
+				SNDRV_CTL_ELEM_ACCESS_TLV_READ),
+		.name = "Line Playback Volume",
+		.info = aureon_ac97_vol_info,
+		.get = aureon_ac97_vol_get,
+		.put = aureon_ac97_vol_put,
+		.private_value = AC97_LINE|AUREON_AC97_STEREO,
 		.tlv = { .p = db_scale_ac97_gain }
- 	},
- 	{
- 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
- 		.name = "Mic Playback Switch",
- 		.info = aureon_ac97_mute_info,
- 		.get = aureon_ac97_mute_get,
- 		.put = aureon_ac97_mute_put,
- 		.private_value = AC97_MIC
- 	},
- 	{
- 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Mic Playback Switch",
+		.info = aureon_ac97_mute_info,
+		.get = aureon_ac97_mute_get,
+		.put = aureon_ac97_mute_put,
+		.private_value = AC97_MIC
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
-			   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
- 		.name = "Mic Playback Volume",
- 		.info = aureon_ac97_vol_info,
- 		.get = aureon_ac97_vol_get,
- 		.put = aureon_ac97_vol_put,
- 		.private_value = AC97_MIC,
+				SNDRV_CTL_ELEM_ACCESS_TLV_READ),
+		.name = "Mic Playback Volume",
+		.info = aureon_ac97_vol_info,
+		.get = aureon_ac97_vol_get,
+		.put = aureon_ac97_vol_put,
+		.private_value = AC97_MIC,
 		.tlv = { .p = db_scale_ac97_gain }
- 	},
- 	{
- 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
- 		.name = "Mic Boost (+20dB)",
- 		.info = aureon_ac97_micboost_info,
- 		.get = aureon_ac97_micboost_get,
- 		.put = aureon_ac97_micboost_put
- 	}
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Mic Boost (+20dB)",
+		.info = aureon_ac97_micboost_info,
+		.get = aureon_ac97_micboost_get,
+		.put = aureon_ac97_micboost_put
+	}
 };
 
 static struct snd_kcontrol_new universe_ac97_controls[] __devinitdata = {
- 	{
- 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "AC97 Playback Switch",
 		.info = aureon_ac97_mmute_info,
 		.get = aureon_ac97_mmute_get,
 		.put = aureon_ac97_mmute_put,
 		.private_value = AC97_MASTER
- 	},
- 	{
- 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
-			   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
- 		.name = "AC97 Playback Volume",
- 		.info = aureon_ac97_vol_info,
- 		.get = aureon_ac97_vol_get,
- 		.put = aureon_ac97_vol_put,
- 		.private_value = AC97_MASTER|AUREON_AC97_STEREO,
+				SNDRV_CTL_ELEM_ACCESS_TLV_READ),
+		.name = "AC97 Playback Volume",
+		.info = aureon_ac97_vol_info,
+		.get = aureon_ac97_vol_get,
+		.put = aureon_ac97_vol_put,
+		.private_value = AC97_MASTER|AUREON_AC97_STEREO,
 		.tlv = { .p = db_scale_ac97_master }
- 	},
- 	{
- 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
- 		.name = "CD Playback Switch",
- 		.info = aureon_ac97_mute_info,
- 		.get = aureon_ac97_mute_get,
- 		.put = aureon_ac97_mute_put,
- 		.private_value = AC97_AUX
- 	},
- 	{
- 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "CD Playback Switch",
+		.info = aureon_ac97_mute_info,
+		.get = aureon_ac97_mute_get,
+		.put = aureon_ac97_mute_put,
+		.private_value = AC97_AUX
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
-			   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
- 		.name = "CD Playback Volume",
- 		.info = aureon_ac97_vol_info,
- 		.get = aureon_ac97_vol_get,
- 		.put = aureon_ac97_vol_put,
- 		.private_value = AC97_AUX|AUREON_AC97_STEREO,
+				SNDRV_CTL_ELEM_ACCESS_TLV_READ),
+		.name = "CD Playback Volume",
+		.info = aureon_ac97_vol_info,
+		.get = aureon_ac97_vol_get,
+		.put = aureon_ac97_vol_put,
+		.private_value = AC97_AUX|AUREON_AC97_STEREO,
 		.tlv = { .p = db_scale_ac97_gain }
- 	},
- 	{
- 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
- 		.name = "Phono Playback Switch",
- 		.info = aureon_ac97_mute_info,
- 		.get = aureon_ac97_mute_get,
- 		.put = aureon_ac97_mute_put,
- 		.private_value = AC97_CD
- 	},
- 	{
- 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Phono Playback Switch",
+		.info = aureon_ac97_mute_info,
+		.get = aureon_ac97_mute_get,
+		.put = aureon_ac97_mute_put,
+		.private_value = AC97_CD
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
-			   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
- 		.name = "Phono Playback Volume",
- 		.info = aureon_ac97_vol_info,
- 		.get = aureon_ac97_vol_get,
- 		.put = aureon_ac97_vol_put,
- 		.private_value = AC97_CD|AUREON_AC97_STEREO,
+				SNDRV_CTL_ELEM_ACCESS_TLV_READ),
+		.name = "Phono Playback Volume",
+		.info = aureon_ac97_vol_info,
+		.get = aureon_ac97_vol_get,
+		.put = aureon_ac97_vol_put,
+		.private_value = AC97_CD|AUREON_AC97_STEREO,
 		.tlv = { .p = db_scale_ac97_gain }
- 	},
- 	{
- 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
- 		.name = "Line Playback Switch",
- 		.info = aureon_ac97_mute_info,
- 		.get = aureon_ac97_mute_get,
- 		.put = aureon_ac97_mute_put,
- 		.private_value = AC97_LINE
- 	},
- 	{
- 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Line Playback Switch",
+		.info = aureon_ac97_mute_info,
+		.get = aureon_ac97_mute_get,
+		.put = aureon_ac97_mute_put,
+		.private_value = AC97_LINE
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
-			   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
- 		.name = "Line Playback Volume",
- 		.info = aureon_ac97_vol_info,
- 		.get = aureon_ac97_vol_get,
- 		.put = aureon_ac97_vol_put,
- 		.private_value = AC97_LINE|AUREON_AC97_STEREO,
+				SNDRV_CTL_ELEM_ACCESS_TLV_READ),
+		.name = "Line Playback Volume",
+		.info = aureon_ac97_vol_info,
+		.get = aureon_ac97_vol_get,
+		.put = aureon_ac97_vol_put,
+		.private_value = AC97_LINE|AUREON_AC97_STEREO,
 		.tlv = { .p = db_scale_ac97_gain }
- 	},
- 	{
- 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
- 		.name = "Mic Playback Switch",
- 		.info = aureon_ac97_mute_info,
- 		.get = aureon_ac97_mute_get,
- 		.put = aureon_ac97_mute_put,
- 		.private_value = AC97_MIC
- 	},
- 	{
- 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Mic Playback Switch",
+		.info = aureon_ac97_mute_info,
+		.get = aureon_ac97_mute_get,
+		.put = aureon_ac97_mute_put,
+		.private_value = AC97_MIC
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
-			   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
- 		.name = "Mic Playback Volume",
- 		.info = aureon_ac97_vol_info,
- 		.get = aureon_ac97_vol_get,
- 		.put = aureon_ac97_vol_put,
- 		.private_value = AC97_MIC,
+				SNDRV_CTL_ELEM_ACCESS_TLV_READ),
+		.name = "Mic Playback Volume",
+		.info = aureon_ac97_vol_info,
+		.get = aureon_ac97_vol_get,
+		.put = aureon_ac97_vol_put,
+		.private_value = AC97_MIC,
 		.tlv = { .p = db_scale_ac97_gain }
- 	},
- 	{
- 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
- 		.name = "Mic Boost (+20dB)",
- 		.info = aureon_ac97_micboost_info,
- 		.get = aureon_ac97_micboost_get,
- 		.put = aureon_ac97_micboost_put
- 	},
- 	{
- 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
- 		.name = "Aux Playback Switch",
- 		.info = aureon_ac97_mute_info,
- 		.get = aureon_ac97_mute_get,
- 		.put = aureon_ac97_mute_put,
- 		.private_value = AC97_VIDEO,
- 	},
- 	{
- 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Mic Boost (+20dB)",
+		.info = aureon_ac97_micboost_info,
+		.get = aureon_ac97_micboost_get,
+		.put = aureon_ac97_micboost_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Aux Playback Switch",
+		.info = aureon_ac97_mute_info,
+		.get = aureon_ac97_mute_get,
+		.put = aureon_ac97_mute_put,
+		.private_value = AC97_VIDEO,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
-			   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
- 		.name = "Aux Playback Volume",
- 		.info = aureon_ac97_vol_info,
- 		.get = aureon_ac97_vol_get,
- 		.put = aureon_ac97_vol_put,
- 		.private_value = AC97_VIDEO|AUREON_AC97_STEREO,
+				SNDRV_CTL_ELEM_ACCESS_TLV_READ),
+		.name = "Aux Playback Volume",
+		.info = aureon_ac97_vol_info,
+		.get = aureon_ac97_vol_get,
+		.put = aureon_ac97_vol_put,
+		.private_value = AC97_VIDEO|AUREON_AC97_STEREO,
 		.tlv = { .p = db_scale_ac97_gain }
- 	},
+	},
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Aux Source",
@@ -1844,43 +1869,43 @@ static struct snd_kcontrol_new universe_ac97_controls[] __devinitdata = {
 static struct snd_kcontrol_new cs8415_controls[] __devinitdata = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = SNDRV_CTL_NAME_IEC958("",CAPTURE,SWITCH),
+		.name = SNDRV_CTL_NAME_IEC958("", CAPTURE, SWITCH),
 		.info = aureon_cs8415_mute_info,
 		.get = aureon_cs8415_mute_get,
 		.put = aureon_cs8415_mute_put
 	},
- 	{
- 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = SNDRV_CTL_NAME_IEC958("",CAPTURE,NONE) "Source",
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = SNDRV_CTL_NAME_IEC958("", CAPTURE, NONE) "Source",
 		.info = aureon_cs8415_mux_info,
 		.get = aureon_cs8415_mux_get,
 		.put = aureon_cs8415_mux_put,
 	},
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
-		.name = SNDRV_CTL_NAME_IEC958("Q-subcode ",CAPTURE,DEFAULT),
+		.name = SNDRV_CTL_NAME_IEC958("Q-subcode ", CAPTURE, DEFAULT),
 		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
 		.info = aureon_cs8415_qsub_info,
 		.get = aureon_cs8415_qsub_get,
 	},
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
-		.name = SNDRV_CTL_NAME_IEC958("",CAPTURE,MASK),
+		.name = SNDRV_CTL_NAME_IEC958("", CAPTURE, MASK),
 		.access = SNDRV_CTL_ELEM_ACCESS_READ,
 		.info = aureon_cs8415_spdif_info,
 		.get = aureon_cs8415_mask_get
 	},
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
-		.name = SNDRV_CTL_NAME_IEC958("",CAPTURE,DEFAULT),
+		.name = SNDRV_CTL_NAME_IEC958("", CAPTURE, DEFAULT),
 		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
 		.info = aureon_cs8415_spdif_info,
 		.get = aureon_cs8415_spdif_get
 	},
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
-		.name = SNDRV_CTL_NAME_IEC958("",CAPTURE,NONE) "Rate",
-		.access =SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.name = SNDRV_CTL_NAME_IEC958("", CAPTURE, NONE) "Rate",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
 		.info = aureon_cs8415_rate_info,
 		.get = aureon_cs8415_rate_get
 	}
@@ -1905,15 +1930,14 @@ static int __devinit aureon_add_controls(struct snd_ice1712 *ice)
 		if (err < 0)
 			return err;
 	}
-	
+
 	if (ice->eeprom.subvendor == VT1724_SUBDEVICE_AUREON71_UNIVERSE) {
 		for (i = 0; i < ARRAY_SIZE(universe_ac97_controls); i++) {
 			err = snd_ctl_add(ice->card, snd_ctl_new1(&universe_ac97_controls[i], ice));
 			if (err < 0)
 				return err;
 		}
-	}
-	else if (ice->eeprom.subvendor != VT1724_SUBDEVICE_PRODIGY71LT &&
+	} else if (ice->eeprom.subvendor != VT1724_SUBDEVICE_PRODIGY71LT &&
 		 ice->eeprom.subvendor != VT1724_SUBDEVICE_PRODIGY71XT) {
 		for (i = 0; i < ARRAY_SIZE(ac97_controls); i++) {
 			err = snd_ctl_add(ice->card, snd_ctl_new1(&ac97_controls[i], ice));
@@ -1932,7 +1956,7 @@ static int __devinit aureon_add_controls(struct snd_ice1712 *ice)
 		else if ((id & 0x0F) != 0x01)
 			snd_printk(KERN_INFO "Detected unsupported CS8415 rev. (%c)\n", (char)((id & 0x0F) + 'A' - 1));
 		else {
-			for (i = 0; i< ARRAY_SIZE(cs8415_controls); i++) {
+			for (i = 0; i < ARRAY_SIZE(cs8415_controls); i++) {
 				struct snd_kcontrol *kctl;
 				err = snd_ctl_add(ice->card, (kctl = snd_ctl_new1(&cs8415_controls[i], ice)));
 				if (err < 0)
@@ -1943,7 +1967,7 @@ static int __devinit aureon_add_controls(struct snd_ice1712 *ice)
 		}
 		snd_ice1712_restore_gpio_status(ice);
 	}
-	
+
 	return 0;
 }
 
@@ -2059,11 +2083,12 @@ static int __devinit aureon_init(struct snd_ice1712 *ice)
 
 	/* to remeber the register values of CS8415 */
 	ice->akm = kzalloc(sizeof(struct snd_akm4xxx), GFP_KERNEL);
-	if (! ice->akm)
+	if (!ice->akm)
 		return -ENOMEM;
 	ice->akm_codecs = 1;
-	
-	if ((err = aureon_ac97_init(ice)) != 0)
+
+	err = aureon_ac97_init(ice);
+	if (err != 0)
 		return err;
 
 	snd_ice1712_gpio_set_dir(ice, 0x5fffff); /* fix this for the time being */
@@ -2086,7 +2111,7 @@ static int __devinit aureon_init(struct snd_ice1712 *ice)
 	/* initialize WM8770 codec */
 	if (ice->eeprom.subvendor == VT1724_SUBDEVICE_PRODIGY71 ||
 		ice->eeprom.subvendor == VT1724_SUBDEVICE_PRODIGY71LT ||
-	        ice->eeprom.subvendor == VT1724_SUBDEVICE_PRODIGY71XT)
+		ice->eeprom.subvendor == VT1724_SUBDEVICE_PRODIGY71XT)
 		p = wm_inits_prodigy;
 	else
 		p = wm_inits_aureon;
@@ -2105,10 +2130,10 @@ static int __devinit aureon_init(struct snd_ice1712 *ice)
 
 	snd_ice1712_restore_gpio_status(ice);
 
-        /* initialize PCA9554 pin directions & set default input*/
+	/* initialize PCA9554 pin directions & set default input */
 	aureon_pca9554_write(ice, PCA9554_DIR, 0x00);
 	aureon_pca9554_write(ice, PCA9554_OUT, 0x00);   /* internal AUX */
-	
+
 	spec->master[0] = WM_VOL_MUTE;
 	spec->master[1] = WM_VOL_MUTE;
 	for (i = 0; i < ice->num_total_dacs; i++) {
@@ -2215,12 +2240,12 @@ struct snd_ice1712_card_info snd_vt1724_aureon_cards[] __devinitdata = {
 		.eeprom_data = aureon71_eeprom,
 		.driver = "Aureon71",
 	},
- 	{
- 		.subvendor = VT1724_SUBDEVICE_AUREON71_UNIVERSE,
- 		.name = "Terratec Aureon 7.1-Universe",
+	{
+		.subvendor = VT1724_SUBDEVICE_AUREON71_UNIVERSE,
+		.name = "Terratec Aureon 7.1-Universe",
 		.model = "universe",
- 		.chip_init = aureon_init,
- 		.build_controls = aureon_add_controls,
+		.chip_init = aureon_init,
+		.build_controls = aureon_add_controls,
 		.eeprom_size = sizeof(aureon71_universe_eeprom),
 		.eeprom_data = aureon71_universe_eeprom,
 		.driver = "Aureon71Univ", /* keep in 15 letters */
