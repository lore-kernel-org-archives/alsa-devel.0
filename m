From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 5/5] ASoC: cq93vc: Use regmap for I/O
Date: Sat, 31 Aug 2013 14:08:59 +0100
Message-ID: <1377954539-7532-5-git-send-email-broonie@kernel.org>
References: <20130831130741.GG18608@sirena.org.uk>
	<1377954539-7532-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1377954539-7532-1-git-send-email-broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Miguel Aguilar <miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Avoid use of the ASoC-specific register I/O functions by converting to
use the MMIO regmap provided the core MFD.

Signed-off-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 sound/soc/codecs/cq93vc.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/cq93vc.c b/sound/soc/codecs/cq93vc.c
index 2cbb584..43737a27 100644
--- a/sound/soc/codecs/cq93vc.c
+++ b/sound/soc/codecs/cq93vc.c
@@ -38,24 +38,6 @@
 #include <sound/soc.h>
 #include <sound/initval.h>
 
-static inline unsigned int cq93vc_read(struct snd_soc_codec *codec,
-						unsigned int reg)
-{
-	struct davinci_vc *davinci_vc = codec->control_data;
-
-	return readl(davinci_vc->base + reg);
-}
-
-static inline int cq93vc_write(struct snd_soc_codec *codec, unsigned int reg,
-		       unsigned int value)
-{
-	struct davinci_vc *davinci_vc = codec->control_data;
-
-	writel(value, davinci_vc->base + reg);
-
-	return 0;
-}
-
 static const struct snd_kcontrol_new cq93vc_snd_controls[] = {
 	SOC_SINGLE("PGA Capture Volume", DAVINCI_VC_REG05, 0, 0x03, 0),
 	SOC_SINGLE("Mono DAC Playback Volume", DAVINCI_VC_REG09, 0, 0x3f, 0),
@@ -156,7 +138,9 @@ static int cq93vc_probe(struct snd_soc_codec *codec)
 	struct davinci_vc *davinci_vc = codec->dev->platform_data;
 
 	davinci_vc->cq93vc.codec = codec;
-	codec->control_data = davinci_vc;
+	codec->control_data = davinci_vc->regmap;
+
+	snd_soc_codec_set_cache_io(codec, 32, 32, SND_SOC_REGMAP);
 
 	/* Off, with power on */
 	cq93vc_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
@@ -172,8 +156,6 @@ static int cq93vc_remove(struct snd_soc_codec *codec)
 }
 
 static struct snd_soc_codec_driver soc_codec_dev_cq93vc = {
-	.read = cq93vc_read,
-	.write = cq93vc_write,
 	.set_bias_level = cq93vc_set_bias_level,
 	.probe = cq93vc_probe,
 	.remove = cq93vc_remove,
-- 
1.8.4.rc3
