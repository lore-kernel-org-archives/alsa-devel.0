From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 2/2] ASoC: Add MICFIL SoC Digital Audio
	Interface driver.
Date: Thu, 13 Dec 2018 14:31:44 +0000
Message-ID: <20181213143144.GH10669@sirena.org.uk>
References: <1544433661-32496-1-git-send-email-cosmin.samoila@nxp.com>
 <1544433661-32496-3-git-send-email-cosmin.samoila@nxp.com>
 <20181212181414.GE6920@sirena.org.uk>
 <1544696446.7700.31.camel@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7128279958109005487=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 30F6226789F
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 15:31:45 +0100 (CET)
In-Reply-To: <1544696446.7700.31.camel@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cosmin Samoila <cosmin.samoila@nxp.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "robh@kernel.org" <robh@kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, "gabrielcsmo@gmail.com" <gabrielcsmo@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7128279958109005487==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AqCDj3hiknadvR6t"
Content-Disposition: inline


--AqCDj3hiknadvR6t
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 10:20:47AM +0000, Cosmin Samoila wrote:
> On Mi, 2018-12-12 at 18:14 +0000, Mark Brown wrote:

> > > +static const char * const micfil_hwvad_rate[] =3D {
> > > +	"48KHz", "44.1KHz",
> > > +};

> > > +static const int micfil_hwvad_rate_ints[] =3D {
> > > +	48000, 44100,
> > > +};
> > Can the driver not determine this automatically from sample rates?

> I think I could add "48000", "44100" instead of "48KHz", "44.1KHz" and
> use kstrtol()

No, you're missing the point - why not set the sample rate based on the
sample rate the interface is running at?

> > > +static const char * const micfil_clk_src_texts[] =3D {
> > > +	"Auto", "AudioPLL1", "AudioPLL2", "ExtClk3",
> > > +};

> > Is this something that should be user selectable or is it going to be
> > controlled by the board design?

> User should be able to select the clock source since, in theory,
> hardware could support any custom rate as long as you can provide the
> clock on extclk.

What I'm saying is that this should not be selectable by the user at
runtime.  It's not like the user is going to open their system and start
soldering links onto the board or anything.

> > What happens if this gets changed while a stream is active - the user
> > will think they changed the configuration but it won't take effect
> > until
> > the next stream is started AFAICT?

> If the stream is active, the configuration will indeed take efect on
> the next stream but this is the desired behavior. If we would want to
> do the config on the fly, we should use sync functions that also resets
> the pdm module which is not what we intend.
> User must first configure the module then start the recording since
> this seems to be the natural flow.

If the user can't reconfigure the stream while it's running the user
shouldn't be able to reconfigure the stream while it's running - we
should block the change if it can't be implemented.  Then the user can
make the change while the interface is idle and and=20

> > Are you *sure* you need to and want to use atomic_set() here and that
> > there's no race conditions resulting from trying to use an atomic
> > variable?=A0=A0It's much simpler and clearer to use mutexes, if for some
> > reason atomic variables make sense then the reasoning needs to be
> > clearly documented as they're quite tricky and easy to break or
> > misunderstand.

> We want to keep track of the recording state and the hwvad state since
> recording and voice detection can work in parallel. The main reason why
> we want to keep track is because the recording and hwvad share the same
> clock and we should not touch the clock when one or another is on.
> Another restriction is that we want to make sure we use the same rate
> for recording and voice detection when doing it in parallel.
> This was the only solution we found viable at that time and it worked
> in any supported scenarios but we are open for suggestions if the
> functionality is kept and code will have a better quality.

This explains what the data is but not why you have chosen to use
atomics to do this; what other concurrency primitives were considered,
why were they rejected and what's the analysis that shows how the use of
atomics is safe?

> > > +	/* set default gain to max_gain */
> > > +	regmap_write(micfil->regmap, REG_MICFIL_OUT_CTRL,
> > > 0x77777777);
> > > +	for (i =3D 0; i < 8; i++)
> > > +		micfil->channel_gain[i] =3D 0xF;

> > I'm assuming the hardware has no defaults here but if we've got to
> > pick
> > a gain wouldn't a low gain be less likely to blast out someone's
> > eardrums than a maximum gain?

> Fair enough. We did this because the maximum output volume isn't that
> high but I guess we should set it to minimum and user should set volume
> via amixer.

The ideal thing is to just not set it at all and use whatever the
hardware designers picked.

--AqCDj3hiknadvR6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwSbU8ACgkQJNaLcl1U
h9DPVQf9HmSooux1/zsEQ+rJH1z6mgB7LykwIFdebqfhutsqbsgaR/CpaBy9l+gb
x6Tmg3M/ccZq850Iu+yjXURzmRkhO1mkaKDxlJgAYmfdl2bjKgP3kYKD2VT/dF8/
VGpB0P2DsTpZMOE2v88gOdRwaGiZRnPvAQpuhsZs2c1ufhsi6t2DICID+V+vgDE7
MOHjD0pJGptG69YP7zX3mj3LlqrCftr1QLpxcdb7LJRKpUuM2ouuEJXcnsnLI101
VVQiUg1anPouYXW1y6BPhmL53OnvmG1WdxqdOp+gB/GzoavdUaUnne+nEFVb+dsk
5ykHahe84SD8B0F19PvY/Tvebci14Q==
=oZxN
-----END PGP SIGNATURE-----

--AqCDj3hiknadvR6t--

--===============7128279958109005487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7128279958109005487==--
