From: Marc Singer <elf@synapse.com>
Subject: [PATCH] Renamed the struct soc_enum field .mask to
	.count. The field refers to the number of enumerable entries
	instead of being a bit mask. This change makes the interface
	a more clear.
Date: Fri, 7 Nov 2008 15:06:56 -0800
Message-ID: <20081107230655.GA30750@friendly.synapse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from henry.synapse.com (henry.synapsedev.com [66.147.194.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 0ED91103826
	for <Alsa-devel@alsa-project.org>; Sat,  8 Nov 2008 00:06:57 +0100 (CET)
Received: from friendly.synapse.com (localhost.localdomain [127.0.0.1])
	by henry.synapse.com (Postfix) with ESMTP id 34254D2C1C7
	for <Alsa-devel@alsa-project.org>; Fri,  7 Nov 2008 15:06:56 -0800 (PST)
Received: from elf by friendly.synapse.com with local (Exim 4.67)
	(envelope-from <elf@synapse.com>) id 1KyaPo-00080E-5v
	for Alsa-devel@alsa-project.org; Fri, 07 Nov 2008 15:06:56 -0800
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Marc Singer <elf@buici.com>
---
 include/sound/soc-codec.h |   14 +++++++-------
 sound/soc/soc-core.c      |   20 ++++++++++----------
 sound/soc/soc-dapm.c      |   14 +++++++-------
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/include/sound/soc-codec.h b/include/sound/soc-codec.h
index d8595ef..d59015a 100644
--- a/include/sound/soc-codec.h
+++ b/include/sound/soc-codec.h
@@ -79,13 +79,13 @@
 	.get = snd_soc_get_volsw_2r, .put = snd_soc_put_volsw_2r, \
 	.private_value = (reg_left) | ((shift) << 8)  | \
 		((max) << 12) | ((invert) << 20) | ((reg_right) << 24) }
-#define SOC_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, xtexts) \
+#define SOC_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xcount, xtexts) \
 {	.reg = xreg, .shift_l = xshift_l, .shift_r = xshift_r, \
-	.mask = xmask, .texts = xtexts }
-#define SOC_ENUM_SINGLE(xreg, xshift, xmask, xtexts) \
-	SOC_ENUM_DOUBLE(xreg, xshift, xshift, xmask, xtexts)
-#define SOC_ENUM_SINGLE_EXT(xmask, xtexts) \
-{	.mask = xmask, .texts = xtexts }
+        .count = xcount, .texts = xtexts }
+#define SOC_ENUM_SINGLE(xreg, xshift, xcount, xtexts) \
+	SOC_ENUM_DOUBLE(xreg, xshift, xshift, xcount, xtexts)
+#define SOC_ENUM_SINGLE_EXT(xcount, xtexts) \
+{	.count = xcount, .texts = xtexts }
 #define SOC_ENUM(xname, xenum) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,\
 	.info = snd_soc_info_enum_double, \
