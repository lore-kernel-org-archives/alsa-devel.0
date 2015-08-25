From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: fix a misjudgement by return"
	to the asoc tree
Date: Tue, 25 Aug 2015 19:13:06 +0100
Message-ID: <E1ZUIiY-00069x-7s@debutante>
References: <1440487137-27989-2-git-send-email-zhengxing@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D5D3C2650BD
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2015 20:13:18 +0200 (CEST)
In-Reply-To: <1440487137-27989-2-git-send-email-zhengxing@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip: fix a misjudgement by return

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

>From 089935ff5ae93aea575c70e36be9264b9c581e24 Mon Sep 17 00:00:00 2001
From: Xing Zheng <zhengxing@rock-chips.com>
Date: Tue, 25 Aug 2015 15:52:42 +0800
Subject: [PATCH] ASoC: rockchip: fix a misjudgement by return

Being careless, judge the return value of snd_soc_card_jack_new
is opposite, so it should be fixed.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_rt5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_rt5645.c b/sound/soc/rockchip/rockchip_rt5645.c
index 3c6bb1ea06ec..adfe98c5d26f 100644
--- a/sound/soc/rockchip/rockchip_rt5645.c
+++ b/sound/soc/rockchip/rockchip_rt5645.c
@@ -118,7 +118,7 @@ static int rk_init(struct snd_soc_pcm_runtime *runtime)
 				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
 				    &headset_jack, NULL, 0);
-	if (!ret) {
+	if (ret) {
 		dev_err(card->dev, "New Headset Jack failed! (%d)\n", ret);
 		return ret;
 	}
-- 
2.5.0
