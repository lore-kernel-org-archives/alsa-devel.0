From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [RFC PATCH] ALSA: compress: Add SND_AUDIOCODEC_BESPOKE
Date: Tue, 20 Oct 2015 14:39:18 +0100
Message-ID: <1445348358-23306-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 4230F26653B
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 15:57:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com, tiwai@suse.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

When working with the compressed framework occasionally vendors will
use esoteric internal audio formats. For such formats it doesn't really
make sense to add an new define to the kernel as their use is not
sufficiently general.

This patch adds a new define SND_AUDIOCODEC_BESPOKE that vendors can use
in such situations.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 include/uapi/sound/compress_params.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/include/uapi/sound/compress_params.h b/include/uapi/sound/compress_params.h
index d9bd9ca..e284380 100644
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
-- 
1.7.2.5
