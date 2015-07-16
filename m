From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: core: add
	snd_soc_of_parse_audio_prefix()" to the asoc tree
Date: Thu, 16 Jul 2015 22:01:08 +0100
Message-ID: <E1ZFqHE-0001dU-RY@finisterre>
References: <87bnfdx5o2.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A7A7D2605D2
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:01:16 +0200 (CEST)
In-Reply-To: <87bnfdx5o2.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Keita Kobayashi <keita.kobayashi.ym@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: core: add snd_soc_of_parse_audio_prefix()

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

>From 5e3cdaa20816dd2fe4dc17d06a9f0dae0abc930c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Jul 2015 07:07:42 +0000
Subject: [PATCH] ASoC: core: add snd_soc_of_parse_audio_prefix()

Current ASoC can add name_prefix for DAPM, and it is necessary for
route settings. This patch adds snd_soc_of_parse_audio_prefix() for
this purpose. It will be used with snd_soc_of_parse_audio_routing().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  4 ++++
 sound/soc/soc-core.c | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 93df8bf..75cd19c 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1604,6 +1604,10 @@ int snd_soc_of_parse_audio_simple_widgets(struct snd_soc_card *card,
 int snd_soc_of_parse_tdm_slot(struct device_node *np,
 			      unsigned int *slots,
 			      unsigned int *slot_width);
+void snd_soc_of_parse_audio_prefix(struct snd_soc_card *card,
+				   struct snd_soc_codec_conf *codec_conf,
+				   struct device_node *of_node,
+				   const char *propname);
 int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 				   const char *propname);
 unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3a4a5c0..fd15d54 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3303,6 +3303,26 @@ int snd_soc_of_parse_tdm_slot(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(snd_soc_of_parse_tdm_slot);
 
+void snd_soc_of_parse_audio_prefix(struct snd_soc_card *card,
+				   struct snd_soc_codec_conf *codec_conf,
+				   struct device_node *of_node,
+				   const char *propname)
+{
+	struct device_node *np = card->dev->of_node;
+	const char *str;
+	int ret;
+
+	ret = of_property_read_string(np, propname, &str);
+	if (ret < 0) {
+		/* no prefix is not error */
+		return;
+	}
+
+	codec_conf->of_node	= of_node;
+	codec_conf->name_prefix	= str;
+}
+EXPORT_SYMBOL_GPL(snd_soc_of_parse_audio_prefix);
+
 int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 				   const char *propname)
 {
-- 
2.1.4
