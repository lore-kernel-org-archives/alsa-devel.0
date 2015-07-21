From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: tidyup parameter assignment
	position" to the asoc tree
Date: Tue, 21 Jul 2015 11:49:14 +0100
Message-ID: <E1ZHV6o-0002ro-Re@debutante>
References: <87vbdecrc7.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E130C2616C9
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2015 12:49:21 +0200 (CEST)
In-Reply-To: <87vbdecrc7.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: tidyup parameter assignment position

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

>From 48725e9cc841da395bfd74e7691bba91613d3517 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 21 Jul 2015 00:03:35 +0000
Subject: [PATCH] ASoC: rsnd: tidyup parameter assignment position

84e95355602c("ASoC: rsnd: show debug message for SSI/SRC/DVC connection")
added debug message on rsnd_dai_connect(), but the relationship of
parameter check was absurdity. This patch tidyup it.
It is reported via Smatch/Dan

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 927a7b02123b..f3feed5ce9b6 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -332,12 +332,15 @@ u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 static int rsnd_dai_connect(struct rsnd_mod *mod,
 			    struct rsnd_dai_stream *io)
 {
-	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
-	struct device *dev = rsnd_priv_to_dev(priv);
+	struct rsnd_priv *priv;
+	struct device *dev;
 
 	if (!mod)
 		return -EIO;
 
+	priv = rsnd_mod_to_priv(mod);
+	dev = rsnd_priv_to_dev(priv);
+
 	io->mod[mod->type] = mod;
 
 	dev_dbg(dev, "%s[%d] is connected to io (%s)\n",
-- 
2.1.4
