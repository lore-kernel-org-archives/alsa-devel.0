From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: ALSA and SALSA install
Date: Wed, 19 Mar 2008 15:20:49 +0000
Message-ID: <200803191520.49705.gineera@aspect135.co.uk>
References: <200803061641.33445.gineera@aspect135.co.uk>
	<200803072031.27878.gineera@aspect135.co.uk>
	<200803172243.18609.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_R9S4HQ6zLppkca0"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (wmsmtp.opaltelecom.net [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A48F246AE
	for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2008 16:18:45 +0100 (CET)
In-Reply-To: <200803172243.18609.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_R9S4HQ6zLppkca0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 17 March 2008 22:43, I wrote:
> On Friday 07 March 2008 20:31, Alan Horstmann wrote:
> > On Thursday 06 March 2008 16:46, Clemens Ladisch wrote:
> > > Alan Horstmann wrote:
> > > > Is there a way to install both at the same time, so on a PC code can
> > > > be compiled and experimented with first -lasound and then -lsalsa
> > > > without alternately re-installing the libraries with make install?
> > >
> > > It should be possible to install salsa-lib into another directory (by
> > > using the *prefix configure options) and then to change the include
> > > and library paths when compiling the program that uses it.
> >
> > Thanks, that is the sort of thing I had hoped was possible; will try that
> > at the next opportunity.
>
> Just to tidy off this thread, here's what I have done to achieve this.  (I
> know it's not rocket science!)  The problem is actually with the headers,
> not the library, as both libs exist in /usr/lib.
>
> First I manually created the salsa headers seperately in
> /usr/include/salsa. Then in the code put:
> 	#ifdef SALSA
> 	#include <salsa/asoundlib.h>
> 	#else
> 	#include <alsa/asoundlib.h>
> 	#endif
>
> Then on the gcc command line
> 	... -D SALSA -lsalsa
> builds with salsa, or
> 	... -lasound
> with standard Alsa.  Is this all OK?
>
> The salsa standard install prefixes etc seemed to always put the headers
> under a alsa/ subdirectory.  By editing salsa-lib..../src/Makefile.in
> 	L244    alsaincludedir = $(includedir)/salsa
> the headers are put in usr/include/salsa.
>
> I think the option of automatically installing salsa headers as above (ie /
> usr/include/salsa/asoundlib.h, etc) would be useful but it doesn't seem
> that the value of 'alsaincludedir' can be set as a configure option.  Might
> it be worth adding it so
> 	./configure --alsaincludedir=...
> is available?


Well, I had a go at this just for interest, guessing at how to alter configure 
script and src/Makefile.in though I have little idea how they work.  In case 
the principle is of any interest, the 2 attached patches enable the salsa 
include sub-directory to be set by configure option '--alsaincludedir=', 
otherwise it is (includedir)/alsa.  In my case the reason is to be able to 
put it in (includedir)/salsa so the headers are separate.  The patches are 
from 0.0.14 but apply to 0.0.17 OK.

I am sure the alterations are not complete, and perhaps the variable should be 
renamed 'salsaincludedir' in this case, but that won't matter unless there is 
any interest in adding this option.

Alan



--Boundary-00=_R9S4HQ6zLppkca0
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="salsa-lib-configure-alsainclude.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="salsa-lib-configure-alsainclude.diff"

--- configure-orig	2007-10-24 15:49:16.000000000 +0100
+++ configure	2008-03-18 17:05:50.000000000 +0000
@@ -787,6 +787,7 @@
 sharedstatedir
 localstatedir
 includedir
+alsaincludedir
 oldincludedir
 docdir
 infodir
@@ -952,6 +953,7 @@
 sharedstatedir='${prefix}/com'
 localstatedir='${prefix}/var'
 includedir='${prefix}/include'
+alsaincludedir='${prefix}/include/alsa'
 oldincludedir='/usr/include'
 docdir='${datarootdir}/doc/${PACKAGE}'
 infodir='${datarootdir}/info'
