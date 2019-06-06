From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ti: omap-hdmi: use modern dai_link
	style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:46 +0100 (BST)
Message-ID: <20190606212646.C1EA5440046@finisterre.sirena.org.uk>
References: <877e9zjrgc.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A7108F896F8
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:47 +0200 (CEST)
In-Reply-To: <877e9zjrgc.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: ti: omap-hdmi: use modern dai_link style

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

>From 3b785a63ee3d2bc9eb6473ca9490d5a268c88c3e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:13:02 +0900
Subject: [PATCH] ASoC: ti: omap-hdmi: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/omap-hdmi.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/sound/soc/ti/omap-hdmi.c b/sound/soc/ti/omap-hdmi.c
index 673a9eb153b2..11c1440da226 100644
--- a/sound/soc/ti/omap-hdmi.c
+++ b/sound/soc/ti/omap-hdmi.c
@@ -321,6 +321,7 @@ static int omap_hdmi_audio_probe(struct platform_device *pdev)
 	struct hdmi_audio_data *ad;
 	struct snd_soc_dai_driver *dai_drv;
 	struct snd_soc_card *card;
+	struct snd_soc_dai_link_component *compnent;
 	int ret;
 
 	if (!ha) {
@@ -371,12 +372,23 @@ static int omap_hdmi_audio_probe(struct platform_device *pdev)
 		devm_kzalloc(dev, sizeof(*(card->dai_link)), GFP_KERNEL);
 	if (!card->dai_link)
 		return -ENOMEM;
+
+	compnent = devm_kzalloc(dev, 3 * sizeof(*compnent), GFP_KERNEL);
+	if (!compnent)
+		return -ENOMEM;
+	card->dai_link->cpus		= &compnent[0];
+	card->dai_link->num_cpus	= 1;
+	card->dai_link->codecs		= &compnent[1];
+	card->dai_link->num_codecs	= 1;
+	card->dai_link->platforms	= &compnent[2];
+	card->dai_link->num_platforms	= 1;
+
 	card->dai_link->name = card->name;
 	card->dai_link->stream_name = card->name;
-	card->dai_link->cpu_dai_name = dev_name(ad->dssdev);
-	card->dai_link->platform_name = dev_name(ad->dssdev);
-	card->dai_link->codec_name = "snd-soc-dummy";
-	card->dai_link->codec_dai_name = "snd-soc-dummy-dai";
+	card->dai_link->cpus->dai_name = dev_name(ad->dssdev);
+	card->dai_link->platforms->name = dev_name(ad->dssdev);
+	card->dai_link->codecs->name = "snd-soc-dummy";
+	card->dai_link->codecs->dai_name = "snd-soc-dummy-dai";
 	card->num_links = 1;
 	card->dev = dev;
 
-- 
2.20.1
