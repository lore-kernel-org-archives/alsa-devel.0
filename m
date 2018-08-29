From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dmic: add DT module alias" to the asoc
	tree
Date: Wed, 29 Aug 2018 16:08:53 +0100 (BST)
Message-ID: <20180829150853.A1E9A112486B@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 214D426792A
 for <alsa-devel@alsa-project.org>; Wed, 29 Aug 2018 17:08:54 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dmic: add DT module alias

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

>From cb06a037f8362e250a6e61872ffa01ab086ec9e2 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 29 Aug 2018 17:00:49 +0200
Subject: [PATCH] ASoC: dmic: add DT module alias

Before this patch the only alias provided by the dmic module is:
alias:          platform:dmic-codec

Device instantiated from DT will not probe automatically with this

After this patch, here is the new alias list:
alias:          platform:dmic-codec
alias:          of:N*T*Cdmic-codecC*
alias:          of:N*T*Cdmic-codec

Now the dmic codec probes automatically when instantiated from DT.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/dmic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index 8c4926df9286..71322e0410ee 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -148,6 +148,7 @@ static const struct of_device_id dmic_dev_match[] = {
 	{.compatible = "dmic-codec"},
 	{}
 };
+MODULE_DEVICE_TABLE(of, dmic_dev_match);
 
 static struct platform_driver dmic_driver = {
 	.driver = {
-- 
2.18.0
