From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 2/2] ASoC: Add MICFIL SoC Digital Audio
 Interface driver.
Date: Fri, 14 Dec 2018 18:04:45 +0000
Message-ID: <20181214180445.GD6467@sirena.org.uk>
References: <1544433661-32496-1-git-send-email-cosmin.samoila@nxp.com>
 <1544433661-32496-3-git-send-email-cosmin.samoila@nxp.com>
 <20181212181414.GE6920@sirena.org.uk>
 <1544696446.7700.31.camel@nxp.com>
 <20181213143144.GH10669@sirena.org.uk>
 <CAEnQRZBnzqMVv86wAqXB9kRtKpkC=R7fLbpE1Avyw6364Cwgfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7746020695186599780=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B6D426798A
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2018 19:04:47 +0100 (CET)
In-Reply-To: <CAEnQRZBnzqMVv86wAqXB9kRtKpkC=R7fLbpE1Avyw6364Cwgfg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "robh@kernel.org" <robh@kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>, "gabrielcsmo@gmail.com" <gabrielcsmo@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7746020695186599780==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Content-Disposition: inline


--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 14, 2018 at 04:54:13PM +0200, Daniel Baluta wrote:
> On Thu, Dec 13, 2018 at 4:31 PM Mark Brown <broonie@kernel.org> wrote:

> > No, you're missing the point - why not set the sample rate based on the
> > sample rate the interface is running at?

> Hmm, definitely we somehow miss the point here. So what happens
> if we only do Voice Activity Detection (VAD) ?

> This means that there is no sample rate yet configured, so for this reason
> we get the sampling rate as above via ALSA kcontrol interface.

> My feeling is that somehow we will need to create maybe another type
> of stream (VAD?).

> This is a thing that we need to think. Suggestions are welcomed!

This is really easy if you do what other people have done and provide
the detected voice as a compressed stream.  On the other hand if there's
no stream and people just pick the audio out of the normal record path
is there any great reason why people would configure this at all.

> > > > Is this something that should be user selectable or is it going to =
be
> > > > controlled by the board design?
> >
> > > User should be able to select the clock source since, in theory,
> > > hardware could support any custom rate as long as you can provide the
> > > clock on extclk.
> >
> > What I'm saying is that this should not be selectable by the user at
> > runtime.  It's not like the user is going to open their system and start
> > soldering links onto the board or anything.
>=20
> Of course, so would this be a better option to select it from dts?

Yes, or the machine driver.

> > > > Are you *sure* you need to and want to use atomic_set() here and th=
at
> > > > there's no race conditions resulting from trying to use an atomic
> > > > variable?  It's much simpler and clearer to use mutexes, if for some
> > > > reason atomic variables make sense then the reasoning needs to be
> > > > clearly documented as they're quite tricky and easy to break or
> > > > misunderstand.

> We can go back to mutexes no problem, but we thought that atomic vars
> are lighter.

They do less than you might think unfortunately and are more complicated
to reason about so unless you're getting a useful performance gain from
them they're rarely worth the effort.

--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwT8L0ACgkQJNaLcl1U
h9AfSgf+PPTqA6AceAO6GPfLtsXnFiYVfA84J3DtkZIayJPymYkDwtAE0SgXLhsI
i7vqbL+fUmYjbHbJb2ejZ+I8VaktSJaa1XXaKcXG2axLFj5F4av+8hQSUm2/eMM6
LAXR0LpjO0iu13hKmKvKs/rVt6Jzc40ITjro8Z4863+PS+1LWfEpNOpHnXnnsRWY
ubD4aWsWFot9/eg15azPMzFQxbXOg3wKIY+25JcMSLKkyJUhN7A3kWabKxrPVE8g
Sm9A2wPgEa8ydvuN5oS4V8q9SaEE2GYbNPu1qHLSJDUnnIze1AVV2xF0/HPdk+mT
390EAutN8dEdUM3oyxtY5mvaH150lA==
=H+5w
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--

--===============7746020695186599780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7746020695186599780==--
