From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 7/8] ASoC: rsnd: Request/Release DMA
	channel each time
Date: Tue, 25 Oct 2016 15:02:31 +0100
Message-ID: <20161025140231.GU17252@sirena.org.uk>
References: <878ttdcm17.wl%kuninori.morimoto.gx@renesas.com>
 <87y41db7c0.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2973678926132222081=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AB3432614A0
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2016 16:02:39 +0200 (CEST)
In-Reply-To: <87y41db7c0.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--===============2973678926132222081==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gSSGYPGSs0dvYOj7"
Content-Disposition: inline


--gSSGYPGSs0dvYOj7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 25, 2016 at 12:37:59AM +0000, Kuninori Morimoto wrote:

> Current Renesas Sound driver requests DMA channel when .probe timing,
> and release it when .remove timing. And use DMA on .start/.stop
> But, Audio DMAC power ON was handled when request timing (= .probe),
> and power OFF was when release timing (= .remove).
> This means Audio DMAC power is always ON during driver was enabled.
> This patch fixup to request/release DMA channel each time.

Isn't this something which should be handled by better power management
in the DMA driver rather than this?

--gSSGYPGSs0dvYOj7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYD2X2AAoJECTWi3JdVIfQA0AH/2USYLXUkS7aWHeyAZ0Go4lb
9sKt+f6Ml1coPdY/BNWSsz0oD3PxKUlm0rB3PCIRXY8tpw3DcSxgZI0F+DXqiQKK
euq1Wbic3vEN9ZQZSThJerfsuoxasnPHnMqIbcI1p+HQ5r8uEQqBL9PT4uuWEYUD
A7Q7oSuirfin+jpgb8svKW1ctLNT6tOKSfrdMndE3z8J9CMIO0eNKmXZoBE1WLPu
V8Bp89RQytMw3Vbkdscn/m8goqomsj8288bY/B1pr78lMWQVBNAjB7Vdxn8XDUBC
JS1ZMAq7xcY/qKHKZ+5ViPM2VSJm3YlAGLkYbmwKV3hobqqArxPJrrUBjn6pifI=
=BUTu
-----END PGP SIGNATURE-----

--gSSGYPGSs0dvYOj7--

--===============2973678926132222081==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2973678926132222081==--
