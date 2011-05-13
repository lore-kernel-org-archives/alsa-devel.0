From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCHv2] ASoC: Fix wrong data type access in a few
	codec drivers
Date: Fri, 13 May 2011 19:16:52 +0300
Message-ID: <1305303412-31837-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BDFE2243C1
	for <alsa-devel@alsa-project.org>;
	Fri, 13 May 2011 18:17:03 +0200 (CEST)
Received: by eyg5 with SMTP id 5so805241eyg.38
	for <alsa-devel@alsa-project.org>; Fri, 13 May 2011 09:17:03 -0700 (PDT)
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
Tested-by: Stephen Warren <swarren@nvidia.com>
---
v2:
- wm8994 and wm8995 needs to be changed too. Thanks to
  Stephen Warren <swarren@nvidia.com> for noticing.
- "Otherwise, on Tegra+WM8903, I repro'd the bug, and tested the fix, so:
  Tested-by: Stephen Warren <swarren@nvidia.com>"
---
 sound/soc/codecs/tlv320aic3x.c |    3 ++-
 sound/soc/codecs/wm8903.c      |    3 ++-
 sound/soc/codecs/wm8993.c      |    3 ++-
 sound/soc/codecs/wm8994.c      |    6 ++++--
 sound/soc/codecs/wm8995.c      |    4 ++--
 5 files changed, 12 insertions(+), 7 deletions(-)

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
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index e6dfa10..970a95c 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -877,7 +877,8 @@ static const char *hp_mux_text[] = {
 static int wm8994_put_hp_enum(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget *w = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget *w = wlist->widgets[0];
 	struct snd_soc_codec *codec = w->codec;
 	int ret;
 
@@ -1004,7 +1005,8 @@ SOC_DAPM_SINGLE("AIF1.1 Switch", WM8994_DAC2_RIGHT_MIXER_ROUTING,
 static int wm8994_put_class_w(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget *w = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget *w = wlist->widgets[0];
 	struct snd_soc_codec *codec = w->codec;
 	int ret;
 
diff --git a/sound/soc/codecs/wm8995.c b/sound/soc/codecs/wm8995.c
index 67eaaec..5ad873f 100644
--- a/sound/soc/codecs/wm8995.c
+++ b/sound/soc/codecs/wm8995.c
@@ -305,11 +305,11 @@ static int check_clk_sys(struct snd_soc_dapm_widget *source,
 static int wm8995_put_class_w(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget *w;
+	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget *w = wlist->widgets[0];
 	struct snd_soc_codec *codec;
 	int ret;
 
-	w = snd_kcontrol_chip(kcontrol);
 	codec = w->codec;
 	ret = snd_soc_dapm_put_volsw(kcontrol, ucontrol);
 	wm8995_update_class_w(codec);
-- 
1.7.0.4
