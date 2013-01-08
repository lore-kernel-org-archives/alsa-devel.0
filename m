From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 031/112] ALSA: hda/realtek - Parse digital
	input path
Date: Tue,  8 Jan 2013 12:38:24 +0100
Message-ID: <1357645185-7645-32-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C6332651B1
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:25 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 9B718A522B
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

This was the last forgotten path.  Now it's parsed via the same path
parser.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a8febe4..60cc1b5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1402,14 +1402,16 @@ static void alc_auto_parse_digital(struct hda_codec *codec)
 	if (spec->autocfg.dig_in_pin) {
 		dig_nid = codec->start_nid;
 		for (i = 0; i < codec->num_nodes; i++, dig_nid++) {
+			struct nid_path *path;
 			unsigned int wcaps = get_wcaps(codec, dig_nid);
 			if (get_wcaps_type(wcaps) != AC_WID_AUD_IN)
 				continue;
 			if (!(wcaps & AC_WCAP_DIGITAL))
 				continue;
-			if (!(wcaps & AC_WCAP_CONN_LIST))
-				continue;
-			if (err >= 0) {
+			path = add_new_nid_path(codec, spec->autocfg.dig_in_pin,
+						dig_nid, 2);
+			if (path) {
+				path->active = true;
 				spec->dig_in_nid = dig_nid;
 				break;
 			}
-- 
1.8.0.1
