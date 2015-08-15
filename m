From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/9] ASoC: Intel: Skylake: Add FE and BE
 hw_params handling
Date: Sat, 15 Aug 2015 07:46:46 -0700
Message-ID: <20150815144646.GD10748@sirena.org.uk>
References: <1438976184-6160-1-git-send-email-subhransu.s.prusty@intel.com>
 <1438976184-6160-5-git-send-email-subhransu.s.prusty@intel.com>
 <20150814215310.GV10748@sirena.org.uk>
 <20150815140014.GE13546@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1496987431696166962=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D23912614E3
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 16:46:57 +0200 (CEST)
In-Reply-To: <20150815140014.GE13546@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1496987431696166962==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YyEPptUYZmwjRdlG"
Content-Disposition: inline


--YyEPptUYZmwjRdlG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2015 at 07:30:14PM +0530, Vinod Koul wrote:
> On Fri, Aug 14, 2015 at 10:53:10PM +0100, Mark Brown wrote:
> > On Sat, Aug 08, 2015 at 01:06:19AM +0530, Subhransu S. Prusty wrote:

> > > +	/*
> > > +	 * 16 bit is 16 bit container whereas 24 bit is in 32 bit container=
 so
> > > +	 * update bit depth accordingly
> > > +	 */
> > > +	if (format->valid_bit_depth =3D=3D SKL_DEPTH_16BIT)
> > > +		format->bit_depth =3D format->valid_bit_depth;
> > > +	else if (format->valid_bit_depth =3D=3D SKL_DEPTH_24BIT)
> > > +		format->bit_depth =3D SKL_DEPTH_32BIT;
> > > +

> > What if the depth is neither 16 bit nor 24 bit?  Shouldn't this just be
> > a simple override for the 24 bit case?

> These are the only two DSP supports, so am not sure that overriding will
> work with DSP. I think we should add else and error out.

Then write a switch statement.  :/

> > > +static int skl_tplg_be_set_params(struct snd_soc_dai *dai,
> > > +					struct snd_soc_dapm_widget *w,
> > > +					struct skl_pipe_params *params)
> > > +{
> > > +	if (!w->power) {
> > > +		dev_dbg(dai->dev, "set params for widget=3D%s\n", w->name);
> > > +		return skl_tplg_be_fill_pipe_params(dai, w->priv, params);
> > > +	}
> > > +
> > > +	return -EINVAL;
> >=20
> > Shouldn't that be -EBUSY?  The normal idiom would be to check to see if
> > we were busy and error out rather than writing it as only configuing if
> > not busy (which looks like an error case now).
>=20
> Not EBUSY. So here we are trying to set params for the pipe. So we would
> expect that pipe (widget) should be powered up by DAPM, but if that is not
> the case then we are in bad state. I am thinking EIO might suit this one =
better

Right, that's why I'm saying -EBUSY - we can't configure the pipe
because it is current in use.

> > There's some more common code here and the same patterns as above...  :/

> well the problem here is sink, source. Former was for source pipe using
> p->source, here we have sink pipe and using p->sink.
> Same here too that we either set params or for sink pipe

> Jeeja did try to make this common but it becomes quite hard, if you have
> a trick up your sleeve for this, am all ears :)

Well, I don't have the code any more.

> > > +	if (params->stream =3D=3D SNDRV_PCM_STREAM_CAPTURE) {
> > > +		w =3D dai->capture_widget;
> > > +
> > > +		dev_dbg(dai->dev, "Stream name=3D%s\n", w->name);
> > > +		return skl_tplg_be_set_sink_pipe_params(dai, w, params);
> > > +	}

> > Normally that'd be written as an if/else, and the only difference
> > between the two cases here is which widget we pick...

> Yes we can change to else. Btw should we rather do if and if else, and el=
se
> for error check, in case the value became bad. I am thinking latter.

Either works.

--YyEPptUYZmwjRdlG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVz1DWAAoJECTWi3JdVIfQ/YgH/2K7FrtAEd+ii1mjgx2HRpyh
YrOBdUnUdJHNjZUS8YJn9EkjbbiZskmFr4Lx1dt/I2yx38b9u0pdoeOHdXKPQlxE
YymnDyk6zGfIAnknCKF+ueQiODkECpRaDKXK18lmn/OZCuNDLoeu6f2QnUGA/ubO
QhjNLk3NnoTdvj4zYDTSCoBQ81Hg1Bm/LA8id5MrKvyp+yl5UB2oFS8x29/r11Og
soHeRS41zY3+SQdgKMpOOA69D0PFxtsXs46G/0QRHwZ7KLIbZyF1C1wHxg7dQvDm
js/XpE7ywREHp3WShgm95mGlLWuqD1bTHNq73+A32rWPvsQ/+a94SoFY3v2TLyg=
=sF+0
-----END PGP SIGNATURE-----

--YyEPptUYZmwjRdlG--

--===============1496987431696166962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1496987431696166962==--
