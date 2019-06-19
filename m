From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sunxi: sun4i-codec: don't select
	unnecessary Platform" to the asoc tree
Date: Wed, 19 Jun 2019 13:12:01 +0100 (BST)
Message-ID: <20190619121201.22A77440046@finisterre.sirena.org.uk>
References: <87zhmetlwd.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CD656F8973A
 for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2019 14:12:02 +0200 (CEST)
In-Reply-To: <87zhmetlwd.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: sunxi: sun4i-codec: don't select unnecessary Platform

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

>From 3f780533bac9025f3e569ebf5ebdc02bd860b27e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 19 Jun 2019 10:18:27 +0900
Subject: [PATCH] ASoC: sunxi: sun4i-codec: don't select unnecessary Platform

ALSA SoC is now supporting "no Platform". Sound card doesn't need to
select "CPU component" as "Platform" anymore if it doesn't need
special Platform.
This patch removes such settings.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 161444fe4518..a5de4011235f 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -1306,24 +1306,21 @@ static struct snd_soc_dai_link *sun4i_codec_create_link(struct device *dev,
 	struct snd_soc_dai_link *link = devm_kzalloc(dev, sizeof(*link),
 						     GFP_KERNEL);
 	struct snd_soc_dai_link_component *dlc = devm_kzalloc(dev,
-						3 * sizeof(*dlc), GFP_KERNEL);
+						2 * sizeof(*dlc), GFP_KERNEL);
 	if (!link || !dlc)
 		return NULL;
 
 	link->cpus	= &dlc[0];
 	link->codecs	= &dlc[1];
-	link->platforms	= &dlc[2];
 
 	link->num_cpus		= 1;
 	link->num_codecs	= 1;
-	link->num_platforms	= 1;
 
 	link->name		= "cdc";
 	link->stream_name	= "CDC PCM";
 	link->codecs->dai_name	= "Codec";
 	link->cpus->dai_name	= dev_name(dev);
 	link->codecs->name	= dev_name(dev);
-	link->platforms->name	= dev_name(dev);
 	link->dai_fmt		= SND_SOC_DAIFMT_I2S;
 
 	*num_links = 1;
-- 
2.20.1
