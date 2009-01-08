From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/7] ASoC: Constify pin names for DAPM pin
	status APIs
Date: Thu,  8 Jan 2009 19:37:59 +0000
Message-ID: <1231443481-29352-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090108193718.GA29183@sirena.org.uk>
	<1231443481-29352-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1231443481-29352-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1231443481-29352-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1231443481-29352-4-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D64524368
	for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2009 20:38:09 +0100 (CET)
In-Reply-To: <1231443481-29352-4-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    8 ++++----
 sound/soc/soc-dapm.c     |   10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index a7f4a5e..0accdba 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -260,10 +260,10 @@ int snd_soc_dapm_set_bias_level(struct snd_soc_device *socdev,
 int snd_soc_dapm_sys_add(struct device *dev);
 
 /* dapm audio pin control and status */
-int snd_soc_dapm_enable_pin(struct snd_soc_codec *codec, char *pin);
-int snd_soc_dapm_disable_pin(struct snd_soc_codec *codec, char *pin);
-int snd_soc_dapm_nc_pin(struct snd_soc_codec *codec, char *pin);
-int snd_soc_dapm_get_pin_status(struct snd_soc_codec *codec, char *pin);
+int snd_soc_dapm_enable_pin(struct snd_soc_codec *codec, const char *pin);
+int snd_soc_dapm_disable_pin(struct snd_soc_codec *codec, const char *pin);
+int snd_soc_dapm_nc_pin(struct snd_soc_codec *codec, const char *pin);
+int snd_soc_dapm_get_pin_status(struct snd_soc_codec *codec, const char *pin);
 int snd_soc_dapm_sync(struct snd_soc_codec *codec);
 
 /* dapm widget types */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a678065..3a759c2 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -898,7 +898,7 @@ static void dapm_free_widgets(struct snd_soc_codec *codec)
 }
 
 static int snd_soc_dapm_set_pin(struct snd_soc_codec *codec,
-	char *pin, int status)
+				const char *pin, int status)
 {
 	struct snd_soc_dapm_widget *w;
 
@@ -1573,7 +1573,7 @@ int snd_soc_dapm_set_bias_level(struct snd_soc_device *socdev,
  * NOTE: snd_soc_dapm_sync() needs to be called after this for DAPM to
  * do any widget power switching.
  */
-int snd_soc_dapm_enable_pin(struct snd_soc_codec *codec, char *pin)
+int snd_soc_dapm_enable_pin(struct snd_soc_codec *codec, const char *pin)
 {
 	return snd_soc_dapm_set_pin(codec, pin, 1);
 }
@@ -1588,7 +1588,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_enable_pin);
  * NOTE: snd_soc_dapm_sync() needs to be called after this for DAPM to
  * do any widget power switching.
  */
-int snd_soc_dapm_disable_pin(struct snd_soc_codec *codec, char *pin)
+int snd_soc_dapm_disable_pin(struct snd_soc_codec *codec, const char *pin)
 {
 	return snd_soc_dapm_set_pin(codec, pin, 0);
 }
@@ -1608,7 +1608,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_disable_pin);
  * NOTE: snd_soc_dapm_sync() needs to be called after this for DAPM to
  * do any widget power switching.
  */
-int snd_soc_dapm_nc_pin(struct snd_soc_codec *codec, char *pin)
+int snd_soc_dapm_nc_pin(struct snd_soc_codec *codec, const char *pin)
 {
 	return snd_soc_dapm_set_pin(codec, pin, 0);
 }
@@ -1623,7 +1623,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_nc_pin);
  *
  * Returns 1 for connected otherwise 0.
  */
-int snd_soc_dapm_get_pin_status(struct snd_soc_codec *codec, char *pin)
+int snd_soc_dapm_get_pin_status(struct snd_soc_codec *codec, const char *pin)
 {
 	struct snd_soc_dapm_widget *w;
 
-- 
1.5.6.5
