From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/19] ASoC: uda1380: Convert to
 module_i2c_driver()
Date: Wed, 16 Nov 2016 18:01:16 +0000
Message-ID: <20161116180116.7bccwv7bw4f6ffnv@sirena.org.uk>
References: <871syd9vq9.wl%kuninori.morimoto.gx@renesas.com>
 <87zil18h4p.wl%kuninori.morimoto.gx@renesas.com>
 <s5hh979clgu.wl-tiwai@suse.de>
 <87zil16y9l.wl%kuninori.morimoto.gx@renesas.com>
 <9078ee4b-d6c6-138d-7bb1-4752dfc6ccfe@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7187938911245846697=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CF28526664F
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2016 19:01:28 +0100 (CET)
In-Reply-To: <9078ee4b-d6c6-138d-7bb1-4752dfc6ccfe@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Takashi Iwai <tiwai@suse.de>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============7187938911245846697==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rpcxcvtmpam24gts"
Content-Disposition: inline


--rpcxcvtmpam24gts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 15, 2016 at 01:08:45PM +0100, Lars-Peter Clausen wrote:
> On 11/15/2016 07:42 AM, Kuninori Morimoto wrote:

> > Hmm.. indeed thanks for your feedback.
> > So, should I send v2 patch ? or as-is is OK at this point ?

In general if there's lots of discussion on a series it's worth sending
new versions once that's addressed.

> While it doesn't prevent the symbol from being selected this will generate a
> warning if the symbol is selected while its dependencies are not met. So I'd
> say it is still useful to have.

Yes.

--rpcxcvtmpam24gts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYLJ7rAAoJECTWi3JdVIfQTYkH/3Gj/ho8XTz2/Md9Nv3E1jC4
Izdtnt0unleEqt2QpDNhnGATxuQoJmDuErcGntMqyGwlGO1NTiuUgGdu26ZoNoqr
TCKR45fXdaEMLg95jldkQNux/0+o9Hvb2IeSEG1kOmOHio+/S8NrGqScyIUVrguh
xlrPglfTFElh3fS2nUOcscOGzdqWx+99lC6CGDJ97sN51Gj5MdNswspv7XCaKJ7I
2E5JJRXHMKs4HgGcc4Z5MV9PPyvEGlfADnxVIdM0RpMHvwAeGKNcOc2P+DxMlEG5
KkMiLGJqDC5oYyi3sNpwm2Mg+d1P48ltI7YUG1YVTj0LixMnxiL2P8UxPZIF+As=
=iVbI
-----END PGP SIGNATURE-----

--rpcxcvtmpam24gts--

--===============7187938911245846697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7187938911245846697==--
