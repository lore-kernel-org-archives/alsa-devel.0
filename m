From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH] mixer name changes for older OSS app support
Date: Thu, 09 Nov 2006 14:02:32 +0000
Message-ID: <1163080952.7722.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-oPZWwdbKVloDNHmAVVku"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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
List-Id: alsa-devel@alsa-project.org


--=-oPZWwdbKVloDNHmAVVku
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch suggested by Richard Purdie changes the names of some WM8731
and WM8750 mixers so that they will be recognised by some older OSS
mixer apps.

Changes:-

 o WM8731 Playback changed to Master Playback
 o WM8750 Out1 changed to Headphone
 o WM8750 Out2 changed to Speaker

Signed-off-by Liam Girdwood <lg@opensource.wolfsonmicro.com>


--=-oPZWwdbKVloDNHmAVVku
Content-Disposition: attachment; filename=oss-emu-mixer.patch
Content-Type: text/x-patch; name=oss-emu-mixer.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 18d936558379 soc/codecs/wm8731.c
--- a/soc/codecs/wm8731.c	Wed Nov 08 15:50:41 2006 +0100
+++ b/soc/codecs/wm8731.c	Thu Nov 09 13:42:31 2006 +0000
@@ -310,8 +310,10 @@ static const struct soc_enum wm8731_enum
 
 static const struct snd_kcontrol_new wm8731_snd_controls[] = {
 
-SOC_DOUBLE_R("Playback Volume", WM8731_LOUT1V, WM8731_ROUT1V, 0, 127, 0),
-SOC_DOUBLE_R("Playback ZC Switch", WM8731_LOUT1V, WM8731_ROUT1V, 7, 1, 0),
+SOC_DOUBLE_R("Master Playback Volume", WM8731_LOUT1V, WM8731_ROUT1V,
+	0, 127, 0),
+SOC_DOUBLE_R("Master Playback ZC Switch", WM8731_LOUT1V, WM8731_ROUT1V,
+	7, 1, 0),
 
 SOC_DOUBLE_R("Capture Volume", WM8731_LINVOL, WM8731_RINVOL, 0, 31, 0),
 SOC_DOUBLE_R("Line Capture Switch", WM8731_LINVOL, WM8731_RINVOL, 7, 1, 1),
diff -r 18d936558379 soc/codecs/wm8750.c
--- a/soc/codecs/wm8750.c	Wed Nov 08 15:50:41 2006 +0100
+++ b/soc/codecs/wm8750.c	Thu Nov 09 13:45:30 2006 +0000
@@ -444,9 +444,9 @@ SOC_DOUBLE_R("Capture ZC Switch", WM8750
 SOC_DOUBLE_R("Capture ZC Switch", WM8750_LINVOL, WM8750_RINVOL, 6, 1, 0),
 SOC_DOUBLE_R("Capture Switch", WM8750_LINVOL, WM8750_RINVOL, 7, 1, 1),
 
-SOC_DOUBLE_R("Out1 Playback ZC Switch", WM8750_LOUT1V,
+SOC_DOUBLE_R("Headphone Playback ZC Switch", WM8750_LOUT1V,
 	WM8750_ROUT1V, 7, 1, 0),
-SOC_DOUBLE_R("Out2 Playback ZC Switch", WM8750_LOUT2V,
+SOC_DOUBLE_R("Speaker Playback ZC Switch", WM8750_LOUT2V,
 	WM8750_ROUT2V, 7, 1, 0),
 
 SOC_ENUM("Playback De-emphasis", wm8750_enum[15]),
@@ -487,7 +487,7 @@ SOC_SINGLE("ZC Timeout Switch", WM8750_A
 SOC_SINGLE("ZC Timeout Switch", WM8750_ADCTL1, 0, 1, 0),
 SOC_SINGLE("Playback Invert Switch", WM8750_ADCTL1, 1, 1, 0),
 
-SOC_SINGLE("Right Out2 Playback Invert Switch", WM8750_ADCTL2, 4, 1, 0),
+SOC_SINGLE("Right Speaker Playback Invert Switch", WM8750_ADCTL2, 4, 1, 0),
 
 /* Unimplemented */
 /* ADCDAC Bit 0 - ADCHPD */
@@ -514,8 +514,10 @@ SOC_DOUBLE_R("Bypass Mono Playback Volum
 
 SOC_SINGLE("Mono Playback ZC Switch", WM8750_MOUTV, 7, 1, 0),
 
-SOC_DOUBLE_R("Out1 Playback Volume", WM8750_LOUT1V, WM8750_ROUT1V, 0, 127, 0),
-SOC_DOUBLE_R("Out2 Playback Volume", WM8750_LOUT2V, WM8750_ROUT2V, 0, 127, 0),
+SOC_DOUBLE_R("Headphone Playback Volume", WM8750_LOUT1V, WM8750_ROUT1V,
+	0, 127, 0),
+SOC_DOUBLE_R("Speaker Playback Volume", WM8750_LOUT2V, WM8750_ROUT2V,
+	0, 127, 0),
 
 SOC_SINGLE("Mono Playback Volume", WM8750_MOUTV, 0, 127, 0),
 

--=-oPZWwdbKVloDNHmAVVku
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-oPZWwdbKVloDNHmAVVku
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-oPZWwdbKVloDNHmAVVku--
