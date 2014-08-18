From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [TINYCOMPRESS][PATCH] crec: Fix error with opening
	file using	O_CREAT
Date: Mon, 18 Aug 2014 09:41:58 +0100
Message-ID: <20140818084158.GA14810@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 66B2F26574C
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 10:42:02 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, ammar.zhd@googlemail.com
List-Id: alsa-devel@alsa-project.org

From: Ammar Zahid Ali Syed <ammar.zhd@googlemail.com>

The code was not compiling when mode was not passed to open()
while using O_CREAT offset. Passed mode to the open() alongwith
O_CREAT to specify the attributes of file and fix compile issue.

Signed-off-by: Ammar Zahid Ali Syed <ammar.zhd@googlemail.com>
---
 crec.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/crec.c b/crec.c
index 31703c5..e3f189f 100644
--- a/crec.c
+++ b/crec.c
@@ -66,6 +66,8 @@
 #include <stdbool.h>
 #include <getopt.h>
 #include <sys/time.h>
+#include <sys/types.h>
+#include <sys/stat.h>
 #define __force
 #define __bitwise
 #define __user
@@ -256,7 +258,7 @@ void capture_samples(char *name, unsigned int card, unsigned int device,
 	if (verbose)
 		printf("%s: entry, reading %u bytes\n", __func__, length);
 
-	file = open(name, O_RDWR | O_CREAT);
+	file = open(name, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP);
 	if (file == -1) {
 		fprintf(stderr, "Unable to open file '%s'\n", name);
 		exit(EXIT_FAILURE);
-- 
1.7.2.5
