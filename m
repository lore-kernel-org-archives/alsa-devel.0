From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC WM8510 Mic PGA problem
Date: Tue, 7 Oct 2008 13:11:44 +0100
Message-ID: <20081007121144.GA5119@rakim.wolfsonmicro.main>
References: <B9D3C48C98930741A166756A50C44A610F17B555@helx1.corp.vaisala.com>
	<20081003133936.GD26035@sirena.org.uk>
	<B9D3C48C98930741A166756A50C44A610F17B556@helx1.corp.vaisala.com>
	<20081006100522.GB14087@sirena.org.uk>
	<B9D3C48C98930741A166756A50C44A610F17B55A@helx1.corp.vaisala.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9DB2124559
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Oct 2008 14:11:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <B9D3C48C98930741A166756A50C44A610F17B55A@helx1.corp.vaisala.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext-jukka.hynninen@vaisala.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 06, 2008 at 01:53:34PM +0300, ext-jukka.hynninen@vaisala.com wrote:

> The control changes state when recording starts. Playback has no effect
> on it.

Could you please give the patch below a spin?  I've not tested it but I
believe it may help.

diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 16768a5..b4997c4 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -56,6 +56,9 @@ static const u16 wm8510_reg[WM8510_CACHEREGNUM] = {
 	0x0001,
 };
 
+#define WM8510_POWER1_BIASEN  0x08
+#define WM8510_POWER1_BUFIOEN 0x10
+
 /*
  * read wm8510 register cache
  */
@@ -527,23 +530,35 @@ static int wm8510_mute(struct snd_soc_dai *dai, int mute)
 static int wm8510_set_bias_level(struct snd_soc_codec *codec,
 	enum snd_soc_bias_level level)
 {
+	u16 power1 = wm8510_read_reg_cache(codec, WM8510_POWER1) & ~0x3;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-		wm8510_write(codec, WM8510_POWER1, 0x1ff);
-		wm8510_write(codec, WM8510_POWER2, 0x1ff);
-		wm8510_write(codec, WM8510_POWER3, 0x1ff);
-		break;
 	case SND_SOC_BIAS_PREPARE:
+		power1 |= 0x1;  /* VMID 50k */
+		wm8510_write(codec, WM8510_POWER1, power1);
+		break;
+
 	case SND_SOC_BIAS_STANDBY:
+		power1 |= WM8510_POWER1_BIASEN | WM8510_POWER1_BUFIOEN;
+
+		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+			/* Initial cap charge at VMID 5k */
+			wm8510_write(codec, WM8510_POWER1, power1 | 0x3);
+			mdelay(100);
+		}
+
+		power1 |= 0x2;  /* VMID 500k */
+		wm8510_write(codec, WM8510_POWER1, power1);
 		break;
+
 	case SND_SOC_BIAS_OFF:
-		/* everything off, dac mute, inactive */
-		wm8510_write(codec, WM8510_POWER1, 0x0);
-		wm8510_write(codec, WM8510_POWER2, 0x0);
-		wm8510_write(codec, WM8510_POWER3, 0x0);
+		wm8510_write(codec, WM8510_POWER1, 0);
+		wm8510_write(codec, WM8510_POWER2, 0);
+		wm8510_write(codec, WM8510_POWER3, 0);
 		break;
 	}
+
 	codec->bias_level = level;
 	return 0;
 }
@@ -641,6 +656,7 @@ static int wm8510_init(struct snd_soc_device *socdev)
 	}
 
 	/* power on device */
+	codec->bias_level = SND_SOC_BIAS_OFF;
 	wm8510_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	wm8510_add_controls(codec);
 	wm8510_add_widgets(codec);
