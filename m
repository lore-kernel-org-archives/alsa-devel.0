From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Move notifier functions to
	header and make inline" to the asoc tree
Date: Thu, 10 Nov 2016 17:29:12 +0000
Message-ID: <E1c4tA0-0005zG-CC@finisterre>
References: <1478791455-11246-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9842A2668B6
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 18:29:36 +0100 (CET)
In-Reply-To: <1478791455-11246-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Move notifier functions to header and make inline

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

>From d3d5c90556301dc1f3afe5a4e1133ddd1f43858b Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Thu, 10 Nov 2016 15:24:14 +0000
Subject: [PATCH] ASoC: arizona: Move notifier functions to header and make
 inline

These functions are very thin wrappers around core functions, so they
make sense as inline functions.  Also making them inline avoids build
issues in the case where the machine driver is built in but the CODEC
is built as a module.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.c | 24 ------------------------
 sound/soc/codecs/arizona.h | 32 ++++++++++++++++++++++++--------
 2 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 99ce6a0e73de..ca5ca9eac272 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -2691,30 +2691,6 @@ int arizona_lhpf_coeff_put(struct snd_kcontrol *kcontrol,
 }
 EXPORT_SYMBOL_GPL(arizona_lhpf_coeff_put);
 
-int arizona_register_notifier(struct snd_soc_codec *codec,
-			      struct notifier_block *nb,
-			      int (*notify)(struct notifier_block *nb,
-					    unsigned long action, void *data))
-{
-	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
-	struct arizona *arizona = priv->arizona;
-
-	nb->notifier_call = notify;
-
-	return blocking_notifier_chain_register(&arizona->notifier, nb);
-}
-EXPORT_SYMBOL_GPL(arizona_register_notifier);
-
-int arizona_unregister_notifier(struct snd_soc_codec *codec,
-				struct notifier_block *nb)
-{
-	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
-	struct arizona *arizona = priv->arizona;
-
-	return blocking_notifier_chain_unregister(&arizona->notifier, nb);
-}
-EXPORT_SYMBOL_GPL(arizona_unregister_notifier);
-
 MODULE_DESCRIPTION("ASoC Wolfson Arizona class device support");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 34d65d1eafba..813f1cdb565d 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -14,6 +14,8 @@
 #define _ASOC_ARIZONA_H
 
 #include <linux/completion.h>
+#include <linux/notifier.h>
+#include <linux/mfd/arizona/core.h>
 
 #include <sound/soc.h>
 
@@ -66,7 +68,6 @@
 /* Notifier events */
 #define ARIZONA_NOTIFY_VOICE_TRIGGER   0x1
 
-struct arizona;
 struct wm_adsp;
 
 struct arizona_dai_priv {
@@ -329,12 +330,27 @@ extern bool arizona_input_analog(struct snd_soc_codec *codec, int shift);
 
 extern const char *arizona_sample_rate_val_to_name(unsigned int rate_val);
 
-extern int arizona_register_notifier(struct snd_soc_codec *codec,
-				     struct notifier_block *nb,
-				     int (*notify)(struct notifier_block *nb,
-						   unsigned long action,
-						   void *data));
-extern int arizona_unregister_notifier(struct snd_soc_codec *codec,
-				       struct notifier_block *nb);
+static inline int arizona_register_notifier(struct snd_soc_codec *codec,
+					    struct notifier_block *nb,
+					    int (*notify)
+					    (struct notifier_block *nb,
+					    unsigned long action, void *data))
+{
+	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct arizona *arizona = priv->arizona;
+
+	nb->notifier_call = notify;
+
+	return blocking_notifier_chain_register(&arizona->notifier, nb);
+}
+
+static inline int arizona_unregister_notifier(struct snd_soc_codec *codec,
+					      struct notifier_block *nb)
+{
+	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct arizona *arizona = priv->arizona;
+
+	return blocking_notifier_chain_unregister(&arizona->notifier, nb);
+}
 
 #endif
-- 
2.10.2
