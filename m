From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 062/112] ALSA: hda - Do sequential writes in
	snd_hda_gen_init()
Date: Tue,  8 Jan 2013 12:38:55 +0100
Message-ID: <1357645185-7645-63-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 286D62651EE
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 45180A52EE
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:23 +0100 (CET)
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

This would reduce the number of actually executed verbs.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index f5eb57c..6fb454e 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3540,6 +3540,8 @@ int snd_hda_gen_init(struct hda_codec *codec)
 
 	snd_hda_apply_verbs(codec);
 
+	codec->cached_write = 1;
+
 	init_multi_out(codec);
 	init_extra_out(codec);
 	init_multi_io(codec);
@@ -3552,6 +3554,9 @@ int snd_hda_gen_init(struct hda_codec *codec)
 	snd_hda_gen_line_automute(codec, NULL);
 	snd_hda_gen_mic_autoswitch(codec, NULL);
 
+	snd_hda_codec_flush_amp_cache(codec);
+	snd_hda_codec_flush_cmd_cache(codec);
+
 	if (spec->vmaster_mute.sw_kctl && spec->vmaster_mute.hook)
 		snd_hda_sync_vmaster_hook(&spec->vmaster_mute);
 
-- 
1.8.0.1
