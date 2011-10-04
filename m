From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC 08/12] ASoC: core: Combine
	snd_soc_info_volsw/info_volsw_2r functions
Date: Tue,  4 Oct 2011 14:39:45 +0300
Message-ID: <1317728389-22062-9-git-send-email-peter.ujfalusi@ti.com>
References: <1317728389-22062-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog103.obsmtp.com (na3sys009aog103.obsmtp.com
	[74.125.149.71])
	by alsa0.perex.cz (Postfix) with ESMTP id CF6DF1038FB
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 13:40:14 +0200 (CEST)
Received: by mail-bw0-f43.google.com with SMTP id s6so834377bka.30
	for <alsa-devel@alsa-project.org>; Tue, 04 Oct 2011 04:40:13 -0700 (PDT)
In-Reply-To: <1317728389-22062-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Handle the info_volsw/info_volsw_2r in one function.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/sound/soc.h  |    8 +++-----
 sound/soc/soc-core.c |   40 +++-------------------------------------
 2 files changed, 6 insertions(+), 42 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 59e72a8..190d603 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -63,7 +63,7 @@
 					  max, invert) }
 #define SOC_DOUBLE_R(xname, reg_left, reg_right, xshift, xmax, xinvert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
-	.info = snd_soc_info_volsw_2r, \
+	.info = snd_soc_info_volsw, \
 	.get = snd_soc_get_volsw_2r, .put = snd_soc_put_volsw_2r, \
 	.private_value = SOC_DOUBLE_R_VALUE(reg_left, reg_right, xshift, \
 					    xmax, xinvert) }
@@ -81,7 +81,7 @@
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
 		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
 	.tlv.p = (tlv_array), \
-	.info = snd_soc_info_volsw_2r, \
+	.info = snd_soc_info_volsw, \
 	.get = snd_soc_get_volsw_2r, .put = snd_soc_put_volsw_2r, \
 	.private_value = SOC_DOUBLE_R_VALUE(reg_left, reg_right, xshift, \
 					    xmax, xinvert) }
@@ -156,7 +156,7 @@
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
 		 SNDRV_CTL_ELEM_ACCESS_READWRITE, \
 	.tlv.p = (tlv_array), \
-	.info = snd_soc_info_volsw_2r, \
+	.info = snd_soc_info_volsw, \
 	.get = xhandler_get, .put = xhandler_put, \
 	.private_value = SOC_DOUBLE_R_VALUE(reg_left, reg_right, xshift, \
 					    xmax, xinvert) }
@@ -393,8 +393,6 @@ int snd_soc_get_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
-int snd_soc_info_volsw_2r(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_info *uinfo);
 int snd_soc_get_volsw_2r(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_put_volsw_2r(struct snd_kcontrol *kcontrol,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1ed8093..d588bb1 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2248,7 +2248,8 @@ EXPORT_SYMBOL_GPL(snd_soc_info_volsw_ext);
  * @kcontrol: mixer control
  * @uinfo: control element information
  *
- * Callback to provide information about a single mixer control.
+ * Callback to provide information about a single mixer control, or a double
+ * mixer control that spans 2 registers.
  *
  * Returns 0 for success.
  */
@@ -2258,8 +2259,6 @@ int snd_soc_info_volsw(struct snd_kcontrol *kcontrol,
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	int platform_max;
-	unsigned int shift = mc->shift;
-	unsigned int rshift = mc->rshift;
 
 	if (!mc->platform_max)
 		mc->platform_max = mc->max;
@@ -2270,7 +2269,7 @@ int snd_soc_info_volsw(struct snd_kcontrol *kcontrol,
 	else
 		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 
-	uinfo->count = shift == rshift ? 1 : 2;
+	uinfo->count = snd_soc_volsw_is_stereo(mc) ? 2 : 1;
 	uinfo->value.integer.min = 0;
 	uinfo->value.integer.max = platform_max;
 	return 0;
@@ -2356,39 +2355,6 @@ int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 EXPORT_SYMBOL_GPL(snd_soc_put_volsw);
 
 /**
- * snd_soc_info_volsw_2r - double mixer info callback
- * @kcontrol: mixer control
- * @uinfo: control element information
- *
- * Callback to provide information about a double mixer control that
- * spans 2 codec registers.
- *
- * Returns 0 for success.
- */
-int snd_soc_info_volsw_2r(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_info *uinfo)
-{
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-	int platform_max;
-
-	if (!mc->platform_max)
-		mc->platform_max = mc->max;
-	platform_max = mc->platform_max;
-
-	if (platform_max == 1 && !strstr(kcontrol->id.name, " Volume"))
-		uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
-	else
-		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-
-	uinfo->count = 2;
-	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = platform_max;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_soc_info_volsw_2r);
-
-/**
  * snd_soc_get_volsw_2r - double mixer get callback
  * @kcontrol: mixer control
  * @ucontrol: control element information
-- 
1.7.7
