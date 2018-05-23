From: Julian Scheel <julian@jusst.de>
Subject: [PATCH v2 1/2] speaker-test: Support S24_3LE sample
	format
Date: Wed, 23 May 2018 15:42:20 +0200
Message-ID: <20180523134221.27260-1-julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web01.jusst.de (jusst.de [188.40.114.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 5202226705D
 for <alsa-devel@alsa-project.org>; Wed, 23 May 2018 15:42:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Julian Scheel <julian@jusst.de>
List-Id: alsa-devel@alsa-project.org

Implement support signed 24 bit samples, packed in 3 bytes.

Signed-off-by: Julian Scheel <julian@jusst.de>
---
 speaker-test/speaker-test.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/speaker-test/speaker-test.c b/speaker-test/speaker-test.c
index 65ab523..4804bcf 100644
--- a/speaker-test/speaker-test.c
+++ b/speaker-test/speaker-test.c
@@ -283,6 +283,8 @@ static const int	supported_formats[] = {
   SND_PCM_FORMAT_S16_LE,
   SND_PCM_FORMAT_S16_BE,
   SND_PCM_FORMAT_FLOAT_LE,
+  SND_PCM_FORMAT_S24_3LE,
+  SND_PCM_FORMAT_S24_3BE,
   SND_PCM_FORMAT_S32_LE,
   SND_PCM_FORMAT_S32_BE,
   -1
@@ -325,6 +327,18 @@ static void do_generate(uint8_t *frames, int channel, int count,
       case SND_PCM_FORMAT_FLOAT_LE:
 	*samp_f++ = res.f;
         break;
+      case SND_PCM_FORMAT_S24_3LE:
+        res.i >>= 8;
+        *samp8++ = LE_INT(res.i);
+        *samp8++ = LE_INT(res.i) >> 8;
+        *samp8++ = LE_INT(res.i) >> 16;
+        break;
+      case SND_PCM_FORMAT_S24_3BE:
+        res.i >>= 8;
+        *samp8++ = BE_INT(res.i);
+        *samp8++ = BE_INT(res.i) >> 8;
+        *samp8++ = BE_INT(res.i) >> 16;
+        break;
       case SND_PCM_FORMAT_S32_LE:
 	*samp32++ = LE_INT(res.i);
         break;
-- 
2.17.0
