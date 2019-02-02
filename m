From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: fixup MIX kctrl registration" to
	the asoc tree
Date: Sat,  2 Feb 2019 16:18:21 +0000 (GMT)
Message-ID: <20190202161821.8604D440082@finisterre.ee.mobilebroadband>
References: <8736p8nel7.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 318D42674F8
 for <alsa-devel@alsa-project.org>; Sat,  2 Feb 2019 17:18:22 +0100 (CET)
In-Reply-To: <8736p8nel7.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Jiada Wang <jiada_wang@mentor.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: fixup MIX kctrl registration

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

>From 7aea8a9d71d54f449f49e20324df06341cc18395 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 1 Feb 2019 16:49:30 +0900
Subject: [PATCH] ASoC: rsnd: fixup MIX kctrl registration

Renesas sound device has many IPs and many situations.
If platform/board uses MIXer, situation will be more complex.
To avoid duplicate DVC kctrl registration when MIXer was used,
it had original flags.
But it was issue when sound card was re-binded, because
no one can't cleanup this flags then.

To solve this issue, commit 9c698e8481a15237a ("ASoC: rsnd: tidyup
registering method for rsnd_kctrl_new()") checks registered
card->controls, because if card was re-binded, these were cleanuped
automatically. This patch could solve re-binding issue.
But, it start to avoid MIX kctrl.

To solve these issues, we need below.
To avoid card re-binding issue: check registered card->controls
To avoid duplicate DVC registration: check registered rsnd_kctrl_cfg
To allow multiple MIX registration: check registered rsnd_kctrl_cfg
This patch do it.

Fixes: 9c698e8481a15237a ("ASoC: rsnd: tidyup registering method for rsnd_kctrl_new()")
Reported-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-By: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 59e250cc2e9d..e819e965e1db 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1526,14 +1526,14 @@ int rsnd_kctrl_new(struct rsnd_mod *mod,
 	int ret;
 
 	/*
-	 * 1) Avoid duplicate register (ex. MIXer case)
-	 * 2) re-register if card was rebinded
+	 * 1) Avoid duplicate register for DVC with MIX case
+	 * 2) Allow duplicate register for MIX
+	 * 3) re-register if card was rebinded
 	 */
 	list_for_each_entry(kctrl, &card->controls, list) {
 		struct rsnd_kctrl_cfg *c = kctrl->private_data;
 
-		if (strcmp(kctrl->id.name, name) == 0 &&
-		    c->mod == mod)
+		if (c == cfg)
 			return 0;
 	}
 
-- 
2.20.1
