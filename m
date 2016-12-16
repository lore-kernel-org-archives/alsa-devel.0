From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] tinycompress: rename crec usages
Date: Fri, 16 Dec 2016 13:09:08 +0530
Message-ID: <1481873948-3720-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F81D265AF3
 for <alsa-devel@alsa-project.org>; Fri, 16 Dec 2016 08:39:39 +0100 (CET)
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

The creord utility help listed crec as the utility name, change that to
crecord and also update the program explanation text.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 src/utils/crecord.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/utils/crecord.c b/src/utils/crecord.c
index 8d5b7b0b2c30..1ba54d70e89c 100644
--- a/src/utils/crecord.c
+++ b/src/utils/crecord.c
@@ -1,7 +1,7 @@
 /*
  * BSD LICENSE
  *
- * crec command line recorder for compress audio record in alsa
+ * crecord command line recorder for compress audio record in alsa
  * Copyright (c) 2011-2012, Intel Corporation
  * Copyright (c) 2013-2014, Wolfson Microelectronic Ltd.
  * All rights reserved.
@@ -35,7 +35,7 @@
  *
  * LGPL LICENSE
  *
- * crec command line recorder for compress audio record in alsa
+ * crecord command line recorder for compress audio record in alsa
  * Copyright (c) 2011-2012, Intel Corporation
  * Copyright (c) 2013-2014, Wolfson Microelectronic Ltd.
  *
@@ -153,7 +153,7 @@ static void size_wave_header(struct wave_header *header, uint32_t size)
 
 static void usage(void)
 {
-	fprintf(stderr, "usage: crec [OPTIONS] [filename]\n"
+	fprintf(stderr, "usage: crecord [OPTIONS] [filename]\n"
 		"-c\tcard number\n"
 		"-d\tdevice node\n"
 		"-b\tbuffer size\n"
@@ -167,8 +167,8 @@ static void usage(void)
 		"If filename is not given the output is\n"
 		"written to stdout\n\n"
 		"Example:\n"
-		"\tcrec -c 1 -d 2 test.wav\n"
-		"\tcrec -f 5 test.wav\n",
+		"\tcrecord -c 1 -d 2 test.wav\n"
+		"\tcrecord -f 5 test.wav\n",
 		DEFAULT_CHANNELS, DEFAULT_RATE);
 
 	exit(EXIT_FAILURE);
-- 
1.9.1
