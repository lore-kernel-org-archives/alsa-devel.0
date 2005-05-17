From: Mikael Magnusson <mikaelmagnusson@glocalnet.net>
Subject: Re: [PATCH] alsa-tools
Date: Tue, 17 May 2005 17:50:05 +0200
Message-ID: <20050517155005.GA749@skinner.hem.za.org>
References: <4288B114.1000900@glocalnet.net> <s5h1x86qlh0.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h1x86qlh0.wl@alsa2.suse.de>
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


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 17, 2005 at 10:56:43AM +0200, Takashi Iwai wrote:
> At Mon, 16 May 2005 16:41:24 +0200,
> Mikael Magnusson wrote:
> > 
> > ld10k1_configure.patch
> > ld10k1_makefile.patch
> > Removes ALSA_CFLAGS and ALSA_LIBS in configure.in, they are added to
> > CFLAGS and LDADD in src/Makefile.am already. Adds "-Wall" to CFLAGS only
> > if CFLAGS is undefined.
> > 
> > qlo10k1_configure.patch
> > qlo10k1_makefile.patch
> > Adds LD10K1_CFLAGS and LD10K1_LDFLAGS in src/Makefile.am, and moves
> > QT_CXXFLAGS to the makefile.
> > 
> > qlo10k1_acinclude.patch
> > Fixes pattern in gw_CHECK_QT not to match files that the linker won't
> > use, for example libqt.so.3 . Needed if both libqt and libqt-mt shared
> > libraries are installed, but only the libqt-mt development library.
> 
> Thanks.  I think we can get rid of -Wall.
> It's not mandatory at all.  Let's simply remove CFLAGS=XXX lines.
> 
> Could you regenerate patches with that change?
> 
> 
> Takashi
> 

Ok, I have removed -Wall from CFLAGS (and CXXFLAGS) in
ld10k1_configure2.patch and qlo10k1_configure2.patch.
I don't resend ld10k1_makefile.patch, qlo10k1_makefile.patch and
qlo10k1_acinclude.patch, since they are unchanged.

/Mikael Magnusson


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ld10k1_configure2.patch"

diff -urNad alsa-tools-1.0.8+1.0.9rc3/ld10k1/configure.in /tmp/dpep.byc0VN/alsa-tools-1.0.8+1.0.9rc3/ld10k1/configure.in
--- alsa-tools-1.0.8+1.0.9rc3/ld10k1/configure.in	2005-05-17 17:31:23.534229607 +0200
+++ /tmp/dpep.byc0VN/alsa-tools-1.0.8+1.0.9rc3/ld10k1/configure.in	2005-05-17 17:31:39.847422177 +0200
@@ -9,8 +9,6 @@
 AC_DISABLE_STATIC
 AC_PROG_LIBTOOL
 AM_PATH_ALSA(1.0.8, [], [])
-CFLAGS="$CFLAGS $ALSA_CFLAGS -Wall"
-LIBS="$LIBS $ALSA_LIBS"
 
 effectsdir='$(pkgdatadir)/effects'
 AC_SUBST(effectsdir)

--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="qlo10k1_configure2.patch"

diff -urNad alsa-tools-1.0.8+1.0.9rc3/qlo10k1/configure.in /tmp/dpep.6IrRDe/alsa-tools-1.0.8+1.0.9rc3/qlo10k1/configure.in
--- alsa-tools-1.0.8+1.0.9rc3/qlo10k1/configure.in	2005-05-17 17:31:23.116327144 +0200
+++ /tmp/dpep.6IrRDe/alsa-tools-1.0.8+1.0.9rc3/qlo10k1/configure.in	2005-05-17 17:32:13.039675246 +0200
@@ -8,7 +8,6 @@
 
 AC_C_BIGENDIAN
 gw_CHECK_QT
-CXXFLAGS="$CXXFLAGS $QT_CXXFLAGS -Wall"
 AM_PATH_LD10K1(0.1.8)
 
 AC_OUTPUT(Makefile

--2fHTh5uZTiUOsy+g--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
