From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 03/11] compat_ioctl: remove translation for sound ioctls
Date: Tue, 11 Sep 2018 21:35:48 +0200
Message-ID: <CAK8P3a2ZPDtFax50joj402H5m-kZG0etu10HqNRjSmo2xU5R5w@mail.gmail.com>
References: <20180908142837.2819693-1-arnd@arndb.de> <20180908142837.2819693-3-arnd@arndb.de>
 <20180909041632.GE19965@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180909041632.GE19965@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-um@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 9, 2018 at 6:17 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sat, Sep 08, 2018 at 04:28:09PM +0200, Arnd Bergmann wrote:
> > The SNDCTL_* and SOUND_* commands are the old OSS user interface.
> >
> > I checked all the sound ioctl commands listed in fs/compat_ioctl.c
> > to see if we still need the translation handlers. Here is what I
> > found:
> >
> > - sound/oss/ is (almost) gone from the kernel, this is what actually
> >   needed all the translations
> > - The ALSA emulation for OSS correctly handles all compat_ioctl
> >   commands already.
> > - sound/oss/dmasound/ is the last holdout of the original OSS code,
> >   this is only used on arch/m68k, which has no 64-bit mode and
> >   hence needs no compat handlers
> > - arch/um/drivers/hostaudio_kern.c may run in 64-bit mode with
> >   32-bit x86 user space underneath it. This rare corner case is
> >   the only one that still needs the compat handlers.
> >
> > By adding a simple redirect of .compat_ioctl to .unlocked_ioctl in the
> > UML driver, we can remove all the COMPATIBLE_IOCTL() annotations without
> > a change in functionality. For completeness, I'm adding the same thing
> > to the dmasound file, knowing that it makes no difference.
>
> > diff --git a/arch/um/drivers/hostaudio_kern.c b/arch/um/drivers/hostaudio_kern.c
> > index 7f9dbdbc4eb7..0278a642a622 100644
> > --- a/arch/um/drivers/hostaudio_kern.c
> > +++ b/arch/um/drivers/hostaudio_kern.c
> > @@ -298,6 +298,7 @@ static const struct file_operations hostaudio_fops = {
> >       .write          = hostaudio_write,
> >       .poll           = hostaudio_poll,
> >       .unlocked_ioctl = hostaudio_ioctl,
> > +     .compat_ioctl   = hostaudio_ioctl,
>
> Umm...  OK, seeing that it's not going to be used on s390...  It's still
> not quite right, though, and I'm afraid that places where we have the
> same ->unlocked_ioctl and ->compat_ioctl need an audit - there probably
> had been other folks who'd stepped into the same.

It turns out that it's actually much more common to have the same
pointer for ioctl handlers that thake pointer arguments than to have
the wrapper. I found 16 instances of trivial wrappers to do compat_ptr()
for file_operations, 4 instances that have a wrapper but skip the
compat_ptr() and around 40 (depending on how you count) that use
the same pointer for both when they only use pointers and should
go through compat_ptr(). This includes a couple that don't use
the argument at all, so they are fine either way.

I've created patches to change all of the above to a new
generic_compat_ioctl_ptrarg() helper I added.

loop_control_ioctl(), kcov_ioctl(), proc_bus_pci_ioctl(), and nbd_ioctl() seem
to be ones that are correct because,  the argument is always an integer.
fs3270_ioctl() has a is_compat_task() check to deal with the problem.

inotify_ioctl(),  vsoc_ioctl(), and usblp_ioctl() are somethat uses both integer
and pointer arguments and may need special handling for s390.

I did not touch those so far.

       Arnd
