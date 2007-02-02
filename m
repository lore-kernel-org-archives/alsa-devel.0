From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: [PATCH 7/19] ASoC 0.13 generic AC97 codec
Date: Fri, 02 Feb 2007 14:44:40 +0000
Message-ID: <1170427480.18082.136.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-rUFqdyNrDSzr4txlzMz/"
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--=-rUFqdyNrDSzr4txlzMz/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch updates the AC97 codec driver to the new API in ASoC 0.13.

Changes:-

o Removed DAI capabilities matching code in favour of manual matching in
the machine drivers.


Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>


Privacy & Confidentiality Notice
-------------------------------------------------
This message and any attachments contain privileged and confidential information that is intended solely for the person(s) to whom it is addressed. If you are not an intended recipient you must not: read; copy; distribute; discuss; take any action in or make any reliance upon the contents of this message; nor open or read any attachment. If you have received this message in error, please notify us as soon as possible on the following telephone number and destroy this message including any attachments. Thank you.
-------------------------------------------------
Wolfson Microelectronics plc
Tel: +44 (0)131 272 7000
Fax: +44 (0)131 272 7001
Web: www.wolfsonmicro.com

Registered in Scotland

Company number SC089839

Registered office: 

Westfield House, 26 Westfield Road, Edinburgh, EH11 2QB, UK


--=-rUFqdyNrDSzr4txlzMz/
Content-Disposition: attachment; filename="asoc13-codec-ac97.patch"
Content-Type: text/x-patch; name="asoc13-codec-ac97.patch"; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r fc216dd0eb92 soc/codecs/ac97.c
--- a/soc/codecs/ac97.c	Thu Feb 01 16:52:06 2007 +0100
+++ b/soc/codecs/ac97.c	Fri Feb 02 10:29:02 2007 +0000
@@ -26,22 +26,7 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 
-#define AC97_VERSION "0.5"
-
-#define AC97_DIR \
-	(SND_SOC_DAIDIR_PLAYBACK | SND_SOC_DAIDIR_CAPTURE)
-
-#define AC97_RATES \
-	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
-	SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
-	SNDRV_PCM_RATE_48000)
-
-/* may need to expand this */
-static struct snd_soc_dai_mode soc_ac97[] = {
-	{0, 0,	SNDRV_PCM_FMTBIT_S16_LE,	AC97_RATES},
-	{0, 0,	SNDRV_PCM_FMTBIT_S18_3LE,	AC97_RATES},
-	{0, 0,	SNDRV_PCM_FMTBIT_S20_3LE,	AC97_RATES},
-};
+#define AC97_VERSION "0.6"
 
 static int ac97_prepare(struct snd_pcm_substream *substream)
 {
@@ -55,21 +40,25 @@ static int ac97_prepare(struct snd_pcm_s
 	return snd_ac97_set_rate(codec->ac97, reg, runtime->rate);
 }
 
+#define STD_AC97_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
+		SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
+
 static struct snd_soc_codec_dai ac97_dai = {
 	.name = "AC97 HiFi",
 	.playback = {
 		.stream_name = "AC97 Playback",
 		.channels_min = 1,
-		.channels_max = 2,},
+		.channels_max = 2,
+		.rates = STD_AC97_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
 	.capture = {
 		.stream_name = "AC97 Capture",
 		.channels_min = 1,
-		.channels_max = 2,},
+		.channels_max = 2,
+		.rates = STD_AC97_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
 	.ops = {
 		.prepare = ac97_prepare,},
-	.caps = {
-		.num_modes = ARRAY_SIZE(soc_ac97),
-		.mode = soc_ac97,},
 };
 
 static unsigned int ac97_read(struct snd_soc_codec *codec,

--=-rUFqdyNrDSzr4txlzMz/
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-rUFqdyNrDSzr4txlzMz/
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-rUFqdyNrDSzr4txlzMz/--
