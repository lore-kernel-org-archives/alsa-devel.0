From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: add missing
	EXPORT_SYMBOL_GPL() for snd_soc_rtdcom_lookup" to the asoc tree
Date: Thu, 18 Jan 2018 11:55:00 +0000
Message-ID: <E1ec8ma-0005Fs-Id@debutante>
References: <87mv1ckm0o.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B021267866
 for <alsa-devel@alsa-project.org>; Thu, 18 Jan 2018 12:55:06 +0100 (CET)
In-Reply-To: <87mv1ckm0o.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: add missing EXPORT_SYMBOL_GPL() for snd_soc_rtdcom_lookup

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

>From 031734b7d6532633d0cde73475c30646bf37cd6d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 18 Jan 2018 01:13:54 +0000
Subject: [PATCH] ASoC: soc-core: add missing EXPORT_SYMBOL_GPL() for
 snd_soc_rtdcom_lookup

Reported-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b9ca939fd05c..9b79c2199781 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -598,6 +598,7 @@ struct snd_soc_component *snd_soc_rtdcom_lookup(struct snd_soc_pcm_runtime *rtd,
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(snd_soc_rtdcom_lookup);
 
 struct snd_pcm_substream *snd_soc_get_dai_substream(struct snd_soc_card *card,
 		const char *dai_link, int stream)
-- 
2.15.1
