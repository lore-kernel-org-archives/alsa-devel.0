From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ak4642: don't have .use_pmdown_time" to
	the asoc tree
Date: Wed, 14 Feb 2018 13:29:41 +0000
Message-ID: <E1elx81-000783-HE@debutante>
References: <87o9ksb7ip.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DDAF4267B39
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 14:29:43 +0100 (CET)
In-Reply-To: <87o9ksb7ip.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ak4642: don't have .use_pmdown_time

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

>From fe439c7c377920d608678db9a6724d6ec91f4cda Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 14 Feb 2018 03:01:46 +0000
Subject: [PATCH] ASoC: ak4642: don't have .use_pmdown_time

snd_soc_runtime_ignore_pmdown_time() returns "ignore pmdown time"
decision. Then, it collects each component driver's .use_pmdown_time
settings by using AND operation.
But, ak4613 has no reason to ignore/use pmdown time.
Thus, It should has use_pmdown_time=0, it means it doesn't have
decision right of "ignore pmdown time".

Otherwise, ak4642 paired driver's pmdown_time settings doesn't
have meaning. In other words, "ignore pmdown time" is determined
irrespective of the value of paired driver's settings
(= ignore will be 0 by ak4642).

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak4642.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 9c35e91d412d..605055964529 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -562,7 +562,6 @@ static const struct snd_soc_component_driver soc_component_dev_ak4642 = {
 	.dapm_routes		= ak4642_intercon,
 	.num_dapm_routes	= ARRAY_SIZE(ak4642_intercon),
 	.idle_bias_on		= 1,
-	.use_pmdown_time	= 1,
 	.endianness		= 1,
 	.non_legacy_dai_naming	= 1,
 };
-- 
2.16.1
