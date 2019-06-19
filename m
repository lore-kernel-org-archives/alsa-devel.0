From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc.h: dobj is used only when
	SND_SOC_TOPOLOGY" to the asoc tree
Date: Wed, 19 Jun 2019 13:11:58 +0100 (BST)
Message-ID: <20190619121158.E355D440046@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B3B2BF80C87
 for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2019 14:12:00 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc.h: dobj is used only when SND_SOC_TOPOLOGY

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

>From 9b3941a8fcdd77d9f17f36f48d84bf6f1ba1a0fb Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 19 Jun 2019 10:28:02 +0900
Subject: [PATCH] ASoC: soc.h: dobj is used only when SND_SOC_TOPOLOGY

snd_soc_dobj is used only when SND_SOC_TOPOLOGY was selected.
Let's enable it under SND_SOC_TOPOLOGY.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 64405cdab8bb..4dbfb21c14cf 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -990,7 +990,9 @@ struct snd_soc_dai_link {
 	unsigned int ignore:1;
 
 	struct list_head list; /* DAI link list of the soc card */
+#ifdef CONFIG_SND_SOC_TOPOLOGY
 	struct snd_soc_dobj dobj; /* For topology */
+#endif
 };
 #define for_each_link_codecs(link, i, codec)				\
 	for ((i) = 0;							\
@@ -1297,7 +1299,9 @@ struct soc_mixer_control {
 	unsigned int sign_bit;
 	unsigned int invert:1;
 	unsigned int autodisable:1;
+#ifdef CONFIG_SND_SOC_TOPOLOGY
 	struct snd_soc_dobj dobj;
+#endif
 };
 
 struct soc_bytes {
@@ -1308,8 +1312,9 @@ struct soc_bytes {
 
 struct soc_bytes_ext {
 	int max;
+#ifdef CONFIG_SND_SOC_TOPOLOGY
 	struct snd_soc_dobj dobj;
-
+#endif
 	/* used for TLV byte control */
 	int (*get)(struct snd_kcontrol *kcontrol, unsigned int __user *bytes,
 			unsigned int size);
@@ -1333,7 +1338,9 @@ struct soc_enum {
 	const char * const *texts;
 	const unsigned int *values;
 	unsigned int autodisable:1;
+#ifdef CONFIG_SND_SOC_TOPOLOGY
 	struct snd_soc_dobj dobj;
+#endif
 };
 
 /**
-- 
2.20.1
