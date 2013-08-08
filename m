From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix missing mute controls for
	CX5051
Date: Thu,  8 Aug 2013 09:32:37 +0200
Message-ID: <1375947157-17611-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 39219265653
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2013 09:31:08 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 19CABA51B7
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2013 09:31:08 +0200 (CEST)
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

We've added a fake mute control (setting the amp volume to zero) for
CX5051 at commit [3868137e: ALSA: hda - Add a fake mute feature], but
this feature was overlooked in the generic parser implementation.  Now
the driver lacks of mute controls on these codecs.

The fix is just to check both AC_AMPCAP_MUTE and AC_AMPCAP_MIN_MUTE
bits in each place checking the amp capabilities.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=59001
Cc: <stable@vger.kernel.org> [v3.9+]
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 8e77cbb..e3c7ba8 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -522,7 +522,7 @@ static bool same_amp_caps(struct hda_codec *codec, hda_nid_t nid1,
 }
 
 #define nid_has_mute(codec, nid, dir) \
-	check_amp_caps(codec, nid, dir, AC_AMPCAP_MUTE)
+	check_amp_caps(codec, nid, dir, (AC_AMPCAP_MUTE | AC_AMPCAP_MIN_MUTE))
 #define nid_has_volume(codec, nid, dir) \
 	check_amp_caps(codec, nid, dir, AC_AMPCAP_NUM_STEPS)
 
@@ -624,7 +624,7 @@ static int get_amp_val_to_activate(struct hda_codec *codec, hda_nid_t nid,
 		if (enable)
 			val = (caps & AC_AMPCAP_OFFSET) >> AC_AMPCAP_OFFSET_SHIFT;
 	}
-	if (caps & AC_AMPCAP_MUTE) {
+	if (caps & (AC_AMPCAP_MUTE | AC_AMPCAP_MIN_MUTE)) {
 		if (!enable)
 			val |= HDA_AMP_MUTE;
 	}
@@ -648,7 +648,7 @@ static unsigned int get_amp_mask_to_modify(struct hda_codec *codec,
 {
 	unsigned int mask = 0xff;
 
-	if (caps & AC_AMPCAP_MUTE) {
+	if (caps & (AC_AMPCAP_MUTE | AC_AMPCAP_MIN_MUTE)) {
 		if (is_ctl_associated(codec, nid, dir, idx, NID_PATH_MUTE_CTL))
 			mask &= ~0x80;
 	}
-- 
1.8.3.1
