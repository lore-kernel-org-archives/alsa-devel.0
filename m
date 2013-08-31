From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/5] ASoC: cq93vc: Use core I/O functions
Date: Sat, 31 Aug 2013 14:08:57 +0100
Message-ID: <1377954539-7532-3-git-send-email-broonie@kernel.org>
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

Support future refactoring by using the core I/O functions rather than
calling the driver provided I/O functions directly.

Signed-off-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 sound/soc/codecs/cq93vc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/cq93vc.c b/sound/soc/codecs/cq93vc.c
index 1ba7588..424e9a4 100644
--- a/sound/soc/codecs/cq93vc.c
+++ b/sound/soc/codecs/cq93vc.c
@@ -64,13 +64,15 @@ static const struct snd_kcontrol_new cq93vc_snd_controls[] = {
 static int cq93vc_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	u8 reg = cq93vc_read(codec, DAVINCI_VC_REG09) & ~DAVINCI_VC_REG09_MUTE;
+	u8 reg;
 
 	if (mute)
-		cq93vc_write(codec, DAVINCI_VC_REG09,
-			     reg | DAVINCI_VC_REG09_MUTE);
+		reg = DAVINCI_VC_REG09_MUTE;
 	else
-		cq93vc_write(codec, DAVINCI_VC_REG09, reg);
+		reg = 0;
+
+	snd_soc_update_bits(codec, DAVINCI_VC_REG09, DAVINCI_VC_REG09_MUTE,
+			    reg);
 
 	return 0;
 }
@@ -97,18 +99,18 @@ static int cq93vc_set_bias_level(struct snd_soc_codec *codec,
 {
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-		cq93vc_write(codec, DAVINCI_VC_REG12,
+		snd_soc_write(codec, DAVINCI_VC_REG12,
 			     DAVINCI_VC_REG12_POWER_ALL_ON);
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		cq93vc_write(codec, DAVINCI_VC_REG12,
+		snd_soc_write(codec, DAVINCI_VC_REG12,
 			     DAVINCI_VC_REG12_POWER_ALL_OFF);
 		break;
 	case SND_SOC_BIAS_OFF:
 		/* force all power off */
-		cq93vc_write(codec, DAVINCI_VC_REG12,
+		snd_soc_write(codec, DAVINCI_VC_REG12,
 			     DAVINCI_VC_REG12_POWER_ALL_OFF);
 		break;
 	}
-- 
1.8.4.rc3
