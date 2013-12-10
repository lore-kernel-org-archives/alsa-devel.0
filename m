From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: compress: Fix 64bit ABI incompatibility
Date: Tue, 10 Dec 2013 15:33:17 +0100
Message-ID: <1386685997-4838-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D196265287
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2013 15:33:17 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4D068A7D77
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2013 15:33:17 +0100 (CET)
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
List-Id: alsa-devel@alsa-project.org

snd_pcm_uframes_t is defined as unsigned long so it would take
different sizes depending on 32 or 64bit architectures.  As we don't
want this ABI incompatibility, and there is no real 64bit user yet,
let's make it the fixed size with __u32.

Also bump the protocol version number to 0.1.2.

Acked-by: Vinod Koul <vinod.koul@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/uapi/sound/compress_offload.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/sound/compress_offload.h b/include/uapi/sound/compress_offload.h
index d630163b9a2e..5759810e1c1b 100644
--- a/include/uapi/sound/compress_offload.h
+++ b/include/uapi/sound/compress_offload.h
@@ -30,7 +30,7 @@
 #include <sound/compress_params.h>
 
 
-#define SNDRV_COMPRESS_VERSION SNDRV_PROTOCOL_VERSION(0, 1, 1)
+#define SNDRV_COMPRESS_VERSION SNDRV_PROTOCOL_VERSION(0, 1, 2)
 /**
  * struct snd_compressed_buffer: compressed buffer
  * @fragment_size: size of buffer fragment in bytes
@@ -67,8 +67,8 @@ struct snd_compr_params {
 struct snd_compr_tstamp {
 	__u32 byte_offset;
 	__u32 copied_total;
-	snd_pcm_uframes_t pcm_frames;
-	snd_pcm_uframes_t pcm_io_frames;
+	__u32 pcm_frames;
+	__u32 pcm_io_frames;
 	__u32 sampling_rate;
 };
 
-- 
1.8.5
