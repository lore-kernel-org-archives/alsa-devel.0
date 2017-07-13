From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5514: Support the DSP recording
 continuously after the hotwording triggered
Date: Thu, 13 Jul 2017 11:09:05 +0100
Message-ID: <20170713100905.gbi6gn4t3qx3gpl7@sirena.org.uk>
References: <1499339685-3112-1-git-send-email-oder_chiou@realtek.com>
 <20170712105434.m3vpt6patlz25szd@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694023B30AA@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4359509510273550332=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 248D626648D
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 12:09:11 +0200 (CEST)
In-Reply-To: <7EB0DE829A537248AF2ED30C97D12694023B30AA@RTITMBSV02.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "hychao@google.com" <hychao@google.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Albert Chen <albertchen@realtek.com>, Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>, Bard Liao <bardliao@realtek.com>, "Flove(HsinFu)" <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============4359509510273550332==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4aq4i27qlg2ct6y2"
Content-Disposition: inline


--4aq4i27qlg2ct6y2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2017 at 02:01:51AM +0000, Oder Chiou wrote:
> > > +static irqreturn_t rt5514_spi_irq(int irq, void *data) {
> > > +	struct rt5514_dsp *rt5514_dsp =3D data;
> > > +
> > > +	schedule_work(&rt5514_dsp->start_work);
> > > +
> > > +	return IRQ_HANDLED;
> > > +}

> > Why not just use a threaded interrupt handler for the start_work?
> > That'd get you into process context.

> Because of the SPI related function the work thread should be manipulated
> by the interrupt handler function. If the SPI related function is
> implemented to the interrupt handler directly, it will cause the runtime
> error while the interrupt handler is triggered.

Why will this cause an error? =20

--4aq4i27qlg2ct6y2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllnRsAACgkQJNaLcl1U
h9BVUAf/bR8b/CQffu1FcvbSpp6Xn0AH3iPXqnKpNrA1D5rFi9rVcbsOEUXSzaR1
6JcGurelrIVzMjDFgwmDR2nSrfExMpyRRPvseQyCZ35h+tyv80gnUdcArexDmsPp
iZHjLuWxKRN/MO8SuvHamhd7slBh0Ui40hPKpbpP1ls+fsFdkneR5uRAJQiVnkoW
KlNjOyQajIHODZOPI88HBuPHyWdS9PJkChpfHf05PWXavEEznHweAZ3hsg2et34z
CvyDVS12xpBqSAm2YpjIOYJkfcG/QobZ0CAg3KUv9JlvHIc9ZmgFdpP7rAqb743C
RYewoyzeOI5Gp5NrnhRWe1bLE71w/A==
=oYVf
-----END PGP SIGNATURE-----

--4aq4i27qlg2ct6y2--

--===============4359509510273550332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4359509510273550332==--
