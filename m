From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ux500: mop500: don't select unnecessary
	Platform" to the asoc tree
Date: Wed, 19 Jun 2019 13:11:59 +0100 (BST)
Message-ID: <20190619121159.73C5C44004F@finisterre.sirena.org.uk>
References: <87ef3qtluo.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F13DFF80CC4
 for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2019 14:12:00 +0200 (CEST)
In-Reply-To: <87ef3qtluo.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: ux500: mop500: don't select unnecessary Platform

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

>From 9ae6cdb184b651bf48b9feed4f947468ff1c3c1f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 19 Jun 2019 10:19:28 +0900
Subject: [PATCH] ASoC: ux500: mop500: don't select unnecessary Platform

ALSA SoC is now supporting "no Platform". Sound card doesn't need to
select "CPU component" as "Platform" anymore if it doesn't need
special Platform.
This patch removes such settings.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ux500/mop500.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
index 20552e9d9217..12b2260efaf4 100644
--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -29,13 +29,11 @@
 /* Define the whole MOP500 soundcard, linking platform to the codec-drivers  */
 SND_SOC_DAILINK_DEFS(link1,
 	DAILINK_COMP_ARRAY(COMP_CPU("ux500-msp-i2s.1")),
-	DAILINK_COMP_ARRAY(COMP_CODEC("ab8500-codec.0", "ab8500-codec-dai.0")),
-	DAILINK_COMP_ARRAY(COMP_PLATFORM("ux500-msp-i2s.1")));
+	DAILINK_COMP_ARRAY(COMP_CODEC("ab8500-codec.0", "ab8500-codec-dai.0")));
 
 SND_SOC_DAILINK_DEFS(link2,
 	DAILINK_COMP_ARRAY(COMP_CPU("ux500-msp-i2s.3")),
-	DAILINK_COMP_ARRAY(COMP_CODEC("ab8500-codec.0", "ab8500-codec-dai.1")),
-	DAILINK_COMP_ARRAY(COMP_PLATFORM("ux500-msp-i2s.3")));
+	DAILINK_COMP_ARRAY(COMP_CODEC("ab8500-codec.0", "ab8500-codec-dai.1")));
 
 static struct snd_soc_dai_link mop500_dai_links[] = {
 	{
@@ -91,8 +89,6 @@ static int mop500_of_probe(struct platform_device *pdev,
 	for (i = 0; i < 2; i++) {
 		mop500_dai_links[i].cpus->of_node = msp_np[i];
 		mop500_dai_links[i].cpus->dai_name = NULL;
-		mop500_dai_links[i].platforms->of_node = msp_np[i];
-		mop500_dai_links[i].platforms->name = NULL;
 		mop500_dai_links[i].codecs->of_node = codec_np;
 		mop500_dai_links[i].codecs->name = NULL;
 	}
-- 
2.20.1
