From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: [PATCH v2] echoaudio, fw_writer
Date: Sun, 23 Jul 2006 17:39:37 +0200
Message-ID: <20060723173937.6dc581b1.pochini@shiny.it>
References: <XFMail.20060719103126.pochini@shiny.it>
	<200607201126.29627.linux@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200607201126.29627.linux@blennerhassett.gen.nz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Eliot Blennerhassett <linux@blennerhassett.gen.nz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 20 Jul 2006 11:26:29 +1200
Eliot Blennerhassett <linux@blennerhassett.gen.nz> wrote:

> Now you don't have to include each C file, you could make fw_loader.c int=
o =

> universal c to fw converter by getting the parameters for
>
> +=A0=A0=A0=A0=A0=A0=A0write_fw("loader_dsp.fw", "DSP/LoaderDSP.c");
>
> from the commandline?

Here you are. This patch is against the current HG version.



Signed-off-by: Giuliano Pochini <pochini@shiny.it>

Change the fw_writer utility so it does not #include the binary images
anymore. It loads them from disk instead.

--- alsa-firmware/echoaudio/Makefile.am__orig	2006-07-23 17:03:56.000000000=
 +0200
+++ alsa-firmware/echoaudio/Makefile.am	2006-07-23 17:13:21.000000000 +0200
@@ -70,4 +70,29 @@ hotplugfw_DATA =3D =

 endif
 =

 $(firmware_files): fw_writer
-	./fw_writer
+	./fw_writer DSP/Darla20DSP.c darla20_dsp.fw
+	./fw_writer DSP/Gina20DSP.c gina20_dsp.fw
+	./fw_writer DSP/Layla20DSP.c layla20_dsp.fw
+	./fw_writer ASIC/LaylaASIC.c layla20_asic.fw
+	./fw_writer DSP/Darla24DSP.c darla24_dsp.fw
+	./fw_writer DSP/Gina24DSP.c gina24_301_dsp.fw
+	./fw_writer ASIC/Gina24ASIC.c gina24_301_asic.fw
+	./fw_writer DSP/Gina24_361DSP.c gina24_361_dsp.fw
+	./fw_writer ASIC/Gina24ASIC_361.c gina24_361_asic.fw
+	./fw_writer DSP/Layla24DSP.c layla24_dsp.fw
+	./fw_writer ASIC/Layla24_1ASIC.c layla24_1_asic.fw
+	./fw_writer ASIC/Layla24_2A_ASIC.c layla24_2A_asic.fw
+	./fw_writer ASIC/Layla24_2S_ASIC.c layla24_2S_asic.fw
+	./fw_writer DSP/MonaDSP.c mona_301_dsp.fw
+	./fw_writer ASIC/Mona1ASIC48.c mona_301_1_asic_48.fw
+	./fw_writer ASIC/Mona1ASIC96.c mona_301_1_asic_96.fw
+	./fw_writer DSP/Mona361DSP.c mona_361_dsp.fw
+	./fw_writer ASIC/Mona1ASIC48_361.c mona_361_1_asic_48.fw
+	./fw_writer ASIC/Mona1ASIC96_361.c mona_361_1_asic_96.fw
+	./fw_writer ASIC/Mona2ASIC.c mona_2_asic.fw
+	./fw_writer DSP/MiaDSP.c mia_dsp.fw
+	./fw_writer DSP/Echo3gDSP.c echo3g_dsp.fw
+	./fw_writer ASIC/3G_ASIC.c 3g_asic.fw
+	./fw_writer DSP/IndigoDSP.c indigo_dsp.fw
+	./fw_writer DSP/IndigoIODSP.c indigo_io_dsp.fw
+	./fw_writer DSP/IndigoDJDSP.c indigo_dj_dsp.fw
--- alsa-firmware/echoaudio/fw_writer.c__orig	2006-07-17 22:41:39.000000000=
 +0200
