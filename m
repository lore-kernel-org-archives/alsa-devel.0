From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: rt5659: Add mclk controls
Date: Fri, 29 Jul 2016 22:25:14 +0530
Message-ID: <20160729165514.GN9681@localhost>
References: <1469660568-3511-1-git-send-email-nicoleotsuka@gmail.com>
 <20160728155732.GG11806@sirena.org.uk>
 <20160728181419.GA4742@Asurada-Nvidia>
 <20160728185510.GK11806@sirena.org.uk>
 <20160729161521.GL9681@localhost>
 <20160729163933.GJ10376@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+sHJum3is6Tsg7/J"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160729163933.GJ10376-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--+sHJum3is6Tsg7/J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 29, 2016 at 05:39:33PM +0100, Mark Brown wrote:
> On Fri, Jul 29, 2016 at 09:45:21PM +0530, Vinod Koul wrote:
>=20
> > Yeah I am not aware of any plan to have clks on x86. For audio we are n=
ot
> > going to use much. ACPI and controller w/ firmware does the job.
>=20
> > I have added Darren, he oversee platform things so might know if clocks
> > would be there in future..
>=20
> Not having controllable clocks is fine but as we've discussed before
> you're going to need to represent the clocks that are there with fixed
> clocks instantiated through whatever you use to enumerate boards.  We
> don't want to have to special case x86 all the time in CODEC drivers.

Right I don't disagree on that. But we are not there yet!

Pierre managed to get that working on BYT, CHT nosuch luck. Further down the
DSPs fw is managing it, not even exposed to SW :(

But yes I can try to get the controller register as a clock provider and set
things that way. Let me see what can be done here.
We can discuss this at uConf, I will add that as topic :)

Thanks
--=20
~Vinod

--+sHJum3is6Tsg7/J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXm4pyAAoJEHwUBw8lI4NH9n8P/34OJ3yPaR0ux0NR+1+Iom6V
6tD0GuuHmQ5CtoKjJ2pQClskb7RF+lU0LQ0pyrLltyyvlGC6rcVQYaCZJ4/XJFpk
DVKdaazKk1hxRZP1+RNkOZUset2BmGi69o+PRAiB7KueIy3VuXH8LL3F/1Oj9aKE
6vEBFGoieEVm1XWW9vxNH/vFMFsZEzBjaiITenfuuyh9GlCsK5kath9uuZcqXSOi
sqiCdW9n4VjtxzekDkF5lVCki4BF5YcFylTRywdVhf1UKBptuymdkL/1PzJcEqkf
n01JIo9UV8yIiLGR4X6YVOh0IKootVu1IF1EgIqk5UEpITIj/Mo2sqt62OG+q0lM
Ltef9aGMKspMoNG2/mBBv5UtE0HGMO5L7fVxJ+RidG9fKLyp4+LaU4tCtQSV9GlV
JY/EA2VSd7vtIFzGfUenAmz/zjxSiIb3BerDIHAZUuJtEFRyjfaBb+ZXFSLynjpL
10YSiQD8v+CXNrr7gDVUzr4HIlBhJq6xTICZMgki3TpFpgqqCyR/eZcuWk3shn+m
S58oD/eqFiXt2H9wZI2D2nMTXkIloGFNkErZm8Wf/fhAcx8DD1HR+ia8LP9g3hzd
6OaWcqnQpr7ypl6kilk3ekjGpsV59TiqF5jja+7L8DWsBjuI9hd7c0t/ATxKxEEs
kw/SQKrVE5AUo94+SjFe
=1nwM
-----END PGP SIGNATURE-----

--+sHJum3is6Tsg7/J--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
