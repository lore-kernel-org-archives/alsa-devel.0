From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH] ASOC, rename mask to max where appropriate
Date: Wed, 23 Jul 2008 18:39:06 -0400
Message-ID: <20080723223906.4636.19213.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.231])
	by alsa0.perex.cz (Postfix) with ESMTP id E69A82488F
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jul 2008 00:39:08 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 36so1434396wra.24
	for <alsa-devel@alsa-project.org>; Wed, 23 Jul 2008 15:39:07 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Where appropriate, rename ASOC mask variables to
max to reflect their use

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---

 include/sound/soc.h  |   22 +++++++++++-----------
 sound/soc/soc-core.c |   20 ++++++++++----------
 sound/soc/soc-dapm.c |   14 +++++++-------
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index cc64b04..412cd83 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -88,25 +88,25 @@
 	.put    = snd_soc_put_volsw_s8, \
 	.private_value = (unsigned long)&(struct soc_mixer_control) \
 		{.reg = xreg, .min = xmin, .max = xmax} }
-#define SOC_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, xtexts) \
+#define SOC_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmax, xtexts) \
 {	.reg = xreg, .shift_l = xshift_l, .shift_r = xshift_r, \
-	.mask = xmask, .texts = xtexts }
-#define SOC_ENUM_SINGLE(xreg, xshift, xmask, xtexts) \
-	SOC_ENUM_DOUBLE(xreg, xshift, xshift, xmask, xtexts)
-#define SOC_ENUM_SINGLE_EXT(xmask, xtexts) \
-{	.mask = xmask, .texts = xtexts }
+	.max = xmax, .texts = xtexts }
+#define SOC_ENUM_SINGLE(xreg, xshift, xmax, xtexts) \
+	SOC_ENUM_DOUBLE(xreg, xshift, xshift, xmax, xtexts)
+#define SOC_ENUM_SINGLE_EXT(xmax, xtexts) \
+{	.max = xmax, .texts = xtexts }
 #define SOC_ENUM(xname, xenum) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,\
 	.info = snd_soc_info_enum_double, \
 	.get = snd_soc_get_enum_double, .put = snd_soc_put_enum_double, \
 	.private_value = (unsigned long)&xenum }
-#define SOC_SINGLE_EXT(xname, xreg, xshift, xmask, xinvert,\
+#define SOC_SINGLE_EXT(xname, xreg, xshift, xmax, xinvert,\
 	 xhandler_get, xhandler_put) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_volsw, \
 	.get = xhandler_get, .put = xhandler_put, \
-	.private_value = SOC_SINGLE_VALUE(xreg, xshift, xmask, xinvert) }
-#define SOC_SINGLE_EXT_TLV(xname, xreg, xshift, xmask, xinvert,\
+	.private_value = SOC_SINGLE_VALUE(xreg, xshift, xmax, xinvert) }
+#define SOC_SINGLE_EXT_TLV(xname, xreg, xshift, xmax, xinvert,\
 	 xhandler_get, xhandler_put, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
@@ -114,7 +114,7 @@
 	.tlv.p = (tlv_array), \
 	.info = snd_soc_info_volsw, \
 	.get = xhandler_get, .put = xhandler_put, \
-	.private_value = SOC_SINGLE_VALUE(xreg, xshift, xmask, xinvert) }
+	.private_value = SOC_SINGLE_VALUE(xreg, xshift, xmax, xinvert) }
 #define SOC_SINGLE_BOOL_EXT(xname, xdata, xhandler_get, xhandler_put) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_bool_ext, \
