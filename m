From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] ASoC: codecs: Add da7218 codec driver
Date: Fri, 6 Nov 2015 11:21:41 +0000
Message-ID: <20151106112141.GE18409@sirena.org.uk>
References: <cover.1446718490.git.Adam.Thomson.Opensource@diasemi.com>
 <01a9b6e96b66327cf9a27781c13aa50545380acb.1446718490.git.Adam.Thomson.Opensource@diasemi.com>
 <20151105152736.GO18409@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CA0C@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SqEuGDw53xMPnx3c"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337D460CA0C-68WUHU125fLLPO1uwJ3ImwLouzNaz+3S@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--SqEuGDw53xMPnx3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 06, 2015 at 11:11:38AM +0000, Opensource [Adam Thomson] wrote:
> On November 5, 2015 15:28, Mark Brown wrote:

> > > +static int da7218_mic_lvl_det_sw_put(struct snd_kcontrol *kcontrol,
> > > +				     struct snd_ctl_elem_value *ucontrol)
> > > +{

> > Why is this a user visible control?

> I can envisage in a system you may want to choose which capture channels can
> trigger level detection (if any), and this may change depending on the use-case
> at the time, so having it as a control makes sense to me.

What is a "capture channel" here?

--SqEuGDw53xMPnx3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWPI1BAAoJECTWi3JdVIfQinwH/0YBLaeoxEDWZM2SRf23/7OZ
/0Re3FtooatAyplUdqwyT8UZezCYuW94EA5fRuhgUslcja+wxfPrbbXk9lBPgpWs
htwFXfLY7Y0Yl/5CW8P8SiYCAXU1rLNnYwQD1SRHtBWSMdF4cDrH/CNXU7hrfXX9
gGoN0vRSPoWUyXWtqRJUgvIfkIuoAYekOiGvqa+VvvCL+42oSTJFI1+AnMEQAYl6
CmL2xHUyWPjM/xiY6dg9uGcn2Tp1dfoXu9/YYHWDRIU99SXW0nSJFI5TQgjMbIMQ
SuEZ2JyerEkyt+K+nzsnIDpXSRuLIhP0tPszvELvGiA6CcL6aJlw2p317EtdQAo=
=GlxG
-----END PGP SIGNATURE-----

--SqEuGDw53xMPnx3c--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
