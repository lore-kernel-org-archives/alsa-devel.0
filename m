From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: WARN() is not related to
	component->driver->probe" to the asoc tree
Date: Tue, 21 May 2019 21:32:42 +0100 (BST)
Message-ID: <20190521203242.3595B1126D1D@debutante.sirena.org.uk>
References: <87imu939x3.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E33E2F89709
 for <alsa-devel@alsa-project.org>; Tue, 21 May 2019 22:32:47 +0200 (CEST)
In-Reply-To: <87imu939x3.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: WARN() is not related to component->driver->probe

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

>From 2ffb0f580bded5f16ec4d619f8abb4745425e864 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 17 May 2019 15:06:37 +0900
Subject: [PATCH] ASoC: soc-core: WARN() is not related to
 component->driver->probe

soc_probe_component() has WARN() under if (component->driver->probe),
but, this WARN() check is not related to .probe callback.
So, it should be called at (B) instead of (A).
This patch moves it out of if().

	if (component->driver->probe) {
		ret = component->driver->probe(component);
		...
(A)		WARN(...)
	}
(B)	WARN(...)

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e83edbe27041..ce8c057bcd5b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1420,12 +1420,11 @@ static int soc_probe_component(struct snd_soc_card *card,
 				"ASoC: failed to probe component %d\n", ret);
 			goto err_probe;
 		}
-
-		WARN(dapm->idle_bias_off &&
-			dapm->bias_level != SND_SOC_BIAS_OFF,
-			"codec %s can not start from non-off bias with idle_bias_off==1\n",
-			component->name);
 	}
+	WARN(dapm->idle_bias_off &&
+	     dapm->bias_level != SND_SOC_BIAS_OFF,
+	     "codec %s can not start from non-off bias with idle_bias_off==1\n",
+	     component->name);
 
 	/* machine specific init */
 	if (component->init) {
-- 
2.20.1
