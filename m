From: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: [PATCH 3/7] ASoC: rockchip-max98090: Fix NULL pointer de reference
 while accessing to jack
Date: Thu,  5 May 2016 10:03:37 +0200
Message-ID: <1462435421-21205-4-git-send-email-enric.balletbo@collabora.com>
References: <1462435421-21205-1-git-send-email-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1462435421-21205-1-git-send-email-enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Since commit f2ed6b07645e ("ASoC: Make aux_dev more like a generic
component") a kernel Oops is seen. What causes the crash is the chain

 rk_98090_headset_init
   -> ts3a227e_enable_jack_detect
      -> snd_jack_set_key
 rk_init
   -> snd_soc_card_jack_new

The above commit moves the new jack object creation from rk_init to
rk_98090_headset_init function making sure jack is accessed after it's
created.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
---
 sound/soc/rockchip/rockchip_max98090.c | 50 ++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
index 5436102..abb64a5 100644
--- a/sound/soc/rockchip/rockchip_max98090.c
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -114,43 +114,27 @@ static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static int rk_init(struct snd_soc_pcm_runtime *runtime)
-{
-	/* Enable Headset and 4 Buttons Jack detection */
-	return snd_soc_card_jack_new(runtime->card, "Headset Jack",
-			       SND_JACK_HEADSET |
-			       SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-			       SND_JACK_BTN_2 | SND_JACK_BTN_3,
-			       &headset_jack,
-			       headset_jack_pins,
-			       ARRAY_SIZE(headset_jack_pins));
-}
-
-static int rk_98090_headset_init(struct snd_soc_component *component)
-{
-	return ts3a227e_enable_jack_detect(component, &headset_jack);
-}
-
 static struct snd_soc_ops rk_aif1_ops = {
 	.hw_params = rk_aif1_hw_params,
 };
 
-static struct snd_soc_aux_dev rk_98090_headset_dev = {
-	.name = "Headset Chip",
-	.init = rk_98090_headset_init,
-};
-
 static struct snd_soc_dai_link rk_dailink = {
 	.name = "max98090",
 	.stream_name = "Audio",
 	.codec_dai_name = "HiFi",
-	.init = rk_init,
 	.ops = &rk_aif1_ops,
 	/* set max98090 as slave */
 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 		SND_SOC_DAIFMT_CBS_CFS,
 };
 
+static int rk_98090_headset_init(struct snd_soc_component *component);
+
+static struct snd_soc_aux_dev rk_98090_headset_dev = {
+	.name = "Headset Chip",
+	.init = rk_98090_headset_init,
+};
+
 static struct snd_soc_card snd_soc_card_rk = {
 	.name = "ROCKCHIP-I2S",
 	.owner = THIS_MODULE,
@@ -166,6 +150,26 @@ static struct snd_soc_card snd_soc_card_rk = {
 	.num_controls = ARRAY_SIZE(rk_mc_controls),
 };
 
+static int rk_98090_headset_init(struct snd_soc_component *component)
+{
+	int ret;
+
+	/* Enable Headset and 4 Buttons Jack detection */
+	ret = snd_soc_card_jack_new(&snd_soc_card_rk, "Headset Jack",
+				    SND_JACK_HEADSET |
+				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
+				    &headset_jack,
+				    headset_jack_pins,
+				    ARRAY_SIZE(headset_jack_pins));
+	if (ret)
+		return ret;
+
+	ret = ts3a227e_enable_jack_detect(component, &headset_jack);
+
+	return ret;
+}
+
 static int snd_rk_mc_probe(struct platform_device *pdev)
 {
 	int ret = 0;
-- 
2.1.0
