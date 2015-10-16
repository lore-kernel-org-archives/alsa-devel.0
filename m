From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4] ASoC: rt5645: Add the HW EQ for the
 customized speaker output of Google Celes
Date: Fri, 16 Oct 2015 16:16:18 +0100
Message-ID: <20151016151618.GQ14956@sirena.org.uk>
References: <1444803300-31699-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3585126595728332642=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 73FBB2606C3
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 17:16:25 +0200 (CEST)
In-Reply-To: <1444803300-31699-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, gary_lin@realtek.com, john.lin@realtek.com, woojoo.lee@samsung.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============3585126595728332642==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uwJuRjKj6RbLtb4h"
Content-Disposition: inline


--uwJuRjKj6RbLtb4h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 14, 2015 at 02:15:00PM +0800, Oder Chiou wrote:
> Signed-off-by: Oder Chiou <oder_chiou@realtek.com>

The userspace interface is now what I'd expec tbut I'm still quite
confused by this.  Why is this not a normal bytes control?  There's
something going on with private data here but I'm not sure what it's
supposed to do over writing to the device - a changelog might've
helped...

> +static int rt5645_hweq_get(struct snd_kcontrol *kcontrol,
> +			struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
> +	struct rt5645_priv *rt5645 = snd_soc_component_get_drvdata(component);
> +	char *p = ucontrol->value.bytes.data;
> +
> +	if (rt5645->pdata.hweq)
> +		memcpy(p, rt5645->eq_param,
> +			RT5645_HWEQ_NUM * sizeof(struct rt5645_eq_param_s));
> +
> +	return 0;

There's a validation function below - we should be using it when the
user supplies data so they can tell if their settings took effect.

> +static struct rt5645_platform_data celes_platform_data = {
> +	.dmic1_data_pin = RT5645_DMIC1_DISABLE,
> +	.dmic2_data_pin = RT5645_DMIC_DATA_IN2P,
> +	.jd_mode = 3,
> +	.hweq = true,
> +};

Why is the hweq setting part of platform data (and why is the platform
data for a specific system being set as part of this patch)?  This is
just a setting that can be set, there's nothing system specific about it
and it's not like we're even passing in a system specific tuning here.

Please, one change per patch and describe changes in the changelog.

--uwJuRjKj6RbLtb4h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWIRTBAAoJECTWi3JdVIfQoEQH/AzGJMCAOjHDGzuJK8AaZojH
GJ/kjTo0YYMFJvtpwCiS/02EMNinzzmakLkkE5N5ZHTHyf0C6I3IYAlU+bKXwCd5
YwMS470u8co4PpC+UtpfB42IZdd10XSi6vdfHmfI5fubbrfDCc3zzGTNHj0n0bPn
WkFZii/x0vPiWnraEidxKvUOVSNq6tln8oBppgvrDczPyNt+6mDeUWxsoYOiDJXo
29XfxjsvoGRNWIrQmUGsSzHliAtLIHoSsfHhZ3pn4hZiECpigz0a447eDmwjT4qm
MeMXVmiEU2rMGJ3iWfj8EnI1XyTy4Z/mJk6hJBIdKJ3tLNVwTrGs5pxN/5M5EXc=
=9WET
-----END PGP SIGNATURE-----

--uwJuRjKj6RbLtb4h--

--===============3585126595728332642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3585126595728332642==--
