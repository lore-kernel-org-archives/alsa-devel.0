From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] davinci-evm: extend it to support DM81xx
	and derivatives
Date: Thu, 13 Jul 2017 11:33:38 +0100
Message-ID: <20170713103338.cu5emql5vnalsamw@sirena.org.uk>
References: <20170712124318.39e5941b49d0da45602bd1c1@gmail.com>
 <c439ed79-1961-1781-1853-bcdc758592d3@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8982684308364444726=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8ED4526648D
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 12:33:49 +0200 (CEST)
In-Reply-To: <c439ed79-1961-1781-1853-bcdc758592d3@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Vladimir Barinov <vbarinov@embeddedalley.com>, alsa-devel@alsa-project.org, Kevin Hilman <khilman@kernel.org>, Vitaly Wool <vitalywool@gmail.com>, Jyri Sarah <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, trini@konsulko.com
List-Id: alsa-devel@alsa-project.org


--===============8982684308364444726==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jbs65zyzdbkxxfpc"
Content-Disposition: inline


--jbs65zyzdbkxxfpc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 13, 2017 at 01:31:25PM +0530, Sekhar Nori wrote:

> While there are some users of davinci-evm.c, I think a majority are
> using simple-audio-card instead. Curious on why you chose not to use
> that. It sounds like codec is not the bitclock and frame-sync master in
> your case. Did that end up creating issues ?

New systems should start using of-graph - that's a more flexible and
extensible replacement for simple-card.  But yes, if you can use one of
the generic cards that's better.

--jbs65zyzdbkxxfpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllnTIEACgkQJNaLcl1U
h9DWzwf/dgYKFuzYxZOtpj78a5Wh4JdETw7EQoBIyr/b6TDkaIqCKBwwqjNwVo7H
r2G3gABSS4oiHU/cODX8JlFueL1f8SpH1n3jtT/td0xsA/OgKNebexZKjiQmntKJ
0BCJl3F96V4RpLV3VfwOfDaVUi12ZSd1j9fqRjrxqyAuMyGZiMo/AFCvIYWzxTUp
zuXHvEizmigsXMgnrMzQiGS1J7rJMK/9H4xsEiuZTV8v8spnlJ0kZwGR66EC9F+E
i4FCuB41YoooT5jBJSMkBpwZvmuU/11QFzB1grub/9z6qsat+zf86hHtJq8PBWWW
I0UbyKe7AyE1bQ0JeGmM8m4HNJ8gMA==
=Mrlv
-----END PGP SIGNATURE-----

--jbs65zyzdbkxxfpc--

--===============8982684308364444726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8982684308364444726==--
