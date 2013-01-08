From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 070/112] ALSA: hda - Fix initialization of
	primary outputs in hda_generic.c
Date: Tue,  8 Jan 2013 12:39:03 +0100
Message-ID: <1357645185-7645-71-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DF0D265203
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 6DA33A531D
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

There were some old codes that look not stable enough, which was
derived from the old Realtek code.  The initialization for primary
output in init_multi_out() needs to consider the case of shared DAC.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 96c779b..a133fcf 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3372,6 +3372,7 @@ static void set_output_and_unmute(struct hda_codec *codec, hda_nid_t pin,
 static void init_multi_out(struct hda_codec *codec)
 {
 	struct hda_gen_spec *spec = codec->spec;
+	hda_nid_t nid, dac;
 	int pin_type;
 	int i;
 
@@ -3380,12 +3381,14 @@ static void init_multi_out(struct hda_codec *codec)
 	else
 		pin_type = PIN_OUT;
 
-	for (i = 0; i <= HDA_SIDE; i++) {
-		hda_nid_t nid = spec->autocfg.line_out_pins[i];
-		if (nid)
-			set_output_and_unmute(codec, nid, pin_type,
-					      spec->multiout.dac_nids[i]);
-
+	for (i = 0; i < spec->autocfg.line_outs; i++) {
+		nid = spec->autocfg.line_out_pins[i];
+		if (nid) {
+			dac = spec->multiout.dac_nids[i];
+			if (!dac)
+				dac = spec->multiout.dac_nids[0];
+			set_output_and_unmute(codec, nid, pin_type, dac);
+		}
 	}
 }
 
-- 
1.8.0.1
