From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [alsa-cvslog] CVS: alsa-utils ChangeLog,1.3,1.4 Makefile.am,1.33,1.34
 configure.in,1.107,1.108
Date: Sat, 13 Aug 2005 17:42:16 +0100
Message-ID: <42FE22E8.4040406@superbug.co.uk>
References: <E1E3yrb-0001Ke-Jk@sc8-pr-cvs1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E1E3yrb-0001Ke-Jk@sc8-pr-cvs1.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <jcdutton@users.sourceforge.net>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hum. This seems wrong. Even after checking this in, ./cvscompile changes 
them all again!
I must have broken build tools.

James Courtier-Dutton wrote:
> Update of /cvsroot/alsa/alsa-utils
> In directory sc8-pr-cvs1.sourceforge.net:/tmp/cvs-serv4768/alsa-utils
> 
> Modified Files:
> 	ChangeLog Makefile.am configure.in 
> Log Message:
> Summary: update build tools.
> 
> It seems that running ./cvscompile changes all these files due to
> an updates. So, sink CVS with build tools.
> 
> 
> 
> Index: ChangeLog
> ===================================================================
> RCS file: /cvsroot/alsa/alsa-utils/ChangeLog,v
> retrieving revision 1.3
> retrieving revision 1.4
> diff -u -r1.3 -r1.4
> --- ChangeLog	15 Nov 1998 15:34:33 -0000	1.3
> +++ ChangeLog	13 Aug 2005 16:27:59 -0000	1.4
> @@ -1,3 +1,8 @@
> +2005-08-13  gettextize  <bug-gnu-gettext@gnu.org>
> +
> +	* Makefile.am (EXTRA_DIST): Add config.rpath, mkinstalldirs.
> +	* configure.in (AM_GNU_GETTEXT_VERSION): Bump to 0.14.4.
> +
>  0.0.7 -> 0.2.0
>  
>  * removed error message from alsamixer
> 
> Index: Makefile.am
> ===================================================================
> RCS file: /cvsroot/alsa/alsa-utils/Makefile.am,v
> retrieving revision 1.33
> retrieving revision 1.34
> diff -u -r1.33 -r1.34
> --- Makefile.am	23 Jun 2005 10:38:06 -0000	1.33
> +++ Makefile.am	13 Aug 2005 16:27:59 -0000	1.34
> @@ -5,7 +5,7 @@
>  ALSAMIXER_DIR=
>  endif
>  SUBDIRS= include alsactl alsaconf $(ALSAMIXER_DIR) amidi amixer aplay iecset seq speaker-test utils m4 po
> -EXTRA_DIST=ChangeLog INSTALL TODO README configure cvscompile depcomp
> +EXTRA_DIST= config.rpath mkinstalldirs ChangeLog INSTALL TODO README configure cvscompile depcomp
>  AUTOMAKE_OPTIONS=foreign
>  ACLOCAL_AMFLAGS = -I m4
>  
> 
> Index: configure.in
> ===================================================================
> RCS file: /cvsroot/alsa/alsa-utils/configure.in,v
> retrieving revision 1.107
> retrieving revision 1.108
> diff -u -r1.107 -r1.108
> --- configure.in	23 Jun 2005 10:38:06 -0000	1.107
> +++ configure.in	13 Aug 2005 16:27:59 -0000	1.108
> @@ -5,7 +5,7 @@
>  AM_INIT_AUTOMAKE(alsa-utils, 1.0.9a)
>  
>  AM_GNU_GETTEXT([external])
> -AM_GNU_GETTEXT_VERSION(0.14.1)
> +AM_GNU_GETTEXT_VERSION([0.14.4])
>  
>  dnl Checks for programs.
>  
> 


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
