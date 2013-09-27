From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: si476x: Remove custom register I/O
	implementation
Date: Fri, 27 Sep 2013 11:07:57 +0100
Message-ID: <20130927100757.GA19304@sirena.org.uk>
References: <1380220461-16359-1-git-send-email-broonie@kernel.org>
 <CAHQ1cqG2Uwhw3M933OPwsX1R=ZrpdmKjsy_DYTL_+CpfQvdVag@mail.gmail.com>
 <20130926194350.GU19304@sirena.org.uk>
 <CAHQ1cqF=8+vW9Ug+5KE3qFamis-m8A+agRF7uJrMbOzd5qk5jQ@mail.gmail.com>
 <20130926205807.GV19304@sirena.org.uk>
 <CAHQ1cqFUNVsKAdimFooyraK3vpvZP=asxAimjzhyyD8T1YRP=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8129944771423408661=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AA2A265068
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 12:08:03 +0200 (CEST)
In-Reply-To: <CAHQ1cqFUNVsKAdimFooyraK3vpvZP=asxAimjzhyyD8T1YRP=Q@mail.gmail.com>
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


--===============8129944771423408661==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Do9hQ/bfCb4zBpLo"
Content-Disposition: inline


--Do9hQ/bfCb4zBpLo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 26, 2013 at 03:48:09PM -0700, Andrey Smirnov wrote:
> On Thu, Sep 26, 2013 at 1:58 PM, Mark Brown <broonie@kernel.org> wrote:

> > In what way might these things conflict?  What are the clashes you are
> > concerned about?

> That lock serves the purpose of making sure that
> si476x_core_send_command, calls to which all the rest of the functions
> boil down to, is not executed in parallel to itself. So I am concerned
> that with the lock acquisition removal it would be possible to make
> that condition happen.

OK, so if it's purely about send_command() then why is the locking not
being done in that function?  Surely the most obvious and robust place
to protect the function is within the function itself?

--Do9hQ/bfCb4zBpLo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSRVj6AAoJELSic+t+oim9j4kQAJprho03MsTyLbdviIzYnXFt
hmainHW2GUQCDT3YJR/ayUZqmnPrBwGqfzXPH60VVnizCgvlrlb7sgdlXOobZclM
y+WXMitdHC4LFf8p7K1iBeGLKP3YXeElUsYTZB1wA/K1DGQKfD+THEkP2sVSvi/S
qngSjeFLG/KmHk0w/yD5wW39aMuZ7uVEkaWSVBPgziPkgirB91dJOAmySZdU8lRm
641+9pKUsRSVeydVA6pJK0+dQMXRKKF+WTeuCjpiKzmPx+cBC0uda3R9lUgTPeGJ
QQ2/JMIj5+lFq9YuY0StZT3DmguTSeBK4etIEhiUE9yd4tRZ5c+NSK+HrYZD0qUu
jWAmHqT9JJCowV09rTBv1E/petIPAy7k5bopCDUbjtEPDqVOlLoba4rhNL6SBPjL
B3uEOSmW0fBJ6tJZFLdEMFtz8Go8bo5fSjcZ++el0JoFRnuba6nqXCIvojFmKtIP
q2EfdPYpXElFp64W/J8CSaF8QXs31c5Y9JcpaEvOLoz0ZyRaEUzzLBnd2H/Abn/G
vqUUJHoLuYS6lSvyDIRP9FIEX0KzyjBH7UZAnMtJswUxyYIZRmW3FiBzR++hsvbC
ITq8nAFw6bLe1mHPEYGdY3BoHYzqw2ZJnbKUWR24AL15wpWKP1FZHG8rByGh+2Sw
5MoVqdfqZ11r5WAQbXiB
=+bSs
-----END PGP SIGNATURE-----

--Do9hQ/bfCb4zBpLo--

--===============8129944771423408661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8129944771423408661==--
