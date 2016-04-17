From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Don't trust the reported actual
	power state
Date: Sun, 17 Apr 2016 09:49:37 +0200
Message-ID: <1460879377-22094-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AD0A32604DF
 for <alsa-devel@alsa-project.org>; Sun, 17 Apr 2016 09:49:39 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 6DCD6AB08
 for <alsa-devel@alsa-project.org>; Sun, 17 Apr 2016 07:49:37 +0000 (UTC)
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

We've got a regression report that the recording on Mac with a cirrus
codec doesn't work any longer.  This turned out to be the missing
power up to D0 by power_save_node enablement.

After analyzing the traces, we found out that the culprit is that the
codec advertises the "actual" power state of a few nodes to be D0
while the "target" power state is D3.  This inconsistency is usually
OK, as it implies the power transition.  But in the case of cirrus
codec, this seems to be stuck to D3 while it's not actually D0.

This patch addresses the issue by checking the power state difference
more strictly.  It sends the power-state change verb unless both the
target and the actual power states show the given value.

We may introduce yet another flag indicating the possible broken
hardware power state, but it's anyway safer to set the proper power
state even in a transition (at least it's harmless as long as the
target state is same).  So this simpler change was applied now.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=116171
Cc: <stable@vger.kernel.org> # v4.4+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 7ca5b89f088a..dfaf1a93fb8a 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -826,7 +826,7 @@ static hda_nid_t path_power_update(struct hda_codec *codec,
 				   bool allow_powerdown)
 {
 	hda_nid_t nid, changed = 0;
-	int i, state;
+	int i, state, power;
 
 	for (i = 0; i < path->depth; i++) {
 		nid = path->path[i];
@@ -838,7 +838,9 @@ static hda_nid_t path_power_update(struct hda_codec *codec,
 			state = AC_PWRST_D0;
 		else
 			state = AC_PWRST_D3;
-		if (!snd_hda_check_power_state(codec, nid, state)) {
+		power = snd_hda_codec_read(codec, nid, 0,
+					   AC_VERB_GET_POWER_STATE, 0);
+		if (power != (state | (state << 4))) {
 			snd_hda_codec_write(codec, nid, 0,
 					    AC_VERB_SET_POWER_STATE, state);
 			changed = nid;
-- 
2.8.1
