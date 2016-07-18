From: Chris Zhong <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH] ASoC: rockchip: correct the spdif clk
Date: Mon, 18 Jul 2016 22:34:34 +0800
Message-ID: <1468852474-15735-1-git-send-email-zyw@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, sugar.zhang-TNX95d0MmH7DzftRWevZcw@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chris Zhong <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The spdif mclk should be 128 times of sample rate, and there is a
internal divider, the real rate of spdif mclk is mclk / (div + 1).
Hence, the original driver always get the good frequency for
48000/96000/44100/192000. But for 32000, the mclk is incorrect,
it should be 32000*128, but get 48000*128. Do not use the internal
divider here, just set all mclk to 128 * sample rate directly.

Signed-off-by: Chris Zhong <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

---

 sound/soc/rockchip/rockchip_spdif.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
index 100781e..4ca2657 100644
--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -101,21 +101,7 @@ static int rk_spdif_hw_params(struct snd_pcm_substream *substream,
 	int ret;
 
 	srate = params_rate(params);
-	switch (srate) {
-	case 32000:
-	case 48000:
-	case 96000:
-		mclk = 96000 * 128; /* 12288000 hz */
-		break;
-	case 44100:
-		mclk = 44100 * 256; /* 11289600 hz */
-		break;
-	case 192000:
-		mclk = 192000 * 128; /* 24576000 hz */
-		break;
-	default:
-		return -EINVAL;
-	}
+	mclk = srate * 128;
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
@@ -139,7 +125,6 @@ static int rk_spdif_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	val |= SPDIF_CFGR_CLK_DIV(mclk/(srate * 256));
 	ret = regmap_update_bits(spdif->regmap, SPDIF_CFGR,
 		SPDIF_CFGR_CLK_DIV_MASK | SPDIF_CFGR_HALFWORD_ENABLE |
 		SDPIF_CFGR_VDW_MASK,
-- 
2.6.3
