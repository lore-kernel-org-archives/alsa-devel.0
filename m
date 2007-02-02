From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/19] ASoC 0.13 WM9712 codec driver
Date: Fri, 02 Feb 2007 14:49:11 +0000
Message-ID: <1170427751.18082.153.camel@localhost.localdomain>
References: <1170427430.18082.135.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-H1HZaoWZwUcKpYlj0QHm"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1170427430.18082.135.camel@localhost.localdomain>
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


--=-H1HZaoWZwUcKpYlj0QHm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

It does help if I attach the patch :)

On Fri, 2007-02-02 at 14:43 +0000, Liam Girdwood wrote:
> This patch updates the WM9712 codec driver to the new API in ASoC 0.13.
> 
> Changes:-
> 
> o Removed DAI capabilities matching code in favour of manual matching in
> the machine drivers.
> 
> o Added DAI operations for codec and CPU interfaces.
> 
> o Removed config_sysclk() function and struct snd_soc_clock_info. No
> longer needed as clocking is now configured manually in the machine
> drivers. Also removed other clocking data from structures.
> 
> Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>

--=-H1HZaoWZwUcKpYlj0QHm
Content-Disposition: attachment; filename=asoc13-codec-wm9712.patch
Content-Type: text/x-patch; name=asoc13-codec-wm9712.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -r fc216dd0eb92 soc/codecs/wm9712.c
--- a/soc/codecs/wm9712.c	Thu Feb 01 16:52:06 2007 +0100
+++ b/soc/codecs/wm9712.c	Thu Feb 01 17:54:13 2007 +0000
@@ -33,23 +33,6 @@ static unsigned int ac97_read(struct snd
 	unsigned int reg);
 static int ac97_write(struct snd_soc_codec *codec,
 	unsigned int reg, unsigned int val);
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
-static struct snd_soc_dai_mode ac97_modes[] = {
-	{
-		.pcmfmt = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S18_3LE,
-		.pcmrate = AC97_RATES,
-		.pcmdir = AC97_DIR,
-	},
-};
 
 /*
  * WM9712 register cache
@@ -554,35 +537,38 @@ static int ac97_aux_prepare(struct snd_p
 	return ac97_write(codec, AC97_PCM_SURR_DAC_RATE, runtime->rate);
 }
 
+#define WM9712_AC97_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
+		SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
+
 struct snd_soc_codec_dai wm9712_dai[] = {
 {
 	.name = "AC97 HiFi",
 	.playback = {
 		.stream_name = "HiFi Playback",
 		.channels_min = 1,
-		.channels_max = 2,},
+		.channels_max = 2,
+		.rates = WM9712_AC97_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
 	.capture = {
 		.stream_name = "HiFi Capture",
 		.channels_min = 1,
-		.channels_max = 2,},
+		.channels_max = 2,
+		.rates = WM9712_AC97_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
 	.ops = {
 		.prepare = ac97_prepare,},
-	.caps = {
-		.num_modes = ARRAY_SIZE(ac97_modes),
-		.mode = ac97_modes,},
-	},
-	{
+},
+{
 	.name = "AC97 Aux",
 	.playback = {
 		.stream_name = "Aux Playback",
 		.channels_min = 1,
-		.channels_max = 1,},
+		.channels_max = 1,
+		.rates = WM9712_AC97_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
 	.ops = {
 		.prepare = ac97_aux_prepare,},
-	.caps = {
-		.num_modes = ARRAY_SIZE(ac97_modes),
-		.mode = ac97_modes,},
-	},
+}
 };
 EXPORT_SYMBOL_GPL(wm9712_dai);
 

--=-H1HZaoWZwUcKpYlj0QHm
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-H1HZaoWZwUcKpYlj0QHm
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-H1HZaoWZwUcKpYlj0QHm--
