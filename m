From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 13/20] ALSA: hda - Update automute / automic
	upon jack retasking
Date: Tue, 15 Jan 2013 12:05:40 +0100
Message-ID: <1358247947-13992-14-git-send-email-tiwai@suse.de>
References: <1358247947-13992-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B5E59265324
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:50 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 9CCA5A5232
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:48 +0100 (CET)
In-Reply-To: <1358247947-13992-1-git-send-email-tiwai@suse.de>
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

When a multi-io jack is switched to another direction, call the
automute and autoswitch update functions, as this jack won't be used
as the headphone or the mic jack that may turn off others.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 2020faf..fb4d843 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1767,6 +1767,12 @@ static int set_multi_io(struct hda_codec *codec, int idx, bool output)
 		snd_hda_activate_path(codec, path, false, true);
 		set_pin_target(codec, nid, spec->multi_io[idx].ctl_in, true);
 	}
+
+	/* update jack retasking in case it modifies any of them */
+	snd_hda_gen_hp_automute(codec, NULL);
+	snd_hda_gen_line_automute(codec, NULL);
+	snd_hda_gen_mic_autoswitch(codec, NULL);
+
 	return 0;
 }
 
-- 
1.8.1
