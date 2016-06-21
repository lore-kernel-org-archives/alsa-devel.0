From: =?UTF-8?B?6auY5bOw?= <fgao@ikuai8.com>
Subject: =?UTF-8?Q?=E7=AD=94=E5=A4=8D:_=E7=AD=94=E5=A4=8D:_=5BPATCH_1/1=5D_sound:_?=
	=?UTF-8?Q?Fix_compile_error_of_seq=5Fdevice.?=
	=?UTF-8?Q?c?=
Date: Tue, 21 Jun 2016 17:35:39 +0800
Message-ID: <001101d1cba0$481bc380$d8534a80$@ikuai8.com>
References: <1466498065-29692-1-git-send-email-fgao@ikuai8.com>	<s5h4m8nx765.wl-tiwai@suse.de>	<000901d1cb99$b0f36130$12da2390$@ikuai8.com> <s5hy45yvqzg.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hy45yvqzg.wl-tiwai@suse.de>
Content-Language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, perex@perex.cz, linux-kernel@vger.kernel.org, gfree.wind@gmail.com
List-Id: alsa-devel@alsa-project.org

I have sent the new commit with the compile errors.
Is it ok now?

BTW, I think the compile error is caused by that "subsys_initcall" stat=
ement losts the semicolon.=20

-----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
=E5=8F=91=E4=BB=B6=E4=BA=BA: Takashi Iwai [mailto:tiwai@suse.de]=20
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2016=E5=B9=B46=E6=9C=8821=E6=97=A5=
 17:20
=E6=94=B6=E4=BB=B6=E4=BA=BA: =E9=AB=98=E5=B3=B0 <fgao@ikuai8.com>
=E6=8A=84=E9=80=81: alsa-devel@alsa-project.org; perex@perex.cz; linux-=
kernel@vger.kernel.org; gfree.wind@gmail.com
=E4=B8=BB=E9=A2=98: Re: =E7=AD=94=E5=A4=8D: [PATCH 1/1] sound: Fix comp=
ile error of seq_device.c

On Tue, 21 Jun 2016 10:48:30 +0200,
=E9=AB=98=E5=B3=B0 wrote:
>=20
> The lastest CentOS7 platform, and the gcc version is gcc version 4.8.=
5
> 20150623 (Red Hat 4.8.5-4) (GCC).
> It could pass compilation after append the lost semicolon.=20
>=20
> from sound/core/seq/seq_device.c:39:
> include/linux/init.h:216:2: error: expected =E2=80=98,=E2=80=99 or =E2=
=80=98;=E2=80=99 before =E2=80=98static=E2=80=99
>   static exitcall_t __exitcall_##fn __exit_call =3D fn
>   ^
> include/linux/init.h:279:24: note: in expansion of macro =E2=80=98__e=
xitcall=E2=80=99
>  #define module_exit(x) __exitcall(x);
>                         ^
> sound/core/seq/seq_device.c:315:1: note: in expansion of macro=20
> =E2=80=98module_exit=E2=80=99
>  module_exit(alsa_seq_device_exit)
>  ^
> make[3]: *** [sound/core/seq/seq_device.o] Error 1
> make[2]: *** [sound/core/seq] Error 2
> make[1]: *** [sound/core] Error 2
> make: *** [sound] Error 2

It's a RH specific issue.  The upstream code has a different definition=
 of module_init(), thus no such an error would occur.

Note that I'm fine to apply the patch, it's a trivial change.
But you need to give the clear reason why to apply it.  In this case, i=
t's no fault of the upstream code.  But if it would make someone's life=
 a bit easier, it's OK to apply such a change.

That being said, please resubmit the patch with a more explanation.


thanks,

Takashi

>=20
> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Takashi Iwai [mailto:tiwai@suse.de]
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2016=E5=B9=B46=E6=9C=8821=E6=97=
=A5 16:45
> =E6=94=B6=E4=BB=B6=E4=BA=BA: fgao@ikuai8.com
> =E6=8A=84=E9=80=81: alsa-devel@alsa-project.org; perex@perex.cz; linu=
x-kernel@vger.kernel.
> org; gfree.wind@gmail.com
> =E4=B8=BB=E9=A2=98: Re: [PATCH 1/1] sound: Fix compile error of seq_d=
evice.c
>=20
> On Tue, 21 Jun 2016 10:34:25 +0200,
> <fgao@ikuai8.com> wrote:
> >=20
> > From: Gao Feng <fgao@ikuai8.com>
> >=20
> > Signed-off-by: Gao Feng <fgao@ikuai8.com>
>=20
> What compile error did you get?
>=20
>=20
> Takashi
>=20
> > ---
> >  sound/core/seq/seq_device.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/sound/core/seq/seq_device.c=20
> > b/sound/core/seq/seq_device.c index c4acf17..4e859e4 100644
> > --- a/sound/core/seq/seq_device.c
> > +++ b/sound/core/seq/seq_device.c
> > @@ -311,5 +311,5 @@ static void __exit alsa_seq_device_exit(void)
> >  	bus_unregister(&snd_seq_bus_type);
> >  }
> > =20
> > -subsys_initcall(alsa_seq_device_init)
> > -module_exit(alsa_seq_device_exit)
> > +subsys_initcall(alsa_seq_device_init);
> > +module_exit(alsa_seq_device_exit);
> > --
> > 1.9.1
> >=20
> >=20
> >=20
> >=20
> >=20
>=20
>=20
>=20
