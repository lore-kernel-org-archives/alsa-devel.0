From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 050/112] ALSA: hda - Fix NULL dereference in
	snd_hda_gen_build_controls()
Date: Tue,  8 Jan 2013 12:38:43 +0100
Message-ID: <1357645185-7645-51-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BD96D2651CD
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:25 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 0A1CCA525D
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

When no controls are assigned in the parser (e.g. no analog path),
spec->kctls.list is still NULL.  We need to check it before passing to
snd_hda_add_new_ctls().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index e512cab..364ec06 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -2906,9 +2906,11 @@ int snd_hda_gen_build_controls(struct hda_codec *codec)
 	struct hda_gen_spec *spec = codec->spec;
 	int err;
 
-	err = snd_hda_add_new_ctls(codec, spec->kctls.list);
-	if (err < 0)
-		return err;
+	if (spec->kctls.used) {
+		err = snd_hda_add_new_ctls(codec, spec->kctls.list);
+		if (err < 0)
+			return err;
+	}
 
 	if (spec->multiout.dig_out_nid) {
 		err = snd_hda_create_dig_out_ctls(codec,
-- 
1.8.0.1
