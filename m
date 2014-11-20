From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 01/10] ALSA: usb-audio: Refactor
	ignore_ctl_error checks
Date: Thu, 20 Nov 2014 18:33:26 +0100
Message-ID: <1416504815-28685-2-git-send-email-tiwai@suse.de>
References: <1416504815-28685-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D9C826061A
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 18:33:47 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E3D8AAD06
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 17:33:46 +0000 (UTC)
In-Reply-To: <1416504815-28685-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Introduce an internal helper macro for avoiding many open codes.

The only slight behavior change is in a couple of get ballcks where
the value is reset at error no matter whether ignore_ctl_error is set
or not.  Actually this is even safer than before.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 14e1455ca9de..7756fcf877e0 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -136,6 +136,10 @@ check_mapped_name(const struct usbmix_name_map *p, char *buf, int buflen)
 	return strlcpy(buf, p->name, buflen);
 }
 
+/* ignore the error value if ignore_ctl_error flag is set */
+#define filter_error(cval, err) \
+	((cval)->mixer->ignore_ctl_error ? 0 : (err))
+
 /* check whether the control should be ignored */
 static inline int
 check_ignored_ctl(const struct usbmix_name_map *p)
@@ -1088,7 +1092,7 @@ static int mixer_ctl_feature_get(struct snd_kcontrol *kcontrol,
 				continue;
 			err = snd_usb_get_cur_mix_value(cval, c + 1, cnt, &val);
 			if (err < 0)
-				return cval->mixer->ignore_ctl_error ? 0 : err;
+				return filter_error(cval, err);
 			val = get_relative_value(cval, val);
 			ucontrol->value.integer.value[cnt] = val;
 			cnt++;
@@ -1098,7 +1102,7 @@ static int mixer_ctl_feature_get(struct snd_kcontrol *kcontrol,
 		/* master channel */
 		err = snd_usb_get_cur_mix_value(cval, 0, 0, &val);
 		if (err < 0)
-			return cval->mixer->ignore_ctl_error ? 0 : err;
+			return filter_error(cval, err);
 		val = get_relative_value(cval, val);
 		ucontrol->value.integer.value[0] = val;
 	}
@@ -1120,7 +1124,7 @@ static int mixer_ctl_feature_put(struct snd_kcontrol *kcontrol,
 				continue;
 			err = snd_usb_get_cur_mix_value(cval, c + 1, cnt, &oval);
 			if (err < 0)
-				return cval->mixer->ignore_ctl_error ? 0 : err;
+				return filter_error(cval, err);
 			val = ucontrol->value.integer.value[cnt];
 			val = get_abs_value(cval, val);
 			if (oval != val) {
@@ -1133,7 +1137,7 @@ static int mixer_ctl_feature_put(struct snd_kcontrol *kcontrol,
 		/* master channel */
 		err = snd_usb_get_cur_mix_value(cval, 0, 0, &oval);
 		if (err < 0)
-			return cval->mixer->ignore_ctl_error ? 0 : err;
+			return filter_error(cval, err);
 		val = ucontrol->value.integer.value[0];
 		val = get_abs_value(cval, val);
 		if (val != oval) {
@@ -1628,12 +1632,10 @@ static int mixer_ctl_procunit_get(struct snd_kcontrol *kcontrol,
 	int err, val;
 
 	err = get_cur_ctl_value(cval, cval->control << 8, &val);
-	if (err < 0 && cval->mixer->ignore_ctl_error) {
+	if (err < 0) {
 		ucontrol->value.integer.value[0] = cval->min;
-		return 0;
+		return filter_error(cval, err);
 	}
-	if (err < 0)
-		return err;
 	val = get_relative_value(cval, val);
 	ucontrol->value.integer.value[0] = val;
 	return 0;
@@ -1647,11 +1649,8 @@ static int mixer_ctl_procunit_put(struct snd_kcontrol *kcontrol,
 	int val, oval, err;
 
 	err = get_cur_ctl_value(cval, cval->control << 8, &oval);
-	if (err < 0) {
-		if (cval->mixer->ignore_ctl_error)
-			return 0;
-		return err;
-	}
+	if (err < 0)
+		return filter_error(cval, err);
 	val = ucontrol->value.integer.value[0];
 	val = get_abs_value(cval, val);
 	if (val != oval) {
@@ -1923,11 +1922,8 @@ static int mixer_ctl_selector_get(struct snd_kcontrol *kcontrol,
 
 	err = get_cur_ctl_value(cval, cval->control << 8, &val);
 	if (err < 0) {
-		if (cval->mixer->ignore_ctl_error) {
-			ucontrol->value.enumerated.item[0] = 0;
-			return 0;
-		}
-		return err;
+		ucontrol->value.enumerated.item[0] = 0;
+		return filter_error(cval, err);
 	}
 	val = get_relative_value(cval, val);
 	ucontrol->value.enumerated.item[0] = val;
@@ -1942,11 +1938,8 @@ static int mixer_ctl_selector_put(struct snd_kcontrol *kcontrol,
 	int val, oval, err;
 
 	err = get_cur_ctl_value(cval, cval->control << 8, &oval);
-	if (err < 0) {
-		if (cval->mixer->ignore_ctl_error)
-			return 0;
-		return err;
-	}
+	if (err < 0)
+		return filter_error(cval, err);
 	val = ucontrol->value.enumerated.item[0];
 	val = get_abs_value(cval, val);
 	if (val != oval) {
-- 
2.1.3
