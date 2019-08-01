From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: isa/wavefront: remove redundant assignment to pointer bptr
Date: Thu,  1 Aug 2019 17:28:24 +0100
Message-ID: <20190801162824.32217-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

The pointer bptr is being assigned a value that is never read
and it is being updated in the next statement with a new value.
The initialization is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/isa/wavefront/wavefront_synth.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/isa/wavefront/wavefront_synth.c b/sound/isa/wavefront/wavefront_synth.c
index aec1c46e6697..c5b1d5900eed 100644
--- a/sound/isa/wavefront/wavefront_synth.c
+++ b/sound/isa/wavefront/wavefront_synth.c
@@ -788,7 +788,6 @@ wavefront_send_patch (snd_wavefront_t *dev, wavefront_patch_info *header)
 
 	dev->patch_status[header->number] |= WF_SLOT_FILLED;
 
-	bptr = buf;
 	bptr = munge_int32 (header->number, buf, 2);
 	munge_buf ((unsigned char *)&header->hdr.p, bptr, WF_PATCH_BYTES);
     
-- 
2.20.1
