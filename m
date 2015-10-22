From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: fixup rsnd_dai_call() behavior
	for .stop/.quit" to the asoc tree
Date: Fri, 23 Oct 2015 08:09:53 +0900
Message-ID: <E1ZpOzZ-00004q-9K@finisterre>
References: <87vb9zsio7.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 74880266B54
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:10:10 +0200 (CEST)
In-Reply-To: <87vb9zsio7.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: fixup rsnd_dai_call() behavior for .stop/.quit

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

>From 89e3e2c352a523be46be5104bf18e200a8ccd444 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Oct 2015 03:14:43 +0000
Subject: [PATCH] ASoC: rsnd: fixup rsnd_dai_call() behavior for .stop/.quit

Current rsnd_dai_call returns immediately if rsnd_mod_call return fail.
Thus, each callback-count can be unbalanced for example .init was OK,
start was OK, but, .stop was not OK. This case .quit should be called
but isn't called. And, rsnd_dai_stream_quit() also not be called.
rsnd_dai_call() should call all .stop/.quit eventhough it returns error.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 5c67144..deed48ef 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -327,9 +327,7 @@ u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 		mod = (io)->mod[i];				\
 		if (!mod)					\
 			continue;				\
-		ret = rsnd_mod_call(mod, io, fn, param);	\
-		if (ret < 0)					\
-			break;					\
+		ret |= rsnd_mod_call(mod, io, fn, param);	\
 	}							\
 	ret;							\
 })
@@ -495,16 +493,10 @@ static int rsnd_soc_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 		ret = rsnd_dai_call(stop, io, priv);
-		if (ret < 0)
-			goto dai_trigger_end;
 
-		ret = rsnd_dai_call(quit, io, priv);
-		if (ret < 0)
-			goto dai_trigger_end;
+		ret |= rsnd_dai_call(quit, io, priv);
 
-		ret = rsnd_platform_call(priv, dai, stop, ssi_id);
-		if (ret < 0)
-			goto dai_trigger_end;
+		ret |= rsnd_platform_call(priv, dai, stop, ssi_id);
 
 		rsnd_dai_stream_quit(io);
 		break;
-- 
2.6.1
