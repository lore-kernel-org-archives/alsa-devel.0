From: Xi Wang <xi.wang@gmail.com>
Subject: [PATCH] ALSA: hda/ca0132 - Avoid division by zero in
	dspxfr_one_seg()
Date: Thu,  7 Mar 2013 00:13:51 -0500
Message-ID: <1362633231-21558-1-git-send-email-xi.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f172.google.com (mail-qc0-f172.google.com
 [209.85.216.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B8CB2615A6
 for <alsa-devel@alsa-project.org>; Thu,  7 Mar 2013 06:14:05 +0100 (CET)
Received: by mail-qc0-f172.google.com with SMTP id b25so25843qca.31
 for <alsa-devel@alsa-project.org>; Wed, 06 Mar 2013 21:14:04 -0800 (PST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Xi Wang <xi.wang@gmail.com>
List-Id: alsa-devel@alsa-project.org

Move the zero check `hda_frame_size_words == 0' before the modulus
`buffer_size_words % hda_frame_size_words'.

Also remove the redundant null check `buffer_addx == NULL'.

Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
 sound/pci/hda/patch_ca0132.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index db02c1e..eefc456 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -2298,6 +2298,11 @@ static int dspxfr_one_seg(struct hda_codec *codec,
 	hda_frame_size_words = ((sample_rate_div == 0) ? 0 :
 			(num_chans * sample_rate_mul / sample_rate_div));
 
+	if (hda_frame_size_words == 0) {
+		snd_printdd(KERN_ERR "frmsz zero\n");
+		return -EINVAL;
+	}
+
 	buffer_size_words = min(buffer_size_words,
 				(unsigned int)(UC_RANGE(chip_addx, 1) ?
 				65536 : 32768));
@@ -2308,8 +2313,7 @@ static int dspxfr_one_seg(struct hda_codec *codec,
 		   chip_addx, hda_frame_size_words, num_chans,
 		   sample_rate_mul, sample_rate_div, buffer_size_words);
 
-	if ((buffer_addx == NULL) || (hda_frame_size_words == 0) ||
-	    (buffer_size_words < hda_frame_size_words)) {
+	if (buffer_size_words < hda_frame_size_words) {
 		snd_printdd(KERN_ERR "dspxfr_one_seg:failed\n");
 		return -EINVAL;
 	}
-- 
1.7.10.4
