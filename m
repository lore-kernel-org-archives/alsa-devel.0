From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/5] ALSA: hda/generic - Make
	snd_hda_gen_path_power_filter() always applicable
Date: Thu,  9 Apr 2015 10:40:36 +0200
Message-ID: <1428568838-21550-4-git-send-email-tiwai@suse.de>
References: <1428568838-21550-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 14507265467
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2015 10:40:40 +0200 (CEST)
In-Reply-To: <1428568838-21550-1-git-send-email-tiwai@suse.de>
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
Cc: Hui Wang <hui.wang@canonical.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Add the check of power_save_node flag at the beginning of the function
so that it skips the rest if the flag isn't set.  In this way, we can
call this function safely no matter whether the widget power-saving is
really used or not.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 46b559832d2c..f0475a19fad7 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -4703,6 +4703,10 @@ unsigned int snd_hda_gen_path_power_filter(struct hda_codec *codec,
 						  hda_nid_t nid,
 						  unsigned int power_state)
 {
+	struct hda_gen_spec *spec = codec->spec;
+
+	if (!spec->power_down_unused && !codec->power_save_node)
+		return power_state;
 	if (power_state != AC_PWRST_D0 || nid == codec->core.afg)
 		return power_state;
 	if (get_wcaps_type(get_wcaps(codec, nid)) >= AC_WID_POWER)
-- 
2.3.5
