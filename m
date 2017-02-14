From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: automatic BCLK and LRC
 divde in master mode
Date: Tue, 14 Feb 2017 11:09:08 +0000
Message-ID: <20170214110908.nhklqtcy5dohhned@sirena.org.uk>
References: <1487051073-2350-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0313005244778904830=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 87C71265142
 for <alsa-devel@alsa-project.org>; Tue, 14 Feb 2017 12:09:20 +0100 (CET)
In-Reply-To: <1487051073-2350-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, WTLI@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org


--===============0313005244778904830==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fpypg7eacvjjpqz3"
Content-Disposition: inline


--fpypg7eacvjjpqz3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 14, 2017 at 01:44:33PM +0800, John Hsu wrote:
> Provide the automatic configurable LRC and BCLK divide. The driver
> will make configurations of LRC and BCLK automatically according to
> BCLK and FS information in master mode.

This patch *still* does not apply.  Please, try sending to yourself and
applying with git am before you resend to me.  Check that the patch is
not being corrupted when you send it (things like space/tab conversion
for example).

--fpypg7eacvjjpqz3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlii5VMACgkQJNaLcl1U
h9AeaQf/fJtmYowqYbW72Rvj2zHNdUaQ6VoS/opwN1p007tkxQ/wmRU4TMgO5jBt
JrS9M5r5Rsm5eEDuzlnOMusjC97SuPNlId6Ozt5vNTFL8Xx7BG/EDyjeFoEkfNkj
YyTrI4NBcZJiOAjRZfAbxPTdkX+AOHGAh7yZCpchwifjSkHAA62O3PzRY7M/QTZF
bBh/VFyDUEO9fXet4ESMUYuXAJZzHI4hYU0t8OTe8C9OmePDTqrjKDNjU1MrDOSr
JA51vjmpRe5gZT3NMXZATOkF/3OpzyfZet9gBnKe9sBnG95lU2UElHO8rrCBVDa/
mit26R7k9IvTEMv/mFMrB4RkI/tN4w==
=sBO0
-----END PGP SIGNATURE-----

--fpypg7eacvjjpqz3--

--===============0313005244778904830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0313005244778904830==--
