From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/12] ALSA: hda - Check aamix-output paths
	from other DACs, too
Date: Mon, 21 Jan 2013 17:06:11 +0100
Message-ID: <1358784377-26102-7-git-send-email-tiwai@suse.de>
References: <1358784377-26102-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 926592616C5
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 17:06:19 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id E658CA51CB
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

Many codecs provide routes to multiple output pins through an aamix
widget, but most of them do it only from a single DAC.  However, the
current generic parser checks only the aamix paths from the original
(directly bound) DACs through aamix NID, and miss the path:
  primary DAC -> aamix -> target out pin

This patch adds a more check for the routes like the above.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 4e9761a..e26e8d3 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1313,14 +1313,26 @@ static int check_aamix_out_path(struct hda_codec *codec, int path_idx)
 {
 	struct hda_gen_spec *spec = codec->spec;
 	struct nid_path *path;
+	hda_nid_t dac, pin;
 
 	path = snd_hda_get_path_from_idx(codec, path_idx);
 	if (!path || !path->depth ||
 	    is_nid_contained(path, spec->mixer_nid))
 		return 0;
-	path = snd_hda_add_new_path(codec, path->path[0],
-				    path->path[path->depth - 1],
-				    spec->mixer_nid);
+	dac = path->path[0];
+	pin = path->path[path->depth - 1];
+	path = snd_hda_add_new_path(codec, dac, pin, spec->mixer_nid);
+	if (!path) {
+		if (dac != spec->multiout.dac_nids[0])
+			dac = spec->multiout.dac_nids[0];
+		else if (spec->multiout.hp_out_nid[0])
+			dac = spec->multiout.hp_out_nid[0];
+		else if (spec->multiout.extra_out_nid[0])
+			dac = spec->multiout.extra_out_nid[0];
+		if (dac)
+			path = snd_hda_add_new_path(codec, dac, pin,
+						    spec->mixer_nid);
+	}
 	if (!path)
 		return 0;
 	/* print_nid_path("output-aamix", path); */
-- 
1.8.1.1
