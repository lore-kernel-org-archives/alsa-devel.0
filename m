From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Use the mod_delayed_work
	instead of the queue_delayed_work and
	cancel_delayed_work_sync" to the asoc tree
Date: Tue, 10 Nov 2015 19:06:26 +0000
Message-ID: <E1ZwEFO-0002hJ-LO@debutante>
References: <1447155318-31001-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E675B26526D
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 20:06:34 +0100 (CET)
In-Reply-To: <1447155318-31001-1-git-send-email-oder_chiou@realtek.com>
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

   ASoC: rt5645: Use the mod_delayed_work instead of the queue_delayed_work and cancel_delayed_work_sync

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

>From d11afbd6c24872d44c2cbfbfb8febe0c2391056c Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Tue, 10 Nov 2015 19:35:18 +0800
Subject: [PATCH] ASoC: rt5645: Use the mod_delayed_work instead of the
 queue_delayed_work and cancel_delayed_work_sync

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 672fafd8314a..4e81181c00c4 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -572,14 +572,12 @@ static int rt5645_spk_put_volsw(struct snd_kcontrol *kcontrol,
 	struct rt5645_priv *rt5645 = snd_soc_component_get_drvdata(component);
 	int ret;
 
-	cancel_delayed_work_sync(&rt5645->rcclock_work);
-
 	regmap_update_bits(rt5645->regmap, RT5645_MICBIAS,
 		RT5645_PWR_CLK25M_MASK, RT5645_PWR_CLK25M_PU);
 
 	ret = snd_soc_put_volsw(kcontrol, ucontrol);
 
-	queue_delayed_work(system_power_efficient_wq, &rt5645->rcclock_work,
+	mod_delayed_work(system_power_efficient_wq, &rt5645->rcclock_work,
 		msecs_to_jiffies(200));
 
 	return ret;
-- 
2.6.2
