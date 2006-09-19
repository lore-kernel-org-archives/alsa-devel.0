From: Julian Scheel <julian@jusst.de>
Subject: Re: ice1724/Audiotrak Prodigy 7.1 HiFi
Date: Tue, 19 Sep 2006 13:56:20 +0200
Message-ID: <200609191356.20534.julian@jusst.de>
References: <200609152111.03266.julian@jusst.de> <s5hlkogw6ip.wl%tiwai@suse.de>
	<200609191140.18077.julian@jusst.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_kr9DF0mDWD4ONAA"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200609191140.18077.julian@jusst.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_kr9DF0mDWD4ONAA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Dienstag, 19. September 2006 11:40 schrieb Julian Scheel:
> Am Dienstag, 19. September 2006 11:27 schrieb Takashi Iwai:
> > At Fri, 15 Sep 2006 21:11:03 +0200,
> > First you should make clear whether the codec chip is connected via
> > the vt1724's standard connection or 3-wired SPI connection via GPIO.
> > The most boards use the latter method while pontis board uses the
> > former.  In the latter case, the address is usually 2 bit, so you can
> > do a wild guess more easily.
>
> I figured out that the WM8766 is connected through a 3-wired
> SPI-connection. I also figured out that the GPIOs 16,17,18 are used.
> pontis.c already includes a SPI-implementation, but according to the WM8766
> specs (look at wolfsonmico.com) this device does not await an address, but
> only 2 bytes of data: register address/values.
> Actually trying to initializing the chip leads to silence, in comparison to
> the noise coming out before, when the chip was in default mode.
> I assume that there must be some timing problem with the data-transmission
> or similiar. I will do some more testing today.
> Maybe I'll send in a patch if I can't find a problem, anyway.

Ok, attached is now what I've done so far. (patch against 1.0.13rc2) This 
causes the WM8766 to be silent. Only way to get the noise back is restarting 
the system without the init-code.
Couldn't find a reason for that behaviour. Maybe you have an idea what could 
be wrong with that code?

-Julian

--Boundary-00=_kr9DF0mDWD4ONAA
Content-Type: text/x-diff; charset="iso-8859-1"; name="prodigy71_hifi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="prodigy71_hifi.patch"

diff -ru alsa-driver-1.0.13rc2.orig/alsa-kernel/pci/ice1712/pontis.c alsa-driver-1.0.13rc2/alsa-kernel/pci/ice1712/pontis.c
--- alsa-driver-1.0.13rc2.orig/alsa-kernel/pci/ice1712/pontis.c	2006-09-12 15:40:57.000000000 +0200
+++ alsa-driver-1.0.13rc2/alsa-kernel/pci/ice1712/pontis.c	2006-09-19 13:52:55.000000000 +0200
@@ -67,6 +67,22 @@
 #define WM_OUT_MUX		0x16
 #define WM_RESET		0x17
 
+/* WM8766 registers */
+#define WM8766_DAC_CTRL		0x02   /* DAC Control */
+#define WM8766_INT_CTRL		0x03   /* Interface Control */
+#define WM8766_DAC_CTRL2	0x09
+#define WM8766_DAC_CTRL3	0x0a
+#define WM8766_RESET		0x1f
+#define WM8766_LDA1		0x00
+#define WM8766_LDA2		0x04
+#define WM8766_LDA3		0x06
+#define WM8766_RDA1		0x01
+#define WM8766_RDA2		0x05
+#define WM8766_RDA3		0x07
+#define WM8766_MUTE1		0x0C
+#define WM8766_MUTE2		0x0F
+
+
 /*
  * GPIO
  */
@@ -75,6 +91,10 @@
 #define PONTIS_CS_RDATA		(1<<6)	/* CS8416 -> VT1720 */
 #define PONTIS_CS_WDATA		(1<<7)	/* VT1720 -> CS8416 */
 
+#define WM8766_SPI_CLK		(1<<17) /* CLK, Pin97 on ICE1724 */
+#define WM8766_SPI_MD		(1<<16) /* DATA VT1724 -> WM8766, Pin96 */
+#define WM8766_SPI_ML		(1<<18) /* Latch, Pin98 */
+
 
 /*
  * get the current register value of WM codec
@@ -353,7 +373,12 @@
 		tmp |= bit;
 	else
 		tmp &= ~bit;
-	snd_ice1712_gpio_write(ice, tmp);
+/*printk("BIT: %08x\n", bit);
+printk("GPIO W: %08x\n", tmp);*/
+        snd_ice1712_gpio_write(ice, tmp);
+/*        udelay(1);
+tmp = snd_ice1712_gpio_read(ice);
+printk("GPIO R: %08x\n", tmp);*/
 }
 
 static void spi_send_byte(struct snd_ice1712 *ice, unsigned char data)
@@ -428,6 +453,39 @@
 	return val;
 }
 
