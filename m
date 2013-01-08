From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 087/112] ALSA: hda - Check the existing path in
	snd_hda_add_new_path()
Date: Tue,  8 Jan 2013 12:39:20 +0100
Message-ID: <1357645185-7645-88-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CC9DD265221
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id AC278A537B
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

If the requested path has been already added, return the existing path
instance instead of adding a duplicated instance.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 31 ++++++++++++++++++++++++-------
 sound/pci/hda/hda_generic.h |  1 +
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 978a0ed..5516905 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -116,11 +116,9 @@ EXPORT_SYMBOL_HDA(snd_hda_gen_spec_free);
  * parsing paths
  */
 
-/* get the path between the given NIDs;
- * passing 0 to either @pin or @dac behaves as a wildcard
- */
-struct nid_path *snd_hda_get_nid_path(struct hda_codec *codec,
-				      hda_nid_t from_nid, hda_nid_t to_nid)
+static struct nid_path *get_nid_path(struct hda_codec *codec,
+				     hda_nid_t from_nid, hda_nid_t to_nid,
+				     int with_aa_mix)
 {
 	struct hda_gen_spec *spec = codec->spec;
 	int i;
@@ -130,11 +128,23 @@ struct nid_path *snd_hda_get_nid_path(struct hda_codec *codec,
 		if (path->depth <= 0)
 			continue;
 		if ((!from_nid || path->path[0] == from_nid) &&
-		    (!to_nid || path->path[path->depth - 1] == to_nid))
-			return path;
+		    (!to_nid || path->path[path->depth - 1] == to_nid)) {
+			if (with_aa_mix == HDA_PARSE_ALL ||
+			    path->with_aa_mix == with_aa_mix)
+				return path;
+		}
 	}
 	return NULL;
 }
+
+/* get the path between the given NIDs;
+ * passing 0 to either @pin or @dac behaves as a wildcard
+ */
+struct nid_path *snd_hda_get_nid_path(struct hda_codec *codec,
+				      hda_nid_t from_nid, hda_nid_t to_nid)
+{
+	return get_nid_path(codec, from_nid, to_nid, HDA_PARSE_ALL);
+}
 EXPORT_SYMBOL_HDA(snd_hda_get_nid_path);
 
 /* check whether the given DAC is already found in any existing paths */
@@ -248,6 +258,8 @@ static bool __parse_nid_path(struct hda_codec *codec,
 
  found:
 	path->path[path->depth] = conn[i];
+	if (conn[i] == spec->mixer_nid)
+		path->with_aa_mix = true;
 	path->idx[path->depth + 1] = i;
 	if (nums > 1 && get_wcaps_type(get_wcaps(codec, to_nid)) != AC_WID_AUD_MIX)
 		path->multi[path->depth + 1] = 1;
@@ -290,6 +302,11 @@ snd_hda_add_new_path(struct hda_codec *codec, hda_nid_t from_nid,
 	if (from_nid && to_nid && !is_reachable_path(codec, from_nid, to_nid))
 		return NULL;
 
+	/* check whether the path has been already added */
+	path = get_nid_path(codec, from_nid, to_nid, with_aa_mix);
+	if (path)
+		return path;
+
 	path = snd_array_new(&spec->paths);
 	if (!path)
 		return NULL;
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 1090a52..f1cae2e 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -53,6 +53,7 @@ struct nid_path {
 	unsigned char multi[MAX_NID_PATH_DEPTH];
 	unsigned int ctls[NID_PATH_NUM_CTLS]; /* NID_PATH_XXX_CTL */
 	bool active;
+	bool with_aa_mix;
 };
 
 /* mic/line-in auto switching entry */
-- 
1.8.0.1
