From: Dan Carpenter <error27@gmail.com>
Subject: Re: broken microphone
Date: Tue, 23 Mar 2010 18:54:56 +0300
Message-ID: <20100323155456.GA15084@bicker>
References: <SNT110-W58162EDFB417DBBD0AE6C8C4270@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <SNT110-W58162EDFB417DBBD0AE6C8C4270@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
To: Vassilios Zafiropoulos <vasili3000@hotmail.com>
Cc: linux-kernel@vger.kernel.org, lydiawang@viatech.com.cn, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I added the Lydia Wang and the alsa people to the CC list.

regards,
dan carpenter

On Mon, Mar 22, 2010 at 10:55:06AM +0000, Vassilios Zafiropoulos wrote:
>=20
> hello,
>=20
>=20
>=20
>  this commit seems to break my microphone. please cc me, as i
>=20
>  am not written on the mailing list. For any other info, please
> ask.
>=20
>=20
>=20
>  yours,
>=20
>  vasilis.
>=20
>=20
>=20
>  --
>=20
>=20
>=20
>  vasili@vaccone=20
>=20
>  /usr/src/linux-2.6 $ sudo git bisect bad
>=20
>=20
>=20
>  f5271101faf1655d862849f42518c2a88ef394fb is the first bad commit
>=20
>  commit=20
>=20
>  f5271101faf1655d862849f42518c2a88ef394fb
>=20
>  Author: Lydia Wang=20
>=20
>  <lydiawang@viatech.com.cn>
>=20
>  Date:=A0=A0 Sat Oct 10 19:07:35 2009 +0800
>=20
>=20
>=20
>  =A0=A0=A0=20
>=20
>  ALSA HDA VIA: Add VIA_CTL_WIDGET_ANALOG_MUTE control type
>=20
>  =A0=A0=A0=20
>=20
>  =A0=A0=A0=20
>=20
>  Enter low power state if AA-Path volume is muted.
>=20
>  =A0=A0=A0=20
>=20
>  =A0=A0=A0 Signed-off-
>=20
>  by: Lydia Wang <lydiawang@viatech.com.cn>
>=20
>  =A0=A0=A0 Signed-off-by: Logan Li=20
>=20
>  <loganli@viatech.com.cn>
>=20
>  =A0=A0=A0 Signed-off-by: Takashi Iwai <tiwai@suse.
>=20
>  de>
>=20
>=20
>=20
>  :040000 040000 ab1ae14ff67f0b08848faeb3ad68def7f3e727f0=20
>=20
>  0bfbfde11fe32e87e8edbdb3c4d03c2d30370393
> M=A0=A0=A0=A0=A0 sound 		 	   		 =20
> _________________________________________________________________
> Hotmail: Free, trusted and rich email service.
> https://signup.live.com/signup.aspx?id=3D60969--
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
