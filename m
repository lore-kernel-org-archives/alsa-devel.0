From: "Brad Milne" <mail_4brad@yahoo.co.uk>
Subject: Re:
	=?windows-1252?q?1=2E0=2E16rc1_release_--_error=3A_?=
	=?windows-1252?q?=91system=5Futsname=92_undeclared?=
Date: Fri, 25 Jan 2008 00:18:33 +1300
Message-ID: <20ddc5da0801240318u6389cbe1l8e6cb4cf0c6f951c@mail.gmail.com>
References: <20ddc5da0801240240n27f4971fwf8a274ed6156b4e4@mail.gmail.com>
	<s5h3asn5w3k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.190])
	by alsa0.perex.cz (Postfix) with ESMTP id B9BD7246B1
	for <Alsa-devel@alsa-project.org>; Thu, 24 Jan 2008 12:18:35 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so146312rvb.32
	for <Alsa-devel@alsa-project.org>; Thu, 24 Jan 2008 03:18:33 -0800 (PST)
In-Reply-To: <s5h3asn5w3k.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Jan 24, 2008 11:58 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 24 Jan 2008 23:40:55 +1300,
>
> Brad Milne wrote:
> >
> > > From tiwai at suse.de  Wed Jan 23 08:31:32 2008
> > > From: tiwai at suse.de (Takashi Iwai)
> > > Date: Wed, 23 Jan 2008 08:31:32 +0100
> > > Subject: [alsa-devel]
> > >  =?iso-8859-7?q?1=2E0=2E16rc1_release_--_error=3A_=A1?=
> > >  =?iso-8859-7?q?system=5Futsname=A2_undeclared?=
> > > In-Reply-To: <s5htzl5t45y.wl%tiwai@suse.de>
> > > References: < Pine.LNX.4.61.0801221247570.9698@tm8103.perex-int.cz>
> > >     <47964342.1060608@measham.id.au> <s5htzl5t45y.wl%tiwai@suse.de >
> > > Message-ID: <s5hsl0pt2uj.wl%tiwai@suse.de>
> >
> > > At Wed, 23 Jan 2008 08:03:05 +0100,
> > > I wrote:
> > > >
> > > > At Wed, 23 Jan 2008 06:25:54 +1100,
> > >  > Rick Measham wrote:
> > > > >
> > > > > [1  <multipart/signed (7bit)>]
> > > > > [1.1  <text/plain; UTF-8 (quoted-printable)>]
> > > > > Jaroslav Kysela wrote:
> > > > > >     1.0.16rc1 release is available for download on
> > > > >
> > > > > Running Kubuntu:
> > > > >
> > > > > # uname -a
> > > > > Linux lugtop 2.6.20-16-386 #2 Sun Sep 23 19:47:10 UTC 2007 i686 GNU/Linux
> > > > >
> > > > >
> > > > > During the make:
> > > > >
> > > > > In file included from
> > > > > /usr/src/alsa/alsa-driver-1.0.16rc1/acore/info_oss.c:7:
> > > > > /usr/src/alsa/alsa-driver-1.0.16rc1/acore/../alsa-kernel/core/info_oss.c:
> > > > >  In function ?snd_sndstat_proc_read?:
> > > > > /usr/src/alsa/alsa-driver-1.0.16rc1/acore/../alsa-kernel/core/info_oss.c:96:
> > > > > error: ?system_utsname? undeclared (first use in this function)
> > > > > /usr/src/alsa/alsa-driver-1.0.16rc1/acore/../alsa-kernel/core/info_oss.c:96:
> > > > > error: (Each undeclared identifier is reported only once
> > > > > /usr/src/alsa/alsa-driver-1.0.16rc1/acore/../alsa-kernel/core/info_oss.c:96:
> > > > > error: for each function it appears in.)
> > > > > make[3]: *** [/usr/src/alsa/alsa-driver-1.0.16rc1/acore/info_oss.o] Error 1
> > > > > make[2]: *** [/usr/src/alsa/alsa-driver-1.0.16rc1/acore] Error 2
> > > > > make[1]: *** [_module_/usr/src/alsa/alsa-driver-1.0.16rc1] Error 2
> > > > > make[1]: Leaving directory `/usr/src/linux-headers-2.6.20-16-386'
> > > > > make: *** [compile] Error 2
> > > >
> > > > Isn't it fixed on HG version?
> >
> > > Nevermind, I myself can confirm that it's broken.
> > > The patch below should fix the problem.
> >
> >
> > > Takashi
> >
> > > diff -r a5f603cb254a configure.in
> > > --- a/configure.in    Tue Jan 22 17:52:34 2008 +0100
> > > +++ b/configure.in    Wed Jan 23 08:28:56 2008 +0100
> > > @@ -2571,7 +2571,7 @@ init_utsname="0"
> > >  init_utsname="0"
> > >  ac_save_CFLAGS="$CFLAGS"
> > >  ac_save_CC="$CC"
> > > -CFLAGS="$KERNEL_CHECK_CFLAGS -Werror"
> > > +CFLAGS="$KERNEL_CHECK_CFLAGS -Werror=implicit-function-declaration"
> > >  CC=$KCC
> > >  AC_TRY_COMPILE([
> > >  #define __KERNEL__
> >
> > It doesn't seem that it is fixed in HG or by this patch (though I do get:
> >                          patching file configure.in
> >                          Hunk #1 succeeded at 1579 with fuzz 2 (offset
> > -992 lines).
> >                          patch unexpectedly ends in middle of line
> > when patching), I get the exact same error in both.
>
> And did you run hgcompile after that?

If I run:
sudo ./configure
then:
sudo ./hgcompile
on the latest hg code, I still get the same error:
...
from /usr/src/alsa/alsa-driver/acore/info_oss.c:7:
include/linux/utsname.h:77: error: expected '=', ',', ';', 'asm' or
'__attribute__' before '{' token
...
/usr/src/alsa/alsa-driver/acore/../alsa-kernel/core/info_oss.c: In
function 'snd_sndstat_proc_read':
/usr/src/alsa/alsa-driver/acore/../alsa-kernel/core/info_oss.c:96:
error: 'system_utsname' undeclared (first use in this function)
...
make[3]: *** [/usr/src/alsa/alsa-driver/acore/info_oss.o] Error 1
...

>
> > I don't pretend to
> > know a lot about alsa workings, but is this patch in the right area as
> > the error complains about 'system_utsname', not 'init_utsname'?
>
> It's about both.  The configure script didn't check the existence of
> init_utsname() properly due to compile warnings on older kernels.
> My patch fixes the configure script but you have to regenerate the
> configure script itself.

Sorry, how do I regenerate the configure script? Is that from configure.in?
>
>
> Takashi
>

Thanks
Brad
