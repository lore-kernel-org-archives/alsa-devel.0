From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: si476x: Remove custom register I/O
	implementation
Date: Sat, 28 Sep 2013 12:53:46 +0100
Message-ID: <20130928115346.GP19304@sirena.org.uk>
References: <20130926194350.GU19304@sirena.org.uk>
 <CAHQ1cqF=8+vW9Ug+5KE3qFamis-m8A+agRF7uJrMbOzd5qk5jQ@mail.gmail.com>
 <20130926205807.GV19304@sirena.org.uk>
 <CAHQ1cqFUNVsKAdimFooyraK3vpvZP=asxAimjzhyyD8T1YRP=Q@mail.gmail.com>
 <20130927100757.GA19304@sirena.org.uk>
 <CAHQ1cqHwqYpdrUnYfXOsVXcYHRPGWzkTNv5SJKACUdXN58=wew@mail.gmail.com>
 <20130927170232.GL19304@sirena.org.uk>
 <CAHQ1cqHEaHSUR1hL5ybs511PdCiz5QWUi5uZ5qDMZcFnVHc3=w@mail.gmail.com>
 <20130927194816.GO19304@sirena.org.uk>
 <CAHQ1cqEeHa+JbDZ8S0ySztRpe09zL1r9BYstyu+unzMn5UeymA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1489900385471490065=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D846260862
 for <alsa-devel@alsa-project.org>; Sat, 28 Sep 2013 13:54:00 +0200 (CEST)
In-Reply-To: <CAHQ1cqEeHa+JbDZ8S0ySztRpe09zL1r9BYstyu+unzMn5UeymA@mail.gmail.com>
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


--===============1489900385471490065==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lzM1j1Hh4qIUNijn"
Content-Disposition: inline


--lzM1j1Hh4qIUNijn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 27, 2013 at 09:37:01PM -0700, Andrey Smirnov wrote:

> > Since the driver doesn't expose any controls to userspace the only
> > things that can cause register writes are the operations provided by the
> > CODEC driver, they could take the lock for their runtime (which is about
> > the level the v4l stuff is running at AIUI).

> Do you mean moving it to si476x_codec_set_dai_fmt and
> si476x_codec_hw_params? If those are the only two places where
> register read and write are called by SoC sound subsystem then I think
> that would work.

Yes, exactly.  Unless you provide controls or DAPM nothing outside of
the callbacks in your driver is going to interact with registers.

--lzM1j1Hh4qIUNijn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSRsNHAAoJELSic+t+oim9MAkP/iZ7ZhCEAoFCc4qy7iOc2GxK
v3B6+09itl0HVciPzUbXLNWU4m2TNUX3FFIS+J8WfZGsqTS5xG2TEsWochMCz55m
+v7wSvPnzdmp0iyNZ388vtGNqPIkA69W0nOldVuSY6KFjNB/k24Kj/y5oW3+ngt1
mDWm+YI7lCmF0xos5gWYggMsHQRhsewRe6qFYv4wy8Gl5a2EZonLFvKYX4iFmaGu
1Bb6TTi60r4Uv+Cr5oGE3qcGzHudqSv/iydy0MqMX8p4/sJfPcPRBgRkpV5bXl2F
KPQAhKOaKdoZo5NmSSUgR1uMm7bXXyKvdriwQeblgcndBgBHdTU8PhaCp5rc/t5p
nKnJSjx1gAk94wZDtlmVTVJ0S1zhfhqLipqG5BoeIwMmwmwqeoacg+hjn3VB8F2G
rDIkjGih6YeQjgCFvHakzBBzfL6S4B9TNfHmIBlnrZIbLoGw8VA2NW5wBgoVxhD3
zA7gS7nwTP2ty3UfZtEFqj1F61vQPIUGyu0UxqDJtoFgtllBnfvjt1ifIXy/Kls1
q1jUsj5biCTP0TsIh/kTI6VKJJSxt8fh0cvxqSHzUxvgU6xsEN7sWH74NlBcdbnl
J3yUdmaClH+l6ne/bmtxqdocdOQeOcj7Q1qeqmgNZuauRLnohFKz82IkaNnu7vni
fWY8DQeWVaYNaakE8Z6o
=qAR+
-----END PGP SIGNATURE-----

--lzM1j1Hh4qIUNijn--

--===============1489900385471490065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1489900385471490065==--
