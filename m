From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH] crec: Always read whole number of fragments
	when length limit specified
Date: Thu, 3 Dec 2015 11:25:35 +0000
Message-ID: <1449141935-23350-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CF64265325
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2015 12:25:37 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This patch removes the lines that adjusted the read size to exactly
read to the end of the calculated length in bytes. Doing this could
lead to invalid fragment sizes being requested which may then cause
a read error on some codecs.

Instead we keep reading whole fragments until we have >= length bytes
of data captured.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 src/utils/crec.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/utils/crec.c b/src/utils/crec.c
index 258fade..e61e620 100644
--- a/src/utils/crec.c
+++ b/src/utils/crec.c
@@ -332,9 +332,6 @@ void capture_samples(char *name, unsigned int card, unsigned int device,
 		fprintf(finfo, "%s: Capturing audio NOW!!!\n", __func__);
 
 	do {
-		if (length && size > length - total_read)
-			size = length - total_read;
-
 		read = compress_read(compress, buffer, size);
 		if (read < 0) {
 			fprintf(stderr, "Error reading sample\n");
-- 
1.9.1
