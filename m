From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: wm_adsp: Dump scratch registers
	on DSP shutdown
Date: Fri, 29 May 2015 10:37:48 +0100
Message-ID: <20150529093748.GK21577@sirena.org.uk>
References: <1432891387-2784-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4983664431744823503=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 831B7260673
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 11:37:55 +0200 (CEST)
In-Reply-To: <1432891387-2784-1-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============4983664431744823503==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U/5jjA7PY3vDBGbG"
Content-Disposition: inline


--U/5jjA7PY3vDBGbG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2015 at 10:23:07AM +0100, Richard Fitzgerald wrote:
> The SCRATCH registers are used by firmwares to hold diagnostic
> information. Log this during shutdown to assist analysis and debug
> of firmwares.

Applied, thanks.

--U/5jjA7PY3vDBGbG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVaDNrAAoJECTWi3JdVIfQF5wH/RVgP9+KXfplbyDYkZvBIOxw
UvVXV2y5CoU8RSxwI+pZ2Rm38rS+oGIYJF4Tna4794XROTWbGnQSE4WRzh2H08/Y
ALMV4/BOnrh74s1LLpDye4gm8Ja1DRPvipnevLARQwRCOo/0Zk7SMco3BXA5w37n
PCEsnMvyCjHlxf61osnlM9PBW8t9iD16OcuwRC5lTRl4IIpX/MlHa3abJkkekyqG
IRvTmIdT8XBpOhJhYCvUd7n77Dvwt14+s19swKHzH5wXhpxWW4eXwq/ED5/s12Wh
Vld+CmUl0GXfR1CxYAXGCs1vx7bF+beitlgnzmMEbH60U7YGJ9EJ7bvM2yPKuMY=
=Nl26
-----END PGP SIGNATURE-----

--U/5jjA7PY3vDBGbG--

--===============4983664431744823503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4983664431744823503==--
