From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] crecord: Fix some minor coding style
	problems
Date: Wed, 18 Jan 2017 16:29:53 +0000
Message-ID: <1484756994-19679-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 9345F266A11
 for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2017 17:29:59 +0100 (CET)
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

- Incorrect indenting of arguments to capture_samples()
- Wrap long line in capture_samples()
- Added a blank line in main() for readability
- Deleted extra trailing blank line at end of file

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 src/utils/crecord.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/src/utils/crecord.c b/src/utils/crecord.c
index 1ba54d7..390fe45 100644
--- a/src/utils/crecord.c
+++ b/src/utils/crecord.c
@@ -237,9 +237,9 @@ static int finish_record(void)
 }
 
 static void capture_samples(char *name, unsigned int card, unsigned int device,
-		     unsigned long buffer_size, unsigned int frag,
-		     unsigned int length, unsigned int rate,
-		     unsigned int channels, unsigned int format)
+			    unsigned long buffer_size, unsigned int frag,
+			    unsigned int length, unsigned int rate,
+			    unsigned int channels, unsigned int format)
 {
 	struct compr_config config;
 	struct snd_codec codec;
@@ -268,7 +268,8 @@ static void capture_samples(char *name, unsigned int card, unsigned int device,
         if (!name) {
                 file = STDOUT_FILENO;
         } else {
-	        file = open(name, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP);
+	        file = open(name, O_RDWR | O_CREAT,
+			    S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP);
 	        if (file == -1) {
 		       fprintf(stderr, "Unable to open file '%s'\n", name);
 		       exit(EXIT_FAILURE);
@@ -466,6 +467,7 @@ int main(int argc, char **argv)
 			exit(EXIT_FAILURE);
 		}
 	}
+
 	if (optind >= argc) {
 		file = NULL;
 		finfo = fopen("/dev/null", "w");
@@ -483,4 +485,3 @@ int main(int argc, char **argv)
 
 	exit(EXIT_SUCCESS);
 }
-
-- 
1.9.1
