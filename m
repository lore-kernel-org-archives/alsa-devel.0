From: Andy Wingo <wingo@pobox.com>
Subject: Re: alsa-utils-0.9.0beta12: Bug in configure
Date: Wed, 3 Apr 2002 15:31:24 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020403203108.GC23358@jesus>
References: <200204030808.g3388UX16054@Port.imtp.ilyichevsk.odessa.ua> <20020403194727.GB23358@jesus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_jesus-23852-1017865884-0001-2"
Received: from jesus (rdu162-226-026.nc.rr.com [24.162.226.26])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA32192
	for <alsa-devel@alsa-project.org>; Wed, 3 Apr 2002 22:31:37 +0200
Content-Disposition: inline
In-Reply-To: <20020403194727.GB23358@jesus>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_jesus-23852-1017865884-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 03 Apr 2002, Andy Wingo wrote:

> On Wed, 03 Apr 2002, Denis Vlasenko wrote:
> 
> > configure uses this to test whether there are alsa libs.
> > But this will fail always since nested functions are not
> > supported by C:
> > 
> > int main() {
> >   void main(void) {  // !?
> >     ...
> >   }
> > }
> 
> from the autoconf 2.53 manual:
> 
>  - Macro: AC_TRY_COMPILE (INCLUDES, FUNCTION-BODY, [ACTION-IF-FOUND],
>           [ACTION-IF-NOT-FOUND])
>      Create a test program in the current language (*note Language
>      Choice::) to see whether a function whose body consists of
>                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>      FUNCTION-BODY can be compiled.  If the file compiles successfully,
>      run shell commands ACTION-IF-FOUND, otherwise run
>      ACTION-IF-NOT-FOUND.
> 
> This is from within alsa.m4. Change the AC_TRY_CONPILE to AC_TRY_RUN and
> it should work.
> 
> So, I suppose this is a 'virtual patch' against alsa.m4 :-)

a better patch is attached. i tested it and it seems to work.

regards,

wingo.

--=_jesus-23852-1017865884-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="alsa.m4-patch"

Index: alsa.m4
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/utils/alsa.m4,v
retrieving revision 1.19
diff -u -r1.19 alsa.m4
--- alsa.m4	19 Dec 2001 07:28:40 -0000	1.19
+++ alsa.m4	3 Apr 2002 20:27:54 -0000
@@ -76,8 +76,6 @@
 AC_TRY_COMPILE([
 #include <alsa/asoundlib.h>
 ], [
-void main(void)
-{
 /* ensure backward compatibility */
 #if !defined(SND_LIB_MAJOR) && defined(SOUNDLIB_VERSION_MAJOR)
 #define SND_LIB_MAJOR SOUNDLIB_VERSION_MAJOR
@@ -109,7 +107,6 @@
 #    endif
 #  endif
 exit(0);
-}
 ],
   [AC_MSG_RESULT(found.)],
   [AC_MSG_RESULT(not present.)

--=_jesus-23852-1017865884-0001-2--
