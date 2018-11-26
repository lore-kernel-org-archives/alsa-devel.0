From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc.h: makes
	snd_soc_of_parse_audio_prefix() inline" to the asoc tree
Date: Mon, 26 Nov 2018 17:20:46 +0000 (GMT)
Message-ID: <20181126172046.BBC1B112519F@debutante.sirena.org.uk>
References: <87h8g43an3.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 61B2F267AC3
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2018 18:20:47 +0100 (CET)
In-Reply-To: <87h8g43an3.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc.h: makes snd_soc_of_parse_audio_prefix() inline

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

>From 2708bccf9c6f142c3ef5a27f15d34febe751ce4c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 26 Nov 2018 01:21:22 +0000
Subject: [PATCH] ASoC: soc.h: makes snd_soc_of_parse_audio_prefix() inline

commit 3b7103562c03c ("ASoC: soc-core: add
snd_soc_of_parse_node_prefix()") maked snd_soc_of_parse_audio_prefix()
as #define. But it'd be better to make this a static inline rather than
a #define. It helps with error messages and type safety.
This patch makes it inline.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 93b7510e7f7d..66aafadcf5ef 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1481,9 +1481,15 @@ void snd_soc_of_parse_node_prefix(struct device_node *np,
 				   struct snd_soc_codec_conf *codec_conf,
 				   struct device_node *of_node,
 				   const char *propname);
-#define snd_soc_of_parse_audio_prefix(card, conf, node, name) \
-	snd_soc_of_parse_node_prefix((card)->dev->of_node,    \
-				     (conf), (node), (name))
+static inline
+void snd_soc_of_parse_audio_prefix(struct snd_soc_card *card,
+				   struct snd_soc_codec_conf *codec_conf,
+				   struct device_node *of_node,
+				   const char *propname)
+{
+	snd_soc_of_parse_node_prefix(card->dev->of_node,
+				     codec_conf, of_node, propname);
+}
 
 int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 				   const char *propname);
-- 
2.19.0.rc2
