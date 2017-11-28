From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: ssiu: clear SSI_MODE for non TDM
	Extended modes" to the asoc tree
Date: Tue, 28 Nov 2017 16:09:15 +0000
Message-ID: <E1eJiRf-0001sS-2v@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E15D2677C6
 for <alsa-devel@alsa-project.org>; Tue, 28 Nov 2017 17:09:19 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: ssiu: clear SSI_MODE for non TDM Extended modes

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

>From a91d7fb97092d6b840af5899ded3b389603fd7f1 Mon Sep 17 00:00:00 2001
From: Jiada Wang <jiada_wang@mentor.com>
Date: Tue, 28 Nov 2017 16:05:13 +0900
Subject: [PATCH] ASoC: rsnd: ssiu: clear SSI_MODE for non TDM Extended modes

register SSI_MODE is set when SSI works in TDM Extended,
but it isn't reset when SSI starts to work in other modes,
thus causes issues.

This patch clearss SSI_MODE register when SSI works in modes
other than TDM Extended.

Fixes: 186fadc132f0 ("ASoC: rsnd: add TDM Extend Mode support")
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssiu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index 4d948757d300..6ff8a36c2c82 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -125,6 +125,7 @@ static int rsnd_ssiu_init_gen2(struct rsnd_mod *mod,
 {
 	int hdmi = rsnd_ssi_hdmi_port(io);
 	int ret;
+	u32 mode = 0;
 
 	ret = rsnd_ssiu_init(mod, io, priv);
 	if (ret < 0)
@@ -136,9 +137,11 @@ static int rsnd_ssiu_init_gen2(struct rsnd_mod *mod,
 		 * see
 		 *	rsnd_ssi_config_init()
 		 */
-		rsnd_mod_write(mod, SSI_MODE, 0x1);
+		mode = 0x1;
 	}
 
+	rsnd_mod_write(mod, SSI_MODE, mode);
+
 	if (rsnd_ssi_use_busif(io)) {
 		rsnd_mod_write(mod, SSI_BUSIF_ADINR,
 			       rsnd_get_adinr_bit(mod, io) |
-- 
2.15.0
