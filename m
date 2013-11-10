From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH 3/3 v2] ALSA: hda - hdmi: Fix wrong baseline
	length in ATI/AMD generated ELD
Date: Sun, 10 Nov 2013 22:57:42 +0200
Message-ID: <1384117062-4952-1-git-send-email-anssi.hannula@iki.fi>
References: <1384109772-7614-4-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirokuusama.dnainternet.net (sirokuusama.dnainternet.net
 [83.102.40.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 52225261B26
 for <alsa-devel@alsa-project.org>; Sun, 10 Nov 2013 21:57:51 +0100 (CET)
In-Reply-To: <1384109772-7614-4-git-send-email-anssi.hannula@iki.fi>
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

According to the HDA specification the baseline ELD length is counted in
DW of 4 bytes instead of in bytes.

Fix the code accordingly.

Baseline length is not used by the kernel so only the ELD exported to
userspace was affected. No issues have been reported.

v2: Fixed so that eld_size is adjusted upwards accordingly as well.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---
 sound/pci/hda/hda_eld.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
index 9b697a28cf53..79ca80f6c77a 100644
--- a/sound/pci/hda/hda_eld.c
+++ b/sound/pci/hda/hda_eld.c
@@ -792,12 +792,15 @@ int snd_hdmi_get_eld_ati(struct hda_codec *codec, hda_nid_t nid,
 		/* else unknown/invalid or 0ms or video ahead of audio, so use zero */
 	}
 
-	/* Baseline length */
-	buf[2] = pos - 4;
-
 	/* SAD count */
 	buf[5] |= ((pos - ELD_FIXED_BYTES - sink_desc_len) / 3) << 4;
 
+	/* Baseline ELD block length is 4-byte aligned */
+	pos = round_up(pos, 4);
+
+	/* Baseline ELD length (4-byte header is not counted in) */
+	buf[2] = (pos - 4) / 4;
+
 	*eld_size = pos;
 
 	return 0;
-- 
1.8.1.5
