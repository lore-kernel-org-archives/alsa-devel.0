From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: max98357a: Fix speaker pop when
	starting playback
Date: Tue, 27 Mar 2018 19:36:31 +0800
Message-ID: <20180327113631.GB29239@sirena.org.uk>
References: <20180321223015.32173-1-ezequiel@vanguardiasur.com.ar>
 <20180322015456.GZ2186@sirena.org.uk>
 <1521723692.1890.1.camel@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7707988991181204492=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CB95E267140
 for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2018 13:53:16 +0200 (CEST)
In-Reply-To: <1521723692.1890.1.camel@collabora.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ezequiel Garcia <ezequiel@collabora.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Stephen Barber <smbarber@chromium.org>, Mac Chiang <mac.chiang@intel.com>, Ezequiel Garcia <ezequiel@collabora.co.uk>, kernel@collabora.com
List-Id: alsa-devel@alsa-project.org


--===============7707988991181204492==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 22, 2018 at 10:01:32AM -0300, Ezequiel Garcia wrote:
> On Thu, 2018-03-22 at 09:54 +0800, Mark Brown wrote:
> > On Wed, Mar 21, 2018 at 07:30:15PM -0300, Ezequiel Garcia wrote:

> > > +- sdmode-delay : specify a delay time for SD_MODE pin. According
> > > +        to the DAC datasheet, if LRCLK is removed while BCLK is
> > > present,
> > > +        the DAC output can cause loud pop/crack noises. This
> > > property
> > > +        specifies a delay for the SD_MODE pin assert, required to
> > > +        eliminate the noise.

> > Why is this configurable?  This sounds like something entirely within
> > the digital domain of the device rather than something that depends
> > on
> > board configuration and it's hard to see how someone would configure
> > this.

> The amount of delay needed seems specific to the CPU DAI,
> not specific to the DAC. The CPU DAIs or the machine=20
> could specify this as a parameter, but I can't don't see how.

This sounds like it's just trying to reimplement the digital mute
feature we already have, it sounds more like what you're seeing is noise
playing out of the SoC at the start of playback due to startup issues
or non-flushed FIFOs.  Can you try implementing there please?

> Perhaps it could be a driver parameter?

Driver parameters are almost never a good idea.  Nobody turns them on
and the mechanisms for doing so are bad.

> > > +static void max98357a_enable_sdmode_work(struct work_struct *work)
> > > +{
> > > +   struct max98357a_priv *max98357a =3D container_of(work,
> > > +           struct max98357a_priv, enable_sdmode_work.work);
> > > +   unsigned long flags;
> > > +
> > > +   spin_lock_irqsave(&max98357a->sdmode_lock, flags);
> > > +   gpiod_set_value(max98357a->sdmode, max98357a-
> > > >sdmode_enabled);
> > > +   spin_unlock_irqrestore(&max98357a->sdmode_lock, flags);
> > > +}

> > What is this lock supposed to accomplish?  We perform a single action
> > under the lock which itself has internal locking, it's not going to
> > have
> > any meaningful effect.

> I am under the impression it removes the race condition
> between the gpiod_set_value() happening in the different
> contexts.

Can you articulate what this race is and how this prevents it - bear in
mind that there's a single operation within each of those locks...

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlq6LL4ACgkQJNaLcl1U
h9BXHggAhcL2fAKYKbL+LPwY+dsbK30lv6Cql3k4ZJhOmYbMtX/3dmJmrAjqm59X
DGuiNVRN4oKoSdCKFobp29Ne+A9bdDsKJD0No30x18nqAqaTNtpS3jrw0jts5xrx
KG3XCZmXSKP4v6hkUfrhrdf+B0wSVvreQnaCFAsM8TdTnlX8RbqtMASot2TFQmue
u8DlqmLCeMbvBiJoMSIg2AHfG1m/yL0cGPv/evktgGJtunW8FVUL8fp/TjSpjgnc
YcAnFzmthOIwI50lXDziow4UPXwdUMj5yFIyC4sl2xk5V+yVlXKyCyYGLUH8dDQ6
Fojnt/qNmnQqTaZkHkfO/PltmbMJQQ==
=fzLy
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--

--===============7707988991181204492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7707988991181204492==--