+/*
+ * SPI implementation for WM8766 codec - only writing supported, no readback
+ */
+
+static void wm8766_spi_send_byte(struct snd_ice1712 *ice, unsigned char data)
+{
+	int i;
+	for (i = 0; i < 8; i++) {
+		set_gpio_bit(ice, WM8766_SPI_CLK, 0);
+		udelay(1);
+		set_gpio_bit(ice, WM8766_SPI_MD, data & 0x80);
+		udelay(1);
+		set_gpio_bit(ice, WM8766_SPI_CLK, 1);
+		udelay(1);
+		data <<= 1;
+	}
+}
+
+static void wm8766_spi_write(struct snd_ice1712 *ice, unsigned int reg, unsigned int data)
+{
+	snd_ice1712_gpio_set_dir(ice, WM8766_SPI_MD|WM8766_SPI_CLK|WM8766_SPI_ML);
+	snd_ice1712_gpio_set_mask(ice, ~(WM8766_SPI_MD|WM8766_SPI_CLK|WM8766_SPI_ML));
+	set_gpio_bit(ice, WM8766_SPI_ML, 0); /* latch must be low when writing */
+	wm8766_spi_send_byte(ice, reg); /* REGISTER ADDRESS */
+	wm8766_spi_send_byte(ice, data); /* DATA */
+	/* release latch */
+	set_gpio_bit(ice, WM8766_SPI_ML, 1);
+	udelay(1);
+	/* restore */
+	snd_ice1712_gpio_set_mask(ice, ice->gpio.write_mask);
+	snd_ice1712_gpio_set_dir(ice, ice->gpio.direction);
+}
+
 
 /*
  * SPDIF input source
@@ -776,6 +834,21 @@
 		WM_DAC_MUTE,	0x0000,	/* DAC unmute */
 		WM_ADC_MUX,	0x0003,	/* ADC unmute, both CD/Line On */
 	};
+        static unsigned short wm8766_inits[] = {
+/*                WM8766_RESET,		0x01,*/
+		WM8766_DAC_CTRL,	0x90,
+                WM8766_INT_CTRL,	0x22, /* I2S Normal Mode, 24 bit */
+                WM8766_DAC_CTRL2,	0x00,
+		WM8766_DAC_CTRL3,	0x10,
+		WM8766_LDA1,		0xff,
+		WM8766_LDA2,		0xff,
+		WM8766_LDA3,		0xff,
+		WM8766_RDA1,		0xff,
+		WM8766_RDA2,		0xff,
+		WM8766_RDA3,		0xff,
+		WM8766_MUTE1,		0x20,
+		WM8766_MUTE2,		0x10,
+        };
 	static unsigned char cs_inits[] = {
 		0x04,	0x80,	/* RUN, RXP0 */
 		0x05,	0x05,	/* slave, 24bit */
@@ -788,12 +861,19 @@
 	ice->vt1720 = 1;
 	ice->num_total_dacs = 2;
 	ice->num_total_adcs = 2;
+	ice->akm_codecs = 1;
+
+        switch (ice->eeprom.subvendor) {
+        case VT1720_SUBDEVICE_PRODIGY71_HIFI:
+		ice->vt1720 = 0;
+                ice->num_total_dacs = 8;
+                ice->akm_codecs = 2;
+        }
 
 	/* to remeber the register values */
-	ice->akm = kzalloc(sizeof(struct snd_akm4xxx), GFP_KERNEL);
+        ice->akm = kcalloc(ice->akm_codecs, sizeof(struct snd_akm4xxx), GFP_KERNEL);
 	if (! ice->akm)
 		return -ENOMEM;
-	ice->akm_codecs = 1;
 
 	/* HACK - use this as the SPDIF source.
 	 * don't call snd_ice1712_gpio_get/put(), otherwise it's overwritten
@@ -807,6 +887,13 @@
 	for (i = 0; i < ARRAY_SIZE(wm_inits2); i += 2)
 		wm_put(ice, wm_inits2[i], wm_inits2[i+1]);
 
+        /* initialize WM8766 codec */
+        for (i = 0; i < ARRAY_SIZE(wm8766_inits); i += 2)
+{
+printk("SET WM8766 REGISTER\n");
+                wm8766_spi_write(ice, wm8766_inits[i], wm8766_inits[i+1]);
+}
+
 	/* initialize CS8416 codec */
 	/* assert PRST#; MT05 bit 7 */
 	outb(inb(ICEMT1724(ice, AC97_CMD)) | 0x80, ICEMT1724(ice, AC97_CMD));
@@ -853,5 +940,14 @@
 		.eeprom_size = sizeof(pontis_eeprom),
 		.eeprom_data = pontis_eeprom,
 	},
+	{
+		.subvendor = VT1720_SUBDEVICE_PRODIGY71_HIFI,
+		.name = "Audiotrak Prodigy 7.1 HiFi",
+		.model = "prodigy71hifi",
+		.chip_init = pontis_init,
+		.build_controls = pontis_add_controls,
+		.eeprom_size = sizeof(pontis_eeprom),
+		.eeprom_data = pontis_eeprom,
+	},
 	{ } /* terminator */
 };
Only in alsa-driver-1.0.13rc2/alsa-kernel/pci/ice1712: pontis.c.orig
diff -ru alsa-driver-1.0.13rc2.orig/alsa-kernel/pci/ice1712/pontis.h alsa-driver-1.0.13rc2/alsa-kernel/pci/ice1712/pontis.h
--- alsa-driver-1.0.13rc2.orig/alsa-kernel/pci/ice1712/pontis.h	2006-09-12 15:40:57.000000000 +0200
+++ alsa-driver-1.0.13rc2/alsa-kernel/pci/ice1712/pontis.h	2006-09-19 13:52:55.000000000 +0200
@@ -27,6 +27,7 @@
 #define PONTIS_DEVICE_DESC 	       "{Pontis,MS300},"
 
 #define VT1720_SUBDEVICE_PONTIS_MS300	0x00020002	/* a dummy id for MS300 */
+#define VT1720_SUBDEVICE_PRODIGY71_HIFI	0x38315441	/* audiotrak prodigy */
 
 extern struct snd_ice1712_card_info  snd_vt1720_pontis_cards[];
 

--Boundary-00=_kr9DF0mDWD4ONAA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_kr9DF0mDWD4ONAA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--Boundary-00=_kr9DF0mDWD4ONAA--
