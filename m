From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH 1/3] ALSA: hda - hdmi: Add error-checking to
	some codec reads
Date: Sun, 10 Nov 2013 20:56:10 +0200
Message-ID: <1384109772-7614-2-git-send-email-anssi.hannula@iki.fi>
References: <1384109772-7614-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sinikuusama.dnainternet.net (sinikuusama.dnainternet.net
 [83.102.40.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D065261B30
 for <alsa-devel@alsa-project.org>; Sun, 10 Nov 2013 19:56:25 +0100 (CET)
In-Reply-To: <1384109772-7614-1-git-send-email-anssi.hannula@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add error checks to HBR status reads (both generic and ATI/AMD) and
ATI/AMD codec reads for ELD generation.

Unchecked errors in these just caused more errors later on (invalid
codec writes for the HBR ones and ELD parsing errors for the ATI/AMD ELD
ones), but it is better to catch them earlier.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---
 sound/pci/hda/hda_eld.c    | 5 ++++-
 sound/pci/hda/patch_hdmi.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
index 32d3e3855a6e..e8c55f5a34ff 100644
--- a/sound/pci/hda/hda_eld.c
+++ b/sound/pci/hda/hda_eld.c
@@ -680,7 +680,7 @@ int snd_hdmi_get_eld_ati(struct hda_codec *codec, hda_nid_t nid,
 
 	spkalloc = snd_hda_codec_read(codec, nid, 0, ATI_VERB_GET_SPEAKER_ALLOCATION, 0);
 
-	if (!spkalloc) {
+	if (spkalloc <= 0) {
 		snd_printd(KERN_INFO "HDMI ATI/AMD: no speaker allocation for ELD\n");
 		return -EINVAL;
 	}
@@ -742,6 +742,9 @@ int snd_hdmi_get_eld_ati(struct hda_codec *codec, hda_nid_t nid,
 		snd_hda_codec_write(codec, nid, 0, ATI_VERB_SET_AUDIO_DESCRIPTOR, i << 3);
 		ati_sad = snd_hda_codec_read(codec, nid, 0, ATI_VERB_GET_AUDIO_DESCRIPTOR, 0);
 
+		if (ati_sad <= 0)
+			continue;
+
 		if (ati_sad & ATI_AUDIODESC_RATES) {
 			/* format is supported, copy SAD as-is */
 			buf[pos++] = (ati_sad & 0x0000ff) >> 0;
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index a96403a828af..fe3b150f97d9 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1247,6 +1247,9 @@ static int hdmi_pin_hbr_setup(struct hda_codec *codec, hda_nid_t pin_nid,
 		pinctl = snd_hda_codec_read(codec, pin_nid, 0,
 					    AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
 
+		if (pinctl < 0)
+			return hbr ? -EINVAL : 0;
+
 		new_pinctl = pinctl & ~AC_PINCTL_EPT;
 		if (hbr)
 			new_pinctl |= AC_PINCTL_EPT_HBR;
@@ -3094,7 +3097,7 @@ static int atihdmi_pin_hbr_setup(struct hda_codec *codec, hda_nid_t pin_nid,
 	int hbr_ctl, hbr_ctl_new;
 
 	hbr_ctl = snd_hda_codec_read(codec, pin_nid, 0, ATI_VERB_GET_HBR_CONTROL, 0);
-	if (hbr_ctl & ATI_HBR_CAPABLE) {
+	if (hbr_ctl >= 0 && (hbr_ctl & ATI_HBR_CAPABLE)) {
 		if (hbr)
 			hbr_ctl_new = hbr_ctl | ATI_HBR_ENABLE;
 		else
-- 
1.8.1.5
