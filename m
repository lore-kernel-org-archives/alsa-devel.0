From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: fixup reset timing of sync
	convert_rate" to the asoc tree
Date: Fri, 03 Feb 2017 12:32:31 +0100
Message-ID: <E1cZc6R-0007n2-G3@finisterre>
References: <87d1f1w5mx.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 19F74265142
 for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2017 12:32:43 +0100 (CET)
In-Reply-To: <87d1f1w5mx.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: fixup reset timing of sync convert_rate

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

>From ef30da1c52c633a6eaa017ad0d075aaa809a6154 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 2 Feb 2017 05:01:05 +0000
Subject: [PATCH] ASoC: rsnd: fixup reset timing of sync convert_rate

Sync convert rate settings should be availabled *after* Playing.
Thus, src->sync should be reset first of init function.
Otherwise, it will set remaining settings when it start playing.
This patch fixes it. Thanks to Yokoyama-san

Reported-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/src.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 3a8f65bd1bf9..42db48db09ba 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -390,6 +390,9 @@ static int rsnd_src_init(struct rsnd_mod *mod,
 {
 	struct rsnd_src *src = rsnd_mod_to_src(mod);
 
+	/* reset sync convert_rate */
+	src->sync.val = 0;
+
 	rsnd_mod_power_on(mod);
 
 	rsnd_src_activation(mod);
@@ -398,9 +401,6 @@ static int rsnd_src_init(struct rsnd_mod *mod,
 
 	rsnd_src_status_clear(mod);
 
-	/* reset sync convert_rate */
-	src->sync.val = 0;
-
 	return 0;
 }
 
-- 
2.11.0
