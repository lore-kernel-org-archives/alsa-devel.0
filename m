From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: Use snd_soc_info_enum_double() for
	SOC_ENUM_EXT controls
Date: Sat, 10 Aug 2013 21:33:10 +0200
Message-ID: <1376163190-25039-2-git-send-email-lars@metafoo.de>
References: <1376163190-25039-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-040.synserver.de (smtp-out-041.synserver.de
 [212.40.185.41])
 by alsa0.perex.cz (Postfix) with ESMTP id F3D83261AA1
 for <alsa-devel@alsa-project.org>; Sat, 10 Aug 2013 21:32:15 +0200 (CEST)
In-Reply-To: <1376163190-25039-1-git-send-email-lars@metafoo.de>
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

snd_soc_info_enum_ext() and snd_soc_info_enum_double() are almost identical. The
only difference is that snd_soc_info_enum_double() is also able to handle stereo
controls. Using snd_soc_info_enum double() instead of snd_soc_info_enum_ext()
for the SOC_ENUM_EXT control's info callback allows us to remove
snd_soc_info_enum_ext().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  |  4 +---
 sound/soc/soc-core.c | 27 ---------------------------
 2 files changed, 1 insertion(+), 30 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 64eb60a..a468e7b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -234,7 +234,7 @@
 	.private_value = xdata }
 #define SOC_ENUM_EXT(xname, xenum, xhandler_get, xhandler_put) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-	.info = snd_soc_info_enum_ext, \
+	.info = snd_soc_info_enum_double, \
 	.get = xhandler_get, .put = xhandler_put, \
 	.private_value = (unsigned long)&xenum }
 
@@ -487,8 +487,6 @@ int snd_soc_add_dai_controls(struct snd_soc_dai *dai,
 	const struct snd_kcontrol_new *controls, int num_controls);
 int snd_soc_info_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo);
-int snd_soc_info_enum_ext(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_info *uinfo);
 int snd_soc_get_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_put_enum_double(struct snd_kcontrol *kcontrol,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 47cb2c0..001154f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2567,33 +2567,6 @@ int snd_soc_put_value_enum_double(struct snd_kcontrol *kcontrol,
 EXPORT_SYMBOL_GPL(snd_soc_put_value_enum_double);
 
 /**
- * snd_soc_info_enum_ext - external enumerated single mixer info callback
- * @kcontrol: mixer control
- * @uinfo: control element information
- *
- * Callback to provide information about an external enumerated
- * single mixer.
- *
- * Returns 0 for success.
- */
-int snd_soc_info_enum_ext(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_info *uinfo)
-{
-	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
-
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = e->max;
-
-	if (uinfo->value.enumerated.item > e->max - 1)
-		uinfo->value.enumerated.item = e->max - 1;
-	strcpy(uinfo->value.enumerated.name,
-		e->texts[uinfo->value.enumerated.item]);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_soc_info_enum_ext);
-
-/**
  * snd_soc_info_volsw - single mixer info callback
  * @kcontrol: mixer control
  * @uinfo: control element information
-- 
1.8.0
