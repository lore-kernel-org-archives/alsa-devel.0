From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/2] ASoC: Intel: Add missing build
	dependencies
Date: Fri, 17 Oct 2014 14:28:09 +0200
Message-ID: <20141017122809.GJ1820@sirena.org.uk>
References: <1413508922-27567-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6943626458035521449=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 65D1226063B
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 14:28:29 +0200 (CEST)
In-Reply-To: <1413508922-27567-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, "Glenn P. Williamson" <glenn.p.williamson@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6943626458035521449==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JsihDCElWRmQcbOr"
Content-Disposition: inline


--JsihDCElWRmQcbOr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 16, 2014 at 06:22:00PM -0700, Ricardo Neri wrote:
> The Broadwell and Haswell machines utilize the RT286 and RT5640 codecs,
> respectively. To communicate with the codecs, the machine utilizes the
> Designware I2C platform adapter. Hence, such adapter should be present
> in order to probe the codec drivers correctly. This short patch series
> fixes the missing dependency.

Applied both, thanks.

--JsihDCElWRmQcbOr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUQQtYAAoJECTWi3JdVIfQyIMH/3M/Lv0+gs2HObjZbQIhl6b+
PeGr/+LJXN/Tvkv+z2duFC0dZeMkRIoh8wPx86eF4ts6oSPwMLAlzptH40O3X46Z
lCeTxjz9J0e3ULz7duabMCFot1Pq/1RFvg+UCBcGUAnjKQH5TbkZNzyIH2uitpyX
P9gnsMeT3U+IM+xxF//nF0DNECSeF9b2Jqe5mWPo+R3k5Mrb0lbAqwG3dxJT1J/a
MuqmYrHcNS7I5rlQdJuP7Mcr3b8Gzo+dgii17FIM0jRlw4s9nPnkiQKGO3Oz+Lrb
TfpLHXorSml+ZJ8Qh5hCC+nmt/Un+BQ4poHp+133qeBkCpxpWX7JTB4HtZpBUqc=
=qZPA
-----END PGP SIGNATURE-----

--JsihDCElWRmQcbOr--

--===============6943626458035521449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6943626458035521449==--
