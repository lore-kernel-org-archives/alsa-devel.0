From: Mark Brown <broonie@kernel.org>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Wed, 14 Nov 2018 16:33:13 -0800
Message-ID: <20181115003313.GH2089@sirena.org.uk>
References: <ed34c70f-8d10-992e-1cf3-3a5f038c3664@gmail.com>
 <dccda0dc-bde7-7790-e4cc-2737871b14ea@linux.intel.com>
 <11a5bb5b-f8ad-d9cc-29df-8efeccb6228d@gmail.com>
 <20181114220640.GB2089@sirena.org.uk>
 <c0546298-960e-df17-273f-fa0734050aac@gmail.com>
 <20181114230255.GG2089@sirena.org.uk>
 <b48bc9d6-767a-24df-692e-fe675afed22e@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5808881900619980885=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CAFE2677E8
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2018 01:33:20 +0100 (CET)
In-Reply-To: <b48bc9d6-767a-24df-692e-fe675afed22e@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papavasiliou <dpapavas@gmail.com>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5808881900619980885==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F/Utwcm1z9NLCQJH"
Content-Disposition: inline


--F/Utwcm1z9NLCQJH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2018 at 01:55:06AM +0200, Dimitris Papavasiliou wrote:
> On 11/15/2018 01:02 AM, Mark Brown wrote:
> > I've no idea what you're proposing, sorry.

> I mentioned it in the message you replied to initially, so you
> can consult that for more details if you want, but I'll give a
> summary below:

That was rather a long mail and I got a bit lost about what the proposal
was.

> As far as I could determine experimentally, switching clocks when
> the DAC is not suspended seems to result in a spike at the input
> of the DAC, the level of which doesn't depend on the digital
> volume setting (so that it's always very loud).  I tried various

This is fairly normal; the DAC is partly digital.

> Avoiding the spike instead of relying on muting seems preferable,
> but, since the power state of the PCM5122 is manipulated by the
> CODEC driver, in response to requests to set the bias level, I'm
> concerned about potential race conditions.

Given that there's no substantial delays in the power up/down paths of
the driver you probably want to set idle_bias_off and possibly also
configuring ignore_pmdown_time to force immediate poweroff.  That should
get the device powered down rapidly, though bouncing the power on and
off all the time isn't great.  If you do need ignore_pmdown_time then
it's probably better to add a higher level interface that allows the
machine driver to cancel all power down timers.

> if (no_switch_needed)
>     return;
>=20
> snd_soc_dapm_mutex_lock(dapm);
> force =3D (snd_soc_dapm_get_bias_level(dapm) !=3D SND_SOC_BIAS_OFF);
>=20
> if (force)
>     snd_soc_dapm_force_bias_level(dapm, SND_SOC_BIAS_OFF);
>=20
> /* Switch the clock here. */
>=20
> ...
>=20
> if (force)
>     snd_soc_dapm_sync_unlocked(dapm);
>=20
> snd_soc_dapm_mutex_unlock(dapm);

This is not a good idea, fiddling around with DAPM internals from
drivers is going to be very fragile as things change in future.

--F/Utwcm1z9NLCQJH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvsvsYACgkQJNaLcl1U
h9DIWQf7BJCzIilYlDv43277+Kp05T/120H22aa7oGTjok32x4ed34vlsu3YvPQ9
yXPGvW//Gr0pw81eeqOlP+XHHC4oDRxoemyMAPazAf1UOn9WixJ7ISyGxwAEYV6n
/k4Xf2s1J8KDfPoMizzHodCjRs5nQl0ak3yPS/D116xutEH3jpU7DchLAjFH8beU
q0kaq9xpetmdg+r5VOqx5WBqBxx4kLzcbwBZdbvaM6nZMi5n1AcftS7s+AFT5hf+
PZVr7edUHOTPprt1+VIlQnBWc7ydfC+DgR5Mjeq+1Ozjbhxr7nKHT67rVDd/3ZUh
oIhYU56SwQ5eeUwP6OiVjn8c9GBWeQ==
=AUpj
-----END PGP SIGNATURE-----

--F/Utwcm1z9NLCQJH--

--===============5808881900619980885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5808881900619980885==--
