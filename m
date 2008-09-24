From: <20080924115907.GA12401@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: Allow machine drivers to mark pins
	as not connected
Date: Wed, 24 Sep 2008 13:01:09 +0100
Message-ID: <1222257670-12527-3-git-send-email-20080924115907.GA12401@rakim.wolfsonmicro.main>
References: <1222257670-12527-1-git-send-email-20080924115907.GA12401@rakim.wolfsonmicro.main>
	<1222257670-12527-2-git-send-email-20080924115907.GA12401@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8975B2417E
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Sep 2008 14:01:11 +0200 (CEST)
In-Reply-To: <1222257670-12527-2-git-send-email-20080924115907.GA12401@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@opensource.wolfsonmicro.com>

Add a new API call snd_soc_dapm_nc_pin() which allows machine drivers to
mark pins as being permanently disabled.  At present this is identical
to snd_soc_dapm_disable_pin() except in terms of improving the internal
documentation of machine drivers that use it.  The intention is that in
future it will be extended to provide additional features such as hiding
controls that are only relevant to paths using the disconnected pin.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    1 +
 sound/soc/soc-dapm.c     |   20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index c1b26fc..ca699a3 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -240,6 +240,7 @@ int snd_soc_dapm_sys_add(struct device *dev);
 /* dapm audio pin control and status */
 int snd_soc_dapm_enable_pin(struct snd_soc_codec *codec, char *pin);
 int snd_soc_dapm_disable_pin(struct snd_soc_codec *codec, char *pin);
+int snd_soc_dapm_nc_pin(struct snd_soc_codec *codec, char *pin);
 int snd_soc_dapm_get_pin_status(struct snd_soc_codec *codec, char *pin);
 int snd_soc_dapm_sync(struct snd_soc_codec *codec);
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c016426..05ffba2 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1484,6 +1484,26 @@ int snd_soc_dapm_disable_pin(struct snd_soc_codec *codec, char *pin)
 EXPORT_SYMBOL_GPL(snd_soc_dapm_disable_pin);
 
 /**
+ * snd_soc_dapm_nc_pin - permanently disable pin.
+ * @codec: SoC codec
+ * @pin: pin name
+ *
+ * Marks the specified pin as being not connected, disabling it along
+ * any parent or child widgets.  At present this is identical to
+ * snd_soc_dapm_disable_pin() but in future it will be extended to do
+ * additional things such as disabling controls which only affect
+ * paths through the pin.
+ *
+ * NOTE: snd_soc_dapm_sync() needs to be called after this for DAPM to
+ * do any widget power switching.
+ */
+int snd_soc_dapm_nc_pin(struct snd_soc_codec *codec, char *pin)
+{
+	return snd_soc_dapm_set_pin(codec, pin, 0);
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_nc_pin);
+
+/**
  * snd_soc_dapm_get_pin_status - get audio pin status
  * @codec: audio codec
  * @pin: audio signal pin endpoint (or start point)
-- 
1.5.6.5
