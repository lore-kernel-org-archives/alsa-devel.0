From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/20] ALSA: hda - Add helper functions to
	cache the current pinctl target
Date: Tue, 15 Jan 2013 12:05:33 +0100
Message-ID: <1358247947-13992-7-git-send-email-tiwai@suse.de>
References: <1358247947-13992-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B432F26531D
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:50 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 7FC87A5213
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

We already have the list of whole pin widgets and there is an unused
space in the list; let's use it for caching the current pinctl value.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 27 +++++++++++++++++++++++++++
 sound/pci/hda/hda_codec.h |  4 ++--
 sound/pci/hda/hda_local.h |  4 ++++
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 733bce6..505cb72 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1100,6 +1100,32 @@ unsigned int snd_hda_codec_get_pincfg(struct hda_codec *codec, hda_nid_t nid)
 }
 EXPORT_SYMBOL_HDA(snd_hda_codec_get_pincfg);
 
+/* remember the current pinctl target value */
+int snd_hda_codec_set_pin_target(struct hda_codec *codec, hda_nid_t nid,
+				 unsigned int val)
+{
+	struct hda_pincfg *pin;
+
+	pin = look_up_pincfg(codec, &codec->init_pins, nid);
+	if (!pin)
+		return -EINVAL;
+	pin->target = val;
+	return 0;
+}
+EXPORT_SYMBOL_HDA(snd_hda_codec_set_pin_target);
+
+/* return the current pinctl target value */
+int snd_hda_codec_get_pin_target(struct hda_codec *codec, hda_nid_t nid)
+{
+	struct hda_pincfg *pin;
+
+	pin = look_up_pincfg(codec, &codec->init_pins, nid);
+	if (!pin)
+		return 0;
+	return pin->target;
+}
+EXPORT_SYMBOL_HDA(snd_hda_codec_get_pin_target);
+
 /**
  * snd_hda_shutup_pins - Shut up all pins
  * @codec: the HDA codec
@@ -5266,6 +5292,7 @@ int _snd_hda_set_pin_ctl(struct hda_codec *codec, hda_nid_t pin,
 				val &= ~(AC_PINCTL_IN_EN | AC_PINCTL_VREFEN);
 		}
 	}
+	snd_hda_codec_set_pin_target(codec, pin, val);
 	if (cached)
 		return snd_hda_codec_update_cache(codec, pin, 0,
 				AC_VERB_SET_PIN_WIDGET_CONTROL, val);
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 93ec747..4c4f166 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -981,8 +981,8 @@ void snd_hda_codec_resume_cache(struct hda_codec *codec);
 /* the struct for codec->pin_configs */
 struct hda_pincfg {
 	hda_nid_t nid;
-	unsigned char ctrl;	/* current pin control value */
-	unsigned char pad;	/* reserved */
+	unsigned char ctrl;	/* original pin control value */
+	unsigned char target;	/* target pin control value */
 	unsigned int cfg;	/* default configuration */
 };
 
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index fec0e2d..655a40f 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -529,6 +529,10 @@ snd_hda_set_pin_ctl_cache(struct hda_codec *codec, hda_nid_t pin,
 	return _snd_hda_set_pin_ctl(codec, pin, val, true);
 }
 
+int snd_hda_codec_get_pin_target(struct hda_codec *codec, hda_nid_t nid);
+int snd_hda_codec_set_pin_target(struct hda_codec *codec, hda_nid_t nid,
+				 unsigned int val);
+
 /*
  * get widget capabilities
  */
-- 
1.8.1
