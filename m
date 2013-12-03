From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2 v2] crec: Add primitive exception handling
Date: Tue,  3 Dec 2013 16:27:55 +0000
Message-ID: <1386088075-21011-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1386088075-21011-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DC18F265200
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2013 17:31:54 +0100 (CET)
In-Reply-To: <1386088075-21011-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@linux.intel.com
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Add very primitive signal handling, we will not attempt to drain any
remaining data etc. simply save out what we have to a file.

Change-Id: I01aee72d0ce9445e9dbe0f7ea42a8752ba71ccbd
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---

Changes since v1:
  - Set fopen parameter to "w+b", this was originally in the
  last patch but makes more sense here as this patch is the
  one that requires it, so that it can read back the header
  from the file on close.

Thanks,
Charles

 crec.c |   92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 78 insertions(+), 14 deletions(-)

diff --git a/crec.c b/crec.c
index 2976df3..b761f7c 100644
--- a/crec.c
+++ b/crec.c
@@ -74,6 +74,7 @@
 #include "tinycompress/tinycompress.h"
 
 static int verbose;
+static FILE *file;
 
 static const unsigned int DEFAULT_CHANNELS = 1;
 static const unsigned int DEFAULT_RATE = 44100;
@@ -183,6 +184,62 @@ static int print_time(struct compress *compress)
 	return 0;
 }
 
+static int finish_record()
+{
+	struct wave_header header;
+	int ret;
+	size_t read, written;
+
+	if (!file)
+		return -ENOENT;
+
+	/* Get amount of data written to file */
+	ret = fseek(file, 0, SEEK_END);
+	if (ret < 0)
+		goto seek_error;
+	ret = ftell(file);
+	if (ret < 0) {
+		fprintf(stderr, "Error reading file position: %s\n",
+			strerror(errno));
+		return errno;
+	}
+	written = ret;
+	if (written < sizeof(header)) {
+		fprintf(stderr, "No data recorded!\n");
+		return -ENOENT;
+	}
+	written -= sizeof(header);
+
+	/* Sync file header from file */
+	ret = fseek(file, 0, SEEK_SET);
+	if (ret < 0)
+		goto seek_error;
+	read = fread(&header, sizeof(header), 1, file);
+	if (read != 1) {
+		ret = ferror(file);
+		fprintf(stderr, "Error reading output file header: %d\n", ret);
+		return ret;
+	}
+
+	/* Update file header */
+	ret = fseek(file, 0, SEEK_SET);
+	if (ret < 0)
+		goto seek_error;
+	size_wave_header(&header, written);
+	written = fwrite(&header, sizeof(header), 1, file);
+	if (written != 1) {
+		ret = ferror(file);
+		fprintf(stderr, "Error updating output file header: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+
+seek_error:
+	fprintf(stderr, "Error seeking: %s\n", strerror(errno));
+	return errno;
+}
+
 void capture_samples(char *name, unsigned int card, unsigned int device,
 		     unsigned long buffer_size, unsigned int frag,
 		     unsigned int length, unsigned int rate,
@@ -192,7 +249,6 @@ void capture_samples(char *name, unsigned int card, unsigned int device,
 	struct snd_codec codec;
 	struct compress *compress;
 	struct wave_header header;
-	FILE *file;
 	char *buffer;
 	size_t written;
 	int read, ret;
@@ -214,7 +270,7 @@ void capture_samples(char *name, unsigned int card, unsigned int device,
 	if (verbose)
 		printf("%s: entry, reading %u bytes\n", __func__, length);
 
-	file = fopen(name, "wb");
+	file = fopen(name, "w+b");
 	if (!file) {
 		fprintf(stderr, "Unable to open file '%s'\n", name);
 		exit(EXIT_FAILURE);
@@ -310,25 +366,16 @@ void capture_samples(char *name, unsigned int card, unsigned int device,
 		fprintf(stderr, "ERR: %s\n", compress_get_error(compress));
 	}
 
-	/* Update file header now we know file size */
-	size_wave_header(&header, total_read);
-	ret = fseek(file, 0, SEEK_SET);
-	if (ret < 0) {
-		fprintf(stderr, "Error seeking: %s\n", stderror(errno));
+	ret = finish_record();
+	if (ret < 0)
 		goto buf_exit;
-	}
-	written = fwrite(&header, sizeof(header), 1, file);
-	if (written != 1) {
-		fprintf(stderr, "Error updating output file header: %d\n",
-			ferror(file));
-		goto buf_exit;
-	}
 
 	if (verbose)
 		printf("%s: exit success\n", __func__);
 
 	free(buffer);
 	fclose(file);
+	file = NULL;
 
 	compress_close(compress);
 
@@ -346,6 +393,18 @@ file_exit:
 	exit(EXIT_FAILURE);
 }
 
+static void sig_handler(int signum __attribute__ ((unused)))
+{
+	printf("Interrupted, saving what we have!\n");
+
+	finish_record();
+
+	if (file)
+		fclose(file);
+
+	_exit(EXIT_FAILURE);
+}
+
 int main(int argc, char **argv)
 {
 	char *file;
@@ -355,6 +414,11 @@ int main(int argc, char **argv)
 	unsigned int rate = DEFAULT_RATE, channels = DEFAULT_CHANNELS;
 	unsigned int format = DEFAULT_FORMAT;
 
+	if (signal(SIGINT, sig_handler) == SIG_ERR) {
+		fprintf(stderr, "Error registering signal handler\n");
+		exit(EXIT_FAILURE);
+	}
+
 	if (argc < 2)
 		usage();
 
-- 
1.7.2.5
