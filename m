From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/14] ASoC: dwc: constify snd_soc_dai_ops
	structures
Date: Fri, 18 Aug 2017 13:18:57 +0100
Message-ID: <20170818121857.vz2fez7fhgriklfy@sirena.org.uk>
References: <1503057971-16033-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1503057971-16033-4-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4061456005490248723=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 84AE1266943
 for <alsa-devel@alsa-project.org>; Fri, 18 Aug 2017 14:19:00 +0200 (CEST)
In-Reply-To: <1503057971-16033-4-git-send-email-arvind.yadav.cs@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, timur@tabi.org, linux-kernel@vger.kernel.org, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============4061456005490248723==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o23rv6r476qrb3ph"
Content-Disposition: inline


--o23rv6r476qrb3ph
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 18, 2017 at 05:36:00PM +0530, Arvind Yadav wrote:
> snd_soc_dai_ops are not supposed to change at runtime. All functions
> working with snd_soc_dai_ops provided by <sound/soc-dai.h> work with
> const snd_soc_dai_ops. So mark the non-const structs as const.

A version of this has also already been applied...

--o23rv6r476qrb3ph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmW2zAACgkQJNaLcl1U
h9ABrgf9GKQ8rHwjhYqPiLGm6fhIc3AoM31Z77Kr6LJgpq9PGxYe6oJOGpZVd2te
zQ6liElaKQA7mZNmXLuA5uPpRhONph5I24ElOMXzV/V9fJGFrnwLo+8YcKdBSEGg
/ECvnRjcqZx0OA7RJAfxjlBvUn6qI2CxhiW3IIJ5EC0J8kSrcWwmnO3oob/lT+iW
Ob5t4N0IugumNBVDU7wVUIqoUcTWKWvu6z2gNg4I7VUzPhM7N3FOPL+aN1ALdft3
7GlJl0pHtclSD8rwgxK5S3S63xswbqzunFBKA5E1yRzpQTemnG5RBF08Ckz77ihH
POMB1SiyPb7P2h6XfjzBlv71aLlsxg==
=Bq64
-----END PGP SIGNATURE-----

--o23rv6r476qrb3ph--

--===============4061456005490248723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4061456005490248723==--
