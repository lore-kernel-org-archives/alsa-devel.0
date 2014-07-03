From: =?ISO-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
Subject: Re: [alsa-devel] [PATCH] ASoC: rsnd: fixup index of SSI mod when
 SRC is used
Date: Thu, 03 Jul 2014 16:09:32 +0200
Message-ID: <1404396572.30947.1.camel@bitron.ch>
References: <1404299931-21384-1-git-send-email-j@bitron.ch>
	 <CA+t-KAiFNi2cdfKQfNYf7svWKXg4sBhPzib+Q7qfONosuwdy7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+t-KAiFNi2cdfKQfNYf7svWKXg4sBhPzib+Q7qfONosuwdy7A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Simon Horman <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

Hi,

On Thu, 2014-07-03 at 22:57 +0900, Kuninori Morimoto wrote:
> If you add this code,
>
>         if (!ssi) {
>                break;
>         } else ...
> =20
> then, I guess we can remove this code ?
>=20
> 	if (mod[i] =3D=3D ssi)
> 	break;

I checked the issue on mainline master where the above two lines are no=
t
present yet. Looking at Mark's for-next tree reveals that you already
fixed the issue in a slightly different way (commit c08c3b08). You may
disregard my patch.

J=C3=BCrg
