From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: use ring buffer for
	rsnd_mod_name()" to the asoc tree
Date: Fri,  9 Nov 2018 15:58:05 +0000 (GMT)
Message-ID: <20181109155805.652541124E6F@debutante.sirena.org.uk>
References: <87lg62ki78.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 32AC72677E4
 for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2018 16:58:06 +0100 (CET)
In-Reply-To: <87lg62ki78.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: use ring buffer for rsnd_mod_name()

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

>From 0246c661b6f0051ef7bfbfff01d8ef7fd0359372 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 9 Nov 2018 04:15:46 +0000
Subject: [PATCH] ASoC: rsnd: use ring buffer for rsnd_mod_name()

commit c0ea089dbad4 ("ASoC: rsnd: rsnd_mod_name() handles both name and
ID") merged "name" and "ID" on rsnd_mod_name() to handle sub-ID
(= for CTU/BUSIF).
Then, it decided to share static char to avoid pointless memory.
But, it doesn't work correctry in below case, because last called
name will be used.

	dev_xxx(dev, "%s is connected to %s\n",
		rsnd_mod_name(mod_a),  /* ssiu[00] */
		rsnd_mod_name(mod_b)); /* ssi[0]   */
	->
	rcar_sound ec500000.sound: ssi[0] is connected to ssi[0]
	                           ~~~~~~                 ~~~~~~
We still don't want to have pointless memory, so let's use ring buffer.
16byte x 5 is very enough for this purpose.

	dev_xxx(dev, "%s is connected to %s\n",
		rsnd_mod_name(mod_a),  /* ssiu[00] */
		rsnd_mod_name(mod_b)); /* ssi[0]   */
	->
	rcar_sound ec500000.sound: ssiu[00] is connected to ssi[0]
	                           ~~~~~~~~                 ~~~~~~
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 12f559e0463f..56469ac4bc8c 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -137,10 +137,17 @@ struct dma_chan *rsnd_mod_dma_req(struct rsnd_dai_stream *io,
 	return mod->ops->dma_req(io, mod);
 }
 
+#define MOD_NAME_NUM   5
 #define MOD_NAME_SIZE 16
 char *rsnd_mod_name(struct rsnd_mod *mod)
 {
-	static char name[MOD_NAME_SIZE];
+	static char names[MOD_NAME_NUM][MOD_NAME_SIZE];
+	static int num;
+	char *name = names[num];
+
+	num++;
+	if (num >= MOD_NAME_NUM)
+		num = 0;
 
 	/*
 	 * Let's use same char to avoid pointlessness memory
-- 
2.19.0.rc2
