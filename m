From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Allow capture-only configuration
Date: Fri,  6 Dec 2013 09:33:36 +0100
Message-ID: <1386318816-2805-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 09364261ADD
 for <alsa-devel@alsa-project.org>; Fri,  6 Dec 2013 09:33:37 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id CEFC2A7D3C
 for <alsa-devel@alsa-project.org>; Fri,  6 Dec 2013 09:33:36 +0100 (CET)
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

We have blindly assumed that all valid configurations should have
either analog or digital playback, but there can be capture-only
configurations.  The parser shouldn't escape in such a case.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 2729e881541d..5ba3106b9712 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -4334,7 +4334,8 @@ int snd_hda_gen_parse_auto_config(struct hda_codec *codec,
 			spec->no_analog = 1;
 			goto dig_only;
 		}
-		return 0; /* can't find valid BIOS pin config */
+		if (!cfg->num_inputs && !cfg->dig_in_pin)
+			return 0; /* can't find valid BIOS pin config */
 	}
 
 	if (!spec->no_primary_hp &&
-- 
1.8.5
