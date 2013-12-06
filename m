From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: fsl: imx-wm8962: Add headphone
 and microphone jack plugin/out detection
Date: Fri, 6 Dec 2013 14:42:56 +0000
Message-ID: <20131206144256.GI29268@sirena.org.uk>
References: <cover.1386322845.git.b42378@freescale.com>
 <82d3285b7efe1f98dbc3d9c0a423b2e5e454481f.1386322845.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0379890623021791730=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id BE9082655B2
 for <alsa-devel@alsa-project.org>; Fri,  6 Dec 2013 15:43:00 +0100 (CET)
In-Reply-To: <82d3285b7efe1f98dbc3d9c0a423b2e5e454481f.1386322845.git.b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, pawel.moll@arm.com, swarren@wwwdotorg.org, linux-doc@vger.kernel.org, tiwai@suse.de, ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, lgirdwood@gmail.com, rob@landley.net
List-Id: alsa-devel@alsa-project.org


--===============0379890623021791730==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0EphSjNCSB1asamE"
Content-Disposition: inline


--0EphSjNCSB1asamE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 06, 2013 at 05:48:23PM +0800, Nicolin Chen wrote:

> Therefore, this patch mainly adds jack event detection feature and switchs I/O
> routes accordingly. Meanwhile, for those monaural input cases, we also turn on
> the ADC monomix features of WM8962 if needed.

No, the kernel shouldn't be doing any route switching or other
configuration - that should be done by userspace.  This is a policy
decision, there are situations where for example audio should go to both
headphones and speaker when headphones are connected in order to make
sure notifications are audible even if headpones have been removed.

> +	if (hp_status != priv->hp_active_low) {
> +		snprintf(buf, 32, "STATE=%d", 2);
> +		snd_soc_dapm_disable_pin(&priv->codec->dapm, "Ext Spk");
> +		ret = imx_hp_jack_gpio.report;
> +	} else {
> +		snprintf(buf, 32, "STATE=%d", 0);
> +		snd_soc_dapm_enable_pin(&priv->codec->dapm, "Ext Spk");
> +		ret = 0;
> +	}
> +
> +	envp[0] = "NAME=headphone";
> +	envp[1] = buf;
> +	envp[2] = NULL;
> +	kobject_uevent_env(&pdev->dev.kobj, KOBJ_CHANGE, envp);

What's this uevent trying to do and why is it open coded in the driver?

--0EphSjNCSB1asamE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSoeJtAAoJELSic+t+oim9PrcP/jmzlN6zrUrkhIfryYC1RZuo
+w3T4BDY6eZRs0y0qC7QUC9K+Bcx4sX7g8ssIJzMUoEOF1RzlOs46/ttmgZHvuyw
L0w1qolcgJyf4TLrJQiTs7X1pI/ZMCUzogDNIlGIGhAVGn2JZ5X9pWsvXyzYBhNx
Lfh+PnVgTfW93KRlBwyQZkg5ewscrDQ2GPAXMnilPmUttIJT9CDBO3PTtzOGKwjK
Fuam3KQnkNaNtJP1pIL99iWhWZVdd3uU5nmS17/Cy9Wd6jE/efpt6AYDozeyLF8H
gNxodgNkA776vgSODFl3CcHgV+4CuNkp82LpXo6RzI2hf1RaDqCNkxup6f9W179O
ACfi6Bw5wYo3oRVjvNF5fZVpOCtaBBXoUZ46dabh2YRuyfAIlG2XE0jxQoaX4M2A
nULjE/YoYTipMrfHGxvpETS4K4WJ8FhFCeKxsRn3mGQijsEmMr53Ysn/I9LPxRiE
se71+SlFlyYdPKcqYT1cqFLJ5ii1U1EzKfo2JRMHyltLc8C6DiQNBSFK/DrbvQKV
EhP9PPUXOoq79vpmyuxV1Jnv+/eXz/5QMVkaxUJSCFhF3exDFeej6BBlKvw0KC1g
jIbY/mljSjbFYqaaxfT5Ww9q6gf3ByZrcdfjnoCzpwbHkLeRFmG8gTZbK8iNsjXI
0n1c0gKpk5eHMJL+2tbZ
=IEpg
-----END PGP SIGNATURE-----

--0EphSjNCSB1asamE--

--===============0379890623021791730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0379890623021791730==--
