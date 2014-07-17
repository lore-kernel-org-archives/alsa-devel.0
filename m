From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/4] ASoC: Add function to register component
	controls
Date: Thu, 17 Jul 2014 22:01:08 +0200
Message-ID: <1405627268-23939-5-git-send-email-lars@metafoo.de>
References: <1405627268-23939-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-180.synserver.de (smtp-out-180.synserver.de
 [212.40.185.180])
 by alsa0.perex.cz (Postfix) with ESMTP id BFF152654ED
 for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2014 22:01:10 +0200 (CEST)
In-Reply-To: <1405627268-23939-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

We have now everything in place to actual let a component register controls. Add
a function which allows to do so.

Also update snd_soc_add_codec_controls() and snd_soc_platform_controls() to use
this new function internally. And while we are at it also change the
num_controls parameter of those two functions from int to unsigned int.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  |  6 ++++--
 sound/soc/soc-core.c | 35 +++++++++++++++++++++++++----------
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 248db66..be6ecae 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -516,10 +516,12 @@ struct snd_kcontrol *snd_soc_cnew(const struct snd_kcontrol_new *_template,
 				  const char *prefix);
 struct snd_kcontrol *snd_soc_card_get_kcontrol(struct snd_soc_card *soc_card,
 					       const char *name);
+int snd_soc_add_component_controls(struct snd_soc_component *component,
+	const struct snd_kcontrol_new *controls, unsigned int num_controls);
 int snd_soc_add_codec_controls(struct snd_soc_codec *codec,
-	const struct snd_kcontrol_new *controls, int num_controls);
+	const struct snd_kcontrol_new *controls, unsigned int num_controls);
 int snd_soc_add_platform_controls(struct snd_soc_platform *platform,
-	const struct snd_kcontrol_new *controls, int num_controls);
+	const struct snd_kcontrol_new *controls, unsigned int num_controls);
 int snd_soc_add_card_controls(struct snd_soc_card *soc_card,
 	const struct snd_kcontrol_new *controls, int num_controls);
 int snd_soc_add_dai_controls(struct snd_soc_dai *dai,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6337603..d4bfd4a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2394,6 +2394,25 @@ struct snd_kcontrol *snd_soc_card_get_kcontrol(struct snd_soc_card *soc_card,
 EXPORT_SYMBOL_GPL(snd_soc_card_get_kcontrol);
 
 /**
+ * snd_soc_add_component_controls - Add an array of controls to a component.
+ *
+ * @component: Component to add controls to
+ * @controls: Array of controls to add
+ * @num_controls: Number of elements in the array
+ *
+ * Return: 0 for success, else error.
+ */
+int snd_soc_add_component_controls(struct snd_soc_component *component,
+	const struct snd_kcontrol_new *controls, unsigned int num_controls)
+{
+	struct snd_card *card = component->card->snd_card;
+
+	return snd_soc_add_controls(card, component->dev, controls,
+			num_controls, component->name_prefix, component);
+}
+EXPORT_SYMBOL_GPL(snd_soc_add_component_controls);
+
+/**
  * snd_soc_add_codec_controls - add an array of controls to a codec.
  * Convenience function to add a list of controls. Many codecs were
  * duplicating this code.
@@ -2405,12 +2424,10 @@ EXPORT_SYMBOL_GPL(snd_soc_card_get_kcontrol);
  * Return 0 for success, else error.
  */
 int snd_soc_add_codec_controls(struct snd_soc_codec *codec,
-	const struct snd_kcontrol_new *controls, int num_controls)
+	const struct snd_kcontrol_new *controls, unsigned int num_controls)
 {
-	struct snd_card *card = codec->component.card->snd_card;
-
-	return snd_soc_add_controls(card, codec->dev, controls, num_controls,
-			codec->component.name_prefix, &codec->component);
+	return snd_soc_add_component_controls(&codec->component, controls,
+		num_controls);
 }
 EXPORT_SYMBOL_GPL(snd_soc_add_codec_controls);
 
@@ -2425,12 +2442,10 @@ EXPORT_SYMBOL_GPL(snd_soc_add_codec_controls);
  * Return 0 for success, else error.
  */
 int snd_soc_add_platform_controls(struct snd_soc_platform *platform,
-	const struct snd_kcontrol_new *controls, int num_controls)
+	const struct snd_kcontrol_new *controls, unsigned int num_controls)
 {
-	struct snd_card *card = platform->component.card->snd_card;
-
-	return snd_soc_add_controls(card, platform->dev, controls, num_controls,
-			NULL, &platform->component);
+	return snd_soc_add_component_controls(&platform->component, controls,
+		num_controls);
 }
 EXPORT_SYMBOL_GPL(snd_soc_add_platform_controls);
 
-- 
1.8.0
