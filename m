From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: Add snd_soc_codec_{readable,
	writable}_register()
Date: Thu, 24 Mar 2011 13:45:18 +0000
Message-ID: <1300974319-14423-2-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1300974319-14423-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 12013103A1C
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2011 14:45:27 +0100 (CET)
In-Reply-To: <1300974319-14423-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg@ti.com
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Provide the top level ASoC core functions for indicating whether
a given register is readable or writable.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    4 ++++
 sound/soc/soc-core.c |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 982e63e..e8447be 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -278,6 +278,10 @@ int snd_soc_register_codec(struct device *dev,
 void snd_soc_unregister_codec(struct device *dev);
 int snd_soc_codec_volatile_register(struct snd_soc_codec *codec,
 				    unsigned int reg);
+int snd_soc_codec_readable_register(struct snd_soc_codec *codec,
+				    unsigned int reg);
+int snd_soc_codec_writable_register(struct snd_soc_codec *codec,
+				    unsigned int reg);
 int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 			       int addr_bits, int data_bits,
 			       enum snd_soc_control_type control);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1cb1446..60a22a6 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2147,6 +2147,42 @@ int snd_soc_codec_volatile_register(struct snd_soc_codec *codec,
 EXPORT_SYMBOL_GPL(snd_soc_codec_volatile_register);
 
 /**
+ * snd_soc_codec_readable_register: Report if a register is readable.
+ *
+ * @codec: CODEC to query.
+ * @reg: Register to query.
+ *
+ * Boolean function indicating if a CODEC register is readable.
+ */
+int snd_soc_codec_readable_register(struct snd_soc_codec *codec,
+				    unsigned int reg)
+{
+	if (codec->readable_register)
+		return codec->readable_register(codec, reg);
+	else
+		return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_codec_readable_register);
+
+/**
+ * snd_soc_codec_writable_register: Report if a register is writable.
+ *
+ * @codec: CODEC to query.
+ * @reg: Register to query.
+ *
+ * Boolean function indicating if a CODEC register is writable.
+ */
+int snd_soc_codec_writable_register(struct snd_soc_codec *codec,
+				    unsigned int reg)
+{
+	if (codec->writable_register)
+		return codec->writable_register(codec, reg);
+	else
+		return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_codec_writable_register);
+
+/**
  * snd_soc_new_ac97_codec - initailise AC97 device
  * @codec: audio codec
  * @ops: AC97 bus operations
-- 
1.7.4.1
