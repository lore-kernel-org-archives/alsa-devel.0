From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 104/112] ALSA: hda - Clear path indices
	properly at each re-evaluation
Date: Tue,  8 Jan 2013 12:39:37 +0100
Message-ID: <1357645185-7645-105-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 58995265236
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:27 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 07330A53D5
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:24 +0100 (CET)
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

The path indices must be reset at each evaluation of DAC assignment.
Otherwise the badness value will be wrongly calculated and mixers may
be inconsistently assigned.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 7c76a00..990a79e 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1138,6 +1138,16 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
 	memset(spec->multiout.extra_out_nid, 0, sizeof(spec->multiout.extra_out_nid));
 	spec->multi_ios = 0;
 	snd_array_free(&spec->paths);
+
+	/* clear path indices */
+	memset(spec->out_paths, 0, sizeof(spec->out_paths));
+	memset(spec->hp_paths, 0, sizeof(spec->hp_paths));
+	memset(spec->speaker_paths, 0, sizeof(spec->speaker_paths));
+	memset(spec->aamix_out_paths, 0, sizeof(spec->aamix_out_paths));
+	memset(spec->digout_paths, 0, sizeof(spec->digout_paths));
+	memset(spec->loopback_paths, 0, sizeof(spec->loopback_paths));
+	memset(&spec->digin_path, 0, sizeof(spec->digin_path));
+
 	badness = 0;
 
 	/* fill hard-wired DACs first */
-- 
1.8.0.1
