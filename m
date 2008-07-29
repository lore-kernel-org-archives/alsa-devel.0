From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH] ASOC: convert use of uint to unsigned int
Date: Tue, 29 Jul 2008 10:22:24 -0400
Message-ID: <20080729142224.19026.32191.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.168])
	by alsa0.perex.cz (Postfix) with ESMTP id 22A4824859
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jul 2008 16:22:26 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so6597377wfg.23
	for <alsa-devel@alsa-project.org>; Tue, 29 Jul 2008 07:22:26 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by terra with esmtp (Exim 4.69) (envelope-from <jonsmirl@gmail.com>)
	id 1KNq5o-0004xP-Lj
	for alsa-devel@alsa-project.org; Tue, 29 Jul 2008 10:22:24 -0400
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
List-Id: alsa-devel@alsa-project.org

ASOC: convert use of uint to unsigned int

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---

 include/sound/soc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 5ca231f..a1e0357 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -527,7 +527,7 @@ struct snd_soc_pcm_runtime {
 /* mixer control */
 struct soc_mixer_control {
 	int min, max;
-	uint reg, rreg, shift, rshift, invert;
+	unsigned int reg, rreg, shift, rshift, invert;
 };
 
 /* enumerated kcontrol */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 11a881c..1563cee 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1457,8 +1457,8 @@ int snd_soc_info_volsw(struct snd_kcontrol *kcontrol,
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	int max = mc->max;
-	uint shift = mc->min;
-	uint rshift = mc->rshift;
+	unsigned int shift = mc->min;
+	unsigned int rshift = mc->rshift;
 
 	if (max == 1)
 		uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
@@ -1487,12 +1487,12 @@ int snd_soc_get_volsw(struct snd_kcontrol *kcontrol,
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	uint reg = mc->reg;
-	uint shift = mc->shift;
-	uint rshift = mc->rshift;
+	unsigned int reg = mc->reg;
+	unsigned int shift = mc->shift;
+	unsigned int rshift = mc->rshift;
 	int max = mc->max;
-	uint mask = (1 << fls(max)) - 1;
-	uint invert = mc->invert;
+	unsigned int mask = (1 << fls(max)) - 1;
+	unsigned int invert = mc->invert;
 
 	ucontrol->value.integer.value[0] =
 		(snd_soc_read(codec, reg) >> shift) & mask;
@@ -1526,12 +1526,12 @@ int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	uint reg = mc->reg;
-	uint shift = mc->shift;
-	uint rshift = mc->rshift;
+	unsigned int reg = mc->reg;
+	unsigned int shift = mc->shift;
+	unsigned int rshift = mc->rshift;
 	int max = mc->max;
-	uint mask = (1 << fls(max)) - 1;
-	uint invert = mc->invert;
+	unsigned int mask = (1 << fls(max)) - 1;
+	unsigned int invert = mc->invert;
 	unsigned short val, val2, val_mask;
 
 	val = (ucontrol->value.integer.value[0] & mask);
@@ -1594,12 +1594,12 @@ int snd_soc_get_volsw_2r(struct snd_kcontrol *kcontrol,
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	uint reg = mc->reg;
-	uint reg2 = mc->rreg;
-	uint shift = mc->shift;
+	unsigned int reg = mc->reg;
+	unsigned int reg2 = mc->rreg;
+	unsigned int shift = mc->shift;
 	int max = mc->max;
-	uint mask = (1<<fls(max))-1;
-	uint invert = mc->invert;
+	unsigned int mask = (1<<fls(max))-1;
+	unsigned int invert = mc->invert;
 
 	ucontrol->value.integer.value[0] =
 		(snd_soc_read(codec, reg) >> shift) & mask;
@@ -1631,12 +1631,12 @@ int snd_soc_put_volsw_2r(struct snd_kcontrol *kcontrol,
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	uint reg = mc->reg;
-	uint reg2 = mc->rreg;
-	uint shift = mc->shift;
+	unsigned int reg = mc->reg;
+	unsigned int reg2 = mc->rreg;
+	unsigned int shift = mc->shift;
 	int max = mc->max;
-	uint mask = (1 << fls(max)) - 1;
-	uint invert = mc->invert;
+	unsigned int mask = (1 << fls(max)) - 1;
+	unsigned int invert = mc->invert;
 	int err;
 	unsigned short val, val2, val_mask;
 
@@ -1701,7 +1701,7 @@ int snd_soc_get_volsw_s8(struct snd_kcontrol *kcontrol,
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	uint reg = mc->reg;
+	unsigned int reg = mc->reg;
 	int min = mc->min;
 	int val = snd_soc_read(codec, reg);
 
@@ -1728,7 +1728,7 @@ int snd_soc_put_volsw_s8(struct snd_kcontrol *kcontrol,
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	uint reg = mc->reg;
+	unsigned int reg = mc->reg;
 	int min = mc->min;
 	unsigned short val;
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index f08be8a..7a88f76 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -106,11 +106,11 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 		int val;
 		struct soc_mixer_control *mc = (struct soc_mixer_control *)
 			w->kcontrols[i].private_value;
-		uint reg = mc->reg;
-		uint shift = mc->shift;
+		unsigned int reg = mc->reg;
+		unsigned int shift = mc->shift;
 		int max = mc->max;
-		uint mask = (1 << fls(max)) - 1;
-		uint invert = mc->invert;
+		unsigned int mask = (1 << fls(max)) - 1;
+		unsigned int invert = mc->invert;
 
 		val = snd_soc_read(w->codec, reg);
 		val = (val >> shift) & mask;
@@ -252,11 +252,11 @@ static int dapm_set_pga(struct snd_soc_dapm_widget *widget, int power)
 	if (widget->num_kcontrols && k) {
 		struct soc_mixer_control *mc =
 			(struct soc_mixer_control *)k->private_value;
-		uint reg = mc->reg;
-		uint shift = mc->shift;
+		unsigned int reg = mc->reg;
+		unsigned int shift = mc->shift;
 		int max = mc->max;
-		uint mask = (1 << fls(max)) - 1;
-		uint invert = mc->invert;
+		unsigned int mask = (1 << fls(max)) - 1;
+		unsigned int invert = mc->invert;
 
 		if (power) {
 			int i;
@@ -1141,12 +1141,12 @@ int snd_soc_dapm_get_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dapm_widget *widget = snd_kcontrol_chip(kcontrol);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	uint reg = mc->reg;
-	uint shift = mc->shift;
-	uint rshift = mc->rshift;
+	unsigned int reg = mc->reg;
+	unsigned int shift = mc->shift;
+	unsigned int rshift = mc->rshift;
 	int max = mc->max;
-	uint invert = mc->invert;
-	uint mask = (1 << fls(max)) - 1;
+	unsigned int invert = mc->invert;
+	unsigned int mask = (1 << fls(max)) - 1;
 
 	/* return the saved value if we are powered down */
 	if (widget->id == snd_soc_dapm_pga && !widget->power) {
@@ -1186,12 +1186,12 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dapm_widget *widget = snd_kcontrol_chip(kcontrol);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	uint reg = mc->reg;
-	uint shift = mc->shift;
-	uint rshift = mc->rshift;
+	unsigned int reg = mc->reg;
+	unsigned int shift = mc->shift;
+	unsigned int rshift = mc->rshift;
 	int max = mc->max;
-	uint mask = (1 << fls(max)) - 1;
-	uint invert = mc->invert;
+	unsigned int mask = (1 << fls(max)) - 1;
+	unsigned int invert = mc->invert;
 	unsigned short val, val2, val_mask;
 	int ret;
