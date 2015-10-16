From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Recheck the jack detect status
	after resuming from S3" to the asoc tree
Date: Fri, 16 Oct 2015 19:06:08 +0100
Message-ID: <E1Zn9OK-0002n4-9a@debutante>
References: <1444720045-15444-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CAB68260471
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 20:06:17 +0200 (CEST)
In-Reply-To: <1444720045-15444-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Recheck the jack detect status after resuming from S3

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

>From c962d03be31f12fd8eea435fa59e5289ce0cc284 Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Tue, 13 Oct 2015 15:07:25 +0800
Subject: [PATCH] ASoC: rt5645: Recheck the jack detect status after resuming
 from S3

The patch rechecks the jack detect status after resuming from S3.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index d9993d42cc4e..b3eff733d778 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2745,6 +2745,10 @@ static int rt5645_set_bias_level(struct snd_soc_codec *codec,
 		snd_soc_update_bits(codec, RT5645_PWR_ANLG1,
 			RT5645_PWR_FV1 | RT5645_PWR_FV2,
 			RT5645_PWR_FV1 | RT5645_PWR_FV2);
+		if (rt5645->en_button_func &&
+			snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF)
+			queue_delayed_work(system_power_efficient_wq,
+				&rt5645->jack_detect_work, msecs_to_jiffies(0));
 		break;
 
 	case SND_SOC_BIAS_OFF:
-- 
2.6.1
