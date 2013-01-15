From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 07/20] ALSA: hda - More strict correction of
	invalid pinctl bits
Date: Tue, 15 Jan 2013 12:05:34 +0100
Message-ID: <1358247947-13992-8-git-send-email-tiwai@suse.de>
References: <1358247947-13992-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BA180265326
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:50 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 910FFA522C
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:48 +0100 (CET)
In-Reply-To: <1358247947-13992-1-git-send-email-tiwai@suse.de>
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

Check more strictly about the validity of pinctl values in
snd_hda_set_pin_ctl() and correct the wrong bits automatically.
Also provide the helper function to correct pinctl bits to codec
drivers.

This automatically fixes the invalid pinctl writes that are found in
a few Realtek fixups for NID 0x0f amp like ASUS A6Rp.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 66 +++++++++++++++++++++++++++++++++++++----------
 sound/pci/hda/hda_local.h |  2 ++
 2 files changed, 54 insertions(+), 14 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 505cb72..0a531f2 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -5275,23 +5275,61 @@ unsigned int snd_hda_get_default_vref(struct hda_codec *codec, hda_nid_t pin)
 }
 EXPORT_SYMBOL_HDA(snd_hda_get_default_vref);
 
+/* correct the pin ctl value for matching with the pin cap */
+unsigned int snd_hda_correct_pin_ctl(struct hda_codec *codec,
+				     hda_nid_t pin, unsigned int val)
+{
+	static unsigned int cap_lists[][2] = {
+		{ AC_PINCTL_VREF_100, AC_PINCAP_VREF_100 },
+		{ AC_PINCTL_VREF_80, AC_PINCAP_VREF_80 },
+		{ AC_PINCTL_VREF_50, AC_PINCAP_VREF_50 },
+		{ AC_PINCTL_VREF_GRD, AC_PINCAP_VREF_GRD },
+	};
+	unsigned int cap;
+
+	if (!val)
+		return 0;
+	cap = snd_hda_query_pin_caps(codec, pin);
+	if (!cap)
+		return val; /* don't know what to do... */
+
+	if (val & AC_PINCTL_OUT_EN) {
+		if (!(cap & AC_PINCAP_OUT))
+			val &= ~(AC_PINCTL_OUT_EN | AC_PINCTL_HP_EN);
+		else if ((val & AC_PINCTL_HP_EN) && !(cap & AC_PINCAP_HP_DRV))
+			val &= ~AC_PINCTL_HP_EN;
+	}
+
+	if (val & AC_PINCTL_IN_EN) {
+		if (!(cap & AC_PINCAP_IN))
+			val &= ~(AC_PINCTL_IN_EN | AC_PINCTL_VREFEN);
+		else {
+			unsigned int vcap, vref;
+			int i;
+			vcap = (cap & AC_PINCAP_VREF) >> AC_PINCAP_VREF_SHIFT;
+			vref = val & AC_PINCTL_VREFEN;
+			for (i = 0; i < ARRAY_SIZE(cap_lists); i++) {
+				if (vref == cap_lists[i][0] &&
+				    !(vcap & cap_lists[i][1])) {
+					if (i == ARRAY_SIZE(cap_lists) - 1)
+						vref = AC_PINCTL_VREF_HIZ;
+					else
+						vref = cap_lists[i + 1][0];
+				}
+			}
+			val &= ~AC_PINCTL_VREFEN;
+			val |= vref;
+		}
+	}
+
+	return val;
+}
+EXPORT_SYMBOL_HDA(snd_hda_correct_pin_ctl);
+
 int _snd_hda_set_pin_ctl(struct hda_codec *codec, hda_nid_t pin,
 			 unsigned int val, bool cached)
 {
-	if (val) {
-		unsigned int cap = snd_hda_query_pin_caps(codec, pin);
-		if (cap && (val & AC_PINCTL_OUT_EN)) {
-			if (!(cap & AC_PINCAP_OUT))
-				val &= ~(AC_PINCTL_OUT_EN | AC_PINCTL_HP_EN);
-			else if ((val & AC_PINCTL_HP_EN) &&
-				 !(cap & AC_PINCAP_HP_DRV))
-				val &= ~AC_PINCTL_HP_EN;
-		}
-		if (cap && (val & AC_PINCTL_IN_EN)) {
-			if (!(cap & AC_PINCAP_IN))
-				val &= ~(AC_PINCTL_IN_EN | AC_PINCTL_VREFEN);
-		}
-	}
+	val = snd_hda_correct_pin_ctl(codec, pin, val);
 	snd_hda_codec_set_pin_target(codec, pin, val);
 	if (cached)
 		return snd_hda_codec_update_cache(codec, pin, 0,
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 655a40f..aa721aa 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -490,6 +490,8 @@ struct hda_bus_unsolicited {
 #define PIN_HP_AMP		(AC_PINCTL_HP_EN)
 
 unsigned int snd_hda_get_default_vref(struct hda_codec *codec, hda_nid_t pin);
+unsigned int snd_hda_correct_pin_ctl(struct hda_codec *codec,
+				     hda_nid_t pin, unsigned int val);
 int _snd_hda_set_pin_ctl(struct hda_codec *codec, hda_nid_t pin,
 			 unsigned int val, bool cached);
 
-- 
1.8.1
