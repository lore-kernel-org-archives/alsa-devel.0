From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 078/112] ALSA: hda - Allow aamix in the primary
	output path
Date: Tue,  8 Jan 2013 12:39:11 +0100
Message-ID: <1357645185-7645-79-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 96A7C26520D
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 86D1BA51D9
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

Allow the path including the loopback mixer widget in the primary
output channel as an alternative in the generic codec parser.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 18b5fae..f3c6ace 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -864,6 +864,10 @@ static int try_assign_dacs(struct hda_codec *codec, int num_outs,
 				badness += bad->no_dac;
 		}
 		path = snd_hda_add_new_path(codec, dac, pin, HDA_PARSE_NO_AAMIX);
+		if (!path && i > 0 && spec->mixer_nid) {
+			/* try with aamix */
+			path = snd_hda_add_new_path(codec, dac, pin, HDA_PARSE_ALL);
+		}
 		if (!path)
 			dac = dacs[i] = 0;
 		else
@@ -1020,6 +1024,7 @@ static int fill_multi_ios(struct hda_codec *codec,
 static bool map_singles(struct hda_codec *codec, int outs,
 			const hda_nid_t *pins, hda_nid_t *dacs)
 {
+	struct hda_gen_spec *spec = codec->spec;
 	int i;
 	bool found = false;
 	for (i = 0; i < outs; i++) {
@@ -1031,6 +1036,8 @@ static bool map_singles(struct hda_codec *codec, int outs,
 		if (!dac)
 			continue;
 		path = snd_hda_add_new_path(codec, dac, pins[i], HDA_PARSE_NO_AAMIX);
+		if (!path && i > 0 && spec->mixer_nid)
+			path = snd_hda_add_new_path(codec, dac, pins[i], HDA_PARSE_ALL);
 		if (path) {
 			dacs[i] = dac;
 			found = true;
-- 
1.8.0.1
