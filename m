From: Mikael Magnusson <mikaelmagnusson@glocalnet.net>
Subject: [PATCH] ld10k1: Don't require as10k1
Date: Sun, 10 Apr 2005 12:24:37 +0200
Message-ID: <4258FEE5.8040608@glocalnet.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030003070102060100030306"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030003070102060100030306
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Summary:
Don't require as10k1 in the configure script and remove the .emu10k1
files in maintainer-clean instead of clean, since the assembled
.emu10k1 files are included in the alsa-tools dist.

diffstat output:
  configure.in              |    4 +---
  setup/effects/Makefile.am |    6 ++++--
  2 files changed, 5 insertions(+), 5 deletions(-)

Signed-off-by: Mikael Magnusson <mikma@users.sourceforge.net>


--------------030003070102060100030306
Content-Type: text/x-patch;
 name="ld10k1-as10k1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ld10k1-as10k1.patch"

diff -ur ld10k1.cvs/configure.in ld10k1/configure.in
--- ld10k1.cvs/configure.in	2005-03-21 15:24:51.000000000 +0100
+++ ld10k1/configure.in	2005-04-10 12:01:52.168577208 +0200
@@ -16,9 +16,7 @@
 AC_SUBST(effectsdir)
 
 AC_CHECK_PROG(AS10K1, as10k1, as10k1)
-if test -z "$AS10K1"; then
-  AC_MSG_ERROR([as10k1 is not installed])
-fi
+AM_CONDITIONAL(HAVE_AS10K1, test x"$AS10K1" != x)
 
 #taken from alsa-lib
 dnl Make a symlink for inclusion of lo10k1/xxx.h
diff -ur ld10k1.cvs/setup/effects/Makefile.am ld10k1/setup/effects/Makefile.am
--- ld10k1.cvs/setup/effects/Makefile.am	2005-04-10 11:57:55.004887745 +0200
+++ ld10k1/setup/effects/Makefile.am	2005-04-10 12:05:19.069307463 +0200
@@ -10,9 +10,11 @@
 	sto51.emu10k1 switch_6.emu10k1 copy_2.emu10k1 \
 	prologic.emu10k1 fxbus.emu10k1
 
-CLEANFILES = $(dist_effects_DATA)
+MAINTAINERCLEANFILES = $(dist_effects_DATA)
 
-SUFFIXEC = .asm .emu10k1
+SUFFIXES = .asm .emu10k1
 
+if HAVE_AS10K1
 .asm.emu10k1:
 	$(AS10K1) -o $@ $<
+endif HAVE_AS10K1

--------------030003070102060100030306--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
