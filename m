From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-utils: respawn dummy Platform" to
	the asoc tree
Date: Fri, 28 Jun 2019 17:56:23 +0100 (BST)
Message-ID: <20190628165623.180A3440049@finisterre.sirena.org.uk>
References: <87ftnutr9i.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D8B7BF80058
 for <alsa-devel@alsa-project.org>; Fri, 28 Jun 2019 18:56:24 +0200 (CEST)
In-Reply-To: <87ftnutr9i.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-utils: respawn dummy Platform

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

>From aff50895269f567d1b30c688ce8d610542991b30 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 28 Jun 2019 10:50:04 +0900
Subject: [PATCH] ASoC: soc-utils: respawn dummy Platform

commit 64ee5067cf64 ("ASoC: soc-utils: remove dummy Platform") removed
dummy Platform from ALSA SoC, but it is over-kill.
This patch respawn it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-utils.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index f67e715a9f42..e3b9dd634c6d 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -262,6 +262,26 @@ static const struct snd_pcm_hardware dummy_dma_hardware = {
 	.periods_max		= 128,
 };
 
+static int dummy_dma_open(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+
+	/* BE's dont need dummy params */
+	if (!rtd->dai_link->no_pcm)
+		snd_soc_set_runtime_hwparams(substream, &dummy_dma_hardware);
+
+	return 0;
+}
+
+static const struct snd_pcm_ops snd_dummy_dma_ops = {
+	.open		= dummy_dma_open,
+	.ioctl		= snd_pcm_lib_ioctl,
+};
+
+static const struct snd_soc_component_driver dummy_platform = {
+	.ops = &snd_dummy_dma_ops,
+};
+
 static const struct snd_soc_component_driver dummy_codec = {
 	.idle_bias_on		= 1,
 	.use_pmdown_time	= 1,
@@ -319,6 +339,11 @@ static int snd_soc_dummy_probe(struct platform_device *pdev)
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					      &dummy_codec, &dummy_dai, 1);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_snd_soc_register_component(&pdev->dev, &dummy_platform,
+					      NULL, 0);
 
 	return ret;
 }
-- 
2.20.1
