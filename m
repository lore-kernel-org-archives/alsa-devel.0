From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH] tinycompress: Update headers to include
	AUDIOCODEC_BESPOKE
Date: Thu, 8 Nov 2018 17:12:32 +0000
Message-ID: <20181108171232.11722-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 3ECF2267AD3
 for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2018 18:12:35 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vkoul@kernel.org
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, andrew.ford@cirrus.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

commit dbb6b94339e8 ("ALSA: compress: Add SND_AUDIOCODEC_BESPOKE") added
an additional CODEC type for bespoke CODECs. Update the local headers to
include this.

Reported-by: Andrew Ford <andrew.ford@cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 include/sound/compress_params.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/sound/compress_params.h b/include/sound/compress_params.h
index 9802292..7286556 100644
--- a/include/sound/compress_params.h
+++ b/include/sound/compress_params.h
@@ -38,8 +38,9 @@
 #define SND_AUDIOCODEC_IEC61937 ((__u32) 0x0000000B)
 #define SND_AUDIOCODEC_G723_1 ((__u32) 0x0000000C)
 #define SND_AUDIOCODEC_G729 ((__u32) 0x0000000D)
+#define SND_AUDIOCODEC_BESPOKE ((__u32) 0x0000000E)
 
-#define SND_AUDIOCODEC_MAX SND_AUDIOCODEC_G729
+#define SND_AUDIOCODEC_MAX SND_AUDIOCODEC_BESPOKE
 #define SND_AUDIOPROFILE_PCM ((__u32) 0x00000001)
 
 #define SND_AUDIOCHANMODE_MP3_MONO ((__u32) 0x00000001)
-- 
2.11.0
