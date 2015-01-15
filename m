From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4] ALSA: ASoC: soc-compress.c: fix NULL
	dereference
Date: Thu, 15 Jan 2015 15:54:47 +0000
Message-ID: <20150115155447.GA3043@sirena.org.uk>
References: <1421225249-19762-1-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8041919024000731822=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 96FF0260605
 for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2015 16:54:57 +0100 (CET)
In-Reply-To: <1421225249-19762-1-git-send-email-qais.yousef@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qais Yousef <qais.yousef@imgtec.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--===============8041919024000731822==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ofekNuVaYCKmvJ0U"
Content-Disposition: inline


--ofekNuVaYCKmvJ0U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 14, 2015 at 08:47:29AM +0000, Qais Yousef wrote:
> In soc_new_compress() when rtd->dai_link->dynamic is set, we create the pcm
> substreams with this call:

Applied, thanks.

--ofekNuVaYCKmvJ0U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUt+LHAAoJECTWi3JdVIfQCuwH/2pzlpBqB/Sq05DrifoytVe8
0krBg9wk0CCFXPmNC5Vz7wEmkF8O3GTNKYNNCw0FNvZ4X6oLcEHTKxtLEcR0MFDG
oe4t0isIUVn98RFijjAJSTFOZVrHFDnSKkIYCLN4TQdnStQxKlIf+INALSmtpWAW
pq72NLVGCluP3C3QBRRthiDHw+O07urXVAPuL1OYHWEQfiee/WSesQisQSLvqhdj
IWRcmtaFOAw2p5JSJQt1xz2Pt9NZF0rXvY3iV0Fajl7d0KTTIoc3vysVwakEcFId
4DwOMgh6nM1ycOymbLBUOaNJPYE2nYh5HrZ96CzngPOxBG8QXov0k0xr87Hm82k=
=qJXn
-----END PGP SIGNATURE-----

--ofekNuVaYCKmvJ0U--

--===============8041919024000731822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8041919024000731822==--
