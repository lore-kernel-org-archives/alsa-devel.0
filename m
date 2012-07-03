From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/4] ALSA: hda - Get rid of superfluous
	beep->mode field
Date: Tue,  3 Jul 2012 18:03:16 +0200
Message-ID: <1341331397-21182-4-git-send-email-tiwai@suse.de>
References: <1341331397-21182-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id B0FBE244F3
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jul 2012 18:03:29 +0200 (CEST)
In-Reply-To: <1341331397-21182-1-git-send-email-tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

It's no longer necessary since beep_mode=2 option was dropped.
It can be checked simply via codec->beep != NULL.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_beep.c |   14 ++++++--------
 sound/pci/hda/hda_beep.h |    1 -
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/sound/pci/hda/hda_beep.c b/sound/pci/hda/hda_beep.c
index 336b4b3..e6cf2a2 100644
--- a/sound/pci/hda/hda_beep.c
+++ b/sound/pci/hda/hda_beep.c
@@ -184,6 +184,7 @@ EXPORT_SYMBOL_HDA(snd_hda_enable_beep_device);
 int snd_hda_attach_beep_device(struct hda_codec *codec, int nid)
 {
 	struct hda_beep *beep;
+	int err;
 
 	if (!snd_hda_get_bool_hint(codec, "beep"))
 		return 0; /* disabled explicitly by hints */
@@ -201,19 +202,16 @@ int snd_hda_attach_beep_device(struct hda_codec *codec, int nid)
 
 	beep->nid = nid;
 	beep->codec = codec;
-	beep->mode = codec->beep_mode;
 	codec->beep = beep;
 
 	INIT_WORK(&beep->beep_work, &snd_hda_generate_beep);
 	mutex_init(&beep->mutex);
 
-	if (beep->mode) {
-		int err = snd_hda_do_attach(beep);
-		if (err < 0) {
-			kfree(beep);
-			codec->beep = NULL;
-			return err;
-		}
+	err = snd_hda_do_attach(beep);
+	if (err < 0) {
+		kfree(beep);
+		codec->beep = NULL;
+		return err;
 	}
 
 	return 0;
diff --git a/sound/pci/hda/hda_beep.h b/sound/pci/hda/hda_beep.h
index 30e79d1..4dc6933 100644
--- a/sound/pci/hda/hda_beep.h
+++ b/sound/pci/hda/hda_beep.h
@@ -31,7 +31,6 @@
 struct hda_beep {
 	struct input_dev *dev;
 	struct hda_codec *codec;
-	unsigned int mode;
 	char phys[32];
 	int tone;
 	hda_nid_t nid;
-- 
1.7.10.4
