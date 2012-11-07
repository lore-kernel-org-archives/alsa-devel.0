From: tiwai@suse.de
Subject: [PATCH 1/3] ALSA: hda - Fix empty DAC filling in
	patch_via.c
Date: Wed,  7 Nov 2012 12:52:18 +0100
Message-ID: <1352289140-30731-2-git-send-email-tiwai@suse.de>
References: <1352289140-30731-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EEDC264FF1
 for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2012 12:52:28 +0100 (CET)
In-Reply-To: <1352289140-30731-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Massimo Del Fedele <max@veneto.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Takashi Iwai <tiwai@suse.de>

In via_auto_fill_adc_nids(), the parser tries to fill dac_nids[] at
the point of the current line-out (i).  When no valid path is found
for this output, this results in dac = 0, thus it creates a hole in
dac_nids[].  This confuses is_empty_dac() and trims the detected DAC
in later reference.

This patch fixes the bug by appending DAC properly to dac_nids[] in
via_auto_fill_adc_nids().

Reported-by: Massimo Del Fedele <max@veneto.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_via.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index 72a2f60..1c1367b 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -1825,7 +1825,7 @@ static int via_auto_fill_dac_nids(struct hda_codec *codec)
 					    &spec->out_mix_path))
 			dac = spec->out_mix_path.path[0];
 		if (dac) {
-			spec->private_dac_nids[i] = dac;
+			spec->private_dac_nids[dac_num] = dac;
 			dac_num++;
 		}
 	}
-- 
1.8.0
