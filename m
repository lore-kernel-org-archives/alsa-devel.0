From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 02/11] ASoC: Consolidate enum and value enum
	controls
Date: Sun, 23 Feb 2014 16:10:12 +0100
Message-ID: <1393168221-23018-3-git-send-email-lars@metafoo.de>
References: <1393168221-23018-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-167.synserver.de (smtp-out-249.synserver.de
 [212.40.185.249])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E57D265144
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 16:10:07 +0100 (CET)
In-Reply-To: <1393168221-23018-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, =?UTF-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Jerry Wong <jerry.wong@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org

The implementations for enum and value enum controls are almost identical. The
only difference is that the value enum uses an additional look-up table to map
the control value to the register value, while the enum control uses a direct
mapping. Enums and value enums can easily be distinguished at runtime, for value
enums the values field of the snd_soc_enum struct contains the look-up table,
while for enums it is NULL. This patch adds two new small helper functions
called snd_soc_enum_item_to_val() and snd_soc_enum_val_to_item() which map
between register value and control item. If the items field of the snd_soc_enum
struct is NULL the function will do a direct mapping otherwise they'll use the
look-up table to do the mapping. Using these small helper functions it is
possible to use the same kcontrol handlers for both enums and value enums. The
functions are added a inline functions in soc.h so they can also be used by the
DAPM code to accomplish similar consolidation.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  |  34 ++++++++++++-----
 sound/soc/soc-core.c | 101 ++++++++-------------------------------------------
 2 files changed, 41 insertions(+), 94 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 8ffaa46..e005196 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -195,11 +195,7 @@
 	.get = snd_soc_get_enum_double, .put = snd_soc_put_enum_double, \
 	.private_value = (unsigned long)&xenum }
 #define SOC_VALUE_ENUM(xname, xenum) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,\
-	.info = snd_soc_info_enum_double, \
-	.get = snd_soc_get_value_enum_double, \
-	.put = snd_soc_put_value_enum_double, \
-	.private_value = (unsigned long)&xenum }
+	SOC_ENUM(xname, xenum)
 #define SOC_SINGLE_EXT(xname, xreg, xshift, xmax, xinvert,\
 	 xhandler_get, xhandler_put) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
@@ -508,10 +504,6 @@ int snd_soc_get_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_put_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
-int snd_soc_get_value_enum_double(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol);
-int snd_soc_put_value_enum_double(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_info_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo);
 #define snd_soc_info_bool_ext		snd_ctl_boolean_mono_info
@@ -1180,6 +1172,30 @@ static inline bool snd_soc_volsw_is_stereo(struct soc_mixer_control *mc)
 	return 1;
 }
 
+static inline unsigned int snd_soc_enum_val_to_item(struct soc_enum *e,
+	unsigned int val)
+{
+	unsigned int i;
+
+	if (!e->values)
+		return val;
+
+	for (i = 0; i < e->items; i++)
+		if (val == e->values[i])
+			return i;
+
+	return 0;
+}
+
+static inline unsigned int snd_soc_enum_item_to_val(struct soc_enum *e,
+	unsigned int item)
+{
+	if (!e->values)
+		return item;
+
+	return e->values[item];
+}
+
 int snd_soc_util_init(void);
 void snd_soc_util_exit(void);
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0911856..bc8da80 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2596,14 +2596,18 @@ int snd_soc_get_enum_double(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
-	unsigned int val;
+	unsigned int val, item;
+	unsigned int reg_val;
 
-	val = snd_soc_read(codec, e->reg);
-	ucontrol->value.enumerated.item[0]
-		= (val >> e->shift_l) & e->mask;
-	if (e->shift_l != e->shift_r)
-		ucontrol->value.enumerated.item[1] =
-			(val >> e->shift_r) & e->mask;
+	reg_val = snd_soc_read(codec, e->reg);
+	val = (reg_val >> e->shift_l) & e->mask;
+	item = snd_soc_enum_val_to_item(e, val);
+	ucontrol->value.enumerated.item[0] = item;
+	if (e->shift_l != e->shift_r) {
+		val = (reg_val >> e->shift_l) & e->mask;
+		item = snd_soc_enum_val_to_item(e, val);
+		ucontrol->value.enumerated.item[1] = item;
+	}
 
 	return 0;
 }
