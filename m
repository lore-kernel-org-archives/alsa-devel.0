From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: add programmable biquad
	filter control
Date: Tue, 31 May 2016 18:39:00 +0100
Message-ID: <20160531173900.GK29837@sirena.org.uk>
References: <1464667061-32646-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1251777703193381601=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FF362654F2
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 19:39:07 +0200 (CEST)
In-Reply-To: <1464667061-32646-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1251777703193381601==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uvMug2t/eFzFwVce"
Content-Disposition: inline


--uvMug2t/eFzFwVce
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 31, 2016 at 11:57:41AM +0800, John Hsu wrote:

> +	if (!component->regmap)
> +		return -EINVAL;

> +	regmap_raw_read(component->regmap, NAU8825_REG_BIQ_COF1,
> +		ucontrol->value.bytes.data, params->max);
> +	return 0;

You should really check the return code from regmap, especially for
larger block transfers where some controllers may have limitations.

--uvMug2t/eFzFwVce
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXTcwtAAoJECTWi3JdVIfQb5QH/3rlnp71ParKUTByHwvHbTyS
8VjhJagdJnQIHo1SxLy3cApyA+OM2alHM0tMQCv6iOHL4JE27QT3hNDA2+lmqNsx
wILzdSxYuk7la8IMj10JqHB9OhDfdp0KWwUcXaLlOaaLX6yWJU+BPH3Lv+uZ6+8p
u0zEa2E0x0Ent8yzvCcXMYWizfwmBlp+bjBIe4LpBFQW9Ki6nxbkyzMaS/+RW/Dc
tXHxFUQFEznngAy+fZiHlvtV4lLAvfDUmEEbN4mSW5hf87jEwgW3fLlwUizeyD4u
3pogGe9BAHDyj5MZkIUkj7ck/wFmUccWfjoA7TRNq2iMiQd8XarYnM6xJE52MSA=
=C3ZO
-----END PGP SIGNATURE-----

--uvMug2t/eFzFwVce--

--===============1251777703193381601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1251777703193381601==--
