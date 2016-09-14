From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: da7219: software reset codec at probe" to the asoc tree
Date: Wed, 14 Sep 2016 18:15:59 +0100
Message-ID: <E1bkDmx-0001mP-P9@debutante>
References: <1473861960-7596-1-git-send-email-zhengxing@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1473861960-7596-1-git-send-email-zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Hsin-Yu Chao <hychao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, cychiang-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, hychao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, smbarber-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org, dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7219: software reset codec at probe

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

>From 96fc294cf6cb27f01a865959b9637d0aea3b57c2 Mon Sep 17 00:00:00 2001
From: Hsin-Yu Chao <hychao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Date: Wed, 14 Sep 2016 22:25:40 +0800
Subject: [PATCH] ASoC: da7219: software reset codec at probe

Da7219 does not trigger interrupt to report jack status
when system boots from warm reset because its power
remains on during warm reset.
Doing software reset at probe to handle this.

Signed-off-by: Hsin-Yu Chao <hychao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 sound/soc/codecs/da7219.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 50ea94317cb3..30f35e88bec2 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1937,6 +1937,14 @@ static int da7219_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	/* Software reset codec. */
+	regmap_write_bits(da7219->regmap, DA7219_ACCDET_CONFIG_1,
+			  DA7219_ACCDET_EN_MASK, 0);
+	regmap_write_bits(da7219->regmap, DA7219_CIF_CTRL,
+			  DA7219_CIF_REG_SOFT_RESET_MASK, 0);
+	regmap_write_bits(da7219->regmap, DA7219_SYSTEM_ACTIVE,
+			  DA7219_SYSTEM_ACTIVE_MASK, 0);
+
 	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_da7219,
 				     &da7219_dai, 1);
 	if (ret < 0) {
-- 
2.8.1
