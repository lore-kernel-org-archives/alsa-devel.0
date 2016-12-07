From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: tidyup ssi->usrcnt counter check
	in hw_params" to the asoc tree
Date: Wed, 07 Dec 2016 15:50:23 +0000
Message-ID: <E1cEeUB-0000nm-1N@finisterre>
References: <87oa0oqyuq.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 58A1426721A
 for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2016 16:50:31 +0100 (CET)
In-Reply-To: <87oa0oqyuq.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>, Nguyen Viet Dung <nv-dung@jinso.co.jp>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: tidyup ssi->usrcnt counter check in hw_params

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

>From 6bf66b1c35870e08359cb03c49a94e7fef529ef5 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 7 Dec 2016 02:05:22 +0000
Subject: [PATCH] ASoC: rsnd: tidyup ssi->usrcnt counter check in hw_params

ssi->usrcnt will be updated on snd_soc_dai_ops::trigger,
but snd_pcm_ops::hw_params will be called *before* it.
Thus, ssi->usrcnt is still 0 when 1st call.
rsnd_ssi_hw_params() needs to check its called count, this means
trigger should be if (ssi->usrcnt) instead of if (ssi->usrcnt > 1).

Reported-by: Nguyen Viet Dung <nv-dung@jinso.co.jp>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index e23e07b54d8c..411bda2387ad 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -417,11 +417,14 @@ static int rsnd_ssi_hw_params(struct rsnd_mod *mod,
 	int chan = params_channels(params);
 
 	/*
-	 * Already working.
-	 * It will happen if SSI has parent/child connection.
+	 * snd_pcm_ops::hw_params will be called *before*
+	 * snd_soc_dai_ops::trigger. Thus, ssi->usrcnt is 0
+	 * in 1st call.
 	 */
-	if (ssi->usrcnt > 1) {
+	if (ssi->usrcnt) {
 		/*
+		 * Already working.
+		 * It will happen if SSI has parent/child connection.
 		 * it is error if child <-> parent SSI uses
 		 * different channels.
 		 */
-- 
2.10.2
