From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/3] ASoC: rt5645: make
	RT5650_TDM_CTRL_4 readable
Date: Mon, 8 Jun 2015 19:09:25 +0100
Message-ID: <20150608180925.GS14071@sirena.org.uk>
References: <1433481857-28437-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3635172138071104024=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 77E322604C7
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 20:09:35 +0200 (CEST)
In-Reply-To: <1433481857-28437-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, zhengxing@rock-chips.com, yang.a.fang@intel.com, lgirdwood@gmail.com, john.lin@realtek.com, koro.chen@mediatek.com, drinkcat@chromium.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============3635172138071104024==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3TG/ZNIaOacldBdr"
Content-Disposition: inline


--3TG/ZNIaOacldBdr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 05, 2015 at 01:24:15PM +0800, Bard Liao wrote:
> Register RT5650_TDM_CTRL_4(0x7A) is readable and used for mixer
> setting. It should be added in rt5645_readable_register function.

Applied all, thanks.

--3TG/ZNIaOacldBdr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVddpVAAoJECTWi3JdVIfQi24H/0NWLzakKrm49gyVdib9HDMj
TMD6jz4qO6Kp3Ek71iTiEG2ne7/NFBoH0gw+c5aXCDkZ2WQe+KXrswXbpdUNr2j9
19Oxm4e99MtpsIWZLpvXOi+8okqgSlbJGGB6S79J1zJf4/dnh5wj2gFe/DjP2/jn
jkzTUYm9l8m57ijuyY05Vdz74UlS4LfwAODadw6okkQY/7T0mjHVFiDtRDfcWqgl
AnRyp9MwgWpZRSpHloL5ErSdLRM2MmZyBzVm7rd3jnKG0NgdoMLXPz3uF4Gyt5M6
Ny/ftBvTZ+UztnW1syx46f9PPJAiTQJKGBmksD/honoOB8G8UAe3nYnIoxKkyTs=
=lH+0
-----END PGP SIGNATURE-----

--3TG/ZNIaOacldBdr--

--===============3635172138071104024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3635172138071104024==--
