From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: rk3288_hdmi_analog: use
	modern dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:23 +0100 (BST)
Message-ID: <20190606212623.D1248440046@finisterre.sirena.org.uk>
References: <87imtjgy3z.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A1FA8F89775
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:24 +0200 (CEST)
In-Reply-To: <87imtjgy3z.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip: rk3288_hdmi_analog: use modern dai_link style

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From e0d129d4cac049ff21861f5a73506786e34e7f5a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:17:31 +0900
Subject: [PATCH] ASoC: rockchip: rk3288_hdmi_analog: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rk3288_hdmi_analog.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/sound/soc/rockchip/rk3288_hdmi_analog.c b/sound/soc/rockchip/rk3288_hdmi_analog.c
index a472d5eb2950..71ee16d7bde6 100644
--- a/sound/soc/rockchip/rk3288_hdmi_analog.c
+++ b/sound/soc/rockchip/rk3288_hdmi_analog.c
@@ -151,24 +151,21 @@ static const struct snd_soc_ops rk_ops = {
 	.hw_params = rk_hw_params,
 };
 
-static struct snd_soc_dai_link_component rk_codecs[] = {
-	{ },
-	{
-		.name = "hdmi-audio-codec.2.auto",
-		.dai_name = "i2s-hifi",
-	},
-};
+SND_SOC_DAILINK_DEFS(audio,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, NULL),
+			   COMP_CODEC("hdmi-audio-codec.2.auto", "i2s-hifi")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
 static struct snd_soc_dai_link rk_dailink = {
 	.name = "Codecs",
 	.stream_name = "Audio",
 	.init = rk_init,
 	.ops = &rk_ops,
-	.codecs = rk_codecs,
-	.num_codecs = ARRAY_SIZE(rk_codecs),
 	/* Set codecs as slave */
 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 		SND_SOC_DAIFMT_CBS_CFS,
+	SND_SOC_DAILINK_REG(audio),
 };
 
 static struct snd_soc_card snd_soc_card_rk = {
@@ -244,15 +241,15 @@ static int snd_rk_mc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	rk_dailink.cpu_of_node = of_parse_phandle(np, "rockchip,i2s-controller",
+	rk_dailink.cpus->of_node = of_parse_phandle(np, "rockchip,i2s-controller",
 						  0);
-	if (!rk_dailink.cpu_of_node) {
+	if (!rk_dailink.cpus->of_node) {
 		dev_err(&pdev->dev,
 			"Property 'rockchip,i2s-controller' missing or invalid\n");
 		return -EINVAL;
 	}
 
-	rk_dailink.platform_of_node = rk_dailink.cpu_of_node;
+	rk_dailink.platforms->of_node = rk_dailink.cpus->of_node;
 
 	ret = snd_soc_of_parse_audio_routing(card, "rockchip,routing");
 	if (ret) {
-- 
2.20.1
