From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ASoC: Fix wrong data type access in a few
	codec drivers
Date: Fri, 13 May 2011 17:24:23 +0300
Message-ID: <1305296663-8284-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 82F362413A
	for <alsa-devel@alsa-project.org>;
	Fri, 13 May 2011 16:24:51 +0200 (CEST)
Received: by ewy6 with SMTP id 6so776438ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 13 May 2011 07:24:49 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Commit fafd217 ("ASoC: Store a list of widgets in a DAPM mux/mixer kcontrol")
changed the control private data type that is passed to snd_soc_cnew when
creating dapm mixer and mux controls. Commit did not update a few codec
drivers that are using their own put callbacks and thus are accessing a
wrong data type.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Stephen Warren <swarren@nvidia.com>
---
This was noted as a null pointer deference when trying to do mutex_lock in
tlv320aic3x: snd_soc_dapm_put_volsw_aic3x but I believe something similar
could orrur also in wm8993 and wm8903 too.
---
 sound/soc/codecs/tlv320aic3x.c |    3 ++-
 sound/soc/codecs/wm8903.c      |    3 ++-
 sound/soc/codecs/wm8993.c      |    3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 6c43c13..c3d96fc 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -157,7 +157,8 @@ static int aic3x_read(struct snd_soc_codec *codec, unsigned int reg,
 static int snd_soc_dapm_put_volsw_aic3x(struct snd_kcontrol *kcontrol,
 					struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget *widget = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	unsigned int reg = mc->reg;
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 957cd66..43e3d76 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -382,7 +382,8 @@ static void wm8903_seq_notifier(struct snd_soc_dapm_context *dapm,
 static int wm8903_class_w_put(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget *widget = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
 	struct snd_soc_codec *codec = widget->codec;
 	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
 	u16 reg;
diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 056aef9..9e5ff78 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -718,7 +718,8 @@ static int clk_sys_event(struct snd_soc_dapm_widget *w,
 static int class_w_put(struct snd_kcontrol *kcontrol,
 		       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget *widget = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
 	struct snd_soc_codec *codec = widget->codec;
 	struct wm8993_priv *wm8993 = snd_soc_codec_get_drvdata(codec);
 	int ret;
-- 
1.7.0.4
