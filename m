From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: mediatek: add power-domain
 get/put ctrl for mt2701
Date: Thu, 16 Feb 2017 18:26:49 +0000
Message-ID: <20170216182649.k6vj3rpvzgbquax5@sirena.org.uk>
References: <1487222836-21174-1-git-send-email-garlic.tseng@mediatek.com>
 <1487222836-21174-2-git-send-email-garlic.tseng@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4594696179428460377=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DB8FB266A02
 for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2017 19:27:10 +0100 (CET)
In-Reply-To: <1487222836-21174-2-git-send-email-garlic.tseng@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Garlic Tseng <garlic.tseng@mediatek.com>
Cc: alsa-devel@alsa-project.org, ir.lian@mediatek.com, srv_heupstream@mediatek.com, tiwai@suse.de, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4594696179428460377==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4uhon5fj5av5susm"
Content-Disposition: inline


--4uhon5fj5av5susm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 16, 2017 at 01:27:15PM +0800, Garlic Tseng wrote:

>  	pm_runtime_enable(&pdev->dev);
>  	if (!pm_runtime_enabled(&pdev->dev))
>  		goto err_pm_disable;
> +	pm_runtime_get_sync(&pdev->dev);

You should really check for errors here.

--4uhon5fj5av5susm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlil7ugACgkQJNaLcl1U
h9Auvgf8DP/0a3HINQuPRhOmPw6Qg6w3EuAY0C7UhkYDZ22QXhW3EzCfTI5LbOGv
BRuDgmtVSDnLDnJfTbMeCewScIXHErJaNSZCboXmRakzkA+2JgbquJigPh8qMg4F
5KY0ykAodCWRmLQu3qGiCta3wgpZg/0izc1cxyDRp8lOAFIySpplhxuy+FME8PyO
7/fUxOGE5AobH8wA4pK78tW+os+ZG7fqry3pqQnEmaYQIWQ2A19wY0zLOMXqw9H3
XKtgdK+0TAACWwsAaQZj04RtLi7/HqbFsQiz5aSij0r4iuqhBLDSHR3zxJq3hX6H
4+DoqtgrXcQn+pcAmu0z6X6juaBCWg==
=RCKs
-----END PGP SIGNATURE-----

--4uhon5fj5av5susm--

--===============4594696179428460377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4594696179428460377==--
