From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ti: rx51: consider CPU-Platform
	possibility" to the asoc tree
Date: Fri, 28 Jun 2019 17:56:23 +0100 (BST)
Message-ID: <20190628165623.9219E440050@finisterre.sirena.org.uk>
References: <87mui2trac.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2CFDBF896CC
 for <alsa-devel@alsa-project.org>; Fri, 28 Jun 2019 18:56:24 +0200 (CEST)
In-Reply-To: <87mui2trac.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: ti: rx51: consider CPU-Platform possibility

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

>From 569440b46baab1f9f696a688de7860a915cebc26 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 28 Jun 2019 10:49:34 +0900
Subject: [PATCH] ASoC: ti: rx51: consider CPU-Platform possibility

commit f0edc6c1ee48 ("ASoC: ti: rx51: don't select unnecessary Platform")

Current ALSA SoC avoid to add duplicate component to rtd,
and this driver was selecting CPU component as Platform component.
Thus, above patch removed Platform settings from this driver,
because it assumed these are same component.

But, some CPU driver is using generic DMAEngine, in such case, both
CPU component and Platform component will have same of_node/name.
In other words, there are some components which are different but
have same of_node/name.

In such case, Card driver definitely need to select Platform even
though it is same as CPU.
It is depends on CPU driver, but is difficult to know it from Card driver.
This patch reverts above patch.

Fixes: commit f0edc6c1ee48 ("ASoC: ti: rx51: don't select unnecessary Platform")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/rx51.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/ti/rx51.c b/sound/soc/ti/rx51.c
index 4270cfb66224..bc6046534fa5 100644
--- a/sound/soc/ti/rx51.c
+++ b/sound/soc/ti/rx51.c
@@ -301,7 +301,8 @@ static int rx51_aic34_init(struct snd_soc_pcm_runtime *rtd)
 SND_SOC_DAILINK_DEFS(aic34,
 	DAILINK_COMP_ARRAY(COMP_CPU("omap-mcbsp.2")),
 	DAILINK_COMP_ARRAY(COMP_CODEC("tlv320aic3x-codec.2-0018",
-				      "tlv320aic3x-hifi")));
+				      "tlv320aic3x-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("omap-mcbsp.2")));
 
 static struct snd_soc_dai_link rx51_dai[] = {
 	{
@@ -378,7 +379,9 @@ static int rx51_soc_probe(struct platform_device *pdev)
 			return -EINVAL;
 		}
 		rx51_dai[0].cpus->dai_name = NULL;
+		rx51_dai[0].platforms->name = NULL;
 		rx51_dai[0].cpus->of_node = dai_node;
+		rx51_dai[0].platforms->of_node = dai_node;
 
 		dai_node = of_parse_phandle(np, "nokia,audio-codec", 0);
 		if (!dai_node) {
-- 
2.20.1
