From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: use snd_pcm_running() in
	rsnd_io_is_working()" to the asoc tree
Date: Tue, 31 Oct 2017 11:21:23 +0000
Message-ID: <E1e9Ubj-0002o9-AS@debutante>
References: <87vaiwxind.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E3EFE26728A
 for <alsa-devel@alsa-project.org>; Tue, 31 Oct 2017 12:21:26 +0100 (CET)
In-Reply-To: <87vaiwxind.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, "Yokoyama (Renesas)" <hiroyuki.yokoyama.vx@renesas.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: use snd_pcm_running() in rsnd_io_is_working()

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

>From 8fce974bc4d5478d4ddee2443a3e268532ab35a8 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 31 Oct 2017 00:39:45 +0000
Subject: [PATCH] ASoC: rsnd: use snd_pcm_running() in rsnd_io_is_working()

Let's use more common style to checking running/working

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 0216d3f53097..b36832ef7342 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -199,7 +199,10 @@ void rsnd_mod_interrupt(struct rsnd_mod *mod,
 int rsnd_io_is_working(struct rsnd_dai_stream *io)
 {
 	/* see rsnd_dai_stream_init/quit() */
-	return !!io->substream;
+	if (io->substream)
+		return snd_pcm_running(io->substream);
+
+	return 0;
 }
 
 int rsnd_runtime_channel_original(struct rsnd_dai_stream *io)
-- 
2.15.0.rc2
