From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 043/112] ALSA: hda - Rearrange INPUT_PIN_ATTR_*
Date: Tue,  8 Jan 2013 12:38:36 +0100
Message-ID: <1357645185-7645-44-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 99C1C2651C2
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:25 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id D6061A524D
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:22 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
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
In the auto-mic implementation, the front panel is preferred over the
rear panel.  By arranging the attr definitions like in this commit, we
can simply use sort() for figuring out the priority order.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_auto_parser.c | 2 +-
 sound/pci/hda/hda_auto_parser.h | 3 ++-
 sound/pci/hda/patch_via.c       | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index d460688..44c81d3 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -363,7 +363,7 @@ static const char *hda_get_input_pin_label(struct hda_codec *codec,
 {
 	unsigned int def_conf;
 	static const char * const mic_names[] = {
-		"Internal Mic", "Dock Mic", "Mic", "Front Mic", "Rear Mic",
+		"Internal Mic", "Dock Mic", "Mic", "Rear Mic", "Front Mic"
 	};
 	int attr;
 
diff --git a/sound/pci/hda/hda_auto_parser.h b/sound/pci/hda/hda_auto_parser.h
index ff11074..f748071 100644
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
index b224b3d..d3c852a 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -1913,7 +1913,7 @@ static void mangle_smart51(struct hda_codec *codec)
 	int i, j, nums, attr;
 	int pins[AUTO_CFG_MAX_INS];
 
-	for (attr = INPUT_PIN_ATTR_REAR; attr >= INPUT_PIN_ATTR_NORMAL; attr--) {
+	for (attr = INPUT_PIN_ATTR_LAST; attr >= INPUT_PIN_ATTR_NORMAL; attr--) {
 		nums = 0;
 		for (i = 0; i < cfg->num_inputs; i++) {
 			unsigned int def;
-- 
1.8.0.1
