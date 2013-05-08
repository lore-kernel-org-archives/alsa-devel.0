From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/6] ASoC: ux500: Do not clear state if
	already idle
Date: Wed, 8 May 2013 11:34:01 +0100
Message-ID: <20130508103401.GX7478@sirena.org.uk>
References: <20130508080448.GG3102@gmail.com>
 <1368002354-15471-1-git-send-email-fabio.baltieri@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0916655776708162796=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id AF463261658
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2013 12:34:12 +0200 (CEST)
In-Reply-To: <1368002354-15471-1-git-send-email-fabio.baltieri@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Baltieri <fabio.baltieri@linaro.org>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============0916655776708162796==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b/3kIrr+SWblMf9a"
Content-Disposition: inline


--b/3kIrr+SWblMf9a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 08, 2013 at 10:39:14AM +0200, Fabio Baltieri wrote:
> As enable_msp gets called only after some audio data has been received,
> if the userspace closes the device before sending any data it causes
> ux500_msp_i2s_close to clear device state even if it was not previously
> initialized.

Ugh, please don't do stuff like this - you're posting an individual
revision of a patch buried in the middle of a thread.  This just makes
things hard to follow and error prone.  Repost the patch series or wait
until what can be applied is applied then repost.

--b/3kIrr+SWblMf9a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRiioWAAoJELSic+t+oim9fkoP/0xYvB8xWrJTr9Wnopic7yX4
DvARISDa6cKnn6qKnNegFqr0apH8/MiwlAXHPgZmD3Of3UDoipb9b/66bsh8wDJQ
eMI1sqiC9i+8iaT4k1uEJuuYab1584MNfqzrFofSLIs/i3B+T/ghhQdUbaQYaZa8
2ghDAmjT18GV1s4MXAqCk9Jy1AyGnw5sCoeqRR6ZZEiDQDQ66p+S2zyk+ebI4EvI
dMY8T89b1AJKFSJws+0whkGO0Is64aOF2tgOxM8iGXBvVlca0fOGWdM70cY/BFE7
7a349XwtWZ4CdDf3TSlHI3+iWQ5qf8PBkO9XnOZvxt4jJNrAaZLd3OBVmjuOG4E9
8iWXbP2g5yGdWn2onS1NAwX2MttsA84ZeGtoA5xiIsHtFlNMzwExC0KGda8z9V1N
UnN2H8L4rJ8wCTEbT3p6RM3BIxW0Ft4AnWbOIWpA1v/F85nsbZ9w2+kUz5KQzC2s
OwT6q0MxpMI08e1Xfq4OTAsQ3/FMT4zWMq5MVpurOcDcSSPA36XEi2GNeviOE3e1
qwxekcegJFt/GkExopADjdKo9p53NqvNUVWfsiuAZN5Uc6mcYOEaBtX1gSVJ0+gY
iQC5F3GQ4zZDccm3VpiTTXHSm4VCiH1ps7dpwowOCkIHfCCVNXtxAtEm0xGQmOdL
VeQ6zeEizImF8gnjYP+V
=xVuL
-----END PGP SIGNATURE-----

--b/3kIrr+SWblMf9a--

--===============0916655776708162796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0916655776708162796==--
