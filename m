From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/11] ALSA: hda/conexant - Enable stereo mix
	input for CX20549 and CX20551
Date: Tue, 28 Jan 2014 11:06:39 +0100
Message-ID: <1390903600-22772-11-git-send-email-tiwai@suse.de>
References: <1390903600-22772-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 271CF2651C0
 for <alsa-devel@alsa-project.org>; Tue, 28 Jan 2014 11:06:43 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0CD20AC87
 for <alsa-devel@alsa-project.org>; Tue, 28 Jan 2014 10:06:43 +0000 (UTC)
In-Reply-To: <1390903600-22772-1-git-send-email-tiwai@suse.de>
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

Both CX20549 and CX20551 codecs have a mixer widget and it can be
connected as the ADC source.  Like AD and VIA codecs, enable the
add_stereo_mix_input flag for these codecs.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_conexant.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 6b2c11da1283..cf2ee7ff6fef 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -3424,12 +3424,14 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	case 0x14f15045:
 		codec->single_adc_amp = 1;
 		spec->gen.mixer_nid = 0x17;
+		spec->gen.add_stereo_mix_input = 1;
 		snd_hda_pick_fixup(codec, cxt5045_fixup_models,
 				   cxt5045_fixups, cxt_fixups);
 		break;
 	case 0x14f15047:
 		codec->pin_amp_workaround = 1;
 		spec->gen.mixer_nid = 0x19;
+		spec->gen.add_stereo_mix_input = 1;
 		snd_hda_pick_fixup(codec, cxt5047_fixup_models,
 				   cxt5047_fixups, cxt_fixups);
 		break;
-- 
1.8.5.2
