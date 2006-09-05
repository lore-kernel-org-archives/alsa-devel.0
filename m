From: Giuliano Pochini <pochini@shiny.it>
Subject: =?iso-8859-1?q?=5BPATCH=5D_echoaudio=2C_fix_=A3=24?=
	=?iso-8859-1?q?=26*=23_typo?=
Date: Tue, 5 Sep 2006 22:31:16 +0200
Message-ID: <20060905223116.627df2a0.pochini@shiny.it>
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


This patch fixes a stupid typo that prevents a very important peice of
firmware from being installed.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

--- alsa-firmware/echoaudio/Makefile.am__orig	2006-09-05 22:14:50.000000000 +0200
+++ alsa-firmware/echoaudio/Makefile.am	2006-09-05 22:18:07.000000000 +0200
@@ -1,5 +1,6 @@
 # # Process this file with automake to produce Makefile.in.
 firmware_files =	\
+		loader_dsp.fw \
 		darla20_dsp.fw \
 		gina20_dsp.fw \
 		layla20_dsp.fw \
@@ -70,6 +71,7 @@ hotplugfw_DATA = 
 endif
 
 $(firmware_files): fw_writer
+	./fw_writer DSP/LoaderDSP.c loader_dsp.fw
 	./fw_writer DSP/Darla20DSP.c darla20_dsp.fw
 	./fw_writer DSP/Gina20DSP.c gina20_dsp.fw
 	./fw_writer DSP/Layla20DSP.c layla20_dsp.fw


--
Giuliano.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
