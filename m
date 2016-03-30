From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: assign DAC Ch to match
	headset L/R
Date: Wed, 30 Mar 2016 10:39:20 -0700
Message-ID: <20160330173920.GO2350@sirena.org.uk>
References: <1459321031-2365-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0397954896524486690=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E2E9A265CF1
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 19:39:27 +0200 (CEST)
In-Reply-To: <1459321031-2365-1-git-send-email-KCHSU0@nuvoton.com>
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
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org


--===============0397954896524486690==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jASSyw8pZdwiLt00"
Content-Disposition: inline


--jASSyw8pZdwiLt00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 30, 2016 at 02:57:11PM +0800, John Hsu wrote:
> The default value of DAC channel select is reverse in codec.
> For normal usage, switch the channel select when codec bootup.

I would expect this to be exposed as DAPM routing?

--jASSyw8pZdwiLt00
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW/A9HAAoJECTWi3JdVIfQQ3oH/303uVd3m8kkvTwrEZwklVu9
A42h/Q6vrgn1bBTwfi4SkaGRcTqyH378/eaqso4fisSjV3J8Z8w9j6WKOp/UbIb/
7d6VQ0TlXDwjvYAUwTU1Ilnm5brXYIHWt7AIY2+K88aETIhhuq6LwqQs6yGkKUaa
NLpU/f8RERJsnu4D9sIynLyvDp3v90uSMmU96JvDULXCI28ohujGmwBfMYns9Lvk
B2K9DeJVtn+S1WiqLL+GG4TTfSHbh+V2UR7qKz+BN0cwi0WjVm2xEN08pL5VjtQ8
HtTVTat8sDsN2NU45D57jUMeVC9ly/vugY5mXgwCgAVOCS20YCWz1iqWsfD3Z5c=
=0nVH
-----END PGP SIGNATURE-----

--jASSyw8pZdwiLt00--

--===============0397954896524486690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0397954896524486690==--
