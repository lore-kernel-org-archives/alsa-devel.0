From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/7] ASoC: dapm: Move error handling to
 snd_soc_dapm_new_control_unlocked
Date: Tue, 28 Aug 2018 19:28:26 +0100
Message-ID: <20180828182826.GH2414@sirena.org.uk>
References: <20180828133508.13012-1-ckeepax@opensource.cirrus.com>
 <20180828133508.13012-3-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7950494670619578052=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A92F8267741
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 20:28:36 +0200 (CEST)
In-Reply-To: <20180828133508.13012-3-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7950494670619578052==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4B4+7MsODflw+h2f"
Content-Disposition: inline


--4B4+7MsODflw+h2f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 28, 2018 at 02:35:04PM +0100, Charles Keepax wrote:
> Currently DAPM has almost identical code to handle errors from
> snd_soc_dapm_new_control_unlocked in many places. Centralise
> this handling within snd_soc_dapm_new_control_unlocked and
> remove the duplicated error reporting. This also has the fringe
> benefit of removing a lot of error messages that would have
> been printed on the -ENOMEM paths.

This changelog doesn't entirely match up with the change:

>  			}
> -			if (!data->widget) {
> -				ret = -ENOMEM;
> -				goto err_data;
> -			}
>  		}

and

>  	w = snd_soc_dapm_new_control_unlocked(dapm, widget);
> -	/* Do not nag about probe deferrals */
> -	if (IS_ERR(w)) {
> -		int ret = PTR_ERR(w);
> -
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(dapm->dev,
> -				"ASoC: Failed to create DAPM control %s (%d)\n",
> -				widget->name, ret);
> -		goto out_unlock;
> -	}
> -	if (!w)
> -		dev_err(dapm->dev,
> -			"ASoC: Failed to create DAPM control %s\n",
> -			widget->name);
> -
> -out_unlock:
>  	mutex_unlock(&dapm->card->dapm_mutex);
> +
>  	return w;

are not obviously identical.

--4B4+7MsODflw+h2f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluFlEoACgkQJNaLcl1U
h9C28Qf/W9ezgjNpUOwvrC2knsK9maYvxC9B80D3bmJOubm3JgITN3PGPvuX5JoE
lb/6elJAb8l2qVoKhS5QhL9Urhj15Y4ECxU4bwk4zYyYrBMElQqIaDlU2NPIdG4u
z+nNYtJgZTXU9Xf4X4ROPd7LZ284AQGDvWoTjpo0PnwA/e1yDakEbOChN0FuVPaD
4c21BAqmNvlUkOTm0Uu7WHDGyI1DMdYEfFPb3GKbZE/FL0n64vuJ8y1p/WQTrMZk
FOx/+l/L0lIck9QEXkwsS7ETwJA2a0JWDcMQwNTIL92j+JW7bQ6WhSNJEffX90s4
K5BivHlhPVO0lyIAvQbjFyXSi8gi3Q==
=N8Z9
-----END PGP SIGNATURE-----

--4B4+7MsODflw+h2f--

--===============7950494670619578052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7950494670619578052==--
