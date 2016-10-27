From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: fixup SCU_SYS_STATUSx access" to
	the asoc tree
Date: Thu, 27 Oct 2016 17:47:36 +0100
Message-ID: <E1bznq4-0007i8-Dv@debutante>
References: <87shrjwxmv.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CED752669E2
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2016 18:47:42 +0200 (CEST)
In-Reply-To: <87shrjwxmv.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Mark Brown <broonie@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: fixup SCU_SYS_STATUSx access

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

>From 42b197e794dbe961cbcebd9e4963252c96cc77f9 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 26 Oct 2016 04:28:42 +0000
Subject: [PATCH] ASoC: rsnd: fixup SCU_SYS_STATUSx access

SCU_SYS_STATUSx is the register that writing 1 initializes the bit,
and writing 0 is ignored. So, it should use rsnd_mod_write()
instead of rsnd_mod_bset(), otherwise all bit will be cleared.
Thanks Shimoda-san

Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/src.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index e13d6d439b32..aa24258b9b14 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -327,8 +327,8 @@ static void rsnd_src_status_clear(struct rsnd_mod *mod)
 {
 	u32 val = OUF_SRC(rsnd_mod_id(mod));
 
-	rsnd_mod_bset(mod, SCU_SYS_STATUS0, val, val);
-	rsnd_mod_bset(mod, SCU_SYS_STATUS1, val, val);
+	rsnd_mod_write(mod, SCU_SYS_STATUS0, val);
+	rsnd_mod_write(mod, SCU_SYS_STATUS1, val);
 }
 
 static bool rsnd_src_error_occurred(struct rsnd_mod *mod)
-- 
2.8.1
