From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [PATCH v2- ALSA 1/3] HDA - Allow hda_jack_tbl to use
 another nid for pin sense
Date: Wed, 23 Sep 2015 10:40:45 +0800
Message-ID: <CAN8cciYNotgS=1qis4ciOQqoYwjND4y=tpxJGmZt1HGahTV3+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f169.google.com (mail-ob0-f169.google.com
 [209.85.214.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 36CE7265132
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2015 04:40:47 +0200 (CEST)
Received: by obbbh8 with SMTP id bh8so23274051obb.0
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2015 19:40:46 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, tiwai@suse.de, arthurborsboom@gmail.com
List-Id: alsa-devel@alsa-project.org

- add sense_nid to __snd_hda_jack_add_kctl for pin sense

- update slave pin sense when master pin sense change

- enable unsolicited event when widcap support UNSOL

Signed-off-by: Raymond Yau <superquad.vortex2@gmail.com>

diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index 366efbf..d81d65f 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -19,6 +19,7 @@
 #include "hda_local.h"
 #include "hda_auto_parser.h"
 #include "hda_jack.h"
+#include "hda_generic.h"

 /**
  * is_jack_detectable - Check whether the given pin is jack-detectable
@@ -157,7 +158,14 @@ static void jack_detect_update(struct hda_codec *codec,
     if (jack->phantom_jack)
         jack->pin_sense = AC_PINSENSE_PRESENCE;
     else
-        jack->pin_sense = read_pin_sense(codec, jack->nid);
+        jack->pin_sense = read_pin_sense(codec,
+            jack->sense_nid ? jack->sense_nid : jack->nid);
+
+    if (jack->slave_nid) {
+        struct hda_jack_tbl *slave = snd_hda_jack_tbl_get(codec,
+                jack->slave_nid);
+        slave->pin_sense = jack->pin_sense;
+    }

     /* A gating jack indicates the jack is invalid if gating is unplugged
*/
     if (jack->gating_jack && !snd_hda_jack_detect(codec,
jack->gating_jack))
@@ -269,11 +277,13 @@ snd_hda_jack_detect_enable_callback(struct hda_codec
*codec, hda_nid_t nid,
     jack->jack_detect = 1;
     if (codec->jackpoll_interval > 0)
         return callback; /* No unsol if we're polling instead */
-    err = snd_hda_codec_write_cache(codec, nid, 0,
+    if (is_jack_detectable(codec, nid)) {
+        err = snd_hda_codec_write_cache(codec, nid, 0,
                      AC_VERB_SET_UNSOLICITED_ENABLE,
                      AC_USRSP_EN | jack->tag);
-    if (err < 0)
-        return ERR_PTR(err);
+        if (err < 0)
+            return ERR_PTR(err);
+    }
     return callback;
 }
 EXPORT_SYMBOL_GPL(snd_hda_jack_detect_enable_callback);
@@ -384,7 +394,7 @@ static void hda_free_jack_priv(struct snd_jack *jack)
  * will have the given name and index.
  */
 static int __snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
-              const char *name, bool phantom_jack)
+          const char *name, bool phantom_jack, hda_nid_t sense_nid)
 {
     struct hda_jack_tbl *jack;
     int err, state, type;
@@ -403,6 +413,7 @@ static int __snd_hda_jack_add_kctl(struct hda_codec
*codec, hda_nid_t nid,

     jack->phantom_jack = !!phantom_jack;
     jack->type = type;
+    jack->sense_nid = sense_nid;
     jack->jack->private_data = jack;
     jack->jack->private_free = hda_free_jack_priv;
     state = snd_hda_jack_detect(codec, nid);
@@ -422,7 +433,7 @@ static int __snd_hda_jack_add_kctl(struct hda_codec
*codec, hda_nid_t nid,
 int snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
               const char *name)
 {
-    return __snd_hda_jack_add_kctl(codec, nid, name, false);
+    return __snd_hda_jack_add_kctl(codec, nid, name, false, nid);
 }
 EXPORT_SYMBOL_GPL(snd_hda_jack_add_kctl);

@@ -451,7 +462,7 @@ static int add_jack_kctl(struct hda_codec *codec,
hda_nid_t nid,
     if (phantom_jack)
         /* Example final name: "Internal Mic Phantom Jack" */
         strncat(name, " Phantom", sizeof(name) - strlen(name) - 1);
-    err = __snd_hda_jack_add_kctl(codec, nid, name, phantom_jack);
+    err = __snd_hda_jack_add_kctl(codec, nid, name, phantom_jack, nid);
     if (err < 0)
         return err;

diff --git a/sound/pci/hda/hda_jack.h b/sound/pci/hda/hda_jack.h
index 387d309..ef3d162 100644
--- a/sound/pci/hda/hda_jack.h
+++ b/sound/pci/hda/hda_jack.h
@@ -41,6 +41,8 @@ struct hda_jack_tbl {
     hda_nid_t gated_jack;        /* gated is dependent on this jack */
     int type;
     struct snd_jack *jack;
+    hda_nid_t sense_nid;
+    hda_nid_t slave_nid;
 };

 struct hda_jack_tbl *
-- 
2.5.0
