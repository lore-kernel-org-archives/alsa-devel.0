From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: call snd_soc_disconnect_sync()
	when remove" to the asoc tree
Date: Tue, 28 Nov 2017 20:22:04 +0000
Message-ID: <E1eJmOK-000894-UW@debutante>
References: <87mv3z4xj5.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 642DF266B02
 for <alsa-devel@alsa-project.org>; Tue, 28 Nov 2017 21:22:10 +0100 (CET)
In-Reply-To: <87mv3z4xj5.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: call snd_soc_disconnect_sync() when remove

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

>From 180d9ef58104dfae78622d01910b9b7756701134 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 6 Nov 2017 08:41:37 +0000
Subject: [PATCH] ASoC: rsnd: call snd_soc_disconnect_sync() when remove

Renesas R-Car sound driver should be stopped if unbinded during
playbacking/capturing. Otherwise clock open/close counter mismatch
happen.

One note is that we can't skip from remove function (= return -Exxx)
in such case if user used unbind. Because unbind function doesn't
check return value from each driver's remove function.
This means we must to stop and remove driver in remove function.

Now ASoC has snd_soc_disconnect_sync() for this purpose.
Let's use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index f12a88a21dfa..bd64dc6ec1c3 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1496,6 +1496,8 @@ static int rsnd_remove(struct platform_device *pdev)
 	};
 	int ret = 0, i;
 
+	snd_soc_disconnect_sync(&pdev->dev);
+
 	pm_runtime_disable(&pdev->dev);
 
 	for_each_rsnd_dai(rdai, priv, i) {
-- 
2.15.0
