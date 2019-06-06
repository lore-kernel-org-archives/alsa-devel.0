From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: atmel: atmel-pdmic: use modern dai_link
	style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:39 +0100 (BST)
Message-ID: <20190606212639.8321E440049@finisterre.sirena.org.uk>
References: <87o93bicua.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 495AFF897A6
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:40 +0200 (CEST)
In-Reply-To: <87o93bicua.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: atmel: atmel-pdmic: use modern dai_link style

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

>From f62da10aba7cc7971dace102ad5cc129e4dfbd94 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:14:00 +0900
Subject: [PATCH] ASoC: atmel: atmel-pdmic: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/atmel-pdmic.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/sound/soc/atmel/atmel-pdmic.c b/sound/soc/atmel/atmel-pdmic.c
index 915c2b064de1..f53213402d94 100644
--- a/sound/soc/atmel/atmel-pdmic.c
+++ b/sound/soc/atmel/atmel-pdmic.c
@@ -511,17 +511,30 @@ static int atmel_pdmic_asoc_card_init(struct device *dev,
 {
 	struct snd_soc_dai_link *dai_link;
 	struct atmel_pdmic *dd = snd_soc_card_get_drvdata(card);
+	struct snd_soc_dai_link_component *comp;
 
 	dai_link = devm_kzalloc(dev, sizeof(*dai_link), GFP_KERNEL);
 	if (!dai_link)
 		return -ENOMEM;
 
+	comp = devm_kzalloc(dev, 3 * sizeof(*comp), GFP_KERNEL);
+	if (!comp)
+		return -ENOMEM;
+
+	dai_link->cpus		= &comp[0];
+	dai_link->codecs	= &comp[1];
+	dai_link->platforms	= &comp[2];
+
+	dai_link->num_cpus	= 1;
+	dai_link->num_codecs	= 1;
+	dai_link->num_platforms	= 1;
+
 	dai_link->name			= "PDMIC";
 	dai_link->stream_name		= "PDMIC PCM";
-	dai_link->codec_dai_name	= ATMEL_PDMIC_CODEC_DAI_NAME;
-	dai_link->cpu_dai_name		= dev_name(dev);
-	dai_link->codec_name		= dev_name(dev);
-	dai_link->platform_name		= dev_name(dev);
+	dai_link->codecs->dai_name	= ATMEL_PDMIC_CODEC_DAI_NAME;
+	dai_link->cpus->dai_name	= dev_name(dev);
+	dai_link->codecs->name		= dev_name(dev);
+	dai_link->platforms->name	= dev_name(dev);
 
 	card->dai_link	= dai_link;
 	card->num_links	= 1;
-- 
2.20.1
