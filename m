From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Don't turn off EAPD for
	headphone on Lenovo N100
Date: Wed, 13 Nov 2013 09:45:32 +0100
Message-ID: <1384332333-20674-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E00926084B
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2013 09:45:33 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 5CF50A6761
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2013 09:45:33 +0100 (CET)
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

The only EAPD on AD1986A is on NID 0x1b where usually the speaker.
But this doesn't control only the speaker amp but may influence on all
outputs, e.g. Lenovo N100 laptop seems to have this issue.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_analog.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 87d2e0335ae4..ba37116168ac 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -219,8 +219,12 @@ static int alloc_ad_spec(struct hda_codec *codec)
 static void ad_fixup_inv_jack_detect(struct hda_codec *codec,
 				     const struct hda_fixup *fix, int action)
 {
-	if (action == HDA_FIXUP_ACT_PRE_PROBE)
+	struct ad198x_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		codec->inv_jack_detect = 1;
+		spec->gen.keep_eapd_on = 1;
+	}
 }
 
 enum {
-- 
1.8.4.2
