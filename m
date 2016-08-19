From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: fsl_asrc: Use np variable
Date: Fri, 19 Aug 2016 16:26:43 +0100
Message-ID: <20160819152643.GB22076@sirena.org.uk>
References: <1471613461-21654-1-git-send-email-fabio.estevam@nxp.com>
 <1471613461-21654-2-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7579556465378004617=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E054C2676B2
 for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2016 17:26:53 +0200 (CEST)
In-Reply-To: <1471613461-21654-2-git-send-email-fabio.estevam@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org, festevam@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7579556465378004617==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Content-Disposition: inline


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 19, 2016 at 10:31:00AM -0300, Fabio Estevam wrote:
> The 'np' variable is already assigned to 'pdev->dev.of_node', so use
> it to improve readability.

Oh, now this turned up - must've been caught up in a queue somewhere.

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXtyUxAAoJECTWi3JdVIfQ7UYH/0hGrgZU634wgypcxuZUeO0r
0R/JpTBjnGgUFjDMCy+3anwB5PXkXOOf43t+HBjpaVA+mHr/9a+W/tUnqzaofqwA
EE9zQ9XFdRUYrupYSrLQW7jaysEJVf/l12efrkSWCTztrmS5+arlc1zqOSdZfMdG
WWkuguPvoJXjbF7mVabgiZVpj53wia+zYKe4mnyCVhec8n2uDnaHgtC2MvVpzoec
nrOQpB1adHzDZLMEDihV0/2tABxm1qXsIsuvaoatox661718Mj6lJoE8409knGFf
HCmDXPNWhNyRbbtgGjfSynrUGdzUNyoXREHk8iQRTy/m3wmrFYjClsgax0hmty0=
=ntID
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--

--===============7579556465378004617==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7579556465378004617==--
