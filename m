From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 094/112] ALSA: hda - Fix truncated control names
Date: Tue,  8 Jan 2013 12:39:27 +0100
Message-ID: <1357645185-7645-95-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BBFC265229
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:27 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id C82AAA538E
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:23 +0100 (CET)
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

... like "Speaker Surround Playback Switch".
This fix had been already applied to patch_conexant.c but was
forgotten in other places, then migrated to hda_generic.c.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 5b30f9f..2b33d50 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1497,7 +1497,7 @@ static int create_extra_outs(struct hda_codec *codec, int num_pins,
 {
 	struct hda_gen_spec *spec = codec->spec;
 	struct hda_bind_ctls *ctl;
-	char name[32];
+	char name[44];
 	int i, n, err;
 
 	if (!num_pins || !pins[0])
@@ -2543,7 +2543,7 @@ static int parse_mic_boost(struct hda_codec *codec)
 		nid = cfg->inputs[i].pin;
 		if (get_wcaps(codec, nid) & AC_WCAP_IN_AMP) {
 			const char *label;
-			char boost_label[32];
+			char boost_label[44];
 			struct nid_path *path;
 			unsigned int val;
 
-- 
1.8.0.1
