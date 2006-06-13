From: Eliot Blennerhassett <linux@blennerhassett.gen.nz>
Subject: Re: AudioScience asihpi HPI + ALSA drivers released.
Date: Tue, 13 Jun 2006 12:11:42 +1200
Message-ID: <200606131211.46584.linux@blennerhassett.gen.nz>
References: <200606091953.37432.linux@blennerhassett.gen.nz>
	<s5hzmgmcv5o.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hzmgmcv5o.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thanks for comitting the changes.

On Sat, 10 Jun 2006 01:31, Takashi Iwai wrote:
> At Fri, 9 Jun 2006 19:53:36 +1200,
>
> Eliot Blennerhassett wrote:
> > Get your smoking hot tarball here:
> >
> > http://www.audioscience.com/internet/download/asihpi_hpi300_alsa1.0.11.ta
> >r.bz2 Signed-off-by: Eliot Blennerhassett
> > <eblennerhassett@audioscience.com>
> >
> > This replaces the contents of alsa-driver/pci/asihpi.  It builds a single
> > module that supports both ALSA and HPI interfaces.
> > This is such a major reorganisation of the code that it doesn't make
> > sense (to me anyway) to provide it as a patch against existing code. 
> > Future minor changes certainly will be submitted as patches.
>
> Thanks, I committed to HG tree with a minor fix for
> '#if HPI_GENERATE_FUNCTIONS' replaced with ifdef.

Thanks.   Applied to our source.
>
> > Currently requires the hpi driver to have been installed in order to
> > install firmware (it doesn't depend on the hpi driver module at all
> > though).
> > http://www.audioscience.com/internet/download/hpklinux-3.00.tar.gz
>
> How about split the firmware data from the driver code?
> Usually the driver data needs more frequent updates than the firmware
> data.

I have added our firmware to (my copy of) alsa-firmware.  Here is the package:
http://www.audioscience.com/internet/download/asihpi_alsa-firmware.tar.bz2

This has modified copies of alsa-firmware/configure.in and Makefile.am
plus a new asihpi subdirectory.
Future updates will only require the actual firmware files to be updated.

regards

Eliot
================================
Here is the hg diff of the textual parts of the changes.  The binaries are in 
the tarball referenced above.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>


diff -r 646538e52e78 Makefile.am
--- a/Makefile.am       Fri May 12 15:37:26 2006 +0200
+++ b/Makefile.am       Tue Jun 13 12:08:59 2006 +1200
@@ -1,6 +1,6 @@ AUTOMAKE_OPTIONS = 1.3 foreign
 AUTOMAKE_OPTIONS = 1.3 foreign

-SUBDIRS = hdsploader mixartloader pcxhrloader usx2yloader vxloader echoaudio
+SUBDIRS = hdsploader mixartloader pcxhrloader usx2yloader vxloader echoaudio 
asihpi

 EXTRA_DIST = depcomp

