From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add
	SNDRV_PCM_TRIGGER_SUSPEND/RESUME" to the asoc tree
Date: Thu, 29 Sep 2016 11:04:15 -0700
Message-ID: <E1bpfgt-0006ZM-MT@finisterre>
References: <87h98zmmuz.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A5F2264EFA
 for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2016 20:04:32 +0200 (CEST)
In-Reply-To: <87h98zmmuz.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Hiep Cao Minh <cm-hiep@jinso.co.jp>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: add SNDRV_PCM_TRIGGER_SUSPEND/RESUME

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

>From 4b9c75eaa4f35504c3ee28d3a354f7b6362dfbe8 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 29 Sep 2016 03:09:22 +0000
Subject: [PATCH] ASoC: rsnd: add SNDRV_PCM_TRIGGER_SUSPEND/RESUME

This patch adds SNDRV_PCM_TRIGGER_SUSPEND/RESUME.
Otherwise, it breaks rsnd driver internal start/stop counter
when suspend/resume. This issue was reported/tested by Hiep

Tested-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index f718a200f77d..f18141098b50 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -576,6 +576,7 @@ static int rsnd_soc_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
 		rsnd_dai_stream_init(io, substream);
 
 		ret = rsnd_dai_call(init, io, priv);
@@ -592,6 +593,7 @@ static int rsnd_soc_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
 		ret = rsnd_dai_call(irq, io, priv, 0);
 
 		ret |= rsnd_dai_call(stop, io, priv);
-- 
2.9.3
