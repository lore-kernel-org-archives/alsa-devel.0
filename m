From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH 2/7] ALSA: hda - hdmi: Fix incorrect default
	channel mapping for unusual CAs
Date: Sat,  5 Oct 2013 02:25:39 +0300
Message-ID: <1380929144-24944-3-git-send-email-anssi.hannula@iki.fi>
References: <1380929144-24944-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tulikuusama.dnainternet.net (tulikuusama.dnainternet.net
 [83.102.40.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E4EC261661
 for <alsa-devel@alsa-project.org>; Sat,  5 Oct 2013 01:26:01 +0200 (CEST)
In-Reply-To: <1380929144-24944-1-git-send-email-anssi.hannula@iki.fi>
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

hdmi_std_setup_channel_mapping() selects a Channel Allocation according
to the sink reported speaker mask, preferring the ALSA standard layouts.

If the channel allocation is not one of the ALSA standard layouts, the
ALSA channels are mapped directly to HDMI channels in order. However,
the function does not take into account that there a holes in the HDMI
channel map.

Additionally, the function tries to disable a slot by using
AC_VERB_SET_CHAN_SLOT with parameter ((alsa_ch << 8) | 0xf), while the
correct parameter is ((0xf << 8) | hdmi_slot), i.e. the slot should be
unassigned, not the ALSA channel.

Fix both of the issues for non-ALSA-default layouts.

Tested on Intel HDMI with a speaker mask of FL | FR | FC | RC, which
causes CA 0x06 to be selected for 4-channel audio, which causes
incorrect output (sound destined to RC goes to FC and FC goes nowhere)
without the patch.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---
 sound/pci/hda/patch_hdmi.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 6ed34df..5244802 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -597,22 +597,32 @@ static void hdmi_std_setup_channel_mapping(struct hda_codec *codec,
 				       bool non_pcm,
 				       int ca)
 {
+	struct cea_channel_speaker_allocation *ch_alloc;
 	int i;
 	int err;
 	int order;
 	int non_pcm_mapping[8];
 
 	order = get_channel_allocation_order(ca);
+	ch_alloc = &channel_allocations[order];
 
 	if (hdmi_channel_mapping[ca][1] == 0) {
-		for (i = 0; i < channel_allocations[order].channels; i++)
-			hdmi_channel_mapping[ca][i] = i | (i << 4);
-		for (; i < 8; i++)
-			hdmi_channel_mapping[ca][i] = 0xf | (i << 4);
+		int hdmi_slot = 0;
+		/* fill actual channel mappings in ALSA channel (i) order */
+		for (i = 0; i < ch_alloc->channels; i++) {
+			while (!ch_alloc->speakers[7 - hdmi_slot] && !WARN_ON(hdmi_slot >= 8))
+				hdmi_slot++; /* skip zero slots */
+
+			hdmi_channel_mapping[ca][i] = (i << 4) | hdmi_slot++;
+		}
+		/* fill the rest of the slots with ALSA channel 0xf */
+		for (hdmi_slot = 0; hdmi_slot < 8; hdmi_slot++)
+			if (!ch_alloc->speakers[7 - hdmi_slot])
+				hdmi_channel_mapping[ca][i++] = (0xf << 4) | hdmi_slot;
 	}
 
 	if (non_pcm) {
-		for (i = 0; i < channel_allocations[order].channels; i++)
+		for (i = 0; i < ch_alloc->channels; i++)
 			non_pcm_mapping[i] = i | (i << 4);
 		for (; i < 8; i++)
 			non_pcm_mapping[i] = 0xf | (i << 4);
-- 
1.8.1.5