@@ -534,7 +534,7 @@ struct soc_enum {
 	unsigned short reg2;
 	unsigned char shift_l;
 	unsigned char shift_r;
-	unsigned int mask;
+	unsigned int max;
 	const char **texts;
 	void *dapm;
 };
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7c59665..c0e6ab4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1296,10 +1296,10 @@ int snd_soc_info_enum_double(struct snd_kcontrol *kcontrol,
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = e->shift_l == e->shift_r ? 1 : 2;
-	uinfo->value.enumerated.items = e->mask;
+	uinfo->value.enumerated.items = e->max;
 
-	if (uinfo->value.enumerated.item > e->mask - 1)
-		uinfo->value.enumerated.item = e->mask - 1;
+	if (uinfo->value.enumerated.item > e->max - 1)
+		uinfo->value.enumerated.item = e->max - 1;
 	strcpy(uinfo->value.enumerated.name,
 		e->texts[uinfo->value.enumerated.item]);
 	return 0;
@@ -1322,7 +1322,7 @@ int snd_soc_get_enum_double(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned short val, bitmask;
 
-	for (bitmask = 1; bitmask < e->mask; bitmask <<= 1)
+	for (bitmask = 1; bitmask < e->max; bitmask <<= 1)
 		;
 	val = snd_soc_read(codec, e->reg);
 	ucontrol->value.enumerated.item[0]
@@ -1352,14 +1352,14 @@ int snd_soc_put_enum_double(struct snd_kcontrol *kcontrol,
 	unsigned short val;
 	unsigned short mask, bitmask;
 
-	for (bitmask = 1; bitmask < e->mask; bitmask <<= 1)
+	for (bitmask = 1; bitmask < e->max; bitmask <<= 1)
 		;
-	if (ucontrol->value.enumerated.item[0] > e->mask - 1)
+	if (ucontrol->value.enumerated.item[0] > e->max - 1)
 		return -EINVAL;
 	val = ucontrol->value.enumerated.item[0] << e->shift_l;
 	mask = (bitmask - 1) << e->shift_l;
 	if (e->shift_l != e->shift_r) {
-		if (ucontrol->value.enumerated.item[1] > e->mask - 1)
+		if (ucontrol->value.enumerated.item[1] > e->max - 1)
 			return -EINVAL;
 		val |= ucontrol->value.enumerated.item[1] << e->shift_r;
 		mask |= (bitmask - 1) << e->shift_r;
@@ -1386,10 +1386,10 @@ int snd_soc_info_enum_ext(struct snd_kcontrol *kcontrol,
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
-	uinfo->value.enumerated.items = e->mask;
+	uinfo->value.enumerated.items = e->max;
 
-	if (uinfo->value.enumerated.item > e->mask - 1)
-		uinfo->value.enumerated.item = e->mask - 1;
+	if (uinfo->value.enumerated.item > e->max - 1)
+		uinfo->value.enumerated.item = e->max - 1;
 	strcpy(uinfo->value.enumerated.name,
 		e->texts[uinfo->value.enumerated.item]);
 	return 0;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b956771..424e4e8 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -125,13 +125,13 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 		struct soc_enum *e = (struct soc_enum *)w->kcontrols[i].private_value;
 		int val, item, bitmask;
 
-		for (bitmask = 1; bitmask < e->mask; bitmask <<= 1)
+		for (bitmask = 1; bitmask < e->max; bitmask <<= 1)
 		;
 		val = snd_soc_read(w->codec, e->reg);
 		item = (val >> e->shift_l) & (bitmask - 1);
 
 		p->connect = 0;
-		for (i = 0; i < e->mask; i++) {
+		for (i = 0; i < e->max; i++) {
 			if (!(strcmp(p->name, e->texts[i])) && item == i)
 				p->connect = 1;
 		}
@@ -168,7 +168,7 @@ static int dapm_connect_mux(struct snd_soc_codec *codec,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	int i;
 
-	for (i = 0; i < e->mask; i++) {
+	for (i = 0; i < e->max; i++) {
 		if (!(strcmp(control_name, e->texts[i]))) {
 			list_add(&path->list, &codec->dapm_paths);
 			list_add(&path->list_sink, &dest->sources);
@@ -1264,7 +1264,7 @@ int snd_soc_dapm_get_enum_double(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned short val, bitmask;
 
-	for (bitmask = 1; bitmask < e->mask; bitmask <<= 1)
+	for (bitmask = 1; bitmask < e->max; bitmask <<= 1)
 		;
 	val = snd_soc_read(widget->codec, e->reg);
 	ucontrol->value.enumerated.item[0] = (val >> e->shift_l) & (bitmask - 1);
@@ -1294,15 +1294,15 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 	unsigned short mask, bitmask;
 	int ret = 0;
 
-	for (bitmask = 1; bitmask < e->mask; bitmask <<= 1)
+	for (bitmask = 1; bitmask < e->max; bitmask <<= 1)
 		;
-	if (ucontrol->value.enumerated.item[0] > e->mask - 1)
+	if (ucontrol->value.enumerated.item[0] > e->max - 1)
 		return -EINVAL;
 	mux = ucontrol->value.enumerated.item[0];
 	val = mux << e->shift_l;
 	mask = (bitmask - 1) << e->shift_l;
 	if (e->shift_l != e->shift_r) {
-		if (ucontrol->value.enumerated.item[1] > e->mask - 1)
+		if (ucontrol->value.enumerated.item[1] > e->max - 1)
 			return -EINVAL;
 		val |= ucontrol->value.enumerated.item[1] << e->shift_r;
 		mask |= (bitmask - 1) << e->shift_r;
