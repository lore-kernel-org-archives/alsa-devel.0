From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] ASoC: simple-card: Support for
 selecting system clocks by ID
Date: Mon, 15 Feb 2016 15:26:35 +0000
Message-ID: <20160215152635.GN18988@sirena.org.uk>
References: <1455545495-20292-1-git-send-email-peter.ujfalusi@ti.com>
 <1455545495-20292-5-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4343432408091237239=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E4331260664
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 16:26:41 +0100 (CET)
In-Reply-To: <1455545495-20292-5-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============4343432408091237239==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JLiXfqD9/Kt1b+Pq"
Content-Disposition: inline


--JLiXfqD9/Kt1b+Pq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 15, 2016 at 04:11:35PM +0200, Peter Ujfalusi wrote:

> Most CPU and codec drivers can select their system clock from different
> sources. They rely on snd_soc_dai_set_sysclk(x, sysclk_id, x, x) to do so.
> Add support for selecting which clock need to be selected along with the
> rate.

Rather than adding new bindings for the ASoC specific clocking APIs it
seems better to use the standard clock API bindings and transition
drivers to use that.  In the past the clock API didn't have DT bindings
so wehad to do our own thing but I think now that's no longer the case?

--JLiXfqD9/Kt1b+Pq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWwe4pAAoJECTWi3JdVIfQBywH/ipTime7ABneW06aE83/xcxd
vDdCCId+G8XAdLzJB7rpNwJPaazp3+lSdOGq4ix4CUxeYNnWcwJTy9Elq1rkPa9x
TN0DaCtEVnPXpYt0x2iPF8LHj+TXKzXkkBr7cRpQS6suUmZO+fMGZvf1erfzRLSy
yy41ssD39VUvXX1LUQnqCvL72nt3al9F+V7MzeElqs6+Xadf8151PXx2BSIQYcJV
uqrojnMa8bh2D8NBKdEicdRd9NTeLuOCaPsJYet3DljhLsJ93oVpSJcAYrnpVM/Y
lTLO0sIyXLsxSHZLcqjCUV1tLGMD4SQTV6YMhcaCwMEC78a1yJrn4kmayxJk8Fo=
=yqSw
-----END PGP SIGNATURE-----

--JLiXfqD9/Kt1b+Pq--

--===============4343432408091237239==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4343432408091237239==--