@@ -985,6 +987,10 @@
   --)
     ac_dashdash=yes ;;
 
+  -alsaincludedir=* | --alsaincludedir=* | --alsaincludedi=* | --alsaincluded=* | --alsainclude=* \
+  | --alsainclud=* | --alsainclu=* | --alsaincl=* | --alsainc=*)
+    alsaincludedir=$ac_optarg ;;
+
   -bindir | --bindir | --bindi | --bind | --bin | --bi)
     ac_prev=bindir ;;
   -bindir=* | --bindir=* | --bindi=* | --bind=* | --bin=* | --bi=*)
@@ -1303,7 +1309,7 @@
 # Be sure to have absolute directory names.
 for ac_var in	exec_prefix prefix bindir sbindir libexecdir datarootdir \
 		datadir sysconfdir sharedstatedir localstatedir includedir \
-		oldincludedir docdir infodir htmldir dvidir pdfdir psdir \
+	alsaincludedir oldincludedir docdir infodir htmldir dvidir pdfdir psdir \
 		libdir localedir mandir
 do
   eval ac_val=\$$ac_var
@@ -1451,6 +1457,7 @@
 For better control, use the options below.
 
 Fine tuning of the installation directories:
+  --alsaincludedir=DIR   alsa C header files [PREFIX/include/alsa]
   --bindir=DIR           user executables [EPREFIX/bin]
   --sbindir=DIR          system admin executables [EPREFIX/sbin]
   --libexecdir=DIR       program executables [EPREFIX/libexec]
@@ -20594,6 +20601,7 @@
 sharedstatedir!$sharedstatedir$ac_delim
 localstatedir!$localstatedir$ac_delim
 includedir!$includedir$ac_delim
+alsaincludedir!$alsaincludedir$ac_delim
 oldincludedir!$oldincludedir$ac_delim
 docdir!$docdir$ac_delim
 infodir!$infodir$ac_delim
@@ -20674,7 +20682,7 @@
 am__fastdepCXX_FALSE!$am__fastdepCXX_FALSE$ac_delim
 _ACEOF
 
-  if test `sed -n "s/.*$ac_delim\$/X/p" conf$$subs.sed | grep -c X` = 97; then
+  if test `sed -n "s/.*$ac_delim\$/X/p" conf$$subs.sed | grep -c X` = 98; then
     break
   elif $ac_last_try; then
     { { echo "$as_me:$LINENO: error: could not make $CONFIG_STATUS" >&5

--Boundary-00=_R9S4HQ6zLppkca0
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="salsa-lib-srcMakefile-alsainclude.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="salsa-lib-srcMakefile-alsainclude.diff"

--- src/Makefile-orig.in	2007-10-24 15:49:15.000000000 +0100
+++ src/Makefile.in	2008-03-19 14:22:58.000000000 +0000
@@ -191,6 +191,7 @@
 ac_ct_CC = @ac_ct_CC@
 ac_ct_CXX = @ac_ct_CXX@
 ac_ct_F77 = @ac_ct_F77@
+alsaincludedir = @alsaincludedir@
 am__include = @am__include@
 am__leading_dot = @am__leading_dot@
 am__quote = @am__quote@
@@ -241,7 +242,6 @@
 	$(am__append_2) $(am__append_3) $(am__append_4) \
 	$(am__append_5) $(am__append_6)
 libsalsa_la_LDFLAGS = -version-info 0:1:0
-alsaincludedir = $(includedir)/alsa
 alsainclude_HEADERS = asoundlib.h version.h recipe.h asound.h \
 	asoundef.h global.h input.h output.h error.h control.h \
 	ctl_types.h ctl_macros.h pcm.h pcm_types.h pcm_macros.h \

--Boundary-00=_R9S4HQ6zLppkca0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_R9S4HQ6zLppkca0--
