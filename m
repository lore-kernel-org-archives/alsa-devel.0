From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 02/10] ASoC: mediatek: Remove
	unnecessary function call
Date: Thu, 24 Aug 2017 11:40:41 +0100
Message-ID: <20170824104041.inwummupdvyrzm6z@sirena.org.uk>
References: <cover.1503484313.git.dolinux.peng@gmail.com>
 <cebccee7e09dfc8b2abf7447367d222e8840a19c.1503484313.git.dolinux.peng@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8835873490926016008=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F80E2675AC
 for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2017 12:41:16 +0200 (CEST)
In-Reply-To: <cebccee7e09dfc8b2abf7447367d222e8840a19c.1503484313.git.dolinux.peng@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peng Donglin <dolinux.peng@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com, linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8835873490926016008==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pz4qlpjrkok6wwp6"
Content-Disposition: inline


--pz4qlpjrkok6wwp6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 23, 2017 at 05:18:38AM -0700, Peng Donglin wrote:
> The work of the function platform_set_drvdata is done by
> devm_snd_soc_register_card.

This also doesn't apply against current code, it looks like versions of
this series have already been sent - please check the entire series and
resend anything that's left.

--pz4qlpjrkok6wwp6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmerSgACgkQJNaLcl1U
h9B58Qf+KpJZync6HPyDKwneDZtGO3WuH6XXKFuUOgUGAmsoXEGNc0baiQFNKdqj
AmY/GGGFK4mMtvKmYoHD/mus/3AySkuUtW31bKrFF7WCYXzGwK4D2pN4QT9ryGti
FhqXcaD51xvkLl9dXx84h4AE7/i1rW9WMcH8N24JAil0J1AV3YfXsUn/S4gPu4t/
zsrF525uf9lvLLdzoo2EmEn8u8PPpAX3ixAe816twk+zOPhJtoRV0cjjSZ3qySb2
HvlkNKo/bafJHmOoEKSrtzgcwQguPNLHUwj3c1QmGOPdYcqHv1aLXVc87Q3muFcm
IvbO0ZxlUY3Qw7nvQHL1cNwFl0tZbA==
=ihVO
-----END PGP SIGNATURE-----

--pz4qlpjrkok6wwp6--

--===============8835873490926016008==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8835873490926016008==--
