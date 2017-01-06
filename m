From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 6/9] ASoC: Intel: Skylake: Add supply
 widget in bxt_da_max machine
Date: Fri, 6 Jan 2017 18:34:30 +0000
Message-ID: <20170106183430.zmjmabovpuz6vuhw@sirena.org.uk>
References: <1483341277-14475-1-git-send-email-jeeja.kp@intel.com>
 <1483341277-14475-7-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3456702735343666269=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BC115267812
 for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2017 19:34:36 +0100 (CET)
In-Reply-To: <1483341277-14475-7-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: jeeja.kp@intel.com
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============3456702735343666269==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q4blhruyw4yee64h"
Content-Disposition: inline


--q4blhruyw4yee64h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 02, 2017 at 12:44:33PM +0530, jeeja.kp@intel.com wrote:

> +static int ssp_set_clk(struct snd_soc_dapm_widget *w,
> +		struct snd_kcontrol *k, int  event)
> +{
> +	struct snd_soc_dai *cpu_dai = NULL;
> +
> +	cpu_dai = skl_get_dai_widget(w);
> +	if (!cpu_dai)
> +		return -EIO;
> +
> +	/* Enable/Disable the SSP clk */
> +	if (SND_SOC_DAPM_EVENT_ON(event))
> +		return snd_soc_dai_set_tristate(cpu_dai, 0);
> +	else
> +		return snd_soc_dai_set_tristate(cpu_dai, 1);
> +}

Erk, no - you definitely want to just move the whole thing to DAPM I
think.  We shoudn't be manually fiddling with the tristating from driver
code when the core will also try to manage tristating, at some point
this widget and the core will inevitably end up fighting with each
other.

--q4blhruyw4yee64h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhv4zUACgkQJNaLcl1U
h9Bu4Af9F5g46wtcdxaQNonKuXRyUiP2Duk6ANL/JqJIjzrBq7Z3KBSfoxraJQo6
cT6eXfqToD2EStzsYYQlR0TlcEz+ERip+Ltp1Sk4fISs3XD67XfqfAUb5YtnPCc5
/qRoBdJMWq0xDiuZVWnFX0n4QC+Tc8DiVaHJTuxiDjdEBDdxv7rlXKHab9tRFB8a
esnj/dFtzS8RhOLCKJHWnoXUi60XcmWq7XsP4sp1Me+bBDk1voMsI/zPqljWcy/f
remn7iZfvp95YyhjHRq+DQrBcGfnjs6YFbgJ5/kaQN54y/agf1CW1ZqHHdMj5523
KpIrdJ5gs5JQPygdsEFgtZVfcPSqNw==
=4imc
-----END PGP SIGNATURE-----

--q4blhruyw4yee64h--

--===============3456702735343666269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3456702735343666269==--
