From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-dpm: fixup DAI active unbalance" to
	the asoc tree
Date: Tue, 21 May 2019 21:32:43 +0100 (BST)
Message-ID: <20190521203243.D31411126D24@debutante.sirena.org.uk>
References: <87mujl3n4t.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CD2FAF8972F
 for <alsa-devel@alsa-project.org>; Tue, 21 May 2019 22:32:58 +0200 (CEST)
In-Reply-To: <87mujl3n4t.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-dpm: fixup DAI active unbalance

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From f7c4842abfa1a219554a3ffd8c317e8fdd979bec Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 17 May 2019 10:21:12 +0900
Subject: [PATCH] ASoC: soc-dpm: fixup DAI active unbalance

snd_soc_dai_link_event() is updating snd_soc_dai :: active,
but it is unbalance.
It counts up if it has startup callback.

	case SND_SOC_DAPM_PRE_PMU:
		...
		snd_soc_dapm_widget_for_each_source_path(w, path) {
			...
			if (source->driver->ops->startup) {
				...
=>				source->active++;
			}
			...
		}
		...

But, always counts down

	case SND_SOC_DAPM_PRE_PMD:
		...
		snd_soc_dapm_widget_for_each_source_path(w, path) {
			...
=>			source->active--;
			...
		}

This patch always counts up when SND_SOC_DAPM_PRE_PMD.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 65ee0bb5dd0b..62e27defce56 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3828,8 +3828,8 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 						ret);
 					goto out;
 				}
-				source->active++;
 			}
+			source->active++;
 			ret = soc_dai_hw_params(&substream, params, source);
 			if (ret < 0)
 				goto out;
@@ -3850,8 +3850,8 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 						ret);
 					goto out;
 				}
-				sink->active++;
 			}
+			sink->active++;
 			ret = soc_dai_hw_params(&substream, params, sink);
 			if (ret < 0)
 				goto out;
-- 
2.20.1
