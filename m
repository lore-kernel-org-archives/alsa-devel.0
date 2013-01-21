From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/12] ALSA: hda/conexant - Set mixer NID 0x19
	for CX20551 codec
Date: Mon, 21 Jan 2013 17:06:07 +0100
Message-ID: <1358784377-26102-3-git-send-email-tiwai@suse.de>
References: <1358784377-26102-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 70EDB26168B
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 17:06:19 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id D9CD5A50F4
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

Conexant CX20551 codec has a mixer in NID 0x19 and a few outputs have
to take the input through this widget.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_conexant.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 2f94acb..2e6e2b0 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -3197,6 +3197,9 @@ static const struct hda_codec_ops cx_auto_patch_ops = {
 	.init = snd_hda_gen_init,
 	.free = snd_hda_gen_free,
 	.unsol_event = snd_hda_jack_unsol_event,
+#ifdef CONFIG_PM
+	.check_power_status = snd_hda_gen_check_power_status,
+#endif
 };
 
 /*
@@ -3348,6 +3351,10 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	case 0x14f15045:
 		codec->single_adc_amp = 1;
 		break;
+	case 0x14f15047:
+		codec->pin_amp_workaround = 1;
+		spec->gen.mixer_nid = 0x19;
+		break;
 	case 0x14f15051:
 		add_cx5051_fake_mutes(codec);
 		codec->pin_amp_workaround = 1;
-- 
1.8.1.1
