From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 022/112] ALSA: hda/realtek - Fix the
	initialization of pin amp-in
Date: Tue,  8 Jan 2013 12:38:15 +0100
Message-ID: <1357645185-7645-23-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C86CD2651A5
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:24 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 5DCBFA5207
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

The pin widget has only a single amp value for the input even if it
has multiple "sources".  Handle the situation in activate_path().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 419979d..3f39ba5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3921,21 +3921,27 @@ static void activate_amp_in(struct hda_codec *codec, struct nid_path *path,
 {
 	struct alc_spec *spec = codec->spec;
 	hda_nid_t conn[16];
-	int n, nums;
+	int n, nums, idx;
 	hda_nid_t nid = path->path[i];
 
 	nums = snd_hda_get_connections(codec, nid, conn, ARRAY_SIZE(conn));
+	if (get_wcaps_type(get_wcaps(codec, nid)) == AC_WID_PIN) {
+		nums = 1;
+		idx = 0;
+	} else
+		idx = path->idx[i];
+
 	for (n = 0; n < nums; n++)
 		init_amp(codec, nid, HDA_INPUT, n);
 
-	if (is_ctl_associated(codec, nid, HDA_INPUT, path->idx[i]))
+	if (is_ctl_associated(codec, nid, HDA_INPUT, idx))
 		return;
 
 	/* here is a little bit tricky in comparison with activate_amp_out();
 	 * when aa-mixer is available, we need to enable the path as well
 	 */
 	for (n = 0; n < nums; n++) {
-		if (n != path->idx[i] && conn[n] != spec->mixer_nid)
+		if (n != idx && conn[n] != spec->mixer_nid)
 			continue;
 		activate_amp(codec, nid, HDA_INPUT, n, enable);
 	}
-- 
1.8.0.1
