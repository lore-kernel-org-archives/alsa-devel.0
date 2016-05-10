From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: rockchip-max98090: Fix NULL pointer dereference while
 accessing to jack." to the asoc tree
Date: Tue, 10 May 2016 19:50:02 +0100
Message-ID: <E1b0CjK-00007p-Fj@debutante>
References: <1462435421-21205-4-git-send-email-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1462435421-21205-4-git-send-email-enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip-max98090: Fix NULL pointer dereference while accessing to jack.

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

>From af637e3adaf538288cbb3e6a2d9a4059853fc15a Mon Sep 17 00:00:00 2001
From: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Date: Mon, 9 May 2016 12:46:31 +0200
Subject: [PATCH] ASoC: rockchip-max98090: Fix NULL pointer dereference while
 accessing to jack.

Commit f2ed6b07645e ("ASoC: Make aux_dev more like a generic
component") caused a regression on this driver, since now a
kernel oops is seen when rockchip-mac98090 driver is loaded.

That commit changed the probing of aux_devs before checking
new DAI links, so for this driver rk_98090_headset_init is
called before rk_init and then the kernel oops due a NULL
pointer dereference inside rk_98090_headset_init function
since there is a call that tries to access the jack pointer
which has not been allocated yet.

This is the call chain that causes the crash:

 rk_98090_headset_init
   -> ts3a227e_enable_jack_detect
      -> snd_jack_set_key
 rk_init
   -> snd_soc_card_jack_new

This patch moves the new jack object creation from rk_init
to rk_98090_headset_init function making sure the jack is
created before is accessed.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 sound/soc/rockchip/rockchip_max98090.c | 50 ++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
index 543610282cdb..abb64a553967 100644
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
2.8.1
