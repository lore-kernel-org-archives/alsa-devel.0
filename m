From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: isa/wavefront: Fix potential Spectre v1 vulnerabilities
Date: Wed, 19 Dec 2018 17:31:43 -0600
Message-ID: <20181219233143.GA14518@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

header->number is indirectly controlled by user-space, hence leading
to a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

sound/isa/wavefront/wavefront_synth.c:792 wavefront_send_patch() warn: potential spectre issue 'dev->patch_status' [w] (local cap)
sound/isa/wavefront/wavefront_synth.c:819 wavefront_send_program() warn: potential spectre issue 'dev->prog_status' [w] (local cap)
sound/isa/wavefront/wavefront_synth.c:1197 wavefront_send_alias() warn: potential spectre issue 'dev->sample_status' [w]
sound/isa/wavefront/wavefront_synth.c:1248 wavefront_send_multisample() warn: potential spectre issue 'dev->sample_status' [w]
sound/isa/wavefront/wavefront_synth.c:1548 wavefront_synth_control() warn: potential spectre issue 'dev->sample_status' [r] (local cap)

Fix this by sanitizing header->number before using it to index
dev->patch_status, dev->prog_status and dev->sample_status.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/isa/wavefront/wavefront_synth.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/sound/isa/wavefront/wavefront_synth.c b/sound/isa/wavefront/wavefront_synth.c
index 0b1e4b34b299..80196a533a36 100644
--- a/sound/isa/wavefront/wavefront_synth.c
+++ b/sound/isa/wavefront/wavefront_synth.c
@@ -31,6 +31,7 @@
 #include <linux/moduleparam.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/nospec.h>
 #include <sound/core.h>
 #include <sound/snd_wavefront.h>
 #include <sound/initval.h>
@@ -788,7 +789,8 @@ wavefront_send_patch (snd_wavefront_t *dev, wavefront_patch_info *header)
 
 	if (header->number >= ARRAY_SIZE(dev->patch_status))
 		return -EINVAL;
-
+	header->number = array_index_nospec(header->number,
+					    ARRAY_SIZE(dev->patch_status));
 	dev->patch_status[header->number] |= WF_SLOT_FILLED;
 
 	bptr = buf;
@@ -815,7 +817,8 @@ wavefront_send_program (snd_wavefront_t *dev, wavefront_patch_info *header)
 
 	if (header->number >= ARRAY_SIZE(dev->prog_status))
 		return -EINVAL;
-
+	header->number = array_index_nospec(header->number,
+					    ARRAY_SIZE(dev->prog_status));
 	dev->prog_status[header->number] = WF_SLOT_USED;
 
 	/* XXX need to zero existing SLOT_USED bit for program_status[i]
@@ -1194,6 +1197,10 @@ wavefront_send_alias (snd_wavefront_t *dev, wavefront_patch_info *header)
 		return -EIO;
 	}
 
+	if (header->number >= ARRAY_SIZE(dev->sample_status))
+		return -EINVAL;
+	header->number = array_index_nospec(header->number,
+					    ARRAY_SIZE(dev->sample_status));
 	dev->sample_status[header->number] = (WF_SLOT_FILLED|WF_ST_ALIAS);
 
 	return (0);
@@ -1245,6 +1252,10 @@ wavefront_send_multisample (snd_wavefront_t *dev, wavefront_patch_info *header)
 		return -EIO;
 	}
 
+	if (header->number >= ARRAY_SIZE(dev->sample_status))
+		return -EINVAL;
+	header->number = array_index_nospec(header->number,
+					    ARRAY_SIZE(dev->sample_status));
 	dev->sample_status[header->number] = (WF_SLOT_FILLED|WF_ST_MULTISAMPLE);
 
 	kfree(msample_hdr);
@@ -1539,12 +1550,13 @@ wavefront_synth_control (snd_wavefront_card_t *acard,
 
 	case WFC_IDENTIFY_SLOT_TYPE:
 		i = wc->wbuf[0] | (wc->wbuf[1] << 7);
-		if (i <0 || i >= WF_MAX_SAMPLE) {
+		if (i < 0 || i >= WF_MAX_SAMPLE) {
 			snd_printk ("invalid slot ID %d\n",
 				i);
 			wc->status = EINVAL;
 			return -EINVAL;
 		}
+		i = array_index_nospec(i, WF_MAX_SAMPLE);
 		wc->rbuf[0] = dev->sample_status[i];
 		wc->status = 0;
 		return 0;
-- 
2.20.1
