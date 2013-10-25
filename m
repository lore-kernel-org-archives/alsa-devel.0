From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Sync EAPD with vmaster on AD1984A
	Thinkpads
Date: Sat, 26 Oct 2013 00:36:09 +0200
Message-ID: <1382740569-20624-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 78A752619DE
 for <alsa-devel@alsa-project.org>; Sat, 26 Oct 2013 00:33:16 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 5D1D5A5B27
 for <alsa-devel@alsa-project.org>; Sat, 26 Oct 2013 00:33:16 +0200 (CEST)
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

As EAPD on NID 0x12 (speaker pin) is used as the master amp on
Thinkpads with AD1984A codec, we can hook this to vmaster for saving a
bit more power at master mute state.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_analog.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 2aa2f57..87d2e03 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -973,8 +973,11 @@ static void ad1884_fixup_thinkpad(struct hda_codec *codec,
 {
 	struct ad198x_spec *spec = codec->spec;
 
-	if (action == HDA_FIXUP_ACT_PRE_PROBE)
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		spec->gen.keep_eapd_on = 1;
+		spec->gen.vmaster_mute.hook = ad_vmaster_eapd_hook;
+		spec->eapd_nid = 0x12;
+	}
 }
 
 /* set magic COEFs for dmic */
-- 
1.8.4
