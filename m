From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/5] ALSA: hda/generic - Don't override
	power_filter when power_save_node is set
Date: Thu,  9 Apr 2015 10:40:37 +0200
Message-ID: <1428568838-21550-5-git-send-email-tiwai@suse.de>
References: <1428568838-21550-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 257FE2658B4
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2015 10:40:40 +0200 (CEST)
In-Reply-To: <1428568838-21550-1-git-send-email-tiwai@suse.de>
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
Cc: Hui Wang <hui.wang@canonical.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Currently the generic parser sets codec->power_filter when
power_save_node flag is set.  But this overrides the existing filter
that has been already set by the codec driver, thus it looses some
features.  Instead, set the default power_filter only when it's not
set yet.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index f0475a19fad7..3d2597b7037b 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -4918,7 +4918,8 @@ int snd_hda_gen_parse_auto_config(struct hda_codec *codec,
 	parse_digital(codec);
 
 	if (spec->power_down_unused || codec->power_save_node)
-		codec->power_filter = snd_hda_gen_path_power_filter;
+		if (!codec->power_filter)
+			codec->power_filter = snd_hda_gen_path_power_filter;
 
 	if (!spec->no_analog && spec->beep_nid) {
 		err = snd_hda_attach_beep_device(codec, spec->beep_nid);
-- 
2.3.5
