From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 14/38] ALSA: hda/realtek - Show multi-io pins
	in debug prints
Date: Fri, 24 Feb 2012 17:36:07 +0100
Message-ID: <1330101391-8788-15-git-send-email-tiwai@suse.de>
References: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 1BF01104315
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:34 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 72318912E4
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 29c1925..4b2ecbc 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3298,6 +3298,11 @@ static void debug_show_configs(struct alc_spec *spec, struct auto_pin_cfg *cfg)
 		      spec->multiout.dac_nids[1],
 		      spec->multiout.dac_nids[2],
 		      spec->multiout.dac_nids[3]);
+	if (spec->multi_ios > 0)
+		debug_badness("multi_ios(%d) = %x/%x : %x/%x\n",
+			      spec->multi_ios,
+			      spec->multi_io[0].pin, spec->multi_io[1].pin,
+			      spec->multi_io[0].dac, spec->multi_io[1].dac);
 	debug_badness("hp_outs = %x/%x/%x/%x : %x/%x/%x/%x\n",
 		      cfg->hp_pins[0], cfg->hp_pins[1],
 		      cfg->hp_pins[2], cfg->hp_pins[2],
-- 
1.7.9
