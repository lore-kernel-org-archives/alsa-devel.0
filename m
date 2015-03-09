From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5670: Revert Keep sysclk on
	patch
Date: Mon, 9 Mar 2015 10:49:52 +0000
Message-ID: <20150309104952.GF28806@sirena.org.uk>
References: <1425891323-21445-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4895069645827989692=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B1312605EB
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2015 11:50:04 +0100 (CET)
In-Reply-To: <1425891323-21445-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, mengdong.lin@intel.com, lgirdwood@gmail.com, john.lin@realtek.com, yao.jin@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============4895069645827989692==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gnQ/OOKD4CRsnGw/"
Content-Disposition: inline


--gnQ/OOKD4CRsnGw/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 09, 2015 at 04:55:22PM +0800, Bard Liao wrote:
> The "Keep sysclk on if JD func is used" patch force enable/disable
> pin in rt5670_set_dai_sysclk. But some machine driver call it in
> dapm widget event. It will cause kernel crash.

Could you go into more detail on what's going wrong here please - this
sounds like the machine drivers are buggy, not the jack detection code?
Configuring jack detection in response to a DAPM event would be very
unusual.

--gnQ/OOKD4CRsnGw/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/XrPAAoJECTWi3JdVIfQjDEH/iL2wnlj9+WeM70ny6SqhCsW
Axd2V8pAp2YVkHBfV453PnZeRLKGWSlEov1iKv1T/wiwMQEotlMAWbmLLUSIYRLT
O6vG2HMyLGZFVeG8WYW6MvkfYu2R58Kb87mx26zvFndQbyeWn37cZemNLKzTL5W9
6z3FK7gUMjIleWpnhKxrP1WkhGdUV1RhJ1q66f0WlhxPFR23CBFR/PYI4ee04nBy
TvCMm49QP+PHC+MUSJ8IrSgWJEiAxBIsN7PPWpJgiqhSYhtLHnEm7QG7b1gq/4+w
iUS2cXd9JCQFmpuC2msGYoLLIxp+8KYvvWoWb7FRlg4Uj+fE3z2STky1Eak1Q5g=
=8CFI
-----END PGP SIGNATURE-----

--gnQ/OOKD4CRsnGw/--

--===============4895069645827989692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4895069645827989692==--
