From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Don't create duplicated ctls
	for loopback paths
Date: Tue,  7 Jan 2014 18:21:33 +0100
Message-ID: <1389115293-20543-2-git-send-email-tiwai@suse.de>
References: <1389115293-20543-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5ED7B264EF3
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 18:21:34 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 01251AC3C
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 17:21:34 +0000 (UTC)
In-Reply-To: <1389115293-20543-1-git-send-email-tiwai@suse.de>
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

AD1986A mic pins (0x1d and 0x1f) share the same widget for controlling
the loopback volume/mute, but the generic parser didn't check it.
This ended up with the duplicated controls for the same effect.

This patch adds the check of the duplication for avoiding it.

After this fix, there will be only one control although it affects
both paths; this remaining issue should be fixed later in a different
patch.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=66621
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index ce004326d54b..7513089c8985 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -2858,9 +2858,11 @@ static bool look_for_mix_leaf_ctls(struct hda_codec *codec, hda_nid_t mix_nid,
 	if (num_conns < idx)
 		return false;
 	nid = list[idx];
-	if (!*mix_val && nid_has_volume(codec, nid, HDA_OUTPUT))
+	if (!*mix_val && nid_has_volume(codec, nid, HDA_OUTPUT) &&
+	    !is_ctl_associated(codec, nid, HDA_OUTPUT, 0, NID_PATH_VOL_CTL))
 		*mix_val = HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_OUTPUT);
-	if (!*mute_val && nid_has_mute(codec, nid, HDA_OUTPUT))
+	if (!*mute_val && nid_has_mute(codec, nid, HDA_OUTPUT) &&
+	    !is_ctl_associated(codec, nid, HDA_OUTPUT, 0, NID_PATH_MUTE_CTL))
 		*mute_val = HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_OUTPUT);
 
 	return *mix_val || *mute_val;
-- 
1.8.5.2
