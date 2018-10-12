From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sta32x: set ->component pointer in
	private struct" to the asoc tree
Date: Fri, 12 Oct 2018 19:00:56 +0200 (CEST)
Message-ID: <20181012170056.8DE28440078@finisterre.ee.mobilebroadband>
References: <20181011183205.18671-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 606942679B3
 for <alsa-devel@alsa-project.org>; Fri, 12 Oct 2018 19:00:57 +0200 (CEST)
In-Reply-To: <20181011183205.18671-1-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sta32x: set ->component pointer in private struct

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 747df19747bc9752cd40b9cce761e17a033aa5c2 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@zonque.org>
Date: Thu, 11 Oct 2018 20:32:05 +0200
Subject: [PATCH] ASoC: sta32x: set ->component pointer in private struct

The ESD watchdog code in sta32x_watchdog() dereferences the pointer
which is never assigned.

This is a regression from a1be4cead9b950 ("ASoC: sta32x: Convert to direct
regmap API usage.") which went unnoticed since nobody seems to use that ESD
workaround.

Fixes: a1be4cead9b950 ("ASoC: sta32x: Convert to direct regmap API usage.")
Signed-off-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/sta32x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index d5035f2f2b2b..ce508b4cc85c 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -879,6 +879,9 @@ static int sta32x_probe(struct snd_soc_component *component)
 	struct sta32x_priv *sta32x = snd_soc_component_get_drvdata(component);
 	struct sta32x_platform_data *pdata = sta32x->pdata;
 	int i, ret = 0, thermal = 0;
+
+	sta32x->component = component;
+
 	ret = regulator_bulk_enable(ARRAY_SIZE(sta32x->supplies),
 				    sta32x->supplies);
 	if (ret != 0) {
-- 
2.19.0
