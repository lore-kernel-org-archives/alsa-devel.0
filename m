From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH] tinycompress: cplay: Correct a couple of small
	message	typos
Date: Mon, 15 Apr 2013 17:39:39 +0100
Message-ID: <20130415163724.GA28342@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 70C822651D8
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 18:39:51 +0200 (CEST)
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Change-Id: I2b25d006328f1a9458f232f77c61e509c9b54d3c
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 cplay.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/cplay.c b/cplay.c
index 60995a4..d9364f4 100644
--- a/cplay.c
+++ b/cplay.c
@@ -337,7 +337,7 @@ void play_samples(char *name, unsigned int card, unsigned int device,
 				goto BUF_EXIT;
 			}
 			if (wrote != num_read) {
-				/* TODO: Buufer pointer needs to be set here */
+				/* TODO: Buffer pointer needs to be set here */
 				fprintf(stderr, "We wrote %d, DSP accepted %d\n", num_read, wrote);
 			}
 			if (verbose) {
@@ -348,7 +348,7 @@ void play_samples(char *name, unsigned int card, unsigned int device,
 	} while (num_read > 0);
 
 	if (verbose)
-		printf("%s: exit sucess\n", __func__);
+		printf("%s: exit success\n", __func__);
 	/* issue drain if it supports */
 	compress_drain(compress);
 	free(buffer);
-- 
1.7.2.5
