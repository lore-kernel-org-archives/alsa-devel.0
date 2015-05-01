From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: rt5645: remove
	RT5645_I2S_BCLK_MS1 control
Date: Fri, 1 May 2015 17:35:11 +0100
Message-ID: <20150501163511.GE22845@sirena.org.uk>
References: <1430389127-24609-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0865377643768967768=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 69CC8260A5D
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2015 18:35:16 +0200 (CEST)
In-Reply-To: <1430389127-24609-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, zhengxing@rock-chips.com, yang.a.fang@intel.com, lgirdwood@gmail.com, john.lin@realtek.com, koro.chen@mediatek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============0865377643768967768==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5mqCGJ/oA/hbmJAP"
Content-Disposition: inline


--5mqCGJ/oA/hbmJAP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 30, 2015 at 06:18:42PM +0800, Bard Liao wrote:
> RT5645_I2S_BCLK_MS1 (reg 0x73 [5]) is reserverd in rt5645 and rt5650.
> This function is move to TDM control. We can configure it by
> snd_soc_dai_set_tdm_slot's slot_width parameter.

Applied all except patch 4 (the DT one), thanks.

--5mqCGJ/oA/hbmJAP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQ6s+AAoJECTWi3JdVIfQSRQH/2eaen/WBgYf/6ABwxIfyRzM
Hnz0FekzrDWFzyQCXsp8ugAWIJtBCBJInm/i90qxaUbwv9ZnLLjwka0ILyK5107Z
6L/d+vbXuX98NF9CdAynWtAuKksrGsf7I2RUIy8ksS/Kgo4LNyvxeG5TRl/0IuS/
bW6WKA1r+dW2E2zraWXttXcgfEVtpIO1iUjirNW87/Hyqu8X6DJXsMzWIDpwKe75
Hzw93ZeOTtV72mFFB/U0rOp6Q82UXWbSPzpZOpOnOfhg1KcMfIPs3XVzMOLJVmcz
P2nWF70OlVOHdqzb0LXRKYHXLEK8AanKFCTrB7upa5oZxBtstRQgtabc96a1xco=
=E7IX
-----END PGP SIGNATURE-----

--5mqCGJ/oA/hbmJAP--

--===============0865377643768967768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0865377643768967768==--
