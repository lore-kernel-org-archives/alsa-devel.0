From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6] ASoC: add RT286 CODEC driver
Date: Tue, 15 Apr 2014 13:04:28 +0100
Message-ID: <20140415120428.GU12304@sirena.org.uk>
References: <1397455170-2701-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2842706267641373310=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DD9C4264FFF
 for <alsa-devel@alsa-project.org>; Tue, 15 Apr 2014 14:04:42 +0200 (CEST)
In-Reply-To: <1397455170-2701-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, Gustaw Lewandowski <gustaw.lewandowski@intel.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============2842706267641373310==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XSEVMyPRvc8xgDhM"
Content-Disposition: inline


--XSEVMyPRvc8xgDhM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 14, 2014 at 01:59:30PM +0800, bardliao@realtek.com wrote:

> +static unsigned int rt286_hw_read(struct snd_soc_codec *codec,
> +						unsigned int reg)
> +{

> +static int rt286_hw_write(struct snd_soc_codec *codec,
> +				unsigned int reg, unsigned int value)
> +{

To repeat what's been said before if you are implementing register I/O
you *MUST* use regmap to do this.  What's not been clear is if this
device has a control interface that looks enough like a register map to
be implemented like one but since we're just guessing based on a
combination of the code and the HDA spec it's not entirely clear.

--XSEVMyPRvc8xgDhM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTSBJAAoJELSic+t+oim9UekQAJlfwIMur5En5Lr/t2PR5c9v
5tORRoszhM0gk4xTaH2X74NMWNmRg159TkxrtvOlgXySYHcfY/MjyUFhOJ6ZoLCt
ukLfEZndZN8/2Me2HEB+qFA20pcECowNVc8cEGBwteFcBUFL6D5wBDIGr+dlU8hG
2Kb4B9ETpV+DCr/Ho9JWE1EYeVe+x1zRpWa8DxXkp5X3FscLDDoPIX7Fy0jFiipQ
47Ze5lOaHVlYa4V7vakpsf0ORFSypRG4eERxuOdSFdbfhXYzO0gfIENM8ipxUxMT
NLF+Muuukn4K7k0AZydBCmCMql8XyqkWqXmcUz7YWdx4VfMmB/ZGws4EcUV0hrhM
hnPYuEsl1dV4xEkRR5Py0wSk8saGJLkYbaSgmMoB7ewePZP/kX55pyU7qiVbihq4
mESgXJX5w5LFheS8H6+7XUWwmfxCctuf+jvP4Y8YpuSImfUq6Nc6GkaBfIkeJu/2
kY8oyIgvl4obw5ovpvkg2djp4Jkf4+mtV5cwQ6bL4Bf42Eu6LMuBGbNo0pdaG7Wl
oRTDlCgb3dfGINf3FrsFBeCcOQMjj5ijIGuEDuDP/C6Z+rBk7rS+uPPSdc0S/CMz
ZXNdBWsNsosmRw25shU0kkPVcG7jDaeqEVv7sFSHkZzRDULAmIsNO7pPiGtR/Psw
1GlI/KogIsdm7Pkvau8D
=d220
-----END PGP SIGNATURE-----

--XSEVMyPRvc8xgDhM--

--===============2842706267641373310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2842706267641373310==--