diff -r 646538e52e78 configure.in
--- a/configure.in      Fri May 12 15:37:26 2006 +0200
+++ b/configure.in      Tue Jun 13 12:08:59 2006 +1200
@@ -43,4 +43,5 @@ AC_OUTPUT(Makefile \
          usx2yloader/Makefile \
          vxloader/Makefile \
          pcxhrloader/Makefile \
-         echoaudio/Makefile)
+         echoaudio/Makefile \
+         asihpi/Makefile)
diff -r 646538e52e78 asihpi/Makefile.am
--- /dev/null   Thu Jan 01 00:00:00 1970 +0000
+++ b/asihpi/Makefile.am        Tue Jun 13 12:08:59 2006 +1200
@@ -0,0 +1,24 @@
+MYNAME = asihpi
+
+dsp_files = \
+       dsp2400.bin\
+       dsp4100.bin\
+       dsp4300.bin\
+       dsp5000.bin\
+       dsp6200.bin\
+       dsp6205.bin\
+       dsp6413.bin\
+       dsp6600.bin\
+       dsp8713.bin
+
+dsp_txt_files = $(subst bin,txt,$(dsp_files))
+
+EXTRA_DIST = $(dsp_files) $(dsp_txt_files)
+
+if USE_HOTPLUG
+hotplugfwdir = @HOTPLUGFWDIR@/asihpi
+hotplugfw_DATA = $(dsp_files)  $(dsp_txt_files)
+else
+hotplugfwdir =
+hotplugfw_DATA =
+endif
diff -r 646538e52e78 asihpi/dsp2400.bin
Binary file asihpi/dsp2400.bin has changed
diff -r 646538e52e78 asihpi/dsp2400.txt
--- /dev/null   Thu Jan 01 00:00:00 1970 +0000
+++ b/asihpi/dsp2400.txt        Tue Jun 13 12:08:59 2006 +1200
@@ -0,0 +1,2 @@
+AX2400, version 037, size 161740, checksum 0xC531A066
+
\ No newline at end of file
diff -r 646538e52e78 asihpi/dsp4100.bin
Binary file asihpi/dsp4100.bin has changed
diff -r 646538e52e78 asihpi/dsp4100.txt
--- /dev/null   Thu Jan 01 00:00:00 1970 +0000
+++ b/asihpi/dsp4100.txt        Tue Jun 13 12:08:59 2006 +1200
@@ -0,0 +1,2 @@
+AX4100, version 422, size 144572, checksum 0xFFF3CB0E
+
\ No newline at end of file
diff -r 646538e52e78 asihpi/dsp4300.bin
Binary file asihpi/dsp4300.bin has changed
diff -r 646538e52e78 asihpi/dsp4300.txt
--- /dev/null   Thu Jan 01 00:00:00 1970 +0000
+++ b/asihpi/dsp4300.txt        Tue Jun 13 12:08:59 2006 +1200
@@ -0,0 +1,2 @@
+AX4300, version 457, size 179636, checksum 0xFF11770C
+
\ No newline at end of file
diff -r 646538e52e78 asihpi/dsp5000.bin
Binary file asihpi/dsp5000.bin has changed
diff -r 646538e52e78 asihpi/dsp5000.txt
--- /dev/null   Thu Jan 01 00:00:00 1970 +0000
+++ b/asihpi/dsp5000.txt        Tue Jun 13 12:08:59 2006 +1200
@@ -0,0 +1,2 @@
+AX5000, version 016, size 157480, checksum 0x7543ACBC
+
\ No newline at end of file
diff -r 646538e52e78 asihpi/dsp6200.bin
Binary file asihpi/dsp6200.bin has changed
diff -r 646538e52e78 asihpi/dsp6200.txt
--- /dev/null   Thu Jan 01 00:00:00 1970 +0000
+++ b/asihpi/dsp6200.txt        Tue Jun 13 12:08:59 2006 +1200
@@ -0,0 +1,2 @@
+AX6200, version 103, size 755608, checksum 0x100AECB7
+
\ No newline at end of file
diff -r 646538e52e78 asihpi/dsp6205.bin
Binary file asihpi/dsp6205.bin has changed
diff -r 646538e52e78 asihpi/dsp6205.txt
--- /dev/null   Thu Jan 01 00:00:00 1970 +0000
+++ b/asihpi/dsp6205.txt        Tue Jun 13 12:08:59 2006 +1200
@@ -0,0 +1,2 @@
+AX6205, version 005, size 58216, checksum 0xCF6280C7
+
\ No newline at end of file
diff -r 646538e52e78 asihpi/dsp6413.bin
Binary file asihpi/dsp6413.bin has changed
diff -r 646538e52e78 asihpi/dsp6413.txt
--- /dev/null   Thu Jan 01 00:00:00 1970 +0000
+++ b/asihpi/dsp6413.txt        Tue Jun 13 12:08:59 2006 +1200
@@ -0,0 +1,2 @@
+AX6413, version 022, size 616296, checksum 0x1D3FE447
+
\ No newline at end of file
diff -r 646538e52e78 asihpi/dsp6600.bin
Binary file asihpi/dsp6600.bin has changed
diff -r 646538e52e78 asihpi/dsp6600.txt
--- /dev/null   Thu Jan 01 00:00:00 1970 +0000
+++ b/asihpi/dsp6600.txt        Tue Jun 13 12:08:59 2006 +1200
@@ -0,0 +1,2 @@
+AX6600, version 018, size 612588, checksum 0x67D43A43
+
\ No newline at end of file
diff -r 646538e52e78 asihpi/dsp8713.bin
Binary file asihpi/dsp8713.bin has changed
diff -r 646538e52e78 asihpi/dsp8713.txt
--- /dev/null   Thu Jan 01 00:00:00 1970 +0000
+++ b/asihpi/dsp8713.txt        Tue Jun 13 12:08:59 2006 +1200
@@ -0,0 +1,2 @@
+AX8713, version 025, size 112616, checksum 0xD3DA2D00
+
\ No newline at end of file
diff -r 646538e52e78 asihpi/licence.txt
--- /dev/null   Thu Jan 01 00:00:00 1970 +0000
+++ b/asihpi/licence.txt        Tue Jun 13 12:08:59 2006 +1200
@@ -0,0 +1,20 @@
+GENERAL
+=======
+
+This directory contains the firmware data files for use with asihpi driver.
+These files should be installed for use by hotplug firmware loader.
+
+
+DEFINITION OF FIRMWARE
+======================
+
+Verbatim copying and distribution of the firmware are permitted
+worldwide, without royalty, in any medium, provided this notice is
+preserved.
+
+
+COPYRIGHT
+=========
+
+Copyright (c) 2005 Audioscience <support@audioscience.com>
+Distributable under GPL.
\ No newline at end of file
