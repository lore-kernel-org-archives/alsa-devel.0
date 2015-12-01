From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: rsrc-card: check return value of
	snd_soc_of_get_dai_name()" to the asoc tree
Date: Tue, 01 Dec 2015 22:59:48 +0000
Message-ID: <E1a3ttk-0006b3-HF@debutante>
References: <87bnaay3id.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 28F32266183
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 23:59:55 +0100 (CET)
In-Reply-To: <87bnaay3id.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: rsrc-card: check return value of snd_soc_of_get_dai_name()

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

>From 575f1f929f5a2ed80130c294aa7b2dc40dba74f2 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 1 Dec 2015 08:33:23 +0000
Subject: [PATCH] ASoC: rsnd: rsrc-card: check return value of
 snd_soc_of_get_dai_name()

This patch adds missing check of snd_soc_of_get_dai_name().
It might not be able to use sound card, because it might returns
-EPROBE_DEFER.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/rsrc-card.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/rsrc-card.c b/sound/soc/sh/rcar/rsrc-card.c
index d61db9c385ea..a3ec13f6271e 100644
--- a/sound/soc/sh/rcar/rsrc-card.c
+++ b/sound/soc/sh/rcar/rsrc-card.c
@@ -208,7 +208,9 @@ static int rsrc_card_parse_links(struct device_node *np,
 		dai_link->dynamic		= 1;
 		dai_link->dpcm_merged_format	= 1;
 		dai_link->cpu_of_node		= args.np;
-		snd_soc_of_get_dai_name(np, &dai_link->cpu_dai_name);
+		ret = snd_soc_of_get_dai_name(np, &dai_link->cpu_dai_name);
+		if (ret < 0)
+			return ret;
 
 		/* set dai_name */
 		snprintf(dai_props->dai_name, DAI_NAME_NUM, "fe.%s",
@@ -240,7 +242,9 @@ static int rsrc_card_parse_links(struct device_node *np,
 		dai_link->no_pcm		= 1;
 		dai_link->be_hw_params_fixup	= rsrc_card_be_hw_params_fixup;
 		dai_link->codec_of_node		= args.np;
-		snd_soc_of_get_dai_name(np, &dai_link->codec_dai_name);
+		ret = snd_soc_of_get_dai_name(np, &dai_link->codec_dai_name);
+		if (ret < 0)
+			return ret;
 
 		/* additional name prefix */
 		if (of_data) {
-- 
2.6.2
