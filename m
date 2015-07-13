From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add rt298 codec driver
Date: Mon, 13 Jul 2015 15:38:57 +0100
Message-ID: <20150713143857.GE11162@sirena.org.uk>
References: <1435287589-8160-1-git-send-email-bardliao@realtek.com>
 <20150709110922.GK11162@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D701089DE1@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4491768482675427114=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D6B1261504
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 16:39:07 +0200 (CEST)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D701089DE1@RTITMBSV03.realtek.com.tw>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "ramesh.babu@intel.com" <ramesh.babu@intel.com>, John Lin <john.lin@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============4491768482675427114==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZFnrwZjhZHc4CUJd"
Content-Disposition: inline


--ZFnrwZjhZHc4CUJd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 13, 2015 at 01:21:53PM +0000, Bard Liao wrote:

> > > +	pr_info("%s\n", __func__);

> > This isn't adding anything, you should remove it.

> Do you mean remove "pr_info("%s\n", __func__);" ?

Yes.

--ZFnrwZjhZHc4CUJd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVo82AAAoJECTWi3JdVIfQMakH/0jHBc8FYD3p8hT5yfO2OqRF
6ly4RoEnTo5HHoCxoC02qjTlhMPANarebH/5cTkZpLqIErVharROMJ8SFM9KnuST
7lxkrHOSXELJqEbbDPBKFcYrghMrn0DuBGoG7Vg/b71+fME9VDTmCZF+WqAvl5zR
SN8cw12vY8brgpHwWsKuDsxe+4LumIiOe3+X18E0O2j89AclBoOHCmfPtLvoBb99
Fw61xrE6bGU9Xbzyt9Z9qng0NdvsqAVCsCwRD0FLaQzqB8PorJqmA8BpVGFaeKIi
d7t1Z+d1V6zbXQnRrza4EjIdwfpFDL7DckIiLbXMKWHbvVCyy+vwjKZC6A8WgSs=
=CLNg
-----END PGP SIGNATURE-----

--ZFnrwZjhZHc4CUJd--

--===============4491768482675427114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4491768482675427114==--
