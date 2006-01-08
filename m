From: Mark Salazar <msalazar@justmyself.net>
Subject: Re: Re: [es18xx.c PATCH] #2/4 for Zoom Video - resolve
 number of record sources
Date: Sun, 08 Jan 2006 18:01:27 -0500
Message-ID: <43C199C7.5050406@justmyself.net>
References: <43B01012.6080304@justmyself.net>	<43B02A26.3080408@justmyself.net> <s5h7j9ir9i9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060505060001000700030304"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7j9ir9i9.wl%tiwai@suse.de>
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
--------------060505060001000700030304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:

>I would add default to return an error here (just to be sure).
>  
>
Done

>Don't put braces for a single line.
>  
>
Done

>Please fix white spaces around braces.
>  
>
Done

New patch attached . Tested same as original version.

Also repatched and tested mods 3 & 4. No change necessary.


--------------060505060001000700030304
Content-Type: text/plain;
 name="es18xx.CVSmod2V2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="es18xx.CVSmod2V2.diff"

diff -Nur ../alsa-driverMod1/alsa-kernel/isa/es18xx.c ./alsa-kernel/isa/es18xx.c
--- ../alsa-driverMod1/alsa-kernel/isa/es18xx.c	2006-01-03 21:50:26.000000000 -0500
+++ ./alsa-kernel/isa/es18xx.c	2006-01-08 12:07:22.000000000 -0500
@@ -929,37 +929,118 @@
  *  MIXER part
  */
 
+/* Record source mux routines:
+ * Depending on the chipset this mux switches between 4, 5, or 8 possible inputs.
+ * bit table for the 4/5 source mux:
+ * reg 1C:
+ *  b2 b1 b0   muxSource
+ *   x  0  x   microphone
+ *   0  1  x   CD
+ *   1  1  0   line
+ *   1  1  1   mixer
+ * if it's "mixer" and it's a 5 source mux chipset then reg 7A bit 3 determines
+ * either the play mixer or the capture mixer.
+ *
+ * "map4Source" translates from source number to reg bit pattern
+ * "invMap4Source" translates from reg bit pattern to source number
+ */
+
 static int snd_es18xx_info_mux(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[8] = {
+	static char *texts4Source[4] = {
+		"Mic", "CD", "Line", "Master"
+	};
+	static char *texts5Source[5] = {
+		"Mic", "CD", "Line", "Master", "Mix"
+	};
+	static char *texts8Source[8] = {
 		"Mic", "Mic Master", "CD", "AOUT",
 		"Mic1", "Mix", "Line", "Master"
 	};
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
-	uinfo->value.enumerated.items = 8;
-	if (uinfo->value.enumerated.item > 7)
-		uinfo->value.enumerated.item = 7;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
+	struct snd_es18xx *chip = snd_kcontrol_chip(kcontrol);
+	switch (chip->version) {
+	case 0x1868:
+	case 0x1878:
+		uinfo->value.enumerated.items = 4;
+		if (uinfo->value.enumerated.item > 3)
+			uinfo->value.enumerated.item = 3;
+		strcpy(uinfo->value.enumerated.name, texts4Source[uinfo->value.enumerated.item]);
+		break;
+	case 0x1887:
+	case 0x1888:
+		uinfo->value.enumerated.items = 5;
+		if (uinfo->value.enumerated.item > 4)
+			uinfo->value.enumerated.item = 4;
+		strcpy(uinfo->value.enumerated.name, texts5Source[uinfo->value.enumerated.item]);
+		break;
+	case 0x1869: /* DS somewhat contradictory for 1869: could be be 5 or 8 */
+	case 0x1879:
+		uinfo->value.enumerated.items = 8;
+		if (uinfo->value.enumerated.item > 7)
+			uinfo->value.enumerated.item = 7;
+		strcpy(uinfo->value.enumerated.name, texts8Source[uinfo->value.enumerated.item]);
+		break;
+	default:
+		return -EINVAL;
+	}
 	return 0;
 }
 
 static int snd_es18xx_get_mux(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
+	static unsigned char invMap4Source[8] = {0, 0, 1, 1, 0, 0, 2, 3};
 	struct snd_es18xx *chip = snd_kcontrol_chip(kcontrol);
-	ucontrol->value.enumerated.item[0] = snd_es18xx_mixer_read(chip, 0x1c) & 0x07;
+	int muxSource = snd_es18xx_mixer_read(chip, 0x1c) & 0x07;
+	if (!(chip->version == 0x1869 || chip->version == 0x1879)) {
+		muxSource = invMap4Source[muxSource];
+		if (muxSource==3 && 
+		    (chip->version == 0x1887 || chip->version == 0x1888) &&
+		    (snd_es18xx_mixer_read(chip, 0x7a) & 0x08)
+		) 
+			muxSource = 4;
+	}
+	ucontrol->value.enumerated.item[0] = muxSource;
 	return 0;
 }
 
 static int snd_es18xx_put_mux(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
+	static unsigned char map4Source[4] = {0, 2, 6, 7};
 	struct snd_es18xx *chip = snd_kcontrol_chip(kcontrol);
 	unsigned char val = ucontrol->value.enumerated.item[0];
-	
-	if (val > 7)
+	unsigned char retVal = 0;
+
+	switch (chip->version) {
+ /* 5 source chips */
+	case 0x1887:
+	case 0x1888:
+		if (val > 4)
+			return -EINVAL;
+		if (val == 4) {
+			retVal = snd_es18xx_mixer_bits(chip, 0x7a, 0x08, 0x08) != 0x08;
+			val = 3;
+		} else
+			retVal = snd_es18xx_mixer_bits(chip, 0x7a, 0x08, 0x00) != 0x00;
+ /* 4 source chips */
+	case 0x1868:
+	case 0x1878:
+		if (val > 3)
+			return -EINVAL;
+		val = map4Source[val];
+		break;
+ /* 8 source chips */
+	case 0x1869:
+	case 0x1879:
+		if (val > 7)
+			return -EINVAL;
+		break;
+	default:
 		return -EINVAL;
-	return snd_es18xx_mixer_bits(chip, 0x1c, 0x07, val) != val;
+	}
+	return (snd_es18xx_mixer_bits(chip, 0x1c, 0x07, val) != val) || retVal;
 }
 
 static int snd_es18xx_info_spatializer_enable(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)

--------------060505060001000700030304--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
