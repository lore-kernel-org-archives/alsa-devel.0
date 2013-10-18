From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH] ASoC: kirkwood: add S/PDIF support
Date: Fri, 18 Oct 2013 17:38:12 +0200
Message-ID: <20131018173812.74a23b52@armhf>
References: <20130924124122.64834b2a@armhf>
	<20131018003439.GG2443@sirena.org.uk>
	<20131018103019.GW25034@n2100.arm.linux.org.uk>
	<20131018124832.GK2443@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131018124832.GK2443-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, 18 Oct 2013 13:48:32 +0100
Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > "widgets that manage the enable of the S/PDIF and I2S interfaces be=
tween
> > the FE and BE DAIs" is exactly what I did and you told me that was =
wrong.
> > Make up your fscking mind. =20
>=20
> No, this is not the case.  The major problem with your last set of
> patches was that they did not create any back end DAIs, instead they
> created purely DAPM routes from the single traditional DAI out to
> widgets in the CODEC.  What I'm asking Jean-Francois to do above is
> create and use back end DAIs.

Mark,

I think I understood what you mean. I am testing my system with this
new approach and I will submit a new patch as soon as it works.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
