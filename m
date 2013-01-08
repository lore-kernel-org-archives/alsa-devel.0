From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 086/112] ALSA: hda - Avoid duplicated path
	creations
Date: Tue,  8 Jan 2013 12:39:19 +0100
Message-ID: <1357645185-7645-87-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C8F6826521D
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id A7DA3A535C
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

When the paths are created in map_singles(), we don't have to
re-create new paths in try_assign_dacs().  Just evaluate the badness
and skip to the next item.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 5051350..978a0ed 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -833,8 +833,13 @@ static int try_assign_dacs(struct hda_codec *codec, int num_outs,
 	for (i = 0; i < num_outs; i++) {
 		struct nid_path *path;
 		hda_nid_t pin = pins[i];
-		if (!dacs[i])
-			dacs[i] = look_for_dac(codec, pin, false);
+
+		if (dacs[i]) {
+			badness += assign_out_path_ctls(codec, pin, dacs[i]);
+			continue;
+		}
+
+		dacs[i] = look_for_dac(codec, pin, false);
 		if (!dacs[i] && !i) {
 			for (j = 1; j < num_outs; j++) {
 				if (is_reachable_path(codec, dacs[j], pin)) {
-- 
1.8.0.1
