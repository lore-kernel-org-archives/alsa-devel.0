From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2 v2] crec: Add primitive exception
 handling
Date: Thu, 5 Dec 2013 14:57:46 +0000
Message-ID: <20131205145746.GU29268@sirena.org.uk>
References: <1386088075-21011-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1386088075-21011-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20131203182256.GL27568@sirena.org.uk>
 <20131203201828.GC29268@sirena.org.uk>
 <20131205142528.GG23979@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3622270880831962895=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B57BC265550
 for <alsa-devel@alsa-project.org>; Thu,  5 Dec 2013 15:57:49 +0100 (CET)
In-Reply-To: <20131205142528.GG23979@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: vinod.koul@linux.intel.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3622270880831962895==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t5UUIFOgpLXgUtsP"
Content-Disposition: inline


--t5UUIFOgpLXgUtsP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 05, 2013 at 02:25:28PM +0000, Charles Keepax wrote:

> Tricky thing is making 100% sure we don't enter a poll
> after we have received the signal, especially if we are just
> using the standard pattern of communicating the signal using a
> sig_atomic_t.

If you don't buffer and use Unix I/O rather than stdio for any I/O in
the handler you can exit happily from the handler IIRC, the big problem
is stdio.

--t5UUIFOgpLXgUtsP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSoJRnAAoJELSic+t+oim9QTYP/23WK4Lwdp3PAr4HBgTwXZiV
CHLOBC0GliNKf5VuRAq9y5Cpy7SewdPmWgXvhttlV8Y5CzdtUFXM2um0O5QZ+xT4
4y5AX6ESO0HqoAmdDnVTs+zwmVCeMopYPfWeFdbA4pW9YjdeHoIi/EI2E5Q/XtQz
Xt0dA/6cadWQkohBwm16G5kIZOVkAd8gtQH80ohSy4xZi31+gSsd8tmw93dDZ4Nf
Ltn5MXGjpehnIlLQiP+4IdZHmv8rZCQX90W0/zlH5Rt5ChNUdDc0v42vGq7jjYKU
5xHEOVe73LNQNNcCDyS2i4ZyyXeYTXLc6OA8sYMQGjJ116pnsnXtxHWVWcFYWn+k
qT7KUKCUdJeTrnPhCwN4gf0buYLrqPGXlfSr4PYzRj6O1NSQZj7J4ZBt2lhHcpJ7
OPm5MgO1+VIRz4Yw+Q20lrb0PC5J6/y5eT7GlhIqmibvk1QvX1wFMV2/N4ghOPMw
oXk2nErj76copBiM1tJSnKjM6269hpYpaEaHfvzDLrPMsE8Ap8vHvu1ZaRkgKcc0
kgGCkYXAo0M87I49DemJwLh46uPzuNkMWisZxZ0xydIX9fxkYS1+ik1qFGygGOdJ
i+aOjUJBgwc8e6ByPqoNmFVFysibHtB1nOKAY+DzzsjwJyvabqATzlstmBak990x
xUYUZlLiYtr8voM99TEX
=awM4
-----END PGP SIGNATURE-----

--t5UUIFOgpLXgUtsP--

--===============3622270880831962895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3622270880831962895==--
