From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: msm8916-wcd-analog: fix micbias
	level" to the asoc tree
Date: Wed, 04 Oct 2017 12:28:33 +0100
Message-ID: <E1dzhqr-0004Mu-2x@debutante>
References: <1506716384-4700-1-git-send-email-jean-francois.tetu@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1816659375683049053=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D89732673E8
 for <alsa-devel@alsa-project.org>; Wed,  4 Oct 2017 13:28:40 +0200 (CEST)
In-Reply-To: <1506716384-4700-1-git-send-email-jean-francois.tetu@savoirfairelinux.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, =?UTF-8?q?Jean-Fran=C3=A7ois=20T=C3=AAtu?= <jean-francois.tetu@savoirfairelinux.com>
List-Id: alsa-devel@alsa-project.org

--===============1816659375683049053==
Content-Type: text/plain

The patch

   ASoC: codecs: msm8916-wcd-analog: fix micbias level

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 664611e7e02f76fbc5470ef545b2657ed25c292b Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Jean-Fran=C3=A7ois=20T=C3=AAtu?=
 <jean-francois.tetu@savoirfairelinux.com>
Date: Fri, 29 Sep 2017 16:19:44 -0400
Subject: [PATCH] ASoC: codecs: msm8916-wcd-analog: fix micbias level
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The macro used to set the microphone bias level causes the
snd_soc_write() call to overwrite other fields in the CDC_A_MICB_1_VAL
register. The macro also does not return the proper level value
to use. This fixes this by preserving all bits from the register
that are not the level while setting the level.

Signed-off-by: Jean-François Têtu <jean-francois.tetu@savoirfairelinux.com>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index 549c269acc7d..a42f8ebb9670 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -104,7 +104,7 @@
 #define CDC_A_MICB_1_VAL		(0xf141)
 #define MICB_MIN_VAL 1600
 #define MICB_STEP_SIZE 50
-#define MICB_VOLTAGE_REGVAL(v)		((v - MICB_MIN_VAL)/MICB_STEP_SIZE)
+#define MICB_VOLTAGE_REGVAL(v)		(((v - MICB_MIN_VAL)/MICB_STEP_SIZE) << 3)
 #define MICB_1_VAL_MICB_OUT_VAL_MASK	GENMASK(7, 3)
 #define MICB_1_VAL_MICB_OUT_VAL_V2P70V	((0x16)  << 3)
 #define MICB_1_VAL_MICB_OUT_VAL_V1P80V	((0x4)  << 3)
@@ -349,8 +349,9 @@ static void pm8916_wcd_analog_micbias_enable(struct snd_soc_codec *codec)
 			    | MICB_1_CTL_EXT_PRECHARG_EN_ENABLE);
 
 	if (wcd->micbias_mv) {
-		snd_soc_write(codec, CDC_A_MICB_1_VAL,
-			      MICB_VOLTAGE_REGVAL(wcd->micbias_mv));
+		snd_soc_update_bits(codec, CDC_A_MICB_1_VAL,
+				    MICB_1_VAL_MICB_OUT_VAL_MASK,
+				    MICB_VOLTAGE_REGVAL(wcd->micbias_mv));
 		/*
 		 * Special headset needs MICBIAS as 2.7V so wait for
 		 * 50 msec for the MICBIAS to reach 2.7 volts.
-- 
2.14.1


--===============1816659375683049053==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1816659375683049053==--
