From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/5] ALSA: hda - Rearrange INPUT_PIN_ATTR_*
Date: Thu, 29 Nov 2012 16:21:25 +0100
Message-ID: <1354202489-12769-2-git-send-email-tiwai@suse.de>
References: <1354202489-12769-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EB1DB26166B
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2012 16:21:45 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id CE704A329C
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2012 16:21:45 +0100 (CET)
In-Reply-To: <1354202489-12769-1-git-send-email-tiwai@suse.de>
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

Put INPUT_PIN_ATTR_FRONT after INPUT_PIN_ATTR_REAR, and define
INPUT_PIN_ATTR_LAST to point to the last element.

This is a preliminary work for cleaning up Realtek auto-mic parser.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_auto_parser.c | 2 +-
 sound/pci/hda/hda_auto_parser.h | 3 ++-
 sound/pci/hda/patch_via.c       | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index 4ec6dc8..90d5b39 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -375,7 +375,7 @@ static const char *hda_get_input_pin_label(struct hda_codec *codec,
 {
 	unsigned int def_conf;
 	static const char * const mic_names[] = {
-		"Internal Mic", "Dock Mic", "Mic", "Front Mic", "Rear Mic",
+		"Internal Mic", "Dock Mic", "Mic", "Rear Mic", "Front Mic"
 	};
 	int attr;
 
diff --git a/sound/pci/hda/hda_auto_parser.h b/sound/pci/hda/hda_auto_parser.h
index 632ad0a..b7d7103 100644
--- a/sound/pci/hda/hda_auto_parser.h
+++ b/sound/pci/hda/hda_auto_parser.h
@@ -51,8 +51,9 @@ enum {
 	INPUT_PIN_ATTR_INT,	/* internal mic/line-in */
 	INPUT_PIN_ATTR_DOCK,	/* docking mic/line-in */
 	INPUT_PIN_ATTR_NORMAL,	/* mic/line-in jack */
-	INPUT_PIN_ATTR_FRONT,	/* mic/line-in jack in front */
 	INPUT_PIN_ATTR_REAR,	/* mic/line-in jack in rear */
+	INPUT_PIN_ATTR_FRONT,	/* mic/line-in jack in front */
+	INPUT_PIN_ATTR_LAST = INPUT_PIN_ATTR_FRONT,
 };
 
 int snd_hda_get_input_pin_attr(unsigned int def_conf);
diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index 274644f..9f04f33 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -1894,7 +1894,7 @@ static void mangle_smart51(struct hda_codec *codec)
 	int i, j, nums, attr;
 	int pins[AUTO_CFG_MAX_INS];
 
-	for (attr = INPUT_PIN_ATTR_REAR; attr >= INPUT_PIN_ATTR_NORMAL; attr--) {
+	for (attr = INPUT_PIN_ATTR_LAST; attr >= INPUT_PIN_ATTR_NORMAL; attr--) {
 		nums = 0;
 		for (i = 0; i < cfg->num_inputs; i++) {
 			unsigned int def;
-- 
1.8.0.1
