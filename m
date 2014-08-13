From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: wm8994: Demux the microphone detection IRQ
Date: Wed, 13 Aug 2014 11:37:26 +0100
Message-ID: <20140813103726.GI17528@sirena.org.uk>
References: <1407920746-7534-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YxHrAKo4WTx4SUzr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1407920746-7534-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikesh Oswal <nikesh@opensource.wolfsonmicro.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--YxHrAKo4WTx4SUzr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 13, 2014 at 10:05:45AM +0100, Nikesh Oswal wrote:
> Current code only allows direct routing of the WM8994 microphone
> detection signal to a GPIO this change adds support to demux the
> interrupt from the main interrupt line of the codec.

Applied, thanks.

--YxHrAKo4WTx4SUzr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT6z/jAAoJELSic+t+oim9ID0P/iycn1S4WadkDs/QFB/Cr+Mu
QIOz9ztn1Lq8Hjdx925HeVcYhpW1GN9g/lqSEqBS4p06jn96qb9CSGvTNEHlgfdq
o7p3aIIJX47+nC5Nl/1P4ZSsVk+2AquGSDpuotEGe+irTbUdwl66zcPKKHOUKro7
ZsNB6aRxcnV8fx8CpEGUAa1BHgO2xkIJcJ84W93KpSDoLko32GmP0puFrRBzHgXj
IacK0ocwiwJxYa4jj4i215sXJpYfZ1iZwgNbexFAdeHqmhi7DuTJ4c6UqL2nymCA
8d+bM6uff9rnmCTDoFroDf5vncxOiNb5v3/CtDZl+nbkiPty/2vY/XuKhWZpXKvh
2A/zjlW1Hii1pUY6QXuPfhmc9YqtYZtKXl93nl+302maGsDeu5sfDwRCIB8LFLqR
vTAw7UG9d5AQWCG2obBGlDjRAfbQX76+vDwpweWiRZizMrQUuzxYoPz3EFiccRV8
b3mNIK94P3+xDQZiUN6cQC3xWhX2ln6zz5eJqpRJpxW6sPsQoYLuABmnK6sa5exz
XN4kzO4J8YfFNre7ZB2wcNHVl/BWmRz0Ff5Kki8q/Z9HRIqy90iYuzsEM6Q0T6Gg
DE4gefyn88HDgt2eHfgG/U2lsMt79Tu7Q4VSx5PI9ISF6PH8qO3M7bKsfblNXhZ/
aXSUCYVxaZXpRgNMPhyr
=Zsc2
-----END PGP SIGNATURE-----

--YxHrAKo4WTx4SUzr--
