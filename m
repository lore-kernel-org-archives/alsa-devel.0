From: Mark Salazar <markTheCoder@justmyself.net>
Subject: Re: [es18xx.c PATCH] #4/4 for Zoom Video - add Zoom Video support
Date: Mon, 26 Dec 2005 12:37:20 -0500
Message-ID: <43B02A50.3000601@justmyself.net>
References: <43B0105B.2080900@justmyself.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030602080502050707020800"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43B0105B.2080900@justmyself.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Mark Salazar <markTheCoder@justmyself.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030602080502050707020800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I surrender. Unable to make Thunderbird's wrapping function submit to 
my will I just attach my patch message and slink away.


--------------030602080502050707020800
Content-Type: text/plain;
 name="es18xx.CVSmod4.diff.msg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="es18xx.CVSmod4.diff.msg"

Forth of 4 es18xx.c patches culminating in Zoom Video support.

This patch adds Zoom Video support for those chipsets that support it.

Testing:
This work was initially done on the source from the Debian Sarge ALSA package, then tested
on an ES1879. I could not test the Zoom Video function for an ES1878 or ES1869.
Patches were created against the Sarge code and then edited to apply correctly to the 
ALSA cvs code. Lastly the patched ALSA cvs code was test for successful compilation. 
No additional testing was done on the ALSA cvs version.

One quirk (noted in my comments below) is that apparently the datasheet is wrong
for one of the ES1879 Zoom Video "enable" bits, because 
 1) if you set this bit it messes up PCM playback (speaker_test play a lower frequency)
 2) even if you don't set this bit Zoom Video still works.
I added a control to toggle the bit on just in case there might be a version of the
ES1879 that requires it, but I expect noone will need it.

Applying:
cd alsa-driver/
cat ../../es18xx.CVSmod4.diff |  patch -p1

Signed-off-by: Mark Salazar <markTheCoder@justmyself.net>

------
diff -Nur ../alsa-driverMod3/alsa-kernel/isa/es18xx.c ./alsa-kernel/isa/es18xx.c
--- ../alsa-driverMod3/alsa-kernel/isa/es18xx.c	2005-12-10 13:59:52.000000000 -0500
+++ ./alsa-kernel/isa/es18xx.c	2005-12-11 14:45:08.000000000 -0500
@@ -49,6 +49,10 @@
  * - contrarily to some pages in DS_1869.PDF the rates can be set
  *   independently.
  *
+ * - Zoom Video is implemented by sharing the FM DAC, thus the user can
+ *   have either FM playback or Video playback but not both simultaneously.
+ *   The Video Playback Switch mixer control toggles this choice.
+ *
  * BUGS:
  *
  * - There is a major trouble I noted:
@@ -63,6 +67,15 @@
  *
  */
 
+/*
+ * ES1879 NOTES:
+ * - When Zoom Video is enabled (reg 0x71 bit 6 toggled on) the PCM playback
+ *   seems to be effected (speaker_test plays a lower frequency). Can't find
+ *   anything in the datasheet to account for this, so a Video Playback Switch
+ *   control has been included to allow ZV to be enabled only when necessary.
+ *   Then again on at least one test system the 0x71 bit 6 enable bit is not 
+ *   needed for ZV, so maybe the datasheet is entirely wrong here.
+ */
 
 #include <sound/driver.h>
 #include <asm/io.h>
@@ -1304,17 +1317,23 @@
  */
 static char UNSETbuf = '\0';
 #define UNSET ((char *)&UNSETbuf)
