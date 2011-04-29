From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 09/10] ALSA: hda - More line-out auto-mute
	support for Realtek
Date: Fri, 29 Apr 2011 19:18:35 +0200
Message-ID: <1304097516-7258-10-git-send-email-tiwai@suse.de>
References: <1304097516-7258-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D7C4103A38
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 19:19:12 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id DEDF78730A
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 19:19:10 +0200 (CEST)
In-Reply-To: <1304097516-7258-1-git-send-email-tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Not only supporting the line-out automute as additional feature
to the existing headphone automute, now the headphone jack can
mute the line-out alone even without the speaker outs.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 9e2594d..3e41d56 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1517,16 +1517,19 @@ static void alc_init_auto_hp(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
+	int present = 0;
 	int i;
 
-	if (!cfg->hp_pins[0]) {
-		if (cfg->line_out_type != AUTO_PIN_HP_OUT)
-			return;
-	}
+	if (cfg->hp_pins[0])
+		present++;
+	if (cfg->line_out_pins[0])
+		present++;
+	if (cfg->speaker_pins[0])
+		present++;
+	if (present < 2) /* need two different output types */
+		return;
 
 	if (!cfg->speaker_pins[0]) {
-		if (cfg->line_out_type != AUTO_PIN_SPEAKER_OUT)
-			return;
 		memcpy(cfg->speaker_pins, cfg->line_out_pins,
 		       sizeof(cfg->speaker_pins));
 		cfg->speaker_outs = cfg->line_outs;
-- 
1.7.4.2
