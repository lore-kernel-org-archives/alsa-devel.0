From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: Remove unused
	snd_soc_info_volsw_ext()
Date: Sat, 10 Aug 2013 21:33:09 +0200
Message-ID: <1376163190-25039-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-040.synserver.de (smtp-out-041.synserver.de
 [212.40.185.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F994261AC9
 for <alsa-devel@alsa-project.org>; Sat, 10 Aug 2013 21:32:09 +0200 (CEST)
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

The SOC_SINGLE_EXT control has been using snd_soc_info_volsw() for its info
callback since commit 1c433fb ("[ALSA] soc - 0.13 ASoC headers"). The
snd_soc_info_volsw_ext() function has been unused ever since then, so remove it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  |  2 --
 sound/soc/soc-core.c | 26 --------------------------
 2 files changed, 28 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 13d388a..64eb60a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -499,8 +499,6 @@ int snd_soc_put_value_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_info_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo);
-int snd_soc_info_volsw_ext(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_info *uinfo);
 #define snd_soc_info_bool_ext		snd_ctl_boolean_mono_info
 int snd_soc_get_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index fdddc45..47cb2c0 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2594,32 +2594,6 @@ int snd_soc_info_enum_ext(struct snd_kcontrol *kcontrol,
 EXPORT_SYMBOL_GPL(snd_soc_info_enum_ext);
 
 /**
- * snd_soc_info_volsw_ext - external single mixer info callback
- * @kcontrol: mixer control
- * @uinfo: control element information
- *
- * Callback to provide information about a single external mixer control.
- *
- * Returns 0 for success.
- */
-int snd_soc_info_volsw_ext(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_info *uinfo)
-{
-	int max = kcontrol->private_value;
-
-	if (max == 1 && !strstr(kcontrol->id.name, " Volume"))
-		uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
-	else
-		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-
-	uinfo->count = 1;
-	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = max;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_soc_info_volsw_ext);
-
-/**
  * snd_soc_info_volsw - single mixer info callback
  * @kcontrol: mixer control
  * @uinfo: control element information
-- 
1.8.0
