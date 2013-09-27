From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: si476x: Remove custom register I/O
	implementation
Date: Fri, 27 Sep 2013 20:48:16 +0100
Message-ID: <20130927194816.GO19304@sirena.org.uk>
References: <1380220461-16359-1-git-send-email-broonie@kernel.org>
 <CAHQ1cqG2Uwhw3M933OPwsX1R=ZrpdmKjsy_DYTL_+CpfQvdVag@mail.gmail.com>
 <20130926194350.GU19304@sirena.org.uk>
 <CAHQ1cqF=8+vW9Ug+5KE3qFamis-m8A+agRF7uJrMbOzd5qk5jQ@mail.gmail.com>
 <20130926205807.GV19304@sirena.org.uk>
 <CAHQ1cqFUNVsKAdimFooyraK3vpvZP=asxAimjzhyyD8T1YRP=Q@mail.gmail.com>
 <20130927100757.GA19304@sirena.org.uk>
 <CAHQ1cqHwqYpdrUnYfXOsVXcYHRPGWzkTNv5SJKACUdXN58=wew@mail.gmail.com>
 <20130927170232.GL19304@sirena.org.uk>
 <CAHQ1cqHEaHSUR1hL5ybs511PdCiz5QWUi5uZ5qDMZcFnVHc3=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1665462682644818670=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A4ED2650C6
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 21:48:22 +0200 (CEST)
In-Reply-To: <CAHQ1cqHEaHSUR1hL5ybs511PdCiz5QWUi5uZ5qDMZcFnVHc3=w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1665462682644818670==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aE2Tjr+Wh4rS13mJ"
Content-Disposition: inline


--aE2Tjr+Wh4rS13mJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 27, 2013 at 12:28:14PM -0700, Andrey Smirnov wrote:

> That is the case for the V4L driver, in that code the locking is
> acquired for logical operations, such "tune" or "power up" rather than
> for a single register write, but for the codec driver, to the best of
> my knowledge, read and write register are the highest level operations
> that it provides. Or am I just unaware of some codec driver
> functionality that driver can provide and SoC sound subsystem will use
> that would allow the lock to be obtained at higher levels?

Since the driver doesn't expose any controls to userspace the only
things that can cause register writes are the operations provided by the
CODEC driver, they could take the lock for their runtime (which is about
the level the v4l stuff is running at AIUI).

This still won't fix the issue with the device being powered off but I
guess that normal usage patterns will have powered the device up to do
tuning or something prior to audio being started.

--aE2Tjr+Wh4rS13mJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSReD8AAoJELSic+t+oim9FqwP/A6QZq1C9ftqs/JkofJuQHYD
34feHVb3sl/4XhfhxT+93JrjiP6UMifhOmqJA28aD4q2qVomjJkuzV4ndGkTbAVD
nttYWG760ISNx+geHoFzjVQVIN1+khGC4JRn6Uai07H26lqloP0zDnfVmgbSKB7S
7GPVDWPi3uymaRKaKaA00KOamw44nUpXdM8Pm1rl5bF1ID1ZPIfagrwOEO9/H2QY
yBAgVYCIN5Fm30K2kEyw09vY78aFYnPG5zd0wV7KQMXXbbbmAeMlD1Sx0L/CSF1z
AibcXpcLbSYM4EKgByWJ6olyR/QdwO3/rmMixTerV1k34803n141Juo+Qcj6hmcw
2H3BQ/rVnF5WpxuVwXVC21BaNlcGMd10DkIc0ziMxDVk95wAIKznieg7HXpmoJP5
OBaQk0D0Z06ozOL69PYjOw5PpntSLDlZn8AQjEeeRroyiv5KdgFGcq8IEIEz2sv9
nVD14OT43v7/UHtPs5+2H/uY4oLobBX6ibZFDKfnN4AaFLJXCnZusqkM22lQf+Uw
CXUQckyiQgsUX/jZEHwXm/3OBvnNPfupa9DL5+0kuHbMAZHPT4W9FyK7Um/CCt3h
kVHmBiF6t62MW3sPJCzZpBFDZBNqz804EPch380P0e2nZ2c1bDWHpShEEo/lNvTc
AYnRtSJvMAXTBMk/XrFy
=lu95
-----END PGP SIGNATURE-----

--aE2Tjr+Wh4rS13mJ--

--===============1665462682644818670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1665462682644818670==--
