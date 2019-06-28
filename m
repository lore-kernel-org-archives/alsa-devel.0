From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: arndale_rt5631: consider
	CPU-Platform possibility" to the asoc tree
Date: Fri, 28 Jun 2019 17:56:25 +0100 (BST)
Message-ID: <20190628165625.878B744004F@finisterre.sirena.org.uk>
References: <87ef3ev5wz.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2CCC4F896B7
 for <alsa-devel@alsa-project.org>; Fri, 28 Jun 2019 18:56:26 +0200 (CEST)
In-Reply-To: <87ef3ev5wz.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: samsung: arndale_rt5631: consider CPU-Platform possibility

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

>From a0e95c4d376d30e50b2b1f4769a6dcc5c7604505 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 28 Jun 2019 10:48:15 +0900
Subject: [PATCH] ASoC: samsung: arndale_rt5631: consider CPU-Platform
 possibility

commit 33949eb5019d ("ASoC: samsung: arndale_rt5631: don't select
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

Fixes: commit 33949eb5019d ("ASoC: samsung: arndale_rt5631: don't select unnecessary Platform")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/arndale_rt5631.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/samsung/arndale_rt5631.c b/sound/soc/samsung/arndale_rt5631.c
index e36c140400b7..c213913eb984 100644
--- a/sound/soc/samsung/arndale_rt5631.c
+++ b/sound/soc/samsung/arndale_rt5631.c
@@ -52,7 +52,8 @@ static struct snd_soc_ops arndale_ops = {
 
 SND_SOC_DAILINK_DEFS(rt5631_hifi,
 	DAILINK_COMP_ARRAY(COMP_EMPTY()),
-	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "rt5631-hifi")));
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "rt5631-hifi")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
 static struct snd_soc_dai_link arndale_rt5631_dai[] = {
 	{
@@ -92,6 +93,9 @@ static int arndale_audio_probe(struct platform_device *pdev)
 				return -EINVAL;
 			}
 		}
+		if (!arndale_rt5631_dai[n].platforms->name)
+			arndale_rt5631_dai[n].platforms->of_node =
+					arndale_rt5631_dai[n].cpus->of_node;
 
 		arndale_rt5631_dai[n].codecs->name = NULL;
 		arndale_rt5631_dai[n].codecs->of_node = of_parse_phandle(np,
-- 
2.20.1
