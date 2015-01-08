From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: rt5677: Add the specific TDM
 setting for Intel platform.
Date: Thu, 8 Jan 2015 18:42:11 +0000
Message-ID: <20150108184211.GA2634@sirena.org.uk>
References: <1420684267-19211-1-git-send-email-oder_chiou@realtek.com>
 <1420684267-19211-3-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3657757810860738664=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CD33C260498
 for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2015 19:42:15 +0100 (CET)
In-Reply-To: <1420684267-19211-3-git-send-email-oder_chiou@realtek.com>
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
Cc: alsa-devel@alsa-project.org, yang.a.fang@intel.com, lgirdwood@gmail.com, john.lin@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============3657757810860738664==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fy3IkwjgC3G0yg4I"
Content-Disposition: inline


--fy3IkwjgC3G0yg4I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 08, 2015 at 10:31:07AM +0800, Oder Chiou wrote:
> The patch adds the specific TDM setting for Intel platform in the platform
> data. It enables the TDM1's capbility that can receive the 100FS data.

So, this is total magic number stuff...  can you be more specific as to
what this 100fs mode is?  We do have an interface for setting up TDM but
given that this is just flipping one bit I'd expect the hardware isn't
actually generic enough to use that so I'd like to better understand
what the configuration actually does.

--fy3IkwjgC3G0yg4I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUrs+CAAoJECTWi3JdVIfQdocH/3Mgezh8Tso6aatgp+nr6go8
F6H41JodtSS1h/kZYMOBW7bcj4QbI3lhI6b+KPOdCCHZ6OmbGXJxF//NVpDmTt4V
neuyiOjOLL0VdiSMlf+QsgGJPlNuTKgLv9z7IU34rtCLNaCPgbeIf7T3sGa9ZvJk
TOiYOtoYj5Al/kDRPpCfahaesBjHlU/6ALyeeB7EKNGpjQoWVwUdlrZ/DfrXrxpO
IzR8b9p3GR6YnhKFKyol4ZROdGLva7fKCQwmcuyzjop+pjGvQI+ZLUgrZxc2hL3e
jtlWEgxw+8J6pKTUp6iIenZpebAbjXIu3bLPdMbKAmc33W8MhbUPiEl4FqSa9iw=
=530I
-----END PGP SIGNATURE-----

--fy3IkwjgC3G0yg4I--

--===============3657757810860738664==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3657757810860738664==--