+++ alsa-firmware/echoaudio/fw_writer.c	2006-07-23 17:17:05.000000000 +0200
@@ -17,6 +17,7 @@
  */
 =

 #include <stdio.h>
+#include <sys/stat.h>
 #include <stdint.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -24,87 +25,85 @@
 #include <string.h>
 #include <errno.h>
 =

-typedef uint8_t u8;
-typedef uint16_t u16;
 =

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
+		if (*c=3D=3D0 || *c =3D=3D '}')
+			return NULL;
+		if (c[0]=3D=3D'0' && c[1]=3D=3D'x')
+			return c;
+	}
+}
 =

 =

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
 =

-	if ((fd =3D open(name, O_WRONLY | O_CREAT | O_TRUNC, 0644)) < 0) {
-		printf("Open error: %s\n", strerror(fd));
-		return fd;
+	if ((fd =3D open(src, O_RDONLY)) < 0) {
+		printf("%s: %s\n", src, strerror(errno));
+		exit(errno);
 	}
-	n =3D write(fd, fw, size);
-	if (n < 0)
-		printf("Error writing %s: %s\n", name, strerror(fd));
-	else if (n < size)
-		printf("Error writing %s: file is incomplete (%s)\n", name, strerror(fd)=
);
+	if (fstat(fd, &stbuf) < 0) {
+		printf("%s: %s\n", src, strerror(errno));
+		exit(errno);
+	}
+	if (!(buf =3D malloc(stbuf.st_size + 1))) {
+		puts("Out of memory.");
+		exit(ENOMEM);
+	}
+	if (read(fd, buf, stbuf.st_size) < stbuf.st_size) {
+		puts("Read error.");
+		exit(EIO);
+	}
+	close(fd);
+	buf[stbuf.st_size] =3D 0;
 =

+	if ((fd =3D open(dest, O_WRONLY | O_CREAT | O_TRUNC, 0644)) < 0) {
+		printf("%s: %s\n", dest, strerror(errno));
+		exit(errno);
+	}
+	if ((c =3D strstr(buf, "u8 ")) || (c =3D strstr(buf, "BYTE ")) || (c =3D =
strstr(buf, "char "))) {
+		while (c =3D next_number(c)) {
+			d8 =3D strtol(c, NULL, 16);
+			if (write(fd, &d8, 1) < 1) {
+				printf("Error writing %s\n", dest);
+				exit(EIO);
+			}
+		}
+	} else if ((c =3D strstr(buf, "u16 ")) || (c =3D strstr(buf, "WORD "))) {
+		while (c =3D next_number(c)) {
+			d16 =3D strtol(c, NULL, 16);
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
 =

 =

 =

-int main(void)
+int main(int argc, char *argv[])
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
-	write_fw("mona_361_1_asic_48.fw", Mona1ASIC48_361, sizeof(Mona1ASIC48_361=
));
-	write_fw("mona_361_1_asic_96.fw", Mona1ASIC96_361, sizeof(Mona1ASIC96_361=
));
-	write_fw("mona_2_asic.fw", Mona2ASIC, sizeof(Mona2ASIC));
-	write_fw("mia_dsp.fw", MiaDSP, sizeof(MiaDSP));
-	write_fw("echo3g_dsp.fw", Echo3gDSP, sizeof(Echo3gDSP));
-	write_fw("3g_asic.fw", echo3g_asic, sizeof(echo3g_asic));
-	write_fw("indigo_dsp.fw", IndigoDSP, sizeof(IndigoDSP));
-	write_fw("indigo_io_dsp.fw", IndigoioDSP, sizeof(IndigoioDSP));
-	write_fw("indigo_dj_dsp.fw", IndigodjDSP, sizeof(IndigodjDSP));
+	if (argc !=3D 3) {
+		printf("Syntax: %s <source> <destination>\n", argv[0]);
+		exit(0);
+	}
+	write_fw(argv[2], argv[1]);
 	return 0;
 }
-



--
Giuliano.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
