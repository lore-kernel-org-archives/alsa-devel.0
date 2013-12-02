From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Use always amps for auto-mute
	on AD1986A codec
Date: Mon,  2 Dec 2013 15:41:10 +0100
Message-ID: <1385995270-12297-2-git-send-email-tiwai@suse.de>
References: <1385995270-12297-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FAC1262626
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 15:41:11 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D7BD9A7D9D
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 15:41:10 +0100 (CET)
In-Reply-To: <1385995270-12297-1-git-send-email-tiwai@suse.de>
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

It seems that AD1986A cannot manage the dynamic pin on/off for
auto-muting, but rather gets confused.  Since each output has own amp,
let's use it instead.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=64971
Cc: <stable@vger.kernel.org> [v3.11+]
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_analog.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index f6351b8e0f5d..cac015be3325 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -361,6 +361,9 @@ static int patch_ad1986a(struct hda_codec *codec)
 	 */
 	spec->gen.multiout.no_share_stream = 1;
 
+	/* AD1986A can't manage the dynamic pin on/off smoothly */
+	spec->gen.auto_mute_via_amp = 1;
+
 	snd_hda_pick_fixup(codec, ad1986a_fixup_models, ad1986a_fixup_tbl,
 			   ad1986a_fixups);
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
-- 
1.8.4.4
