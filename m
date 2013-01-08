From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 053/112] ALSA: hda - Use "Capture Source" for
	single sources
Date: Tue,  8 Jan 2013 12:38:46 +0100
Message-ID: <1357645185-7645-54-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C217E2651CE
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:25 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 147DDA52BF
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

In general we prefer "Capture Source" to "Input Source".
The latter was chosen in many places just because "Capture Source"
label doesn't work well with the current alsa-lib mixer abstraction
when multiple instances are present.  But when we know that there is a
single input-source element, we can safely choose "Capture Source"
label.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 6914d70..f8d1d03 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -2172,7 +2172,9 @@ static int create_capture_mixers(struct hda_codec *codec)
 
 	if (!spec->auto_mic && imux->num_items > 1) {
 		struct snd_kcontrol_new *knew;
-		knew = snd_hda_gen_add_kctl(spec, NULL, &cap_src_temp);
+		const char *name;
+		name = nums > 1 ? "Input Source" : "Capture Source";
+		knew = snd_hda_gen_add_kctl(spec, name, &cap_src_temp);
 		if (!knew)
 			return -ENOMEM;
 		knew->count = nums;
-- 
1.8.0.1
