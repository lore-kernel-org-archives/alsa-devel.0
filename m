From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: kirkwood: armada-370-db: don't select
	unnecessary Platform" to the asoc tree
Date: Wed, 19 Jun 2019 13:12:02 +0100 (BST)
Message-ID: <20190619121202.7A62F44004C@finisterre.sirena.org.uk>
References: <87h88mv0iu.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7A9FFF89749
 for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2019 14:12:03 +0200 (CEST)
In-Reply-To: <87h88mv0iu.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: kirkwood: armada-370-db: don't select unnecessary Platform

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

>From 717f163317127bc5fdc0d90ad42e3d309dac0df0 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 19 Jun 2019 10:17:14 +0900
Subject: [PATCH] ASoC: kirkwood: armada-370-db: don't select unnecessary
 Platform

ALSA SoC is now supporting "no Platform". Sound card doesn't need to
select "CPU component" as "Platform" anymore if it doesn't need
special Platform.
This patch removes such settings.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/kirkwood/armada-370-db.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/kirkwood/armada-370-db.c b/sound/soc/kirkwood/armada-370-db.c
index b2d735b610b8..14f41ea874ef 100644
--- a/sound/soc/kirkwood/armada-370-db.c
+++ b/sound/soc/kirkwood/armada-370-db.c
@@ -60,18 +60,15 @@ static const struct snd_soc_dapm_route a370db_route[] = {
 
 SND_SOC_DAILINK_DEFS(analog,
 	DAILINK_COMP_ARRAY(COMP_CPU("i2s")),
-	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "cs42l51-hifi")),
-	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "cs42l51-hifi")));
 
 SND_SOC_DAILINK_DEFS(spdif_out,
 	DAILINK_COMP_ARRAY(COMP_CPU("spdif")),
-	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "dit-hifi")),
-	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "dit-hifi")));
 
 SND_SOC_DAILINK_DEFS(spdif_in,
 	DAILINK_COMP_ARRAY(COMP_CPU("spdif")),
-	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "dir-hifi")),
-	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "dir-hifi")));
 
 static struct snd_soc_dai_link a370db_dai[] = {
 {
@@ -115,21 +112,18 @@ static int a370db_probe(struct platform_device *pdev)
 	a370db_dai[0].cpus->of_node =
 		of_parse_phandle(pdev->dev.of_node,
 				 "marvell,audio-controller", 0);
-	a370db_dai[0].platforms->of_node = a370db_dai[0].cpus->of_node;
 
 	a370db_dai[0].codecs->of_node =
 		of_parse_phandle(pdev->dev.of_node,
 				 "marvell,audio-codec", 0);
 
 	a370db_dai[1].cpus->of_node = a370db_dai[0].cpus->of_node;
-	a370db_dai[1].platforms->of_node = a370db_dai[0].cpus->of_node;
 
 	a370db_dai[1].codecs->of_node =
 		of_parse_phandle(pdev->dev.of_node,
 				 "marvell,audio-codec", 1);
 
 	a370db_dai[2].cpus->of_node = a370db_dai[0].cpus->of_node;
-	a370db_dai[2].platforms->of_node = a370db_dai[0].cpus->of_node;
 
 	a370db_dai[2].codecs->of_node =
 		of_parse_phandle(pdev->dev.of_node,
-- 
2.20.1