@@ -2623,17 +2627,18 @@ int snd_soc_put_enum_double(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	unsigned int *item = ucontrol->value.enumerated.item;
 	unsigned int val;
 	unsigned int mask;
 
-	if (ucontrol->value.enumerated.item[0] >= e->items)
+	if (item[0] >= e->items)
 		return -EINVAL;
-	val = ucontrol->value.enumerated.item[0] << e->shift_l;
+	val = snd_soc_enum_item_to_val(e, item[0]) << e->shift_l;
 	mask = e->mask << e->shift_l;
 	if (e->shift_l != e->shift_r) {
-		if (ucontrol->value.enumerated.item[1] >= e->items)
+		if (item[1] >= e->items)
 			return -EINVAL;
-		val |= ucontrol->value.enumerated.item[1] << e->shift_r;
+		val |= snd_soc_enum_item_to_val(e, item[1]) << e->shift_r;
 		mask |= e->mask << e->shift_r;
 	}
 
@@ -2642,80 +2647,6 @@ int snd_soc_put_enum_double(struct snd_kcontrol *kcontrol,
 EXPORT_SYMBOL_GPL(snd_soc_put_enum_double);
 
 /**
- * snd_soc_get_value_enum_double - semi enumerated double mixer get callback
- * @kcontrol: mixer control
- * @ucontrol: control element information
- *
- * Callback to get the value of a double semi enumerated mixer.
- *
- * Semi enumerated mixer: the enumerated items are referred as values. Can be
- * used for handling bitfield coded enumeration for example.
- *
- * Returns 0 for success.
- */
-int snd_soc_get_value_enum_double(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
-	unsigned int reg_val, val, mux;
-
-	reg_val = snd_soc_read(codec, e->reg);
-	val = (reg_val >> e->shift_l) & e->mask;
-	for (mux = 0; mux < e->items; mux++) {
-		if (val == e->values[mux])
-			break;
-	}
-	ucontrol->value.enumerated.item[0] = mux;
-	if (e->shift_l != e->shift_r) {
-		val = (reg_val >> e->shift_r) & e->mask;
-		for (mux = 0; mux < e->items; mux++) {
-			if (val == e->values[mux])
-				break;
-		}
-		ucontrol->value.enumerated.item[1] = mux;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_soc_get_value_enum_double);
-
-/**
- * snd_soc_put_value_enum_double - semi enumerated double mixer put callback
- * @kcontrol: mixer control
- * @ucontrol: control element information
- *
- * Callback to set the value of a double semi enumerated mixer.
- *
- * Semi enumerated mixer: the enumerated items are referred as values. Can be
- * used for handling bitfield coded enumeration for example.
- *
- * Returns 0 for success.
- */
-int snd_soc_put_value_enum_double(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
-	unsigned int val;
-	unsigned int mask;
-
-	if (ucontrol->value.enumerated.item[0] >= e->items)
-		return -EINVAL;
-	val = e->values[ucontrol->value.enumerated.item[0]] << e->shift_l;
-	mask = e->mask << e->shift_l;
-	if (e->shift_l != e->shift_r) {
-		if (ucontrol->value.enumerated.item[1] >= e->items)
-			return -EINVAL;
-		val |= e->values[ucontrol->value.enumerated.item[1]] << e->shift_r;
-		mask |= e->mask << e->shift_r;
-	}
-
-	return snd_soc_update_bits_locked(codec, e->reg, mask, val);
-}
-EXPORT_SYMBOL_GPL(snd_soc_put_value_enum_double);
-
-/**
  * snd_soc_read_signed - Read a codec register and interprete as signed value
  * @codec: codec
  * @reg: Register to read
-- 
1.8.0
