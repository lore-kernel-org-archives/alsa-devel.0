From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/8] ASoC: dapm: Unexport
	snd_soc_dapm_new_control()
Date: Thu, 16 Feb 2012 21:56:04 -0800
Message-ID: <1329458170-22119-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1329458170-22119-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 08AE0103A1E
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 06:56:17 +0100 (CET)
In-Reply-To: <1329458170-22119-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Everything now uses snd_soc_dapm_new_controls() instead so we don't need
to make it part of the external API.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    2 --
 sound/soc/soc-dapm.c     |    5 ++---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index db8435a..c28d20b 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -352,8 +352,6 @@ int snd_soc_dapm_get_pin_switch(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *uncontrol);
 int snd_soc_dapm_put_pin_switch(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *uncontrol);
-int snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
-	const struct snd_soc_dapm_widget *widget);
 int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 	const struct snd_soc_dapm_widget *widget,
 	int num);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d3f6bad0..c7032fa 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2710,8 +2710,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_put_pin_switch);
  *
  * Returns 0 for success else error.
  */
-int snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
-	const struct snd_soc_dapm_widget *widget)
+static int snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
+				    const struct snd_soc_dapm_widget *widget)
 {
 	struct snd_soc_dapm_widget *w;
 	size_t name_len;
@@ -2801,7 +2801,6 @@ int snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	w->connected = 1;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(snd_soc_dapm_new_control);
 
 /**
  * snd_soc_dapm_new_controls - create new dapm controls
-- 
1.7.9.rc1
