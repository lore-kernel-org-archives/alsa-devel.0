From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: atmel: sam9g20_wm8731: consider
	CPU-Platform possibility" to the asoc tree
Date: Fri, 28 Jun 2019 17:56:27 +0100 (BST)
Message-ID: <20190628165627.31ABA440049@finisterre.sirena.org.uk>
References: <871rzewkjg.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C1B0EF8974F
 for <alsa-devel@alsa-project.org>; Fri, 28 Jun 2019 18:56:28 +0200 (CEST)
In-Reply-To: <871rzewkjg.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: atmel: sam9g20_wm8731: consider CPU-Platform possibility

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

>From 0efd1d7cbcc5f5be4025fc6cd2809e50c3030f09 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 28 Jun 2019 10:47:02 +0900
Subject: [PATCH] ASoC: atmel: sam9g20_wm8731: consider CPU-Platform
 possibility

commit bfc7938e58142a5 ("ASoC: atmel: sam9g20_wm8731: don't select
unnecessary Platform")

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

Fixes: commit bfc7938e58142a5 ("ASoC: atmel: sam9g20_wm8731: don't select unnecessary Platform")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/sam9g20_wm8731.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index df098d3cf844..b1bef2bf142d 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -118,7 +118,8 @@ static int at91sam9g20ek_wm8731_init(struct snd_soc_pcm_runtime *rtd)
 
 SND_SOC_DAILINK_DEFS(pcm,
 	DAILINK_COMP_ARRAY(COMP_CPU("at91rm9200_ssc.0")),
-	DAILINK_COMP_ARRAY(COMP_CODEC("wm8731.0-001b", "wm8731-hifi")));
+	DAILINK_COMP_ARRAY(COMP_CODEC("wm8731.0-001b", "wm8731-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("at91rm9200_ssc.0")));
 
 static struct snd_soc_dai_link at91sam9g20ek_dai = {
 	.name = "WM8731",
@@ -209,12 +210,14 @@ static int at91sam9g20ek_audio_probe(struct platform_device *pdev)
 
 	/* Parse dai and platform info */
 	at91sam9g20ek_dai.cpus->dai_name = NULL;
+	at91sam9g20ek_dai.platforms->name = NULL;
 	cpu_np = of_parse_phandle(np, "atmel,ssc-controller", 0);
 	if (!cpu_np) {
 		dev_err(&pdev->dev, "dai and pcm info missing\n");
 		return -EINVAL;
 	}
 	at91sam9g20ek_dai.cpus->of_node = cpu_np;
+	at91sam9g20ek_dai.platforms->of_node = cpu_np;
 
 	of_node_put(codec_np);
 	of_node_put(cpu_np);
-- 
2.20.1
