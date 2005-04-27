From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: C-Port midi bug.
Date: Wed, 27 Apr 2005 16:53:28 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0504271651390.28618-100000@studcom.urz.uni-halle.de>
References: <Pine.HPX.4.33n.0504260944030.8237-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0504260944030.8237-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Geoff Beasley <songshop@bizmedia.com.au>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I wrote:
> Geoff Beasley wrote:
> > I have midi output OK but no input.
>
> This is the same old well-known bug -- for some reason, the MIDI
> interrupt isn't enabled.
>
> I think it may be possible to change the driver to use polling
> instead.

Please try this patch.


-- 
--- alsa-kernel/pci/ice1712/ice1712.h	11 Apr 2005 13:08:40 -0000	1.31
+++ alsa-kernel/pci/ice1712/ice1712.h	27 Apr 2005 14:51:11 -0000
@@ -490,7 +490,8 @@
 	char *driver;
 	int (*chip_init)(ice1712_t *);
 	int (*build_controls)(ice1712_t *);
-	unsigned int no_mpu401: 1;
+	u8 no_mpu401;
+	u8 no_mpu401_irq;
 	unsigned int eeprom_size;
 	unsigned char *eeprom_data;
 };
--- alsa-kernel/pci/ice1712/hoontech.c	27 Sep 2004 14:44:14 -0000	1.8
+++ alsa-kernel/pci/ice1712/hoontech.c	27 Apr 2005 14:51:11 -0000
@@ -302,24 +302,28 @@
 		.name = "Hoontech SoundTrack Audio DSP24",
 		.model = "dsp24",
 		.chip_init = snd_ice1712_hoontech_init,
+		.no_mpu401_irq = 1,
 	},
 	{
 		.subvendor = ICE1712_SUBDEVICE_STDSP24_VALUE,	/* a dummy id */
 		.name = "Hoontech SoundTrack Audio DSP24 Value",
 		.model = "dsp24_value",
 		.chip_init = snd_ice1712_value_init,
+		.no_mpu401_irq = 1,
 	},
 	{
 		.subvendor = ICE1712_SUBDEVICE_STDSP24_MEDIA7_1,
 		.name = "Hoontech STA DSP24 Media 7.1",
 		.model = "dsp24_71",
 		.chip_init = snd_ice1712_hoontech_init,
+		.no_mpu401_irq = 1,
 	},
 	{
 		.subvendor = ICE1712_SUBDEVICE_EVENT_EZ8,	/* a dummy id */
 		.name = "Event Electronics EZ8",
 		.model = "ez8",
 		.chip_init = snd_ice1712_ez8_init,
+		.no_mpu401_irq = 1,
 	},
 	{ } /* terminator */
 };
--- alsa-kernel/pci/ice1712/ice1712.c	11 Apr 2005 15:58:28 -0000	1.66
+++ alsa-kernel/pci/ice1712/ice1712.c	27 Apr 2005 14:51:11 -0000
@@ -2703,9 +2703,11 @@
 		}

 	if (! c->no_mpu401) {
+		int irq = c->no_mpu401_irq ? -1 : ice->irq;
+
 		if ((err = snd_mpu401_uart_new(card, 0, MPU401_HW_ICE1712,
 					       ICEREG(ice, MPU1_CTRL), 1,
-					       ice->irq, 0,
+					       irq, 0,
 					       &ice->rmidi[0])) < 0) {
 			snd_card_free(card);
 			return err;
@@ -2714,7 +2716,7 @@
 		if (ice->eeprom.data[ICE_EEP1_CODEC] & ICE1712_CFG_2xMPU401)
 			if ((err = snd_mpu401_uart_new(card, 1, MPU401_HW_ICE1712,
 						       ICEREG(ice, MPU2_CTRL), 1,
-						       ice->irq, 0,
+						       irq, 0,
 						       &ice->rmidi[1])) < 0) {
 				snd_card_free(card);
 				return err;



-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
