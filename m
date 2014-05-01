From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: mc13783: Add devicetree support
Date: Thu, 1 May 2014 08:42:53 +0100
Message-ID: <20140501074253.GA32761@lee--X1>
References: <1398495423-2223-1-git-send-email-shc_work@mail.ru>
 <20140429222522.GS15125@sirena.org.uk>
 <20140430140849.GR29462@lee--X1>
 <1398867073.695596467@f224.i.mail.ru>
 <20140430141708.GS29462@lee--X1>
 <20140430180653.GB3245@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140430180653.GB3245-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wed, 30 Apr 2014, Mark Brown wrote:

> On Wed, Apr 30, 2014 at 03:17:08PM +0100, Lee Jones wrote:
>=20
> > Neither Mark, nor I can apply this patch independently, we need to
> > create a shared branch somewhere, or we'll risk conflicts at merge
> > time.
>=20
> You acked it without saying you didn't want me to apply it...  usuall=
y
> that means someone is OK with things getting applied.

Actually, that's not true:

MFD changes look sensible:
  Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

I'm happy to create a shared branch if required.   <-----###

> In any case, as
> ever it's on a branch by itself so you can pull it in easily.  I just
> tagged it.

Very well, thanks.

> The following changes since commit c9eaa447e77efe77b7fa4c953bd62de829=
7fd6c5:
>=20
>   Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)
>=20
> are available in the git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tag=
s/mc13783-asoc
>=20
> for you to fetch changes up to 780aaeff96819ca58e0cad830bfbe6eee9aef8=
2c:
>=20
>   ASoC: mc13783: Add devicetree support (2014-04-29 15:24:54 -0700)
>=20
> ----------------------------------------------------------------
> ASoC: mc13783 DT support
>=20
> Tagged since it updates the MFD as well.
>=20
> ----------------------------------------------------------------
> Alexander Shiyan (1):
>       ASoC: mc13783: Add devicetree support
>=20
>  Documentation/devicetree/bindings/mfd/mc13xxx.txt |  3 +++
>  drivers/mfd/mc13xxx-core.c                        | 10 +++++++---
>  sound/soc/codecs/mc13783.c                        | 14 +++++++++++++=
-
>  3 files changed, 23 insertions(+), 4 deletions(-)



--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
