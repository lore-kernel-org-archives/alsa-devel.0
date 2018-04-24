From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH v2 2/4] ALSA: usb-audio: ADC3: Fix channel mapping conversion for ADC3.
Date: Tue, 24 Apr 2018 18:24:43 +0100
Message-ID: <20180424172445.31928-3-jorge.sanjuan@codethink.co.uk>
References: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
 <20180424172445.31928-1-jorge.sanjuan@codethink.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180424172445.31928-1-jorge.sanjuan@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.com
Cc: alsa-devel@alsa-project.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, Michael Drake <michael.drake@codethink.co.uk>, Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
List-Id: alsa-devel@alsa-project.org

From: Michael Drake <michael.drake@codethink.co.uk>

The channel mapping is defined by bChRelationship, not bChPurpose.

Fixes: 9a2fe9b801f5 ("ALSA: usb: initial USB Audio Device Class 3.0
support")
Reviewed-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Signed-off-by: Michael Drake <michael.drake@codethink.co.uk>
Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 sound/usb/stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 6a8f5843334e..956be9f7c72a 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -349,7 +349,7 @@ snd_pcm_chmap_elem *convert_chmap_v3(struct uac3_cluster_header_descriptor
 			 * TODO: this conversion is not complete, update it
 			 * after adding UAC3 values to asound.h
 			 */
-			switch (is->bChPurpose) {
+			switch (is->bChRelationship) {
 			case UAC3_CH_MONO:
 				map = SNDRV_CHMAP_MONO;
 				break;
-- 
2.11.0
