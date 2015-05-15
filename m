From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/8] ASoC: sn95031: Replace direct
	snd_soc_codec dapm field access
Date: Fri, 15 May 2015 12:32:53 +0200
Message-ID: <1431685980-6600-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-168.synserver.de (smtp-out-168.synserver.de
 [212.40.185.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A5992608C7
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2015 12:33:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

The dapm field of the snd_soc_codec struct is eventually going to be
removed, in preparation for this replace all manual access to
codec->dapm.bias_level with snd_soc_codec_get_bias_level().

While we are at it also replace the if(x == A) ... else if(x == B) ...
construct with a switch-case.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Complete series depends on topic/dapm
---
 sound/soc/codecs/sn95031.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index e474368..3a7de01 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -194,7 +194,7 @@ static int sn95031_set_vaud_bias(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_PREPARE:
-		if (codec->dapm.bias_level == SND_SOC_BIAS_STANDBY) {
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_STANDBY) {
 			pr_debug("vaud_bias powering up pll\n");
 			/* power up the pll */
 			snd_soc_write(codec, SN95031_AUDPLLCTRL, BIT(5));
@@ -205,17 +205,22 @@ static int sn95031_set_vaud_bias(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
+		switch (snd_soc_codec_get_bias_level(codec)) {
+		case SND_SOC_BIAS_OFF:
 			pr_debug("vaud_bias power up rail\n");
 			/* power up the rail */
 			snd_soc_write(codec, SN95031_VAUD,
 					BIT(2)|BIT(1)|BIT(0));
 			msleep(1);
-		} else if (codec->dapm.bias_level == SND_SOC_BIAS_PREPARE) {
+			break;
+		case SND_SOC_BIAS_PREPARE:
 			/* turn off pcm */
 			pr_debug("vaud_bias power dn pcm\n");
 			snd_soc_update_bits(codec, SN95031_PCM2C2, BIT(0), 0);
 			snd_soc_write(codec, SN95031_AUDPLLCTRL, 0);
+			break;
+		default:
+			break;
 		}
 		break;
 
-- 
1.8.0
