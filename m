From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH 3/3] ALSA: hda - hdmi: Fix wrong baseline
	length in ATI/AMD generated ELD
Date: Sun, 10 Nov 2013 20:56:12 +0200
Message-ID: <1384109772-7614-4-git-send-email-anssi.hannula@iki.fi>
References: <1384109772-7614-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sinikuusama.dnainternet.net (sinikuusama.dnainternet.net
 [83.102.40.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 18358261B26
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

According to the HDA specification the baseline ELD length is counted in
DW of 4 bytes instead of in bytes.

Fix the code accordingly.

Baseline length is not used by the kernel so only the ELD exported to
userspace was affected. No issues have been reported.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---
 sound/pci/hda/hda_eld.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
index 9b697a28cf53..cc814d02a0e4 100644
--- a/sound/pci/hda/hda_eld.c
+++ b/sound/pci/hda/hda_eld.c
@@ -793,7 +793,7 @@ int snd_hdmi_get_eld_ati(struct hda_codec *codec, hda_nid_t nid,
 	}
 
 	/* Baseline length */
-	buf[2] = pos - 4;
+	buf[2] = DIV_ROUND_UP(pos - 4, 4);
 
 	/* SAD count */
 	buf[5] |= ((pos - ELD_FIXED_BYTES - sink_desc_len) / 3) << 4;
-- 
1.8.1.5
