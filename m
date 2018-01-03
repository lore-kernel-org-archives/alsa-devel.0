From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: rt5645: change micbias widget
	type to supply.
Date: Wed, 3 Jan 2018 10:50:53 +0000
Message-ID: <20180103105053.GA5603@sirena.org.uk>
References: <20180102185314.17189-1-hdegoede@redhat.com>
 <20180102185314.17189-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2869050492230705888=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C415266CFE
 for <alsa-devel@alsa-project.org>; Wed,  3 Jan 2018 11:51:00 +0100 (CET)
In-Reply-To: <20180102185314.17189-2-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============2869050492230705888==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 02, 2018 at 07:53:09PM +0100, Hans de Goede wrote:

> Register "micbias1" and "micbias2" to supply widegts as modern drivers do.

> -	SND_SOC_DAPM_MICBIAS("micbias1", RT5645_PWR_ANLG2,
> -			RT5645_PWR_MB1_BIT, 0),
> -	SND_SOC_DAPM_MICBIAS("micbias2", RT5645_PWR_ANLG2,
> -			RT5645_PWR_MB2_BIT, 0),
> +	SND_SOC_DAPM_SUPPLY("micbias1", RT5645_PWR_ANLG2,
> +			RT5645_PWR_MB1_BIT, 0, NULL, 0),
> +	SND_SOC_DAPM_SUPPLY("micbias2", RT5645_PWR_ANLG2,
> +			RT5645_PWR_MB2_BIT, 0, NULL, 0),

This is a good change to make but we have machines with the rt5645, are
we sure none of them use microphones?  The two widget types work
differently so it needs some checking and possibly machine driver
updates to convert.

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpMtWYACgkQJNaLcl1U
h9CdXAf+KJyuo5hugeV9QoimnkQo/1ObCyYDoKYMUG+Tts7UDjRTCv8u2hg5A2Nv
9pPHmgsoOeAQ4QmjhT1rviwsdYr/+pu2D5gR1G8jQQrNC7JdeR9sWt/k7xUF3YPg
TZnhD8oiugsIC/MtmMxz7Vx+6hdsC8Kyf5FttZxhyTn+Wdt5HmRaNkBtiJ7LR3QM
gcL7OaQyMwN6dpJ0X//PEnGfqnxSU0DCzbm/oASeNmsz86n3knr1cjDCtk5c8OnA
xk0//21iSi+2eHlMnN3n8hXo5QxX7+sLFDN2VUDTQYnunnfUtvpn18eQWmkeNKWF
6U5onJZ8621n0fkW0fFh7HIXNUVoCA==
=t0Nx
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--

--===============2869050492230705888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2869050492230705888==--
