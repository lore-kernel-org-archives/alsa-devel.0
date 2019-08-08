From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: tidyup for
	snd_soc_add_component_controls()" to the asoc tree
Date: Thu,  8 Aug 2019 21:33:43 +0100 (BST)
Message-ID: <20190808203343.85A2A2742B42@ypsilon.sirena.org.uk>
References: <87ef1xahor.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 58D9EF800E4
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2019 22:33:44 +0200 (CEST)
In-Reply-To: <87ef1xahor.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-core: tidyup for snd_soc_add_component_controls()

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

>From e6d7020c2946bef2efab7c70339eee6a6b3cb6a6 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 7 Aug 2019 10:30:58 +0900
Subject: [PATCH] ASoC: soc-core: tidyup for snd_soc_add_component_controls()

snd_soc_add_component_controls() registers controls by using
for(... i < num; ...). If controls was NULL, num should be zero.
Thus, we don't need to check about controls pointer.
This patch also cares missing return value.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87ef1xahor.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index bb1e9e2c4ff4..e481f9999bfb 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1304,10 +1304,12 @@ static int soc_probe_component(struct snd_soc_card *card,
 		}
 	}
 
-	if (component->driver->controls)
-		snd_soc_add_component_controls(component,
-					       component->driver->controls,
-					       component->driver->num_controls);
+	ret = snd_soc_add_component_controls(component,
+					     component->driver->controls,
+					     component->driver->num_controls);
+	if (ret < 0)
+		goto err_probe;
+
 	if (component->driver->dapm_routes)
 		snd_soc_dapm_add_routes(dapm,
 					component->driver->dapm_routes,
-- 
2.20.1
