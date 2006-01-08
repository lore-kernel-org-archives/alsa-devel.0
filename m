From: Mark Salazar <msalazar@justmyself.net>
Subject: Re: [es18xx.c PATCH] #1/4 for Zoom Video - resolve common
 vs chipset specific mixer controls
Date: Sun, 08 Jan 2006 18:01:21 -0500
Message-ID: <43C199C1.1050301@justmyself.net>
References: <43B00FF2.6030007@justmyself.net>	<1135613234.8293.38.camel@mindpipe>	<43B02A0E.20401@justmyself.net> <s5h8xtyr9oh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040809010105040901080408"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8xtyr9oh.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040809010105040901080408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:

>This doesn't work for the multiple cards because you overwrite the
>static array.  
>
Yup. Good catch. Chalk up another one for peer review.

>Better to create once kcontrol instaces via
>snd_ctl_new1(), then copy the name on each instance according to the
>model.
>  
>
Hmmm .. what if I just reset it to UNSET in the loop where it's used (as 
this patch does)?

New patch attached . Tested same as original version.


--------------040809010105040901080408
Content-Type: text/plain;
 name="es18xx.CVSmod1V2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="es18xx.CVSmod1V2.diff"

diff -Nur ../alsa-driver/alsa-kernel/isa/es18xx.c ./alsa-kernel/isa/es18xx.c
--- ../alsa-driver/alsa-kernel/isa/es18xx.c	2004-12-15 10:26:10.000000000 -0500
+++ ./alsa-kernel/isa/es18xx.c	2006-01-03 21:50:26.000000000 -0500
@@ -1181,19 +1181,22 @@
 	return change;
 }
 
+/* Mixer controls
+ * These arrays contain setup data for mixer controls.
+ * 
+ * The controls that are universal to all chipsets are fully initialized
+ * here.
+ */
 static struct snd_kcontrol_new snd_es18xx_base_controls[] = {
 ES18XX_DOUBLE("Master Playback Volume", 0, 0x60, 0x62, 0, 0, 63, 0),
 ES18XX_DOUBLE("Master Playback Switch", 0, 0x60, 0x62, 6, 6, 1, 1),
 ES18XX_DOUBLE("Line Playback Volume", 0, 0x3e, 0x3e, 4, 0, 15, 0),
 ES18XX_DOUBLE("CD Playback Volume", 0, 0x38, 0x38, 4, 0, 15, 0),
 ES18XX_DOUBLE("FM Playback Volume", 0, 0x36, 0x36, 4, 0, 15, 0),
-ES18XX_DOUBLE("Mono Playback Volume", 0, 0x6d, 0x6d, 4, 0, 15, 0),
 ES18XX_DOUBLE("Mic Playback Volume", 0, 0x1a, 0x1a, 4, 0, 15, 0),
 ES18XX_DOUBLE("Aux Playback Volume", 0, 0x3a, 0x3a, 4, 0, 15, 0),
-ES18XX_SINGLE("PC Speaker Playback Volume", 0, 0x3c, 0, 7, 0),
 ES18XX_SINGLE("Record Monitor", 0, 0xa8, 3, 1, 0),
 ES18XX_DOUBLE("Capture Volume", 0, 0xb4, 0xb4, 4, 0, 15, 0),
-ES18XX_SINGLE("Capture Switch", 0, 0x1c, 4, 1, 1),
 {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Capture Source",
@@ -1203,19 +1206,34 @@
 }
 };
 
-static struct snd_kcontrol_new snd_es18xx_mono_in_control = 
-ES18XX_DOUBLE("Mono Input Playback Volume", 0, 0x6d, 0x6d, 4, 0, 15, 0);
-
 static struct snd_kcontrol_new snd_es18xx_recmix_controls[] = {
 ES18XX_DOUBLE("PCM Capture Volume", 0, 0x69, 0x69, 4, 0, 15, 0),
 ES18XX_DOUBLE("Mic Capture Volume", 0, 0x68, 0x68, 4, 0, 15, 0),
 ES18XX_DOUBLE("Line Capture Volume", 0, 0x6e, 0x6e, 4, 0, 15, 0),
 ES18XX_DOUBLE("FM Capture Volume", 0, 0x6b, 0x6b, 4, 0, 15, 0),
-ES18XX_DOUBLE("Mono Capture Volume", 0, 0x6f, 0x6f, 4, 0, 15, 0),
 ES18XX_DOUBLE("CD Capture Volume", 0, 0x6a, 0x6a, 4, 0, 15, 0),
 ES18XX_DOUBLE("Aux Capture Volume", 0, 0x6c, 0x6c, 4, 0, 15, 0)
 };
 
