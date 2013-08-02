From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 10/10] ASoC: dapm: Implement mixer input
	auto-disable
Date: Fri, 2 Aug 2013 11:22:02 +0100
Message-ID: <20130802102202.GB15416@sirena.org.uk>
References: <1375110845-8069-1-git-send-email-lars@metafoo.de>
 <1375110845-8069-10-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0899873696422722939=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E560F26173C
 for <alsa-devel@alsa-project.org>; Fri,  2 Aug 2013 12:22:07 +0200 (CEST)
In-Reply-To: <1375110845-8069-10-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0899873696422722939==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 29, 2013 at 05:14:04PM +0200, Lars-Peter Clausen wrote:
> Some devices have the problem that if a internal audio signal source is disabled
> the output of the source becomes undefined or goes to a undesired state (E.g.

I was about to apply this but it looks like it needs refreshing after
the bug fixes - can you check and resend please?

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+4hHAAoJELSic+t+oim9MJkP/0HeLJwPMK7+oCs3AgrzOR2F
rklvjscqlT4FopkS++5biBRR7RBCEkwRRZWBOTB8wnyw2sJ2Q+MmjvzN3qucHyJr
pu8Zzb2WrNkzasSuaxcL09O510V8ZkvOljWmw6H0HYpEmbgGgYTPH1LU1d09ncZs
EVA9g4HFiCflTA/WZag6IArbzs2peE4B0jEmeefF1GihXhEhXa7IojhwH12/U9se
bEAsegoREAiM1+mclmJbp/QWQoFYVb1Mxdpv2NCf6KqNroeJ1gbz1n/dqkf2nd/I
/UHuDW5O2tF00vzvR/Vx5mJSiap1IVXS3QoltlQo6Pxg+tPnF5m8EzYpliOCaQag
X2BLgKXRH+9vKrf1D+3/ORt+TWgpz6se99sznLfQoNpMbonrZwa086xY6fki3NQP
Lp6slKQuAnl9m2+4lsSLLzCLwEqP+ItY3D5cCt/pom9Q1jUdo50UV+IM9SbWqjJ4
KL65YCKCgCuwtjLI4AqZW0ZFyIDCw3OhKklZwMT0cZuMt2wqfIj2N+qAKE4An5J6
SuIQkmmCfGKvHpwLCLTcAPbxrNvmJF/6PRVVb8L02VSqifaxRy6GHqhKodY2ULMx
ElLvmE9+4xo1KFg3t2zIvHHNlDp0VOLFeaJaHWsB2ZE3Pdkrtw0XIkyqh9HlBBqN
wL+sQNM+gcvd6dAiTkvH
=AujX
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--

--===============0899873696422722939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0899873696422722939==--
