From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add snd_soc_component_xxx_bias_level()"
	to the asoc tree
Date: Wed, 08 Nov 2017 21:32:18 +0000
Message-ID: <E1eCXxK-0005Or-HO@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D3BBC267661
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 22:33:44 +0100 (CET)
In-Reply-To: 
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

   ASoC: add snd_soc_component_xxx_bias_level()

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

>From 10e079d9874802c35dc3f51af922531e5423a6bf Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 6 Nov 2017 01:48:37 +0000
Subject: [PATCH] ASoC: add snd_soc_component_xxx_bias_level()

snd_soc_codec_xxx_bias_level() (= for Codec) will be removed soon.
This patch Component version of it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 747588273c96..f69b13c4a641 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1439,6 +1439,21 @@ static inline void snd_soc_codec_init_bias_level(struct snd_soc_codec *codec,
 	snd_soc_dapm_init_bias_level(snd_soc_codec_get_dapm(codec), level);
 }
 
+/**
+ * snd_soc_component_init_bias_level() - Initialize COMPONENT DAPM bias level
+ * @component: The COMPONENT for which to initialize the DAPM bias level
+ * @level: The DAPM level to initialize to
+ *
+ * Initializes the COMPONENT DAPM bias level. See snd_soc_dapm_init_bias_level().
+ */
+static inline void
+snd_soc_component_init_bias_level(struct snd_soc_component *component,
+				  enum snd_soc_bias_level level)
+{
+	snd_soc_dapm_init_bias_level(
+		snd_soc_component_get_dapm(component), level);
+}
+
 /**
  * snd_soc_dapm_get_bias_level() - Get current CODEC DAPM bias level
  * @codec: The CODEC for which to get the DAPM bias level
@@ -1451,6 +1466,19 @@ static inline enum snd_soc_bias_level snd_soc_codec_get_bias_level(
 	return snd_soc_dapm_get_bias_level(snd_soc_codec_get_dapm(codec));
 }
 
+/**
+ * snd_soc_component_get_bias_level() - Get current COMPONENT DAPM bias level
+ * @component: The COMPONENT for which to get the DAPM bias level
+ *
+ * Returns: The current DAPM bias level of the COMPONENT.
+ */
+static inline enum snd_soc_bias_level
+snd_soc_component_get_bias_level(struct snd_soc_component *component)
+{
+	return snd_soc_dapm_get_bias_level(
+		snd_soc_component_get_dapm(component));
+}
+
 /**
  * snd_soc_codec_force_bias_level() - Set the CODEC DAPM bias level
  * @codec: The CODEC for which to set the level
@@ -1466,6 +1494,23 @@ static inline int snd_soc_codec_force_bias_level(struct snd_soc_codec *codec,
 		level);
 }
 
+/**
+ * snd_soc_component_force_bias_level() - Set the COMPONENT DAPM bias level
+ * @component: The COMPONENT for which to set the level
+ * @level: The level to set to
+ *
+ * Forces the COMPONENT bias level to a specific state. See
+ * snd_soc_dapm_force_bias_level().
+ */
+static inline int
+snd_soc_component_force_bias_level(struct snd_soc_component *component,
+				   enum snd_soc_bias_level level)
+{
+	return snd_soc_dapm_force_bias_level(
+		snd_soc_component_get_dapm(component),
+		level);
+}
+
 /**
  * snd_soc_dapm_kcontrol_codec() - Returns the codec associated to a kcontrol
  * @kcontrol: The kcontrol
-- 
2.15.0
