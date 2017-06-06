From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: remove unused rsnd_dai_path_info"
	to the asoc tree
Date: Tue, 06 Jun 2017 20:06:28 +0100
Message-ID: <E1dIJoC-0007L0-CB@debutante>
References: <87k24pzw4a.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DEF1D267222
 for <alsa-devel@alsa-project.org>; Tue,  6 Jun 2017 21:06:36 +0200 (CEST)
In-Reply-To: <87k24pzw4a.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: linux-renesas-soc@vger.kernel.org, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: remove unused rsnd_dai_path_info

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

>From d70c34db3357cedf8735ebad0b0fa5fed7b54b35 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 6 Jun 2017 02:35:10 +0000
Subject: [PATCH] ASoC: rsnd: remove unused rsnd_dai_path_info

commit 2ea2cc86db7c ("ASoC: rsnd: remove struct rcar_snd_info")
removed all struct rsnd_dai_path_info related code.
This patch removes unused rsnd_dai_path_info.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/rsnd.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 037e33ffa69d..96a567de5f14 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -421,7 +421,6 @@ struct rsnd_dai_stream {
 	char name[RSND_DAI_NAME_SIZE];
 	struct snd_pcm_substream *substream;
 	struct rsnd_mod *mod[RSND_MOD_MAX];
-	struct rsnd_dai_path_info *info; /* rcar_snd.h */
 	struct rsnd_dai *rdai;
 	u32 parent_ssi_status;
 	int byte_pos;
-- 
2.11.0
