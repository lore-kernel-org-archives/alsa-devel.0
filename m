From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: core: Add snd_soc_card_get_kcontrol()
Date: Mon, 29 Jul 2013 13:51:58 +0100
Message-ID: <1375102319-10645-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EF8EF261AAF
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2013 14:59:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This is useful for drivers who want to grab a pointer to
snd_kcontrol outside of the kcontrol callbacks.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |  2 ++
 sound/soc/soc-core.c | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 6eabee7..b33d1de 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -475,6 +475,8 @@ int snd_soc_set_ac97_ops(struct snd_ac97_bus_ops *ops);
 struct snd_kcontrol *snd_soc_cnew(const struct snd_kcontrol_new *_template,
 				  void *data, const char *long_name,
 				  const char *prefix);
+struct snd_kcontrol *snd_soc_card_get_kcontrol(struct snd_soc_card *soc_card,
+					       const char *name);
 int snd_soc_add_codec_controls(struct snd_soc_codec *codec,
 	const struct snd_kcontrol_new *controls, int num_controls);
 int snd_soc_add_platform_controls(struct snd_soc_platform *platform,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d82ee38..d68a486 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2299,6 +2299,22 @@ static int snd_soc_add_controls(struct snd_card *card, struct device *dev,
 	return 0;
 }
 
+struct snd_kcontrol *snd_soc_card_get_kcontrol(struct snd_soc_card *soc_card,
+					       const char *name)
+{
+	struct snd_card *card = soc_card->snd_card;
+	struct snd_kcontrol *kctl;
+
+	if (unlikely(!name))
+		return NULL;
+
+	list_for_each_entry(kctl, &card->controls, list)
+		if (!strncmp(kctl->id.name, name, sizeof(kctl->id.name)))
+			return kctl;
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_card_get_kcontrol);
+
 /**
  * snd_soc_add_codec_controls - add an array of controls to a codec.
  * Convenience function to add a list of controls. Many codecs were
-- 
1.8.3.4
