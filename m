From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: max98927: Adding support for TDM
 mode and Envelop tracking control
Date: Sun, 14 May 2017 19:11:15 +0900
Message-ID: <20170514101115.f53hlcbp7z4muelu@sirena.org.uk>
References: <1494006135-1178-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2423661476105897381=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 60F6326684C
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 09:56:09 +0200 (CEST)
In-Reply-To: <1494006135-1178-1-git-send-email-ryans.lee@maximintegrated.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ryan Lee <ryans.lee@maximintegrated.com>
Cc: alsa-devel@alsa-project.org, ryan.lee.maxim@gmail.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org


--===============2423661476105897381==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="52va3uy4twnioty7"
Content-Disposition: inline


--52va3uy4twnioty7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2017 at 10:42:15AM -0700, Ryan Lee wrote:
> Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
> ---

The subject line suggests that this is adding two new features.  Unless
they are very closely related in the code they should be submitted as
separate patches as covered in SubmittingPatches.

>  	default:
> -		dev_err(codec->dev, "DAI clock mode unsupported");
> +		dev_err(codec->dev, "DAI clock mode unsupported\n");
>  		return -EINVAL;
>  	}
> =20

It also seems like there are a number of unrelated stylistic changes in
this patch.  While it's fine to make such changes they too should be in
separate patches.

--52va3uy4twnioty7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkYLUMACgkQJNaLcl1U
h9Cqqgf/YjlhSOcuvG0d1rGFO9ghHZio4yTHLTNRcqWJ2vFgCAUR3XSXul79gZMu
f/1bZUh+dUMAKJg3TmRE23A0l5Xg4bJIc8a8BSzHCij/xsgQz/jkapD1GOhiOk2V
mgy93DfSSU+iudZUjz3sKazjBc09LIx2s3AXKlV8vgKEMIL3plA5d+xONOFwpK8Q
4epFmHpBySn+BAWUdqms8E4qhLkz+x37X1jxlq01OfsYmRevxVjtdgv9eSwoPk3M
OsgDO/70JT227eanuECAGNKFtWqd2uyj2wP0VebekH/kYdMtGJ8yA7b6Jwu8TWd/
fkFhywrfhlodLjxRf5clqXVEIVfdlQ==
=sVeo
-----END PGP SIGNATURE-----

--52va3uy4twnioty7--

--===============2423661476105897381==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2423661476105897381==--
