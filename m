From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] echoaudio, fw_writer
Date: Tue, 18 Jul 2006 23:19:35 +0200
Message-ID: <20060718231935.63c255ea.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


After a talk with Richard Stallman, who said it is not correct to link a
binary image into a GPL program even if is just dumped onto disk, here you
are this patch that makes fw_writer to load and parse the C sources
containing the images instead of including them at compile time. It supports
both the "sources" that are already part of alsa-firmware and the original
files downloadable from the Echoaudio web site.



Signed-off-by: Giuliano Pochini <pochini@shiny.it>

Change the fw_writer utility so it does not #include the binary images
anymore. It loads them from disk instead.

--- alsa-firmware/echoaudio/fw_writer.c__orig	2006-07-17 22:41:39.000000000 +0200
+++ alsa-firmware/echoaudio/fw_writer.c	2006-07-18 22:55:01.000000000 +0200
@@ -17,6 +17,7 @@
  */
 
 #include <stdio.h>
+#include <sys/stat.h>
 #include <stdint.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -24,53 +25,74 @@
 #include <string.h>
 #include <errno.h>
 
-typedef uint8_t u8;
-typedef uint16_t u16;
 
-#include "DSP/LoaderDSP.c"
-#include "DSP/Darla20DSP.c"
-#include "DSP/Gina20DSP.c"
-#include "DSP/Layla20DSP.c"
-#include "ASIC/LaylaASIC.c"
-#include "DSP/Darla24DSP.c"
-#include "ASIC/Gina24ASIC.c"
-#include "ASIC/Gina24ASIC_361.c"
-#include "DSP/Gina24DSP.c"
-#include "DSP/Gina24_361DSP.c"
-#include "DSP/Layla24DSP.c"
-#include "ASIC/Layla24_1ASIC.c"
-#include "ASIC/Layla24_2A_ASIC.c"
-#include "ASIC/Layla24_2S_ASIC.c"
-#include "DSP/MonaDSP.c"
-#include "DSP/Mona361DSP.c"
-#include "ASIC/Mona1ASIC48.c"
-#include "ASIC/Mona1ASIC96.c"
-#include "ASIC/Mona1ASIC48_361.c"
-#include "ASIC/Mona1ASIC96_361.c"
-#include "ASIC/Mona2ASIC.c"
-#include "DSP/MiaDSP.c"
-#include "DSP/Echo3gDSP.c"
-#include "ASIC/3G_ASIC.c"
-#include "DSP/IndigoDSP.c"
-#include "DSP/IndigoIODSP.c"
-#include "DSP/IndigoDJDSP.c"
+char *next_number(char *c)
+{
+	while (1) {
+		c++;
+		if (*c==0 || *c == '}')
+			return NULL;
+		if (c[0]=='0' && c[1]=='x')
+			return c;
+	}
+}
 
 
-int write_fw(const char *name, void *fw, ssize_t size)
+
+int write_fw(const char *dest, const char *src)
 {
-	int fd, n;
+	uint16_t d16;
+	uint8_t d8;
+	int fd;
+	struct stat stbuf;
+	char *buf, *c;
 
-	if ((fd = open(name, O_WRONLY | O_CREAT | O_TRUNC, 0644)) < 0) {
-		printf("Open error: %s\n", strerror(fd));
-		return fd;
+	if ((fd = open(src, O_RDONLY)) < 0) {
+		printf("%s: %s\n", src, strerror(errno));
+		exit(errno);
 	}
-	n = write(fd, fw, size);
-	if (n < 0)
-		printf("Error writing %s: %s\n", name, strerror(fd));
-	else if (n < size)
-		printf("Error writing %s: file is incomplete (%s)\n", name, strerror(fd));
+	if (fstat(fd, &stbuf) < 0) {
+		printf("%s: %s\n", src, strerror(errno));
+		exit(errno);
+	}
+	if (!(buf = malloc(stbuf.st_size + 1))) {
+		puts("Out of memory.");
+		exit(ENOMEM);
+	}
+	if (read(fd, buf, stbuf.st_size) < stbuf.st_size) {
+		puts("Read error.");
+		exit(EIO);
+	}
+	close(fd);
+	buf[stbuf.st_size] = 0;
 
+	if ((fd = open(dest, O_WRONLY | O_CREAT | O_TRUNC, 0644)) < 0) {
+		printf("%s: %s\n", dest, strerror(errno));
+		exit(errno);
+	}
+	if ((c = strstr(buf, "u8 ")) || (c = strstr(buf, "BYTE "))) {
+		while (c = next_number(c)) {
+			d8 = strtol(c, NULL, 16);
+			if (write(fd, &d8, 1) < 1) {
+				printf("Error writing %s\n", dest);
+				exit(EIO);
+			}
+		}
+	} else if ((c = strstr(buf, "u16 ")) || (c = strstr(buf, "WORD "))) {
+		while (c = next_number(c)) {
+			d16 = strtol(c, NULL, 16);
+			if (write(fd, &d16, 2) < 2) {
+				printf("Error writing %s\n", dest);
+				exit(EIO);
+			}
+		}
+	} else {
+		printf("%s currupted ?\n", src);
+		exit(EINVAL);
+	}
 	close(fd);
+	free(buf);
+
 	return 0;
 }
 
@@ -78,33 +100,32 @@ int write_fw(const char *name, void *fw,
 
 int main(void)
 {
-	write_fw("loader_dsp.fw", LoaderDSP, sizeof(LoaderDSP));
-	write_fw("darla20_dsp.fw", Darla20DSP, sizeof(Darla20DSP));
-	write_fw("gina20_dsp.fw", Gina20DSP, sizeof(Gina20DSP));
-	write_fw("layla20_dsp.fw", Layla20DSP, sizeof(Layla20DSP));
-	write_fw("layla20_asic.fw", LaylaASIC, sizeof(LaylaASIC));
-	write_fw("darla24_dsp.fw", Darla24DSP, sizeof(Darla24DSP));
-	write_fw("gina24_301_dsp.fw", Gina24DSP, sizeof(Gina24DSP));
-	write_fw("gina24_301_asic.fw", Gina24ASIC, sizeof(Gina24ASIC));
-	write_fw("gina24_361_dsp.fw", Gina24_361DSP, sizeof(Gina24_361DSP));
-	write_fw("gina24_361_asic.fw", Gina24ASIC_361, sizeof(Gina24ASIC_361));
-	write_fw("layla24_dsp.fw", Layla24DSP, sizeof(Layla24DSP));
-	write_fw("layla24_1_asic.fw", Layla24_1ASIC, sizeof(Layla24_1ASIC));
-	write_fw("layla24_2A_asic.fw", Layla24_2A_ASIC, sizeof(Layla24_2A_ASIC));
-	write_fw("layla24_2S_asic.fw", Layla24_2S_ASIC, sizeof(Layla24_2S_ASIC));
-	write_fw("mona_301_dsp.fw", MonaDSP, sizeof(MonaDSP));
-	write_fw("mona_301_1_asic_48.fw", Mona1ASIC48, sizeof(Mona1ASIC48));
-	write_fw("mona_301_1_asic_96.fw", Mona1ASIC96, sizeof(Mona1ASIC96));
-	write_fw("mona_361_dsp.fw", Mona361DSP, sizeof(Mona361DSP));
-	write_fw("mona_361_1_asic_48.fw", Mona1ASIC48_361, sizeof(Mona1ASIC48_361));
-	write_fw("mona_361_1_asic_96.fw", Mona1ASIC96_361, sizeof(Mona1ASIC96_361));
-	write_fw("mona_2_asic.fw", Mona2ASIC, sizeof(Mona2ASIC));
-	write_fw("mia_dsp.fw", MiaDSP, sizeof(MiaDSP));
-	write_fw("echo3g_dsp.fw", Echo3gDSP, sizeof(Echo3gDSP));
-	write_fw("3g_asic.fw", echo3g_asic, sizeof(echo3g_asic));
-	write_fw("indigo_dsp.fw", IndigoDSP, sizeof(IndigoDSP));
-	write_fw("indigo_io_dsp.fw", IndigoioDSP, sizeof(IndigoioDSP));
-	write_fw("indigo_dj_dsp.fw", IndigodjDSP, sizeof(IndigodjDSP));
+	write_fw("loader_dsp.fw", "DSP/LoaderDSP.c");
+	write_fw("darla20_dsp.fw", "DSP/Darla20DSP.c");
+	write_fw("gina20_dsp.fw", "DSP/Gina20DSP.c");
+	write_fw("layla20_dsp.fw", "DSP/Layla20DSP.c");
+	write_fw("layla20_asic.fw", "ASIC/LaylaASIC.c");
+	write_fw("darla24_dsp.fw", "DSP/Darla24DSP.c");
+	write_fw("gina24_301_dsp.fw", "DSP/Gina24DSP.c");
+	write_fw("gina24_301_asic.fw", "ASIC/Gina24ASIC.c");
+	write_fw("gina24_361_dsp.fw", "DSP/Gina24_361DSP.c");
+	write_fw("gina24_361_asic.fw", "ASIC/Gina24ASIC_361.c");
+	write_fw("layla24_dsp.fw", "DSP/Layla24DSP.c");
+	write_fw("layla24_1_asic.fw", "ASIC/Layla24_1ASIC.c");
+	write_fw("layla24_2A_asic.fw", "ASIC/Layla24_2A_ASIC.c");
+	write_fw("layla24_2S_asic.fw", "ASIC/Layla24_2S_ASIC.c");
+	write_fw("mona_301_dsp.fw", "DSP/MonaDSP.c");
+	write_fw("mona_301_1_asic_48.fw", "ASIC/Mona1ASIC48.c");
+	write_fw("mona_301_1_asic_96.fw", "ASIC/Mona1ASIC96.c");
+	write_fw("mona_361_dsp.fw", "DSP/Mona361DSP.c");
+	write_fw("mona_361_1_asic_48.fw", "ASIC/Mona1ASIC48_361.c");
+	write_fw("mona_361_1_asic_96.fw", "ASIC/Mona1ASIC96_361.c");
+	write_fw("mona_2_asic.fw", "ASIC/Mona2ASIC.c");
+	write_fw("mia_dsp.fw", "DSP/MiaDSP.c");
+	write_fw("echo3g_dsp.fw", "DSP/Echo3gDSP.c");
+	write_fw("3g_asic.fw", "ASIC/3G_ASIC.c");
+	write_fw("indigo_dsp.fw", "DSP/IndigoDSP.c");
+	write_fw("indigo_io_dsp.fw", "DSP/IndigoIODSP.c");
+	write_fw("indigo_dj_dsp.fw", "DSP/IndigoDJDSP.c");
 	return 0;
 }
-



--
Giuliano.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
