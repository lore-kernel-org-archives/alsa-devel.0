From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 07/13] ALSA: hda - Fix wrong arguments for path
	deactivation checks
Date: Thu, 24 Jan 2013 18:37:56 +0100
Message-ID: <1359049082-5880-8-git-send-email-tiwai@suse.de>
References: <1359049082-5880-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BC9B2616E9
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 18:38:15 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id EA861A51B6
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 18:38:14 +0100 (CET)
In-Reply-To: <1359049082-5880-1-git-send-email-tiwai@suse.de>
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

The arguments to call is_active_nid() in activate_amp() were swapped,
and this resulted in the muted amp on some SPDIF output pins.

Also, the index to be passed to is_active_nid() must be idx_to_check.
Otherwise it checks the wrong connection in the case of implicit aamix
connection paths.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 921582d..31ffd66 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -569,7 +569,7 @@ static bool has_amp_out(struct hda_codec *codec, struct nid_path *path, int idx)
 
 /* check whether the given (nid,dir,idx) is active */
 static bool is_active_nid(struct hda_codec *codec, hda_nid_t nid,
-			  unsigned int idx, unsigned int dir)
+			  unsigned int dir, unsigned int idx)
 {
 	struct hda_gen_spec *spec = codec->spec;
 	int i, n;
@@ -642,7 +642,7 @@ static void activate_amp(struct hda_codec *codec, hda_nid_t nid, int dir,
 	unsigned int caps;
 	unsigned int mask, val;
 
-	if (!enable && is_active_nid(codec, nid, dir, idx))
+	if (!enable && is_active_nid(codec, nid, dir, idx_to_check))
 		return;
 
 	caps = query_amp_caps(codec, nid, dir);
-- 
1.8.1.1
