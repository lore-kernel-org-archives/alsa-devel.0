From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: rt5645: add DAC1 soft volume
	func control
Date: Thu, 7 Jul 2016 11:57:25 +0200
Message-ID: <20160707095725.GM6247@sirena.org.uk>
References: <1467770115-16706-1-git-send-email-bardliao@realtek.com>
 <1467770115-16706-2-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8293685098522339782=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EF02B265232
 for <alsa-devel@alsa-project.org>; Thu,  7 Jul 2016 11:57:52 +0200 (CEST)
In-Reply-To: <1467770115-16706-2-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, koro.chen@mediatek.com, PC.Liao@mediatek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============8293685098522339782==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kNWh/WJk9f5Nf1i0"
Content-Disposition: inline


--kNWh/WJk9f5Nf1i0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 06, 2016 at 09:55:15AM +0800, Bard Liao wrote:

> This patch add an alsa control for DAC1 digital volume control function
> selection. The options are:
> 0: Gain update immediately
> 1: Gain update when a zero crossing
> 2: Gain update when a zero crossing with a soft ramp

This seems like it should be an enum?

--kNWh/WJk9f5Nf1i0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXfieDAAoJECTWi3JdVIfQa7YH+QGRtXcBDnogzWtK4Go9y4OQ
otZSW8deSyxizfmooq6gqdcMCpgvqYZGs+1dqVFxXwrkXjB65/XoB2czaNzjPOfH
l4pk+/r/WjAsO5eJQ/nnvaxqn+jHL6hPM6iyA1inqJjS8odcK+kKSkTQH64xhrnP
TyjSbR6bJAdhTUaA/kgcSYIXCsGoDLghQkYFrSDjteH1X3KU4g7ZmaRbpSEILnSq
Vc7ZqrhPHCUe+YWjOOdgv/9bfos4jxijACQcfqq2gHQ5bHcHfDeUJcskxJfg7i5i
DJFsqLzhwf0N8oBh9UGSxQLJ77yjasyDql6qdHBrssuFRk2UNZUYf7mYCT/ucd8=
=F7hB
-----END PGP SIGNATURE-----

--kNWh/WJk9f5Nf1i0--

--===============8293685098522339782==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8293685098522339782==--
