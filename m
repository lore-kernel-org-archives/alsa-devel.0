From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 112/112] ALSA: hda - Add a flag to suppress mic
	auto-switch
Date: Tue,  8 Jan 2013 12:39:45 +0100
Message-ID: <1357645185-7645-113-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 85D5926523B
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:27 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 18315A5443
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

Add a new flag spec->suppress_mic_auto_switch for codecs that don't
support unsol events properly like VT1708.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 3 +++
 sound/pci/hda/hda_generic.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index ba88be2..2e02094 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3032,6 +3032,9 @@ static int check_auto_mic_availability(struct hda_codec *codec)
 	unsigned int types;
 	int i, num_pins;
 
+	if (spec->suppress_auto_mic)
+		return 0;
+
 	types = 0;
 	num_pins = 0;
 	for (i = 0; i < cfg->num_inputs; i++) {
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 343195c..1763e33 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -175,6 +175,7 @@ struct hda_gen_spec {
 	unsigned int automute_speaker_possible:1; /* there are speakers and either LO or HP */
 	unsigned int automute_lo_possible:1;	  /* there are line outs and HP */
 	unsigned int keep_vref_in_automute:1; /* Don't clear VREF in automute */
+	unsigned int suppress_auto_mic:1; /* suppress input jack auto switch */
 	unsigned int line_in_auto_switch:1; /* allow line-in auto switch */
 
 	/* other flags */
-- 
1.8.0.1
