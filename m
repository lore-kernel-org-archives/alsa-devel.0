From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: rt5670: Add IRQ function
Date: Wed, 11 Mar 2015 12:08:31 +0000
Message-ID: <20150311120831.GA28806@sirena.org.uk>
References: <1426045365-15975-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6797238420779800536=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AA0D2651C7
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2015 13:08:46 +0100 (CET)
In-Reply-To: <1426045365-15975-1-git-send-email-bardliao@realtek.com>
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


--===============6797238420779800536==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5NsQWDwfMDrsTk14"
Content-Disposition: inline


--5NsQWDwfMDrsTk14
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 11, 2015 at 11:42:44AM +0800, Bard Liao wrote:
> This patch adds the IRQ function support of rt5670. We use a flag
> named dev_gpio in platform data to inform codec driver if the IRQ
> function is used or not. Also, we export rt5670_set_jack_detect
> for machine driver to pass the jack point.

Applied both, thanks.

--5NsQWDwfMDrsTk14
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVADA+AAoJECTWi3JdVIfQFUgH/02mxWVRJo2HXHfC++g3zmSs
riJaJFqTNqqQjBX7Rusw3PBwHy6qXqdInj+hYr7mS/O9xwpf9EY5a3Us/s7QP3WA
EgI20W8eEHx5Fca2DstV2zILvt3gWeUkDjZV8S5rzdiC+1al3CkszEpjx75MHqqj
oYX3jI88eFXdazvcsEJJj0RpaOLXPxXmR62Nl5zmKKaaFdiI6igWdj4Pb4bNPTdt
l3l9yNxFPHJ2Q84eYTDuKhY/3Id3EQBDRyKnRUmFZn3UTpM4MsHjK4oqmqnriOZq
ncz9k+df4LHpTIJKlxQUSQ2C5PJechoMi0bFEXptQiOn04mFrFE8WR1mS051TgA=
=G9ab
-----END PGP SIGNATURE-----

--5NsQWDwfMDrsTk14--

--===============6797238420779800536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6797238420779800536==--