@@ -180,7 +180,7 @@ struct soc_enum {
 	unsigned short reg2;
 	unsigned char shift_l;
 	unsigned char shift_r;
-	unsigned int mask;
+	unsigned int count;	       /* Count of options */
 	const char **texts;
 	void *dapm;
 };
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 706f98d..b8efb4b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1262,10 +1262,10 @@ int snd_soc_info_enum_double(struct snd_kcontrol *kcontrol,
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = e->shift_l == e->shift_r ? 1 : 2;
-	uinfo->value.enumerated.items = e->mask;
+	uinfo->value.enumerated.items = e->count;
 
-	if (uinfo->value.enumerated.item > e->mask - 1)
-		uinfo->value.enumerated.item = e->mask - 1;
+	if (uinfo->value.enumerated.item > e->count - 1)
+		uinfo->value.enumerated.item = e->count - 1;
 	strcpy(uinfo->value.enumerated.name,
 		e->texts[uinfo->value.enumerated.item]);
 	return 0;
@@ -1288,7 +1288,7 @@ int snd_soc_get_enum_double(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned short val, bitmask;
 
-	for (bitmask = 1; bitmask < e->mask; bitmask <<= 1)
+	for (bitmask = 1; bitmask < e->count; bitmask <<= 1)
 		;
 	val = snd_soc_read(codec, e->reg);
 	ucontrol->value.enumerated.item[0] = (val >> e->shift_l) & (bitmask - 1);
@@ -1317,14 +1317,14 @@ int snd_soc_put_enum_double(struct snd_kcontrol *kcontrol,
 	unsigned short val;
 	unsigned short mask, bitmask;
 
-	for (bitmask = 1; bitmask < e->mask; bitmask <<= 1)
+	for (bitmask = 1; bitmask < e->count; bitmask <<= 1)
 		;
-	if (ucontrol->value.enumerated.item[0] > e->mask - 1)
+	if (ucontrol->value.enumerated.item[0] > e->count - 1)
 		return -EINVAL;
 	val = ucontrol->value.enumerated.item[0] << e->shift_l;
 	mask = (bitmask - 1) << e->shift_l;
 	if (e->shift_l != e->shift_r) {
-		if (ucontrol->value.enumerated.item[1] > e->mask - 1)
+		if (ucontrol->value.enumerated.item[1] > e->count - 1)
 			return -EINVAL;
 		val |= ucontrol->value.enumerated.item[1] << e->shift_r;
 		mask |= (bitmask - 1) << e->shift_r;
@@ -1351,10 +1351,10 @@ int snd_soc_info_enum_ext(struct snd_kcontrol *kcontrol,
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
-	uinfo->value.enumerated.items = e->mask;
+	uinfo->value.enumerated.items = e->count;
 
-	if (uinfo->value.enumerated.item > e->mask - 1)
-		uinfo->value.enumerated.item = e->mask - 1;
+	if (uinfo->value.enumerated.item > e->count - 1)
+		uinfo->value.enumerated.item = e->count - 1;
 	strcpy(uinfo->value.enumerated.name,
 		e->texts[uinfo->value.enumerated.item]);
 	return 0;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index f203693..5b83329 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -119,13 +119,13 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 		struct soc_enum *e = (struct soc_enum *)w->kcontrols[i].private_value;
 		int val, item, bitmask;
 
-		for (bitmask = 1; bitmask < e->mask; bitmask <<= 1)
+		for (bitmask = 1; bitmask < e->count; bitmask <<= 1)
 		;
 		val = snd_soc_read(w->codec, e->reg);
 		item = (val >> e->shift_l) & (bitmask - 1);
 
 		p->connect = 0;
-		for (i = 0; i < e->mask; i++) {
+		for (i = 0; i < e->count; i++) {
 			if (!(strcmp(p->name, e->texts[i])) && item == i)
 				p->connect = 1;
 		}
@@ -162,7 +162,7 @@ static int dapm_connect_mux(struct snd_soc_card *soc_card,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	int i;
 
-	for (i = 0; i < e->mask; i++) {
+	for (i = 0; i < e->count; i++) {
 		if (!(strcmp(control_name, e->texts[i]))) {
 			list_add(&path->list, &soc_card->dapm_paths);
 			list_add(&path->list_sink, &dest->sources);
@@ -1197,7 +1197,7 @@ int snd_soc_dapm_get_enum_double(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned short val, bitmask;
 
-	for (bitmask = 1; bitmask < e->mask; bitmask <<= 1)
+	for (bitmask = 1; bitmask < e->count; bitmask <<= 1)
 		;
 	val = snd_soc_read(widget->codec, e->reg);
 	ucontrol->value.enumerated.item[0] = (val >> e->shift_l) & (bitmask - 1);
@@ -1227,15 +1227,15 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 	unsigned short mask, bitmask;
 	int ret = 0;
 
-	for (bitmask = 1; bitmask < e->mask; bitmask <<= 1)
+	for (bitmask = 1; bitmask < e->count; bitmask <<= 1)
 		;
-	if (ucontrol->value.enumerated.item[0] > e->mask - 1)
+	if (ucontrol->value.enumerated.item[0] > e->count - 1)
 		return -EINVAL;
 	mux = ucontrol->value.enumerated.item[0];
 	val = mux << e->shift_l;
 	mask = (bitmask - 1) << e->shift_l;
 	if (e->shift_l != e->shift_r) {
-		if (ucontrol->value.enumerated.item[1] > e->mask - 1)
+		if (ucontrol->value.enumerated.item[1] > e->count - 1)
 			return -EINVAL;
 		val |= ucontrol->value.enumerated.item[1] << e->shift_r;
 		mask |= (bitmask - 1) << e->shift_r;
-- 
1.5.6.5
