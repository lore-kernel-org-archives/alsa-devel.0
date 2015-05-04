From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: Intel: Add Cherrytrail &
 Braswell machine driver cht_bsw_max98090_ti
Date: Mon, 4 May 2015 13:17:49 +0100
Message-ID: <20150504121749.GO15510@sirena.org.uk>
References: <1430358238-74659-2-git-send-email-yang.a.fang@intel.com>
 <1430505723-75442-1-git-send-email-yang.a.fang@intel.com>
 <1430505723-75442-2-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8077066001226292651=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 32C87260586
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 15:14:40 +0200 (CEST)
In-Reply-To: <1430505723-75442-2-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: yang.a.fang@intel.com
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, vinod.koul@intel.com, praveen.k.jain@intel.com, praveen.diwakar@intel.com, lgirdwood@gmail.com, denny.iriawan@intel.com, sathyanarayana.nujella@intel.com, kevin.strasser@linux.intel.com, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org


--===============8077066001226292651==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GPOl6LAGMgeiWDic"
Content-Disposition: inline


--GPOl6LAGMgeiWDic
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 01, 2015 at 11:42:03AM -0700, yang.a.fang@intel.com wrote:
> From: "Fang, Yang A" <yang.a.fang@intel.com>
>=20
> Add machine driver for two Intel Cherryview-based platforms, Cherrytrail
> and Braswell. This machine driver will support max98090 codec as primary
> codec. it can also support TI jack detect chip as aux device if platform
> supports it.

Applied, thanks - but this seems like it was against something other
than mainline since it didn't immediately apply.

--GPOl6LAGMgeiWDic
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVR2NsAAoJECTWi3JdVIfQ2W4H/ArnrUxI/HYktzUwDlp3YOwX
L5HzytRUo6BlRawzXaNHgDo0cdr/gFF53Kb+YeNSX+2w8sLOlZwGhFaJipJDKxng
lUbAUfMDpGYibDefh292jysFZXK8zKA+AfPMkBDl8cwiJwXNcRnfLiEVOzJYibbl
ZRM64QL+1w3lfSe1Efn+ueUfPlDv7PmhVyYlPOFl82MjxYy7L9+9Hf/iHrBn/6TB
so4gxXtdd608uThQqYbgOmPmC2BKY4CXiAKUpZo4Nkok0xu/zcNSXZZ76tlmBOrv
hdeLHbjqpDbeiBZAfztieRCYs/vaiRxmOfDNt1BiWeXS89Nld8T429Ib/Gs6TiU=
=tYOm
-----END PGP SIGNATURE-----

--GPOl6LAGMgeiWDic--

--===============8077066001226292651==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8077066001226292651==--
