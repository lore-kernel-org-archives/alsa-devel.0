From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 37/38] ALSA: hda/realtek - Fix the wrong offset
	for two-speaker systems
Date: Fri, 24 Feb 2012 17:36:30 +0100
Message-ID: <1330101391-8788-38-git-send-email-tiwai@suse.de>
References: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id BD68C104327
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:34 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id C56C5934B2
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

When the machine has two speakers but wants to put more multi-io
jacks, the parser shouldn't consider about the shared DAC but try to
assign the individual DACs.  Otherwise the channel mapping would be
fairly confused and lead to the wrong DACs.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e5c0459..e82911a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3353,7 +3353,11 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
 	}
 	if (cfg->hp_outs && cfg->line_out_type == AUTO_PIN_SPEAKER_OUT) {
 		/* try multi-ios with HP + inputs */
-		err = alc_auto_fill_multi_ios(codec, cfg->hp_pins[0], false, 1);
+		int offset = 0;
+		if (cfg->line_outs >= 3)
+			offset = 1;
+		err = alc_auto_fill_multi_ios(codec, cfg->hp_pins[0], false,
+					      offset);
 		if (err < 0)
 			return err;
 		badness += err;
-- 
1.7.9
