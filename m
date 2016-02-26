From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: improve headphone pop when
	system resumes from S3" to the asoc tree
Date: Fri, 26 Feb 2016 11:46:58 +0900
Message-ID: <E1aZ8Qk-0006Kj-Kc@finisterre>
References: <1456377507-13120-1-git-send-email-john.lin@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 113B3265268
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2016 03:47:02 +0100 (CET)
In-Reply-To: <1456377507-13120-1-git-send-email-john.lin@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Lin <john.lin@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: improve headphone pop when system resumes from S3

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

>From 0150e8c053e585dbd3f8141fbb942015532527ca Mon Sep 17 00:00:00 2001
From: John Lin <john.lin@realtek.com>
Date: Thu, 25 Feb 2016 13:18:26 +0800
Subject: [PATCH] ASoC: rt5645: improve headphone pop when system resumes from
 S3

When playing audio through headphone, headphone makes pop noise if system
resumes from S3 to S0. We modify the sequence of writing register for
avoiding pop sound.

Signed-off-by: John Lin <john.lin@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index c61d38b585fb..c3dc371a7ef3 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3029,13 +3029,18 @@ static int rt5645_set_bias_level(struct snd_soc_codec *codec,
 			RT5645_PWR_BG | RT5645_PWR_VREF2,
 			RT5645_PWR_VREF1 | RT5645_PWR_MB |
 			RT5645_PWR_BG | RT5645_PWR_VREF2);
+		mdelay(10);
 		snd_soc_update_bits(codec, RT5645_PWR_ANLG1,
 			RT5645_PWR_FV1 | RT5645_PWR_FV2,
 			RT5645_PWR_FV1 | RT5645_PWR_FV2);
-		if (rt5645->en_button_func &&
-			snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF)
-			queue_delayed_work(system_power_efficient_wq,
-				&rt5645->jack_detect_work, msecs_to_jiffies(0));
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+			snd_soc_write(codec, RT5645_DEPOP_M2, 0x1140);
+			msleep(40);
+			if (rt5645->en_button_func)
+				queue_delayed_work(system_power_efficient_wq,
+					&rt5645->jack_detect_work,
+					msecs_to_jiffies(0));
+		}
 		break;
 
 	case SND_SOC_BIAS_OFF:
-- 
2.7.0