+/*
+ * These chipset specific mixer controls are initialized in
+ * snd_es18xx_mixer. Those controls which are not UNSET are then
+ * instantiated.
+ */
+static char UNSETbuf = '\0';
+#define UNSET ((char *)&UNSETbuf)
+static enum optionalControlsIndex {reg1cBit4, reg3cMono, reg6d, reg6f};
+static struct snd_kcontrol_new snd_es18xx_optional_controls[] = {
+ES18XX_SINGLE(UNSET, 0, 0x1c, 4, 1, 1),
+ES18XX_SINGLE(UNSET, 0, 0x3c, 0, 7, 0),
+ES18XX_DOUBLE(UNSET, 0, 0x6d, 0x6d, 4, 0, 15, 0),
+ES18XX_DOUBLE(UNSET, 0, 0x6f, 0x6f, 4, 0, 15, 0)
+};
+static char* captureSwitchName = "Capture Switch";
+static char* speakerPlayName = "PC Speaker Playback Volume";
+static char* monoPlayName = "Mono Playback Volume";
+static char* monoRecName = "Mono Capture Volume";
+
 static struct snd_kcontrol_new snd_es18xx_pcm1_controls[] = {
 ES18XX_DOUBLE("PCM Playback Volume", 0, 0x14, 0x14, 4, 0, 15, 0),
 };
@@ -1466,11 +1484,14 @@
 	}
 			
         outb(0x40, chip->port + 0x04);
+	udelay(10);
 	hi = inb(chip->port + 0x05);
+	udelay(10);
 	lo = inb(chip->port + 0x05);
 	if (hi != lo) {
 		chip->version = hi << 8 | lo;
 		chip->ctrl_port = inb(chip->port + 0x05) << 8;
+		udelay(10);
 		chip->ctrl_port += inb(chip->port + 0x05);
 
 		if ((chip->res_ctrl_port = request_region(chip->ctrl_port, 8, "ES18xx - CTRL")) == NULL) {
@@ -1744,7 +1765,7 @@
 static int __devinit snd_es18xx_mixer(struct snd_es18xx *chip)
 {
 	struct snd_card *card;
-	int err;
+	int err, retVal;
 	unsigned int idx;
 
 	card = chip->card;
@@ -1781,10 +1802,6 @@
 		}
 	}
 
-	if (chip->caps & ES18XX_MONO) {
-		if ((err = snd_ctl_add(card, snd_ctl_new1(&snd_es18xx_mono_in_control, chip))) < 0)
-			return err;
-	}
 	if (chip->caps & ES18XX_RECMIX) {
 		for (idx = 0; idx < ARRAY_SIZE(snd_es18xx_recmix_controls); idx++) {
 			if ((err = snd_ctl_add(card, snd_ctl_new1(&snd_es18xx_recmix_controls[idx], chip))) < 0)
@@ -1822,7 +1839,27 @@
 			
 		}
 	}
-	return 0;
+/* finish initializing other chipset specific controls
+ */
+	if (chip->version != 0x1868) {
+		snd_es18xx_optional_controls[reg3cMono].name = speakerPlayName;
+	}
+	switch (chip->version) {
+	case 0x1869:
+		snd_es18xx_optional_controls[reg1cBit4].name = captureSwitchName;
+		snd_es18xx_optional_controls[reg6d].name = monoPlayName;
+		snd_es18xx_optional_controls[reg6f].name = monoRecName;
+		break;
+	}
+	retVal = 0;
+	for (idx = 0; idx < ARRAY_SIZE(snd_es18xx_optional_controls); idx++) {
+		if (snd_es18xx_optional_controls[idx].name == UNSET)
+			continue;
+		if ((err = snd_ctl_add(card, snd_ctl_new1(&snd_es18xx_optional_controls[idx], chip))) < 0)
+			retVal = err;
+		snd_es18xx_optional_controls[idx].name = UNSET;
+	}
+	return retVal;
 }
        

--------------040809010105040901080408--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
