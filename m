From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] MFD: twl6040: Update register bit
	definitions
Date: Thu, 27 Jun 2013 09:20:03 +0100
Message-ID: <20130627082003.GU27646@sirena.org.uk>
References: <1372081326-6917-1-git-send-email-peter.ujfalusi@ti.com>
 <1372081326-6917-3-git-send-email-peter.ujfalusi@ti.com>
 <20130627080547.GD4576@zurbaran>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8230720366587783036=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C30A265583
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2013 10:20:17 +0200 (CEST)
In-Reply-To: <20130627080547.GD4576@zurbaran>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: alsa-devel@alsa-project.org, patches@linaro.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============8230720366587783036==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ElEgulhWJDonIdTi"
Content-Disposition: inline


--ElEgulhWJDonIdTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 27, 2013 at 10:05:47AM +0200, Samuel Ortiz wrote:

> I don't see the rest of the patchset, so I can't tell if there's a build
> time dependeny between this one and the other patches.
> I applied it for now, please let me know if you'd like the whole
> patchset to go through another tree at once.

There's build dependencies - the new register bits are used by the
following patches.  I'd already applied this to ASoC and sent it
upstream unfortunately so I can't rebase it out or pull in your commit
instead sadly.

--ElEgulhWJDonIdTi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRy/WwAAoJELSic+t+oim9VeAP/iAMfSn/KXVbn8p2OPk4fgI8
MK/+KHcHDxcxmDNbWNIlyQxP1S0/wG4Jj2Yh4fPu41TTdyxWYv8duIaqj301g/8e
yamUAKE0Z5C1SFYy0g3JX+sHdpN8cVXAhZuCwPkAd1AbnVwvQn8TXY5G7gYfSqij
SOSOPd0ICwwx1DpnKXcp1NZDM/SkyTiZZXR1FyqSdyNqMO7vr2FtujzfYyxsuuqL
rNrFtBHoVRHMHlMf2ySqSKcF4YoC3KAL6+rkInIV2yijzkhh7I0tKV5eHkahSN58
mQIeC3ucpDNAwQue5e/xO3EWbLrxLTpqCFO9V8oYWoznXErRe8th29MGe0nFq9zR
Dn4wA3DJVBovQKjmnzTcsCHqwr6oYHR2YFhEIxkSmbLR8TwuRV2l40YFUr2eCy5W
ho0xtpkSJPmvW8GhzeitPwi3Z5Dj0nsRRfjq96iGbGawoa90s2ken8GQWxiyk4CQ
3Lp/RUFXHEOsUS2APJEcxWCdxUCM02hMH8MpbCuZBxCfxyMvo1i1JZsgRVIsbc7+
hAiFsdBe/FiPb8QvXpD5pFDi+8Oo74kE2XgNZiWUjasmIXxT7PIEmNpT+im3qNbx
O3Ac65L6ALIGIlDz922c/H7tKeZdcKGEGVOnCAQ8JFkFRl3bNB6D6irzatLIuGpT
AA6T1yZjrz8lRHNLVso4
=Dxym
-----END PGP SIGNATURE-----

--ElEgulhWJDonIdTi--

--===============8230720366587783036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8230720366587783036==--
