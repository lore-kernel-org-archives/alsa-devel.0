From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCHv2 1/4] ASoC: simple-card: add
 asoc_simple_card_fmt_master() to simplify the code.
Date: Tue, 2 Sep 2014 13:09:12 +0200
Message-ID: <20140902130912.65c5b750@armhf>
References: <1409649969-15759-1-git-send-email-Li.Xiubo@freescale.com>
	<1409649969-15759-2-git-send-email-Li.Xiubo@freescale.com>
	<54059A35.3020303@gmail.com>
	<20140902123848.78c4c62a@armhf>
	<54059F20.4080509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54059F20.4080509-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, jsarha-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, 02 Sep 2014 16:12:40 +0530
Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> >>> +	switch (((np =3D=3D bitclkmaster) << 4) | (np =3D=3D framemaste=
r)) {
> >>> +	case 0x11:
> >>> +		return SND_SOC_DAIFMT_CBS_CFS;
> >>> +	case 0x10:
> >>> +		return SND_SOC_DAIFMT_CBS_CFM;
> >>> +	case 0x01:
> >>> +		return SND_SOC_DAIFMT_CBM_CFS;
> >>> +	default:
> >>> +		return SND_SOC_DAIFMT_CBM_CFM;
> >>> +	}
> >>> +
> >>> +	/* Shouldn't be here */
> >>> +	return -EINVAL;
> >>> +} =20
> >> It will be nice if we declare the switch case numbers as macros (s=
pecific name)... =20
> > I don't see which macros: the values are just 2 booleans.
> > =20
> I am talking about 0x11, 0x10, 0x01 values.. We can give any understa=
ndable
> names to those...?

#define TRUE_TRUE 0x11
#define TRUE_FALSE 0x10
#define FALSE_TRUE 0x01

or

	case ((TRUE << 4) | TRUE:
		...
	case ((TRUE << 4) | FALSE:
		...
	case ((FALSE << 4) | TRUE:
		...

??

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
