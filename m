From: Ryan Underwood <nemesis-lists@icequake.net>
Subject: Re: [Alsa-devel] mips fix
Date: Tue, 16 Sep 2003 02:14:21 -0500
Message-ID: <20030916071421.GV1804@dbz.icequake.net>
References: <20030908033657.GB2359@dbz.icequake.net> <s5h8yoxu93q.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <bounce-debian-mips=debian-mips=m.gmane.org@lists.debian.org>
Content-Disposition: inline
In-Reply-To: <s5h8yoxu93q.wl@alsa2.suse.de>
Resent-Message-ID: <RQxbMB.A.bO.WhrZ_@murphy>
List-Post: <mailto:debian-mips@lists.debian.org>
List-Help: <mailto:debian-mips-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-mips-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-mips-request@lists.debian.org?subject=unsubscribe>
List-Archive: <http://lists.debian.org/debian-mips/>
To: alsa-devel@lists.sourceforge.net
Cc: debian-mips@lists.debian.org
List-Id: alsa-devel@alsa-project.org


Hi,

On Tue, Sep 09, 2003 at 08:09:45PM +0200, Takashi Iwai wrote:
> At Sun, 7 Sep 2003 22:36:57 -0500,
> Ryan Underwood wrote:
> > 
> > 
> > In configure.in:
> >   mips*)
> >     c_opts="-mcpu=r4600 -G 0 -mips2 -fno-pic -mno-abicalls -mlong-calls"
> >     processor="mips"
> >     test "$CONFIG_ISA" = "probe" && CONFIG_ISA=
> >     ;;
> > 
> > 
> > -mcpu apparently needs to be changed for latest versions of gcc, as -mcpu
> > is no longer an option on mips architecture.
> 
> ok, i tried to fix it on cvs.
> could you give a try?

Hmm, using -DEXPORT_SYMTAB has a problem in module.h, which is included
from adriver.h:

#ifdef __GENKSYMS__
#  define _set_ver(sym) sym
#  undef  MODVERSIONS
#  define MODVERSIONS
#else /* ! __GENKSYMS__ */
# if !defined(MODVERSIONS) && defined(EXPORT_SYMTAB)
#   define _set_ver(sym) sym
#   include <linux/modversions.h>
# endif
#endif /* __GENKSYMS__ */

Since MODVERSIONS is not defined with the mips kernel (module versioning
is disabled) and EXPORT_SYMTAB is defined, it tries to include
linux/modversions.h, which doesn't exist in the mips kernel.

Removing -DEXPORT_SYMTAB from Rules.make causes the build to die with:
hwdep.c:501: error: syntax error before
"this_object_must_be_defined_as_export_objs_in_the_Makefile"

on the last line which exports a symbol:
EXPORT_SYMBOL(snd_hwdep_new);

Any ideas?  I posted to debian-mips before and received no reply.

-- 
Ryan Underwood, <nemesis at icequake.net>, icq=10317253
