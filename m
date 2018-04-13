From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH][tinycompress] crecord: Use whole buffer
	requested by user
Date: Fri, 13 Apr 2018 12:58:59 +0100
Message-ID: <20180413115859.20310-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 29CF326723C
 for <alsa-devel@alsa-project.org>; Fri, 13 Apr 2018 13:59:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Currently, crecord will only actually use 1 fragment worth of its
internal buffer no matter what the user requests. Correct this so that
the whole buffer requested by the user is used for copying data.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 src/utils/crecord.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/utils/crecord.c b/src/utils/crecord.c
index e051c2d..8728c5d 100644
--- a/src/utils/crecord.c
+++ b/src/utils/crecord.c
@@ -370,15 +370,15 @@ static void capture_samples(char *name, unsigned int card, unsigned int device,
 	if (verbose)
 		fprintf(finfo, "%s: Opened compress device\n", __func__);
 
-	size = config.fragment_size;
-	buffer = malloc(size * config.fragments);
+	size = config.fragments * config.fragment_size;
+	buffer = malloc(size);
 	if (!buffer) {
 		fprintf(stderr, "Unable to allocate %d bytes\n", size);
 		goto comp_exit;
 	}
 
 	fprintf(finfo, "Recording file %s On Card %u device %u, with buffer of %lu bytes\n",
-	       name, card, device, buffer_size);
+	       name, card, device, size);
 	fprintf(finfo, "Codec %u Format %u Channels %u, %u Hz\n",
 	       codec.id, codec.format, codec.ch_out, rate);
 
-- 
2.11.0
