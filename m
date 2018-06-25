From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5651: Add support for external
 amplifier enable GPIO
Date: Mon, 25 Jun 2018 11:45:03 +0100
Message-ID: <20180625104503.GA9413@sirena.org.uk>
References: <20180624130247.18150-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3186147536672337536=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 46C712675FB
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 12:45:13 +0200 (CEST)
In-Reply-To: <20180624130247.18150-1-hdegoede@redhat.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============3186147536672337536==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 24, 2018 at 03:02:46PM +0200, Hans de Goede wrote:
> The rt5651 does not have a built-in speaker amplifier, so it is often
> used together with an external amplifier. On some boards the external
> amplifier's enable pin is driven through a GPIO, add support for this.

This obviously shouldn't be part of the CODEC driver since it's not part
of the device, you should make a driver for GPIO controlled amplifiers
and add it to the card.  There's actually a guy I've been talking to a
bit on IRC recently who's just written one actually and will hopefully
be posting it soon.

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlswx6wACgkQJNaLcl1U
h9D+yAf9FRWoWneEKcEj39nzZ6jZKrRaDmyChPHF5jiK7kPgQ5UjeYKMAv/xQZfD
mtChwic8EryiN6VU0pGk0EUiJtUyAABPeFfRE5xS3S1NSJz5KYaeF8/GYa19HgMx
OVKELvQhcuY+i4w/PJp0uK2cOTI5L6yDgjP3tzlmaA31PzI889zZJ6u9pWRvG1I+
FN1GNUB4r/PUFsQD/SosHRdkxLPCBBkaffc68d0B/gCtGpe+bY3kdUvANqMdEuIn
4sbuf5FjkSC0m+wJVwVADG1pbIQkOn63CnKilu0faK519ixCT/rRQFVpiOGVwa5l
0ndar6RHnYJ7rD/KCBldItZpK8Tl5g==
=knSW
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--

--===============3186147536672337536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3186147536672337536==--
