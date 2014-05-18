From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/11] ASoC: Add helper functions to cast from
	DAPM context to CODEC/platform
Date: Sun, 18 May 2014 14:24:12 +0200
Message-ID: <1400415858-11025-6-git-send-email-lars@metafoo.de>
References: <1400415858-11025-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-145.synserver.de (smtp-out-151.synserver.de
 [212.40.185.151])
 by alsa0.perex.cz (Postfix) with ESMTP id A8D85264F03
 for <alsa-devel@alsa-project.org>; Sun, 18 May 2014 14:24:28 +0200 (CEST)
In-Reply-To: <1400415858-11025-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

This is useful if we have a pointer to a DAPM context and know that it is a
CODEC or platform DAPM context and want to get a pointer to the CODEC or
platform.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 9b335d8..aa9acaf 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1142,6 +1142,33 @@ static inline struct snd_soc_platform *snd_soc_component_to_platform(
 	return container_of(component, struct snd_soc_platform, component);
 }
 
+/**
+ * snd_soc_dapm_to_codec() - Casts a DAPM context to the CODEC it is embedded in
+ * @dapm: The DAPM context to cast to the CODEC
+ *
+ * This function must only be used on DAPM contexts that are known to be part of
+ * a CODEC (e.g. in a CODEC driver). Otherwise the behavior is undefined.
+ */
+static inline struct snd_soc_codec *snd_soc_dapm_to_codec(
+	struct snd_soc_dapm_context *dapm)
+{
+	return container_of(dapm, struct snd_soc_codec, dapm);
+}
+
+/**
+ * snd_soc_dapm_to_platform() - Casts a DAPM context to the platform it is
+ *  embedded in
+ * @dapm: The DAPM context to cast to the platform.
+ *
+ * This function must only be used on DAPM contexts that are known to be part of
+ * a platform (e.g. in a platform driver). Otherwise the behavior is undefined.
+ */
+static inline struct snd_soc_platform *snd_soc_dapm_to_platform(
+	struct snd_soc_dapm_context *dapm)
+{
+	return container_of(dapm, struct snd_soc_platform, dapm);
+}
+
 /* codec IO */
 unsigned int snd_soc_read(struct snd_soc_codec *codec, unsigned int reg);
 int snd_soc_write(struct snd_soc_codec *codec, unsigned int reg,
-- 
1.8.0
