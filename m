From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 076/112] ALSA: hda - Fix typos in
	debug_show_configs()
Date: Tue,  8 Jan 2013 12:39:09 +0100
Message-ID: <1357645185-7645-77-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 81F2026520C
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 7FF15A51BB
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

It never showed the 4th line out and headphone pins since quite ago.
Oh well.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 8af5324..b341450 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1164,7 +1164,7 @@ static void debug_show_configs(struct hda_gen_spec *spec, struct auto_pin_cfg *c
 {
 	debug_badness("multi_outs = %x/%x/%x/%x : %x/%x/%x/%x\n",
 		      cfg->line_out_pins[0], cfg->line_out_pins[1],
-		      cfg->line_out_pins[2], cfg->line_out_pins[2],
+		      cfg->line_out_pins[2], cfg->line_out_pins[3],
 		      spec->multiout.dac_nids[0],
 		      spec->multiout.dac_nids[1],
 		      spec->multiout.dac_nids[2],
@@ -1176,7 +1176,7 @@ static void debug_show_configs(struct hda_gen_spec *spec, struct auto_pin_cfg *c
 			      spec->multi_io[0].dac, spec->multi_io[1].dac);
 	debug_badness("hp_outs = %x/%x/%x/%x : %x/%x/%x/%x\n",
 		      cfg->hp_pins[0], cfg->hp_pins[1],
-		      cfg->hp_pins[2], cfg->hp_pins[2],
+		      cfg->hp_pins[2], cfg->hp_pins[3],
 		      spec->multiout.hp_out_nid[0],
 		      spec->multiout.hp_out_nid[1],
 		      spec->multiout.hp_out_nid[2],
-- 
1.8.0.1
