From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 036/112] ALSA: hda/realtek - Assign Master
	mixer when possible
Date: Tue,  8 Jan 2013 12:38:29 +0100
Message-ID: <1357645185-7645-37-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 71D4F2651B5
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:25 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id B2884A5232
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:22 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
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

There are a few more cases where we can assign "Master" mixer element
safely, e.g. when a single DAC is used in the whole output paths.

Also, when vmaster hook is present, avoid "Master" but assign "PCM"
instead.  Otherwise vmaster hook won't work properly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 579a35e..c980489 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2306,7 +2306,14 @@ static const char *alc_get_line_out_pfx(struct alc_spec *spec, int ch,
 	*index = 0;
 	if (cfg->line_outs == 1 && !spec->multi_ios &&
 	    !cfg->hp_outs && !cfg->speaker_outs && can_be_master)
-		return "Master";
+		return spec->vmaster_mute.hook ? "PCM" : "Master";
+
+	/* if there is really a single DAC used in the whole output paths,
+	 * use it master (or "PCM" if a vmaster hook is present)
+	 */
+	if (spec->multiout.num_dacs == 1 && !spec->mixer_nid &&
+	    !spec->multiout.hp_out_nid[0] && !spec->multiout.extra_out_nid[0])
+		return spec->vmaster_mute.hook ? "PCM" : "Master";
 
 	switch (cfg->line_out_type) {
 	case AUTO_PIN_SPEAKER_OUT:
-- 
1.8.0.1
