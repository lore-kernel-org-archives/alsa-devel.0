From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Document DAI signal polarity
Date: Wed, 30 Sep 2015 19:10:04 +0100
Message-ID: <20150930181004.GN15635@sirena.org.uk>
References: <1441054258-33200-1-git-send-email-anatol.pomozov@gmail.com>
 <20150918135427.GI12027@sirena.org.uk>
 <CAOMFOmW3RCcrGn6o0xsQWREz5gqVT_ucjO5uDAf=zexZrxWEdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4890388633049659509=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 02C66260682
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 20:10:12 +0200 (CEST)
In-Reply-To: <CAOMFOmW3RCcrGn6o0xsQWREz5gqVT_ucjO5uDAf=zexZrxWEdA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: liam.r.girdwood@linux.intel.com, =?utf-8?B?6Zmz56uL5bOw?= <albertchen@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


--===============4890388633049659509==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tDYGg60iReQ7u8wj"
Content-Disposition: inline


--tDYGg60iReQ7u8wj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 29, 2015 at 02:34:33PM -0700, Anatol Pomozov wrote:
> On Fri, Sep 18, 2015 at 6:54 AM, Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Aug 31, 2015 at 01:50:58PM -0700, Anatol Pomozov wrote:

> >> Per discussion at [1] currently there is no clear definition of what is FSYNC polarity.
> >> Different drivers use its own definition of what is "normal" and what is "inverted"
> >> fsync in different modes. This leads to compatibility problems between drivers.

> > Please keep changelogs wrapped at under 80 columns as is covered in
> > SubmittingPatches and please write free standing changelogs that don't
> > require reference to external discussions unless there is a strong
> > reason to do so.  This makes both the e-mails and the git changelogs
> > easier to read, ensuring that people don't need to go online to read
> > things and links don't go bad.

> I see that external links quite actively used by developers:
> $ git log --grep Link

> but no problem, I can inline info into the commit description.

Like I say there can be strong reasons to do this but this doesn't seem
to be one of them.

> >> + * For FSYNC:
> >> + *  - "normal" polarity means frame starts at rising edge of FSYNC
> >> + *  - "inverted" polarity means frame starts at falling edge of FSYNC

> > This isn't true (or at least isn't clear) for I2S based modes, normally
> > the left channel is thought of as the first channel sent and the left
> > channel starts on the falling edge of LRCLK, not the rising edge (which
> > signals the start of the right frame).

> In the I2S docs/specs I found I2S format has frames like you described
> - starts at falling edge, left channel first. Per description above
> this will have "negative" FSYNC polarity.

> The I2S docs do not define frame polarity. Polarity is purely Linux
> driver thing and we can choose definition we want.

I don't think that's true, the expectation is that a left/right sample
pair is time aligned so the left channel is definitely the start of
frame for all meaningful purposes.  It's certainly what I'd expect most
people to understand - choosing a counterintuitive definition to make
this one statement convenient is going to lead to constant confusion for
the mode which is clearest.

--tDYGg60iReQ7u8wj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWDCV8AAoJECTWi3JdVIfQGSMH/0E7EpYAn4WaDf+PG6QxAP7G
RNSnE3Sq0Pl99hXIYCmBEEVIKYeZYCaYhfPDMdk3sIpDfE4tzr692It9cWnNlj0S
2wFuFqPI6i2G7dYgyePr14QBtxdH0KA0bpoYqB4snf1GNfsOZzBzjT68DvzBBHhG
uO+8gHziy53qM+hE8wvD71k7F9+tbs1mTV+nPnBkCnp3LYDdDgVEmc6Esz5K4WZm
fEQri6d5ANAAd8RbieTD0EG8ZRceoI4oSq9QAEW9Nh3y91MEhOqiqD23CcVmR32I
RmA/gexaqsGYTACXk9YSWMy0Ek/nFgChWJeyNRtZaKd2CJjNfftGcCPwp+J6xb0=
=gZl5
-----END PGP SIGNATURE-----

--tDYGg60iReQ7u8wj--

--===============4890388633049659509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4890388633049659509==--
