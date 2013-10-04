From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH 1/7] ALSA: hda - hdmi: Fix reported channel map
	on common default layouts
Date: Sat,  5 Oct 2013 02:25:38 +0300
Message-ID: <1380929144-24944-2-git-send-email-anssi.hannula@iki.fi>
References: <1380929144-24944-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tulikuusama.dnainternet.net (tulikuusama.dnainternet.net
 [83.102.40.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F2C4261664
 for <alsa-devel@alsa-project.org>; Sat,  5 Oct 2013 01:25:56 +0200 (CEST)
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

hdmi_setup_fake_chmap() is supposed to set the reported channel map when
the channel map is not specified by the user.

However, the function indexes channel_allocations[] with a wrong value
and extracts the wrong nibble from hdmi_channel_mapping[], causing wrong
channel maps to be shown.

Fix those issues.

Tested on Intel HDMI to correctly generate various channel maps, for
example 3,4,14,15,7,8,5,6 (instead of incorrect 3,4,8,7,5,6,14,0) for
standard 7.1 channel audio. (Note that the side and rear channels are
reported as RL/RR and RLC/RRC, respectively, as per the CEA-861
standard, instead of the more traditional SL/SR and RL/RR.)

Note that this only fixes the layouts that only contain traditional 7.1
speakers (2.0, 2.1, 4.0, 5.1, 7.1, etc.). E.g. the rear center of 6.1
is still being shown wrongly due to an issue with from_cea_slot()
which will be fixed in a later patch.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---

I'm assuming the usage of RL/RR and RLC/RRC instead of SL/SR and RL/RR is
intentional. If not, everything needs to be rethinked.


 sound/pci/hda/patch_hdmi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 09f38a1..6ed34df 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -742,9 +742,10 @@ static int hdmi_manual_setup_channel_mapping(struct hda_codec *codec,
 static void hdmi_setup_fake_chmap(unsigned char *map, int ca)
 {
 	int i;
+	int ordered_ca = get_channel_allocation_order(ca);
 	for (i = 0; i < 8; i++) {
-		if (i < channel_allocations[ca].channels)
-			map[i] = from_cea_slot((hdmi_channel_mapping[ca][i] >> 4) & 0x0f);
+		if (i < channel_allocations[ordered_ca].channels)
+			map[i] = from_cea_slot(hdmi_channel_mapping[ca][i] & 0x0f);
 		else
 			map[i] = 0;
 	}
-- 
1.8.1.5
