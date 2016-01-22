From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: try to connect connected mod is
	not error" to the asoc tree
Date: Fri, 22 Jan 2016 18:26:47 +0000
Message-ID: <E1aMgQ3-00049b-Mv@debutante>
References: <87k2n34s1v.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4361E260A59
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 19:26:52 +0100 (CET)
In-Reply-To: <87k2n34s1v.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: try to connect connected mod is not error

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From bfa3119c38afb8177f8e403b9e9b2ecd0306bb26 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 21 Jan 2016 01:56:36 +0000
Subject: [PATCH] ASoC: rsnd: try to connect connected mod is not error

If system uses CTU/MUX, CTU/MUX/DVC will try to connect same CMD to
system, but it is not error in this case.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 3eb7e9a7b5dc..ad97ce3ae844 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -369,6 +369,9 @@ int rsnd_dai_connect(struct rsnd_mod *mod,
 	if (!mod)
 		return -EIO;
 
+	if (io->mod[type] == mod)
+		return 0;
+
 	if (io->mod[type])
 		return -EINVAL;
 
-- 
2.7.0.rc3
