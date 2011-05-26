From: =?ISO-8859-1?Q?Lorenzo_Fundar=F3?= <lfundaro@etu.utc.fr>
Subject: Re: about ioctl calls
Date: Thu, 26 May 2011 14:37:31 +0200
Message-ID: <BANLkTim3XPHKK3cZY3tofdzfwxA9N21g0A@mail.gmail.com>
References: <BANLkTi=NFkcwxPiwULYxtLGv+=dgjXgFdg@mail.gmail.com>
	<4DDE2B33.1090809@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A521103868
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 14:37:51 +0200 (CEST)
Received: by qwf7 with SMTP id 7so368861qwf.38
	for <alsa-devel@alsa-project.org>; Thu, 26 May 2011 05:37:51 -0700 (PDT)
In-Reply-To: <4DDE2B33.1090809@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for your reply,

I want to be able to take the samples and do something with them before the
program touches them. To do so, I am overloading the mmap function as
follows:

static void* (*_mmap) (void*, size_t, int, int, int, off_t) =3D NULL;

void* mmap(void* addr, size_t length, int prot, int flags, int fd, off_t
offset) {

  /* First call, load the original mmap function */
  if (_mmap =3D=3D NULL) {
    _mmap =3D dlsym(RTLD_NEXT, "mmap");
  }

  /* Trigger original mmap */
  void* result =3D _mmap(addr, length, prot, flags, fd, offset);

  /* Check if file descriptor fd corresponds to that of the sound card
device */
  if (fd =3D=3D FD_SOUND_DEVICE) {
    sound.fd =3D fd;
    sound.size  =3D length;
    sound.addr  =3D result;    // I'll later use the data contained within
result.
  }
  return result;
}

So now that things are clearer, the question will be, what's in the mapped
address returned by mmap ? What's the form of this structure so I can take
the samples and work with them.

Note: I am forced to do this workaround since the program does not give me
any interface to work with the samples.

Cheers !

Lorenzo Fundar=F3 Garc=EDa
Universit=E9 de Technologie de Compi=E8gne
G=E9nie Informatique
Tel: +33 6 86 69 56 11



On Thu, May 26, 2011 at 12:28 PM, Clemens Ladisch <clemens@ladisch.de>wrote:

> Lorenzo Fundar=F3 wrote:
> > I have a program that constantly make ioctl calls like this:
> >
> > ioctl(4, 0x4122, 0x8b703)
> > ioctl(4, 0x4122, 0xbfb65768)
> >
> > I suspect that this call pertains to ALSA, since I have straced other
> > programs that play music and they always use in the ioctl request field
> the
> > 0x4122 code.
>
> This is SNDRV_PCM_IOCTL_HWSYNC.
>
> > I am interested on finding out what's in the third argument of the ioctl
> > call,
> > is it a sort of struct that contains the audio samples ?
>
> The samples and some control structures are in mmap()ed memory.
> This ioctl tells the kernel to synchronize and update hardware status.
>
> There is no third parameter; the values shown are random stack contents.
>
>
> Regards,
> Clemens
>
