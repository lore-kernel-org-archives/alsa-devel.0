From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 020/102] ASoC: isabelle: Fix the wrong
 number of items in enum ctls
Date: Thu, 20 Feb 2014 01:53:57 +0900
Message-ID: <20140219165357.GD2669@sirena.org.uk>
References: <1392723422-12689-1-git-send-email-tiwai@suse.de>
 <1392723422-12689-5-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3124435360063875598=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 176B826536C
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 00:20:41 +0100 (CET)
In-Reply-To: <1392723422-12689-5-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3124435360063875598==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z6MHCWJTg2o7o0PI"
Content-Disposition: inline


--Z6MHCWJTg2o7o0PI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:36:55PM +0100, Takashi Iwai wrote:
> isabelle codec driver has a few places wrongly defining the number of
> enum items.

Applied, thanks.

> Use SOC_ENUM_SINGLE_DECL() macro and they are automatically fixed.

There's also these other fixes not using that:

>  static const struct soc_enum isabelle_rx1_enum[] = {
> -	SOC_ENUM_SINGLE(ISABELLE_VOICE_HPF_CFG_REG, 3, 1, isabelle_rx1_texts),
> -	SOC_ENUM_SINGLE(ISABELLE_AUDIO_HPF_CFG_REG, 5, 1, isabelle_rx1_texts),
> +	SOC_ENUM_SINGLE(ISABELLE_VOICE_HPF_CFG_REG, 3,
> +			ARRAY_SIZE(isabelle_rx1_texts), isabelle_rx1_texts),
> +	SOC_ENUM_SINGLE(ISABELLE_AUDIO_HPF_CFG_REG, 5,
> +			ARRAY_SIZE(isabelle_rx1_texts), isabelle_rx1_texts),

but they're fine of course.

--Z6MHCWJTg2o7o0PI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBOGhAAoJELSic+t+oim9Ke8P/1CzuTMD16XgsSQgbvID8qYl
xpWafGk9PuFc+PiC21qIVIgAXCxyjfYUqOt8pHuLSbuQAYEqW4u/jyjD+ig1+Ch9
fzLz+aFYhbE3zmOiprSLN+GF7+hMayaNU3dTHQrb7+i6XHz5qVBLZXw/tJamovXX
TaVcMhhdr0n2aQOGlfpe4NxhJko9TVfhkaCgJ62gMKmucxtixdONCwaaHof8x7Sz
TKpcFDWxygB2lyA4b6pFupHMm+qCpCzwJjGBTOIWwQjNGgDTeKquilpfGZjP8OB9
vUKWDXjye7nZ5S9Wv55T9JRj+lfNh2f1RyzUSJyyXWr7SMOenEVGD57qyzptwiGY
HJgRnG2tsb2rPtq51R1rOrzT+N1u8/n4RLXoy4gsfamUpfaRAD9B9Fbe/V8cHfnB
f573yHxth1iHfEEGaNW/JDoR55Wx0ku3MmsAm9my8XVrq7wy91H3xUvpbPY1+gI5
+v0KEWDZUQppa6f12buFe5y7elbuMzGHhNiARFeResYAyz4IFHn52ijBkeR5isMj
2VEo3/mQV0FC77up7b6SRkXBFFiTUdiJRH1CtgLl65gYSe55F+YSyog7teff3d8f
VNoN4o9TuMBMsk77vAm5YOVlce4ZkGKjYXnm6UtYi7xOqiR5ZbFj8mV47dL6YnLM
w/9D0UHMupF54j+1zOEe
=5W6P
-----END PGP SIGNATURE-----

--Z6MHCWJTg2o7o0PI--

--===============3124435360063875598==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3124435360063875598==--
