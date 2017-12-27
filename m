From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-dai.h: remove symmetric_xxx from
	snd_soc_dai" to the asoc tree
Date: Wed, 27 Dec 2017 10:39:29 +0000 (GMT)
Message-ID: <20171227103929.3FBA744006B@finisterre.ee.mobilebroadband>
References: <87y3lyxk4l.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 66AA72670E0
 for <alsa-devel@alsa-project.org>; Wed, 27 Dec 2017 11:39:32 +0100 (CET)
In-Reply-To: <87y3lyxk4l.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-dai.h: remove symmetric_xxx from snd_soc_dai

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

>From 574d31d013d977be1cfe909da6c227c950856822 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 Dec 2017 01:38:26 +0000
Subject: [PATCH] ASoC: soc-dai.h: remove symmetric_xxx from snd_soc_dai

ALSA SoC has some duplicate parameter.
snd_soc_dai::symmetric_xxx are one of them.

commit f0fba2ad1b6b ("ASoC: multi-component - ASoC Multi-Component
Support") moved "symmetric_xxx" flags from snd_soc_dai to
snd_soc_dai_driver. No one is using snd_soc_dai::symmetric_xxx now.
Let's remove it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dai.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 58acd00cae19..e05d05b5a790 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -294,9 +294,6 @@ struct snd_soc_dai {
 	/* DAI runtime info */
 	unsigned int capture_active:1;		/* stream is in use */
 	unsigned int playback_active:1;		/* stream is in use */
-	unsigned int symmetric_rates:1;
-	unsigned int symmetric_channels:1;
-	unsigned int symmetric_samplebits:1;
 	unsigned int probed:1;
 
 	unsigned int active;
-- 
2.15.0
