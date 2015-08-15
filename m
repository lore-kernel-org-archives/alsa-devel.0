From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 4/9] ASoC: Intel: Skylake: Add FE and BE
 hw_params handling
Date: Sat, 15 Aug 2015 20:43:22 +0530
Message-ID: <20150815151322.GI13546@localhost>
References: <1438976184-6160-1-git-send-email-subhransu.s.prusty@intel.com>
 <1438976184-6160-5-git-send-email-subhransu.s.prusty@intel.com>
 <20150814215310.GV10748@sirena.org.uk>
 <20150815140014.GE13546@localhost>
 <20150815144646.GD10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7219532056827586243=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id BDF8026513F
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 17:11:21 +0200 (CEST)
In-Reply-To: <20150815144646.GD10748@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7219532056827586243==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t4apE7yKrX2dGgJC"
Content-Disposition: inline


--t4apE7yKrX2dGgJC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2015 at 07:46:46AM -0700, Mark Brown wrote:
> On Sat, Aug 15, 2015 at 07:30:14PM +0530, Vinod Koul wrote:
> > On Fri, Aug 14, 2015 at 10:53:10PM +0100, Mark Brown wrote:
> > > On Sat, Aug 08, 2015 at 01:06:19AM +0530, Subhransu S. Prusty wrote:
>=20
> > > > +	/*
> > > > +	 * 16 bit is 16 bit container whereas 24 bit is in 32 bit contain=
er so
> > > > +	 * update bit depth accordingly
> > > > +	 */
> > > > +	if (format->valid_bit_depth =3D=3D SKL_DEPTH_16BIT)
> > > > +		format->bit_depth =3D format->valid_bit_depth;
> > > > +	else if (format->valid_bit_depth =3D=3D SKL_DEPTH_24BIT)
> > > > +		format->bit_depth =3D SKL_DEPTH_32BIT;
> > > > +
>=20
> > > What if the depth is neither 16 bit nor 24 bit?  Shouldn't this just =
be
> > > a simple override for the 24 bit case?
>=20
> > These are the only two DSP supports, so am not sure that overriding will
> > work with DSP. I think we should add else and error out.
>=20
> Then write a switch statement.  :/

Ok

>=20
> > > > +static int skl_tplg_be_set_params(struct snd_soc_dai *dai,
> > > > +					struct snd_soc_dapm_widget *w,
> > > > +					struct skl_pipe_params *params)
> > > > +{
> > > > +	if (!w->power) {
> > > > +		dev_dbg(dai->dev, "set params for widget=3D%s\n", w->name);
> > > > +		return skl_tplg_be_fill_pipe_params(dai, w->priv, params);
> > > > +	}
> > > > +
> > > > +	return -EINVAL;
> > >=20
> > > Shouldn't that be -EBUSY?  The normal idiom would be to check to see =
if
> > > we were busy and error out rather than writing it as only configuing =
if
> > > not busy (which looks like an error case now).
> >=20
> > Not EBUSY. So here we are trying to set params for the pipe. So we would
> > expect that pipe (widget) should be powered up by DAPM, but if that is =
not
> > the case then we are in bad state. I am thinking EIO might suit this on=
e better
>=20
> Right, that's why I'm saying -EBUSY - we can't configure the pipe
> because it is current in use.

Ok will update

> > > There's some more common code here and the same patterns as above... =
 :/
>=20
> > well the problem here is sink, source. Former was for source pipe using
> > p->source, here we have sink pipe and using p->sink.
> > Same here too that we either set params or for sink pipe
>=20
> > Jeeja did try to make this common but it becomes quite hard, if you have
> > a trick up your sleeve for this, am all ears :)
>=20
> Well, I don't have the code any more.
>=20
> > > > +	if (params->stream =3D=3D SNDRV_PCM_STREAM_CAPTURE) {
> > > > +		w =3D dai->capture_widget;
> > > > +
> > > > +		dev_dbg(dai->dev, "Stream name=3D%s\n", w->name);
> > > > +		return skl_tplg_be_set_sink_pipe_params(dai, w, params);
> > > > +	}
>=20
> > > Normally that'd be written as an if/else, and the only difference
> > > between the two cases here is which widget we pick...
>=20
> > Yes we can change to else. Btw should we rather do if and if else, and =
else
> > for error check, in case the value became bad. I am thinking latter.
>=20
> Either works.
Ok will add latter

--=20
~Vinod

--t4apE7yKrX2dGgJC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVz1cSAAoJEHwUBw8lI4NHNvQQAKUYlkqreslXWRtF1BOA8IhC
aU4gbzuR3s/WA+qPJ4b3WMdIytH2A9QkXzr4vUd+HWNgEi7s6NPeakbvo0Oty/l9
WPbAj7WbyzlXWumnM4IquxX4Z5BkW5uoR2EZY1TtZ0dfkDxUTRE+c5PSDPSVBzcI
CFQBMdS8lrcLprs20itggGKPDG65OEPW6Wbt1i73Kdzc6y2+reDfWGyMJfCNQ1j4
OGXSLZLrEHFCUOGs51i27W/hzFlerFH7KnwoWBAEJZZqDLEbMzfaBKOB4eO20Vsk
OaVWMGNpPiehrPtsVxwsku+jYICah3BBcCAFyJmfk6aCf8QF9Da4MDIi2cwk57dF
cU3VvLkvQAQbnbz0jG+PcC7e24kxf6tEnlLITICgO65Z6/3IMynk+RdKhe2i9N3R
D9h3Kce7GQlz6b8yXN+ZCtGlsfYQpL5DO3NT3caZp+ISRNzHrr/q4l9BfRo1h0jW
GWSPou8Dp4jCIYTWWNOSlutS/0x4kzummBIIm4zoXp9RSl6E2EpXH6imJTC3kZHb
qWC/svtjpC/xLTpDw6KpMrSOdZBqWof2UDRJLN8ViU0nCmUo4HptgMDKl5Hjd/ug
uzKdSLNA0TmTukgYc0uOVr1ulfsOWnr7l2jtbIAi1E2pokSD+z8pfvHuzmLztugO
O4WsIfVDTY+H/tynbCHW
=Hz8G
-----END PGP SIGNATURE-----

--t4apE7yKrX2dGgJC--

--===============7219532056827586243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7219532056827586243==--
