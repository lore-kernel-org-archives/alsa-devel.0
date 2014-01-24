From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [TINYCOMPRESS PATCH 2/2 v4] crec: Add primitive
	exception handling
Date: Fri, 24 Jan 2014 11:37:35 +0000
Message-ID: <1390563455-26209-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1390563455-26209-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0A0052616F1
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2014 12:45:52 +0100 (CET)
In-Reply-To: <1390563455-26209-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 crec.c |   74 +++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 62 insertions(+), 12 deletions(-)

diff --git a/crec.c b/crec.c
index 568e4b7..31703c5 100644
--- a/crec.c
+++ b/crec.c
@@ -74,6 +74,7 @@
 #include "tinycompress/tinycompress.h"
 
 static int verbose;
+static int file;
 
 static const unsigned int DEFAULT_CHANNELS = 1;
 static const unsigned int DEFAULT_RATE = 44100;
@@ -183,6 +184,48 @@ static int print_time(struct compress *compress)
 	return 0;
 }
 
+static int finish_record()
+{
+	struct wave_header header;
+	int ret;
+	size_t nread, written;
+
+	if (!file)
+		return -ENOENT;
+
+	/* Get amount of data written to file */
+	ret = lseek(file, 0, SEEK_END);
+	if (ret < 0)
+		return -errno;
+
+	written = ret;
+	if (written < sizeof(header))
+		return -ENOENT;
+	written -= sizeof(header);
+
+	/* Sync file header from file */
+	ret = lseek(file, 0, SEEK_SET);
+	if (ret < 0)
+		return -errno;
+
+	nread = read(file, &header, sizeof(header));
+	if (nread != sizeof(header))
+		return -errno;
+
+	/* Update file header */
+	ret = lseek(file, 0, SEEK_SET);
+	if (ret < 0)
+		return -errno;
+
+	size_wave_header(&header, written);
+
+	written = write(file, &header, sizeof(header));
+	if (written != sizeof(header))
+		return -errno;
+
+	return 0;
+}
+
 void capture_samples(char *name, unsigned int card, unsigned int device,
 		     unsigned long buffer_size, unsigned int frag,
 		     unsigned int length, unsigned int rate,
@@ -192,7 +235,6 @@ void capture_samples(char *name, unsigned int card, unsigned int device,
 	struct snd_codec codec;
 	struct compress *compress;
 	struct wave_header header;
-	int file;
 	char *buffer;
 	size_t written;
 	int read, ret;
@@ -214,7 +256,7 @@ void capture_samples(char *name, unsigned int card, unsigned int device,
 	if (verbose)
 		printf("%s: entry, reading %u bytes\n", __func__, length);
 
-	file = open(name, O_WRONLY | O_CREAT);
+	file = open(name, O_RDWR | O_CREAT);
 	if (file == -1) {
 		fprintf(stderr, "Unable to open file '%s'\n", name);
 		exit(EXIT_FAILURE);
@@ -311,17 +353,9 @@ void capture_samples(char *name, unsigned int card, unsigned int device,
 		fprintf(stderr, "ERR: %s\n", compress_get_error(compress));
 	}
 
-	/* Update file header now we know file size */
-	size_wave_header(&header, total_read);
-	ret = lseek(file, 0, SEEK_SET);
+	ret = finish_record();
 	if (ret < 0) {
-		fprintf(stderr, "Error seeking: %s\n", strerror(errno));
-		goto buf_exit;
-	}
-	written = write(file, &header, sizeof(header));
-	if (written != sizeof(header)) {
-		fprintf(stderr, "Error updating output file header: %s\n",
-			strerror(errno));
+		fprintf(stderr, "Failed to finish header: %s\n", strerror(ret));
 		goto buf_exit;
 	}
 
@@ -330,6 +364,7 @@ void capture_samples(char *name, unsigned int card, unsigned int device,
 
 	free(buffer);
 	close(file);
+	file = 0;
 
 	compress_close(compress);
 
@@ -347,6 +382,16 @@ file_exit:
 	exit(EXIT_FAILURE);
 }
 
+static void sig_handler(int signum __attribute__ ((unused)))
+{
+	finish_record();
+
+	if (file)
+		close(file);
+
+	_exit(EXIT_FAILURE);
+}
+
 int main(int argc, char **argv)
 {
 	char *file;
@@ -356,6 +401,11 @@ int main(int argc, char **argv)
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
