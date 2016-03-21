From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add max98371 codec driver
Date: Mon, 21 Mar 2016 14:56:42 +0000
Message-ID: <20160321145642.GV2566@sirena.org.uk>
References: <1458525542-2168-1-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7691318826054743424=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A2195265707
 for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2016 15:56:49 +0100 (CET)
In-Reply-To: <1458525542-2168-1-git-send-email-yesanishhere@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: anish kumar <yesanishhere@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7691318826054743424==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mCdhXfk5CmamXiy1"
Content-Disposition: inline


--mCdhXfk5CmamXiy1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 20, 2016 at 06:59:02PM -0700, anish kumar wrote:

This looks mostly good, a few small things:

> +static const char *const voltage_level_text[] = {
> +	"9.5dB", "10.5dB", "11.5dB", "11.5dB", "12.5dB",
> +	"13.5dB", "14.5dB", "15.5dB", "16.5dB", "17.5dB",
> +	"18.5dB", "19.5dB", "20.5dB"
> +};

Volume controls should be done with TLV data not enums.

> +static const struct snd_kcontrol_new max98371_snd_controls[] = {
> +	SOC_SINGLE_TLV("Speaker Gain", MAX98371_GAIN,
> +			MAX98371_GAIN_SHIFT, (1<<MAX98371_GAIN_WIDTH)-1, 0,
> +			max98371_gain_tlv),

Volume controls should end with Volume.

> +static int max98371_probe(struct snd_soc_codec *codec)
> +{
> +	struct max98371_priv *max98371 = snd_soc_codec_get_drvdata(codec);
> +
> +	max98371->codec = codec;
> +	return 0;
> +}

Do we ever actually use this?

--mCdhXfk5CmamXiy1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW8AupAAoJECTWi3JdVIfQ4FoH/jHKqPpDFSesVB2MVo35TKyw
gJgBkF+djGuoOeTeZWAxNdcCx4MJWfZwtuyVO+fs70f4dTfFN/7L4CsQB/5+euJR
tP/VViUcEahAU6FPtr2iK9vVJvILVrV1nY2867mOPZ0gUP6/yzbEowc8h3+IUc3l
csXEolOcQ2ZaDKQHnTAI0OkGJRrVLfH+2tPgkTFeoeva0ipDbXc9yl+NSssULhHc
r2Z6gylaOEIEqbF/H2I9gq77q93qBztvvhNPE7+I0kZYJlBxm3AIx5WGyxA92e1v
L38fTO52XPbo1BNAlsWaycjAeD35xCrEli11ysamVc+aXJIxUtkw5hY9LicJxGA=
=Pt3R
-----END PGP SIGNATURE-----

--mCdhXfk5CmamXiy1--

--===============7691318826054743424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7691318826054743424==--
