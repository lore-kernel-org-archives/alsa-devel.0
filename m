From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/7] ALSA: hda - Apply AMP fix in
	hdmi_setup_audio_infoframe() generically
Date: Tue, 22 Mar 2016 12:29:28 +0100
Message-ID: <1458646173-14520-3-git-send-email-tiwai@suse.de>
References: <1458646173-14520-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 453962658F0
 for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2016 12:29:36 +0100 (CET)
In-Reply-To: <1458646173-14520-1-git-send-email-tiwai@suse.de>
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
Cc: libin.yang@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The need for reprogramming the AMP mute bit at each audio info frame
setup isn't always specific to Intel chips.  It's safer to set it
generically for all codecs with the amp bit, as this verb execution
itself isn't too much load.  This eliminates one usage of
is_haswell_plus() macro, after all.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 48c63fea7018..fcd207d3ce7d 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -683,7 +683,8 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
 	if (!channels)
 		return;
 
-	if (is_haswell_plus(codec))
+	/* some HW (e.g. HSW+) needs reprogramming the amp at each time */
+	if (get_wcaps(codec, pin_nid) & AC_WCAP_OUT_AMP)
 		snd_hda_codec_write(codec, pin_nid, 0,
 					    AC_VERB_SET_AMP_GAIN_MUTE,
 					    AMP_OUT_UNMUTE);
-- 
2.7.4
