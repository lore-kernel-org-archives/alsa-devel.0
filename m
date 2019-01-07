From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt298: Variable "val" and "buf" in
 rt298_jack_detect() could be uninitialized
Date: Mon, 7 Jan 2019 16:28:44 +0000
Message-ID: <20190107162844.GK9570@sirena.org.uk>
References: <20190104215253.16278-1-yzhai003@ucr.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8528655444901359375=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C5C62665E5
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 17:28:59 +0100 (CET)
In-Reply-To: <20190104215253.16278-1-yzhai003@ucr.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yizhuo <yzhai003@ucr.edu>
Cc: csong@cs.ucr.edu, Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, zhiyunq@cs.ucr.edu, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============8528655444901359375==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IJAclU0AInkryoed"
Content-Disposition: inline


--IJAclU0AInkryoed
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 04, 2019 at 01:52:53PM -0800, Yizhuo wrote:

>  {
>  	struct snd_soc_dapm_context *dapm;
>  	unsigned int val, buf;
> +	int ret = 0;

It's bad practice to just initailize like this without a reason - it
tends to just mask actual cases where we miss error handling by ensuring
that it's always initialized.

>  			if (0x0070 == (val & 0x0070)) {
>  				*mic = true;
>  			} else {
>  				regmap_update_bits(rt298->regmap,
>  					RT298_CBJ_CTRL1, 0xfcc0, 0xe400);
>  				msleep(300);
> -				regmap_read(rt298->regmap,
> +				ret = regmap_read(rt298->regmap,
>  					RT298_CBJ_CTRL2, &val);
> +				if (ret)
> +					return ret;

We've started doing some writes to the device (which you've not added
checks for) here but then if the read fails we just bomb out with an
error code - are you sure that none of the writes need to be reverted?

--IJAclU0AInkryoed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwzfjsACgkQJNaLcl1U
h9B8ZAf/crhqUm6mmOd0Zu21moCGdovWEr4Dks4ovW6tH+i8R8DPPlFwFrrwqoUC
AmfutDFZo0Ee87LDb6olzsVWECeXWeQpuv4DyKz+nmpnjUSqbZ0Vqgc0abSTHY8b
9PY/xrggQsOYc4vsW+/1NpmkZ/ATsaQ8zzNJyX0H4Ywt/BPTSoT7R8PGGxo//gC1
1LN7TgNgWxa/tHknt8d6tvDCfW1miFApieGEmPyZSpDoUY1qfceMvdkD+2gX80wF
P+ZwDvKykq6kGNH2/nVYPc8pErH/ADtMmHR3fpOlKEcG3Rv7I3iiboPmevqyJVZl
Ml8x0GeaTZMAsvhfdKEFRKFTo+5JRg==
=tyXZ
-----END PGP SIGNATURE-----

--IJAclU0AInkryoed--

--===============8528655444901359375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8528655444901359375==--
