From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: core: remove redundunt address
 operation for array type variable
Date: Mon, 13 Mar 2017 16:54:19 +0000
Message-ID: <20170313165418.m4n2njcf6wq4c3mq@sirena.org.uk>
References: <20170313030743.25019-1-takashi.sakamoto@miraclelinux.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3321926485357367921=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E216266B13
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 17:54:25 +0100 (CET)
In-Reply-To: <20170313030743.25019-1-takashi.sakamoto@miraclelinux.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <takashi.sakamoto@miraclelinux.com>
Cc: ichiro.suzuki@miraclelinux.com, alsa-devel@alsa-project.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>, yukie.kato@miraclelinux.com
List-Id: alsa-devel@alsa-project.org


--===============3321926485357367921==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q475ihpgyjwp6uwj"
Content-Disposition: inline


--q475ihpgyjwp6uwj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2017 at 12:07:43PM +0900, Takashi Sakamoto wrote:

> These two evaluation have the same value, a pointer to the first element
> of the array.

> This kind of address operation is not good for readers, because it easily
> brings confusions as an address operations to pointers. For example,

This is done explicitly for clarity, in order to make it clear that the
value is a pointer rather than being (say) an integer.  The value is the
same as you say but that's only clear if the reader realizes that data
is an array.  If I were clarifying this I'd change to explicitly take
the address of the first element of the array rather than the array as
a whole.=20

> Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Fixes: f831b055ecec ("ASoC: core: Add support for masking out parts of co=
efficient blocks")

This is a style change rather than a fix.

--q475ihpgyjwp6uwj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljGzroACgkQJNaLcl1U
h9A2pgf/fJXTCP5bskbHKhgKwfNgs16VPhBteNH2rnuRweSp6SyOCD0Pcq18pmL/
am6iRBfBjvgBB+PRYLhikcQL0RU+3DDIdQOXGVsCWxu2IDnhmw4zAy7yVcxyR1Gh
/Z82COvserntWN1i+yAqAa1bdSRwx2UxAsXtn3zvTPlaIrhfi6xmJHwjzjR/7R8K
ULGwwl7bxNemAucQJgjx2sJbmoevCeXvSVjNbtfp+ofvdTrGDHfR2097DlU37MCv
K70FSTjn5kT7gHSFx6E3LSO8C3B5U58mTXvxfP6/u5GMhsJZJb+5sqlWXnljKaBx
By2cKLzIjLMLBYezM8tNCBxTKR1jSA==
=0ZuD
-----END PGP SIGNATURE-----

--q475ihpgyjwp6uwj--

--===============3321926485357367921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3321926485357367921==--
