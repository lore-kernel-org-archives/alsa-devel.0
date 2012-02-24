From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 36/38] ALSA: hda/realtek - Fix the possible
	conflicts of Bass Speaker name
Date: Fri, 24 Feb 2012 17:36:29 +0100
Message-ID: <1330101391-8788-37-git-send-email-tiwai@suse.de>
References: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 7CDC510B8C2
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:34 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id BDECB93182
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:33 +0100 (CET)
In-Reply-To: <1330101391-8788-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When the multi-io is added to the two speaker output configuration,
the parser would try to add yet another "Bass Speaker" control since
it checks only cfg->line_outs.  Add a workaround for it by simply
passing the channel name in the case of multi-io outputs.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3cedb26..e5c0459 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3613,14 +3613,17 @@ static int alc_auto_create_multi_out_ctls(struct hda_codec *codec,
 		dac = spec->multiout.dac_nids[i];
 		if (!dac)
 			continue;
-		if (i >= cfg->line_outs)
+		if (i >= cfg->line_outs) {
 			pin = spec->multi_io[i - 1].pin;
-		else
+			index = 0;
+			name = channel_name[i];
+		} else {
 			pin = cfg->line_out_pins[i];
+			name = alc_get_line_out_pfx(spec, i, true, &index);
+		}
 
 		sw = alc_look_for_out_mute_nid(codec, pin, dac);
 		vol = alc_look_for_out_vol_nid(codec, pin, dac);
-		name = alc_get_line_out_pfx(spec, i, true, &index);
 		if (!name || !strcmp(name, "CLFE")) {
 			/* Center/LFE */
 			err = alc_auto_add_vol_ctl(codec, "Center", 0, vol, 1);
-- 
1.7.9
