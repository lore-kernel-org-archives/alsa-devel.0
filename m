From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: rt5651: add Volume to the name
 of volume control
Date: Tue, 24 Jul 2018 15:40:47 +0100
Message-ID: <20180724144047.GE13268@sirena.org.uk>
References: <1532051300-11884-1-git-send-email-bardliao@realtek.com>
 <ABFD875FF5FB574BA706497D987D48D702846306@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2704429113833114143=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 31D8826733D
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2018 16:40:49 +0200 (CEST)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D702846306@RTITMBSV02.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>, Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>, "Flove(HsinFu)" <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============2704429113833114143==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EXKGNeO8l0xGFBjy"
Content-Disposition: inline


--EXKGNeO8l0xGFBjy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 24, 2018 at 01:49:48AM +0000, Bard Liao wrote:

> Please ignore these patches. There is no significant advantage of
> adding "Volume" to the control name. To prevent breaking the
> configuration files on user space, we should find out all projects
> which are using these controls and modify them. It will take time.
> So I think it is better to leave it as it is.

The RT5631 doesn't appear to have any users except Arndale, certainly no
x86 users?

--EXKGNeO8l0xGFBjy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltXOm4ACgkQJNaLcl1U
h9D6qQf7BjS659iN/cwUiS8gJrX2jkTJbJ4qNhVDFP6v0jCaCvMr+OjBYa1nwhd6
ZGC6tSiNqVoQ07lJG064IzsSg1kTlOu5JRzYXANccZuj2X7kIJvYugKFme7Z4jMa
YEyIZcIKGLBsu1IOc9dpB/xOav0PXBak5pd2F+f1P9N+4vGbeb8yhSC+nhGyAbXL
zYWG+Obk9L7FAAC2HCzumFJDQQAjzdfHESQvRGj/9IsCklUWFPIqp/qn35T8bdPD
ca0JATx1YcoHdnCqBtFD5u6ouazyrEhlKJY0mAj2BuEg6Gar4/6TxKs0IHCuD+fl
iHdZc24TmeF0om1flR4t9IUEnuoQBw==
=lZWC
-----END PGP SIGNATURE-----

--EXKGNeO8l0xGFBjy--

--===============2704429113833114143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2704429113833114143==--
