From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-dai: use bit field for bus_control"
	to the asoc tree
Date: Thu, 22 Aug 2019 19:32:56 +0100 (BST)
Message-ID: <20190822183256.D26A2D02CD0@fitzroy.sirena.org.uk>
References: <87v9uszazh.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E51F7F80112
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 20:33:03 +0200 (CEST)
In-Reply-To: <87v9uszazh.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Sridharan@sirena.org.uk, Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Ranjani <ranjani.sridharan@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-dai: use bit field for bus_control

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From 6b8ac43c33b912bc5435192ce3b3f051f6f2dc9d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 20 Aug 2019 14:05:28 +0900
Subject: [PATCH] ASoC: soc-dai: use bit field for bus_control

.bus_control can be bit field.
this patch do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/87v9uszazh.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dai.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index dc48fe081a20..939c73db6a03 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -293,8 +293,6 @@ struct snd_soc_dai_driver {
 	/* Optional Callback used at pcm creation*/
 	int (*pcm_new)(struct snd_soc_pcm_runtime *rtd,
 		       struct snd_soc_dai *dai);
-	/* DAI is also used for the control bus */
-	bool bus_control;
 
 	/* ops */
 	const struct snd_soc_dai_ops *ops;
@@ -306,6 +304,7 @@ struct snd_soc_dai_driver {
 	unsigned int symmetric_rates:1;
 	unsigned int symmetric_channels:1;
 	unsigned int symmetric_samplebits:1;
+	unsigned int bus_control:1; /* DAI is also used for the control bus */
 
 	/* probe ordering - for components with runtime dependencies */
 	int probe_order;
-- 
2.20.1
