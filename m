From: Mark Salazar <msalazar@justmyself.net>
Subject: Re: [es18xx.c PATCH] #4/4 for Zoom Video - add Zoom Video support
Date: Sun, 15 Jan 2006 15:37:53 -0500
Message-ID: <43CAB2A1.5020505@justmyself.net>
References: <43B0105B.2080900@justmyself.net> <43B02A50.3000601@justmyself.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020505090409040804060802"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43B02A50.3000601@justmyself.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020505090409040804060802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is a rework of patch #4 which adds Zoom Video support.
Tested only on an ES1879 system this time, but should still work for 
ES1878 and ES1869.

Applying: should use -p0 instead of -p1
cd alsa-driver/
cat ../../es18xx.CVSmod4V2.diff |  patch -p0


Signed-off-by: Mark Salazar <markTheCoder@justmyself.net>



--------------020505090409040804060802
Content-Type: text/plain;
 name="es18xx.CVSmod4V2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="es18xx.CVSmod4V2.diff"

--- alsa-kernel/isa/es18xx.c.orig	2006-01-15 11:59:50.000000000 -0500
+++ alsa-kernel/isa/es18xx.c	2006-01-15 12:00:44.000000000 -0500
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
@@ -63,7 +67,16 @@
  *
  */
 
-
+/*
+ * ES1879 NOTES:
+ * - When Zoom Video is enabled (reg 0x71 bit 6 toggled on) the PCM playback
+ *   seems to be effected (speaker_test plays a lower frequency). Can't find
+ *   anything in the datasheet to account for this, so a Video Playback Switch
+ *   control has been included to allow ZV to be enabled only when necessary.
+ *   Then again on at least one test system the 0x71 bit 6 enable bit is not 
+ *   needed for ZV, so maybe the datasheet is entirely wrong here.
+ */
+ 
 #include <sound/driver.h>
 #include <linux/init.h>
 #include <linux/err.h>
@@ -1317,10 +1330,20 @@
 
 static struct snd_kcontrol_new snd_es18xx_opt_1869[] = {
 ES18XX_SINGLE("Capture Switch", 0, 0x1c, 4, 1, 1),
+ES18XX_SINGLE("Video Playback Switch", 0, 0x7f, 0, 1, 0),
 ES18XX_DOUBLE("Mono Playback Volume", 0, 0x6d, 0x6d, 4, 0, 15, 0),
 ES18XX_DOUBLE("Mono Capture Volume", 0, 0x6f, 0x6f, 4, 0, 15, 0)
 };
 
+static struct snd_kcontrol_new snd_es18xx_opt_1878 =
+	ES18XX_DOUBLE("Video Playback Volume", 0, 0x68, 0x68, 4, 0, 15, 0);
+
+static struct snd_kcontrol_new snd_es18xx_opt_1879[] = {
+ES18XX_SINGLE("Video Playback Switch", 0, 0x71, 6, 1, 0),
+ES18XX_DOUBLE("Video Playback Volume", 0, 0x6d, 0x6d, 4, 0, 15, 0),
+ES18XX_DOUBLE("Video Capture Volume", 0, 0x6f, 0x6f, 4, 0, 15, 0)
+};
+
 static struct snd_kcontrol_new snd_es18xx_pcm1_controls[] = {
 ES18XX_DOUBLE("PCM Playback Volume", 0, 0x14, 0x14, 4, 0, 15, 0),
 };
@@ -1365,7 +1388,6 @@
 ES18XX_SINGLE("Hardware Master Volume Split", 0, 0x64, 7, 1, 0),
 };
 
-#if 0
 static int __devinit snd_es18xx_config_read(struct snd_es18xx *chip, unsigned char reg)
 {
 	int data;
@@ -1376,7 +1398,6 @@
         spin_unlock_irqrestore(&chip->ctrl_lock, flags);
 	return data;
 }
-#endif
 
 static void __devinit snd_es18xx_config_write(struct snd_es18xx *chip, 
 					      unsigned char reg, unsigned char data)
@@ -1522,6 +1543,17 @@
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
@@ -1929,6 +1961,19 @@
 			if (err < 0)
 				return err;
 		}
+	} else if (chip->version == 0x1878) {
+		err = snd_ctl_add(card, snd_ctl_new1(&snd_es18xx_opt_1878,
+						     chip));
+		if (err < 0)
+			return err;
+	} else if (chip->version == 0x1879) {
+		for (idx = 0; idx < ARRAY_SIZE(snd_es18xx_opt_1879); idx++) {
+			err = snd_ctl_add(card,
+					  snd_ctl_new1(&snd_es18xx_opt_1879[idx],
+						       chip));
+			if (err < 0)
+				return err;
+		}
 	}
 	return 0;
 }

--------------020505090409040804060802--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
