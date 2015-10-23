From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/9] ASoC: Intel: Skylake: Update for ssp
 node index in copier cfg
Date: Sat, 24 Oct 2015 01:30:52 +0900
Message-ID: <20151023163052.GI29919@sirena.org.uk>
References: <1445536362-26670-1-git-send-email-vinod.koul@intel.com>
 <1445536362-26670-6-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8009412764871033759=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E2440261AAF
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 18:31:03 +0200 (CEST)
In-Reply-To: <1445536362-26670-6-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8009412764871033759==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o7gdRJTuwFmWapyH"
Content-Disposition: inline


--o7gdRJTuwFmWapyH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2015 at 11:22:38PM +0530, Vinod Koul wrote:
> From: Jeeja KP <jeeja.kp@intel.com>
>=20
> DSP firmware has interface change for SSP node index structure.
> New FW interface removes the dual_mono field and adds 4 bits for
> TDM slot group index. This patch updates the ssp dma to align with
> the DSP firmware structure.

This probably doesn't matter right now since things haven't been
released yet but it's going to become an ABI issue...

--o7gdRJTuwFmWapyH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWKmC7AAoJECTWi3JdVIfQSwcH/1UlS6CM4g+X7a8RHeBHSYRd
zQmOA6vjUMs2Cdb4nBL0yxC79E1Sq/pMPF6CuzYhBKmBXAqqUvEk9Cs1E5eMi1mn
CMFvwdqZs33TbZUdLsUcAudRCwbSUTNs7sQhkBCF1bB/S60DCzUaTb5EDSu8I9fV
TznveC3FbfC187tA2ePROjh1RDom3D1T9ASTGnNptjNZHuTi3zhgM4x7HcUwLzsw
jR38MX62NG1pMSvWVUtruMyFbaAW9+XQZJmocQKBcs3CDSMe9g/QSh5ral9L4o1E
HeweuspUD+v6V0KCqnFLlSRRt5ik6RKjY0L5qsKpl/or4btQX1N8cfbpgzlH+GY=
=P/m0
-----END PGP SIGNATURE-----

--o7gdRJTuwFmWapyH--

--===============8009412764871033759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8009412764871033759==--
