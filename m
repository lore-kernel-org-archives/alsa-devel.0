From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/12] ALSA: hda - Add missing badness
	evaluation for unresolved paths
Date: Mon, 21 Jan 2013 17:06:10 +0100
Message-ID: <1358784377-26102-6-git-send-email-tiwai@suse.de>
References: <1358784377-26102-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 932D92625FE
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 17:06:19 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id E16F2A51CA
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 17:06:18 +0100 (CET)
In-Reply-To: <1358784377-26102-1-git-send-email-tiwai@suse.de>
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

When a patch couldn't be resolved in try_assign_dacs() although the
target DAC is expected, we forgot to add a proper badness value but
continued.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 7b739b5..4e9761a 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1105,14 +1105,17 @@ static int try_assign_dacs(struct hda_codec *codec, int num_outs,
 			else
 				badness += bad->no_dac;
 		}
+		if (!dac)
+			continue;
 		path = snd_hda_add_new_path(codec, dac, pin, -spec->mixer_nid);
 		if (!path && !i && spec->mixer_nid) {
 			/* try with aamix */
 			path = snd_hda_add_new_path(codec, dac, pin, 0);
 		}
-		if (!path)
+		if (!path) {
 			dac = dacs[i] = 0;
-		else {
+			badness += bad->no_dac;
+		} else {
 			/* print_nid_path("output", path); */
 			path->active = true;
 			path_idx[i] = snd_hda_get_path_idx(codec, path);
-- 
1.8.1.1
