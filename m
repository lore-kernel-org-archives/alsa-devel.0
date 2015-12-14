From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2 3/8] ALSA: compress: Add
	SND_AUDIOCODEC_BESPOKE
Date: Mon, 14 Dec 2015 17:53:24 +0000
Message-ID: <1450115609-14094-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1450115609-14094-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 09234260631
 for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2015 18:53:34 +0100 (CET)
In-Reply-To: <1450115609-14094-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

When working with the compressed framework occasionally vendors will
use esoteric internal audio formats. For such formats it doesn't really
make sense to add an new define to the kernel as their use is not
sufficiently general.

This patch adds a new define SND_AUDIOCODEC_BESPOKE that vendors can use
in such situations.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
---
 include/uapi/sound/compress_params.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/uapi/sound/compress_params.h b/include/uapi/sound/compress_params.h
index d9bd9ca..9625484 100644
--- a/include/uapi/sound/compress_params.h
+++ b/include/uapi/sound/compress_params.h
@@ -73,7 +73,8 @@
 #define SND_AUDIOCODEC_IEC61937              ((__u32) 0x0000000B)
 #define SND_AUDIOCODEC_G723_1                ((__u32) 0x0000000C)
 #define SND_AUDIOCODEC_G729                  ((__u32) 0x0000000D)
-#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_G729
+#define SND_AUDIOCODEC_BESPOKE               ((__u32) 0x0000000E)
+#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_BESPOKE
 
 /*
  * Profile and modes are listed with bit masks. This allows for a
@@ -312,7 +313,7 @@ struct snd_enc_flac {
 
 struct snd_enc_generic {
 	__u32 bw;	/* encoder bandwidth */
-	__s32 reserved[15];
+	__s32 reserved[15];	/* Can be used for SND_AUDIOCODEC_BESPOKE */
 } __attribute__((packed, aligned(4)));
 
 union snd_codec_options {
-- 
2.1.4
