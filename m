From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add rt5665 codec driver
Date: Mon, 7 Nov 2016 17:29:55 +0000
Message-ID: <20161107172955.o5iiun4rojndyhbd@sirena.org.uk>
References: <1477903079-11883-1-git-send-email-bardliao@realtek.com>
 <20161031181933.vya7yy5fniaimxvw@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D7011D28D9@RTITMBSV03.realtek.com.tw>
 <20161101201433.4l2ruiczhbveaeif@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D7011D5502@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3426038125969370865=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B02A42659AA
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2016 18:30:06 +0100 (CET)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D7011D5502@RTITMBSV03.realtek.com.tw>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============3426038125969370865==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vbixyop23wbyt244"
Content-Disposition: inline


--vbixyop23wbyt244
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 07, 2016 at 02:39:12AM +0000, Bard Liao wrote:

> > No, that's something the regulator API will handle for you - individual drivers
> > should be written with sensible error handling, the regulator API will handle
> > stubbing out things that are needed.

> Sorry, maybe I didn't describe it clear. What I mean is all power pins
> needed by rt5665 codec can be connected by hardware directly without
> SW control. There is no specific power sequence for these power pins.
> So, we don't need to control them by driver. That's why we think they
> are optional.

That's exactly what I understood you to mean.  The regulator API will
hide this for you.

--vbixyop23wbyt244
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYILoTAAoJECTWi3JdVIfQ8WIH/24VHsfdmnDpkuFqKCXAm+SJ
VahD6vbGI5PEMDv7dej8q0CKUcuJ9wk+qYuhJGHt5+HyY3x85d49UACTpnzBHWmJ
8ui6S6hKLL1lO0kKwfvtV/8NysOqlTg2WAvBdpjRx8YdGlnN/jp2oXJzRGArNOyn
sLlQGhVyhv5naumwOgRbpmo3jI/0b/vCF41cD7DrPQXV9vg7pa1Vt1irZUDoI99u
3iqqlPqVKoLUiSuAQVkxY8UZ7SPlpJvDBrP9KoUy6vxdS5GoBkVs91jmPEkiDR0M
qJHNi/AinwWk/9CqdSNgwiWmlVaE/+nYAJVbQwxRSNRAGwISsdyHspJgK8Y8GhM=
=UzEb
-----END PGP SIGNATURE-----

--vbixyop23wbyt244--

--===============3426038125969370865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3426038125969370865==--