-static enum optionalControlsIndex {reg1cBit4, reg3cMono, reg6d, reg6f};
+static enum optionalControlsIndex {reg1cBit4, reg3cMono, reg6d, reg6f, reg68, reg71Bit6, reg7fBit0};
 static struct snd_kcontrol_new snd_es18xx_optional_controls[] = {
 ES18XX_SINGLE(UNSET, 0, 0x1c, 4, 1, 1),
 ES18XX_SINGLE(UNSET, 0, 0x3c, 0, 7, 0),
 ES18XX_DOUBLE(UNSET, 0, 0x6d, 0x6d, 4, 0, 15, 0),
-ES18XX_DOUBLE(UNSET, 0, 0x6f, 0x6f, 4, 0, 15, 0)
+ES18XX_DOUBLE(UNSET, 0, 0x6f, 0x6f, 4, 0, 15, 0),
+ES18XX_DOUBLE(UNSET, 0, 0x68, 0x68, 4, 0, 15, 0),
+ES18XX_SINGLE(UNSET, 0, 0x71, 6, 1, 0),
+ES18XX_SINGLE(UNSET, 0, 0x7f, 0, 1, 0)
 };
 static char* captureSwitchName = "Capture Switch";
 static char* speakerPlayName = "PC Speaker Playback Volume";
 static char* monoPlayName = "Mono Playback Volume";
 static char* monoRecName = "Mono Capture Volume";
+static char* videoPlayName = "Video Playback Volume";
+static char* videoRecName = "Video Capture Volume";
+static char* videoSwitchName = "Video Playback Switch";
 
 static struct snd_kcontrol_new snd_es18xx_pcm1_controls[] = {
 ES18XX_DOUBLE("PCM Playback Volume", 0, 0x14, 0x14, 4, 0, 15, 0),
@@ -1360,7 +1379,6 @@
 ES18XX_SINGLE("Hardware Master Volume Split", 0, 0x64, 7, 1, 0),
 };
 
-#if 0
 static int __devinit snd_es18xx_config_read(struct snd_es18xx *chip, unsigned char reg)
 {
 	int data;
@@ -1371,7 +1389,6 @@
         spin_unlock_irqrestore(&chip->ctrl_lock, flags);
 	return data;
 }
-#endif
 
 static void __devinit snd_es18xx_config_write(struct snd_es18xx *chip, 
 					      unsigned char reg, unsigned char data)
@@ -1517,6 +1534,17 @@
 		snd_es18xx_mixer_write(chip, 0x58, 0x94);
 		snd_es18xx_mixer_write(chip, 0x5a, 0x80);
 	}
+	/* Flip the "enable I2S" bits for those chipsets that need it */
+	switch (chip->version) {
+	case 0x1879:
+		//Leaving I2S enabled on the 1879 screws up the PCM playback (rate effected somehow)
+		//so a Switch control has been added to toggle this 0x71 bit on/off:
+		//snd_es18xx_mixer_bits(chip, 0x71, 0x40, 0x40);
+		/* Note: we fall through on purpose here. */
+	case 0x1878:
+		snd_es18xx_config_write(chip, 0x29, snd_es18xx_config_read(chip, 0x29) | 0x40);
+		break;
+	}
 	/* Mute input source */
 	if (chip->caps & ES18XX_MUTEREC)
 		mask = 0x10;
@@ -1931,6 +1959,15 @@
 		snd_es18xx_optional_controls[reg1cBit4].name = captureSwitchName;
 		snd_es18xx_optional_controls[reg6d].name = monoPlayName;
 		snd_es18xx_optional_controls[reg6f].name = monoRecName;
+		snd_es18xx_optional_controls[reg7fBit0].name = videoSwitchName;
+		break;
+	case 0x1878:
+		snd_es18xx_optional_controls[reg68].name = videoPlayName;
+		break;
+	case 0x1879:
+		snd_es18xx_optional_controls[reg6d].name = videoPlayName;
+		snd_es18xx_optional_controls[reg6f].name = videoRecName;
+		snd_es18xx_optional_controls[reg71Bit6].name = videoSwitchName;
 		break;
 	}
 	for (idx = 0; idx < ARRAY_SIZE(snd_es18xx_optional_controls); idx++) {

--------------030602080502050707020800--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
