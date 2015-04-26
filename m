From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 6/7] ASoC: hda: Add support for SSP register
	settings
Date: Sun, 26 Apr 2015 19:48:31 +0530
Message-ID: <20150426141831.GS2738@intel.com>
References: <1429390653-8194-1-git-send-email-vinod.koul@intel.com>
 <1429390653-8194-7-git-send-email-vinod.koul@intel.com>
 <20150424175532.GD22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0075644973240015915=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 620DA2606AC
 for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2015 16:21:20 +0200 (CEST)
In-Reply-To: <20150424175532.GD22845@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Hardik T Shah <hardik.t.shah@intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0075644973240015915==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibvzjYYg+QDzMCy1"
Content-Disposition: inline


--ibvzjYYg+QDzMCy1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2015 at 06:55:32PM +0100, Mark Brown wrote:
> On Sun, Apr 19, 2015 at 02:27:32AM +0530, Vinod Koul wrote:
>=20
> > +	req_bclk =3D fs * slots * s_fmt;
>=20
> We have a helper for this.
will use
>=20
> > +	dummy =3D 0;
> > +	/* Find the lowest bit clock possible for particular configuration */
> > +	do {
> > +		req_bclk =3D ((s_fmt * fs * slots) + (fs * dummy));
> > +		mod =3D HDA_SSP_MAX_FREQ_192 % req_bclk;
> > +		divisor =3D HDA_SSP_MAX_FREQ_192 / req_bclk;
> > +		if (!mod) {
> > +			found =3D 1;
> > +			break;
> > +		}
> > +		/* Dont add odd number of dummy bits, since I2S requires
> > +		 * dummy bit after each slot/channel
> > +		 */
>=20
> It does?
For us unfortuntely yes. We send 24 bit audio to codec and clock divider
doesn't give us 48clocks per frame, so we have to add dummy clocks in each
slot and send 25 clocks per slot

> > +		dummy +=3D 2;
> > +		if (dummy > (HDA_SSPSP2_FEP_MASK >> HDA_SSPSP2_FEP_SHIFT)) {
> > +			dev_err(ctx->dev, "Dummy bit greater than what SSP can support\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +	} while (divisor > 0);
>=20
> Aside from the limits this all looks like it could be generic?
sure will try to do that.

Thanks
--=20
~Vinod

--ibvzjYYg+QDzMCy1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJVPPO3AAoJEHwUBw8lI4NH5OwP/2Gych8vqD2BvrokO7E2iw+R
KGOn6lRBcxDOHvBab96/1DXjpPBcitIoC0erNT12/lCRoCFLLZPhfJcR0cp0C1ZR
8kpdUYvvPhGLzJwPsun5Or8Zl+D7qjQccu0WgNkULfSKAZcwLq5hKnPxm8yGijxk
eLOlonlazcVJCxewb3U6NeBLeQXVvqeVaQ8kyLWwqQ27kDo8bROUn8eAKq5NZym7
EG27rsrtSWjHhNdTGs1WSSU7rKVAODBDXNkEtPaFiMzRqd//9irovTG0m2BrIF5B
nV4asYREAMPsAFaiQ+oK4w/ZtnYCfecdIzQEIp7gmzPLkgDc2F1y+Yo7m+MJX30F
I7SvDtDz+BimbPU3sZGW78rVkz8JkWoXKZwvKXnFE6S9GfmJwhgdjDjcX8uaZ4HI
5Sklc/7jRbZwtA87GlWkuHHTa+bKy2l+lt4eu5IU0zE1OtfDDuSLOB6/IyAjzZ6H
tcMU0l3WGLG9W0/mqF35I9k/ry9ksAmlCS++VNOJXQGqlf4WK9AB6GHbyAWZSHwU
VjPWl6D6q1GRCjyxd9sgVyjiC5ukrFcdfoB1/+QlzmzDkOhw6xwTQpqnx/C3o0Uy
647+u1rbZOKu8G6DCK0J4cb2gui1ksSrrPXf5xmCp5oRRHU6kEiPCFyJjeZT+fCG
1fiUHj+HB15eSCEPoz2L
=l3YG
-----END PGP SIGNATURE-----

--ibvzjYYg+QDzMCy1--

--===============0075644973240015915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0075644973240015915==--
