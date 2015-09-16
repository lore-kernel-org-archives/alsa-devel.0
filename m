From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] ASoC: wm5110: Add additional analogue
 input enable for early revs
Date: Wed, 16 Sep 2015 21:02:00 +0100
Message-ID: <20150916200159.GV12027@sirena.org.uk>
References: <1442408383-31682-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1442408383-31682-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0147518640470145999=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 229E22616EF
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2015 22:02:05 +0200 (CEST)
In-Reply-To: <1442408383-31682-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0147518640470145999==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HFuJZczTr8zDHu18"
Content-Disposition: inline


--HFuJZczTr8zDHu18
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 16, 2015 at 01:59:43PM +0100, Charles Keepax wrote:

> +static int wm5110_in_pga_get(struct snd_kcontrol *kcontrol,
> +			     struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
> +	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
> +	struct snd_soc_card *card = dapm->card;
> +	int ret;
> +
> +	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
> +
> +	ret = snd_soc_get_volsw_range(kcontrol, ucontrol);
> +
> +	mutex_unlock(&card->dapm_mutex);

Can we please have a comment explaining why we need the lock (I see why
but someone reading the code in the future might not)?

--HFuJZczTr8zDHu18
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV+cq3AAoJECTWi3JdVIfQqDIIAIKFpI9afMI5q64PMvReg1HV
N6i6KbjMBPh98zc83j+UempLkEiVuAikQSyZh3aaFjJurC/aGVQK0Dz3UbVzC+SY
ix10/oyZ8L789U0V61rHKjq3ncAy/hY7YQwO/5zZ666C3gIVfb4XE+D8OmhCjdyJ
vJ2z3AEvHlZu46rf/2MJuB2uCkoXnS4vmmsHwwPFPptkct1jzEFcFvfpFSvfmkgN
YThkhGwXaScng+ofyN9zQSyV6F3F/DWzJpTNvI8e2n63JsLPiAn7KnPPEWvmHSQe
FAMcZ6jnnnhk3FgGmzof9FtEXHE+Jmnljau8hYme1l28+l0XMRR1bS9lTOycAAA=
=vWsu
-----END PGP SIGNATURE-----

--HFuJZczTr8zDHu18--

--===============0147518640470145999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0147518640470145999==--
