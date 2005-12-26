From: Mark Salazar <markTheCoder@justmyself.net>
Subject: Re: [es18xx.c PATCH] #3/4 for Zoom Video - change Hardware Volume
 interrupt handling
Date: Mon, 26 Dec 2005 12:37:15 -0500
Message-ID: <43B02A4B.50601@justmyself.net>
References: <43B01035.7060604@justmyself.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070903040702030704020804"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43B01035.7060604@justmyself.net>
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
--------------070903040702030704020804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I surrender. Unable to make Thunderbird's wrapping function submit to 
my will I just attach my patch message and slink away.


--------------070903040702030704020804
Content-Type: text/plain;
 name="es18xx.CVSmod3.diff.msg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="es18xx.CVSmod3.diff.msg"

Third of 4 es18xx.c patches culminating in Zoom Video support.

This patch changes the Hardware Volume support to reflect the fact that not all of the
supported chipsets have seperate registers dedicated to the Hardware Volume inputs. Although
all the chipsets can generate an HWV interrupt whenever a Hardware Volume input is received
only those with seperate HWV registers can split the HWV registers from the Master volume 
registers.

Testing:
This work was initially done on the source from the Debian Sarge ALSA package, then tested
on an ES1879 and an ES1878 machine. Patches were created against the Sarge code and then edited
to apply correctly to the ALSA cvs code. Lastly the patched ALSA cvs code was test for
successful compilation. No additional testing was done on the ALSA cvs version.

Applying:
cd alsa-driver/
cat ../../es18xx.CVSmod3.diff |  patch -p1

Signed-off-by: Mark Salazar <markTheCoder@justmyself.net>

------
diff -Nur ../alsa-driverMod2/alsa-kernel/isa/es18xx.c ./alsa-kernel/isa/es18xx.c
--- ../alsa-driverMod2/alsa-kernel/isa/es18xx.c	2005-12-10 13:59:42.000000000 -0500
+++ ./alsa-kernel/isa/es18xx.c	2005-12-10 13:59:52.000000000 -0500
@@ -140,7 +140,7 @@
 #define ES18XX_DUPLEX_SAME 0x0010	/* Playback and record must share the same rate */
 #define ES18XX_NEW_RATE	0x0020	/* More precise rate setting */
 #define ES18XX_AUXB	0x0040	/* AuxB mixer control */
-#define ES18XX_HWV	0x0080	/* Has hardware volume */
+#define ES18XX_HWV	0x0080	/* Has seperate hardware volume mixer controls*/
 #define ES18XX_MONO	0x0100	/* Mono_in mixer control */
 #define ES18XX_I2S	0x0200	/* I2S mixer control */
 #define ES18XX_MUTEREC	0x0400	/* Record source can be muted */
@@ -778,9 +778,12 @@
 
 	/* Hardware volume */
 	if (status & HWV_IRQ) {
-		int split = snd_es18xx_mixer_read(chip, 0x64) & 0x80;
-		snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE, &chip->hw_switch->id);
-		snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE, &chip->hw_volume->id);
+		int split = 0;
+		if (chip->caps & ES18XX_HWV) {
+			split = snd_es18xx_mixer_read(chip, 0x64) & 0x80;
+			snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE, &chip->hw_switch->id);
+			snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE, &chip->hw_volume->id);
+		}
 		if (!split) {
 			snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE, &chip->master_switch->id);
 			snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE, &chip->master_volume->id);
@@ -1609,22 +1612,22 @@
 
 	switch (chip->version) {
 	case 0x1868:
-		chip->caps = ES18XX_DUPLEX_MONO | ES18XX_DUPLEX_SAME | ES18XX_CONTROL | ES18XX_HWV;
+		chip->caps = ES18XX_DUPLEX_MONO | ES18XX_DUPLEX_SAME | ES18XX_CONTROL;
 		break;
 	case 0x1869:
 		chip->caps = ES18XX_PCM2 | ES18XX_SPATIALIZER | ES18XX_RECMIX | ES18XX_NEW_RATE | ES18XX_AUXB | ES18XX_MONO | ES18XX_MUTEREC | ES18XX_CONTROL | ES18XX_HWV;
 		break;
 	case 0x1878:
-		chip->caps = ES18XX_DUPLEX_MONO | ES18XX_DUPLEX_SAME | ES18XX_I2S | ES18XX_CONTROL | ES18XX_HWV;
+		chip->caps = ES18XX_DUPLEX_MONO | ES18XX_DUPLEX_SAME | ES18XX_I2S | ES18XX_CONTROL;
 		break;
 	case 0x1879:
 		chip->caps = ES18XX_PCM2 | ES18XX_SPATIALIZER | ES18XX_RECMIX | ES18XX_NEW_RATE | ES18XX_AUXB | ES18XX_I2S | ES18XX_CONTROL | ES18XX_HWV;
 		break;
 	case 0x1887:
-		chip->caps = ES18XX_PCM2 | ES18XX_RECMIX | ES18XX_AUXB | ES18XX_DUPLEX_SAME | ES18XX_HWV;
+		chip->caps = ES18XX_PCM2 | ES18XX_RECMIX | ES18XX_AUXB | ES18XX_DUPLEX_SAME;
 		break;
 	case 0x1888:
-		chip->caps = ES18XX_PCM2 | ES18XX_RECMIX | ES18XX_AUXB | ES18XX_DUPLEX_SAME | ES18XX_HWV;
+		chip->caps = ES18XX_PCM2 | ES18XX_RECMIX | ES18XX_AUXB | ES18XX_DUPLEX_SAME;
 		break;
 	default:
                 snd_printk("[0x%lx] unsupported chip ES%x\n",

--------------070903040702030704020804--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
