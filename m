From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] OMAPDSS/ASoC: Relocate ASoC HDMI
	codec. Part 2
Date: Sun, 12 Feb 2012 13:20:38 +0000
Message-ID: <20120212132036.GC3395@opensource.wolfsonmicro.com>
References: <1329006197-28332-1-git-send-email-ricardo.neri@ti.com>
	<1329006197-28332-2-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3912231658229601511=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9F22F2417D
	for <alsa-devel@alsa-project.org>; Sun, 12 Feb 2012 14:20:41 +0100 (CET)
In-Reply-To: <1329006197-28332-2-git-send-email-ricardo.neri@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: x0055901@ti.com, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, tomi.valkeinen@ti.com, s-guiriec@ti.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============3912231658229601511==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Content-Disposition: inline


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 11, 2012 at 06:23:15PM -0600, Ricardo Neri wrote:

> The ASoC HDMI codec is to be relocated under sound/soc/codecs. This
> patch places the codec under ASoC. A previous patch removed the code
> from DSS. The purpose of the relocation is to give a more logical
> organization to OMAP HDMI code.

Looks pretty clean, a few things below but mostly fairly nitpicky.

>  sound/soc/codecs/omap-hdmi.c |  422 ++++++++++++++++++++++++++++++++++++++++++

If this is relocating the code shouldn't some old code be being deleted?

> +	switch (sample_freq) {
> +	case 32000:
> +		if ((deep_color == 125) && ((pclk == 54054)
> +				|| (pclk == 74250)))
> +			*n = 8192;
> +		else
> +			*n = 4096;

Use a switch on deep_color too (in all these cases).

> +
> +static int hdmi_audio_startup(struct snd_pcm_substream *substream,
> +				  struct snd_soc_dai *dai)
> +{
> +	if (omapdss_hdmi_get_hdmi_mode() != HDMI_HDMI) {
> +		pr_err("Current video settings do not support audio.\n");

dev_ prints please (throughout the driver).

> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (priv == NULL)
> +		return -ENOMEM;

Use devm_ functions for this and mapping the io region - that way you
don't have to worry about them when cleaning up and doing error
handling...

> +	hdmi_rsrc = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	if (!hdmi_rsrc) {
> +		dev_err(&pdev->dev, "Cannot obtain IORESOURCE_MEM HDMI\n");
> +		return -EINVAL;
> +	}

...like here :)  You should also move the allocation and mapping to the
platform device probe and only register the CODEC once you've got
everything else, this is more idiomatic for the Linux driver stack.

> +static struct snd_soc_dai_driver hdmi_codec_dai_drv = {
> +	.name = "hdmi-audio-codec",

Should proably have an omap- in here somewhere.

> +static int __init hdmi_codec_init(void)
> +{
> +	return platform_driver_register(&hdmi_codec_driver);
> +}
> +module_init(hdmi_codec_init);

module_platform_driver()

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPN7ydAAoJEBus8iNuMP3dPvIQAJUy0V9A0GlcfjCA6qKkGb0V
SH8g+XVfCpYC9nmV5JiQbrWI7I5nQpxob70aFnE8dcwkf4Qq0hg5jGbqupGKKYHQ
fqc/Et6T6xzLBSQ4P0QmCANzudOYSCv2/XkwUav1mkGoYiJHF7ThDGH+6zUwOYcQ
Nz/Cds0ER/rk4kAlDSATUEAz2TmySMDJQPw+ruhiT5CaKfXW/EfMhOVCCvVNsIOW
fx5FkdN+L61GtrvJOmBSAo4PQmjuPzIMCQl4GRXhcpgyoN5GDsdpnaQzp9QgLtcL
a0dgTGDbQmgkN9IuHEaqsMpMffm9R6Df5pJ/aWmrCx7h+MFt+8v1GD1PxoDsFZtw
8wbDWlKSazmzfEbSHTF/cMkD4yYgsQhu9e0fQwCpVMBlVLQpxEBfdCTt5iD5pkmH
4YIp7x2jGjfvnbW8y0MZ2bt73tl06vk84lv5cvJz9/mzXQ4pM9wLlrBsbgG0/KpE
tULJI4Va3zbXN3YJaajGf0PeH0ixbI1eB5jq7TdayGvwg9h+wsVEr629/Aqrzz5E
7+c390nWjyTUyYD25yTZMwiqtcE6WmTINUawSLvZ+PsBwqx0dGWzEIMsteN6go/l
NZJw9pN3zjkdRL1ww9S16i/Y3Dnyu5ieC+x134RV6h9JX0OAzQQnYFpknrcS41tV
Yz3vYvx47q1FgLC57j+i
=/aiE
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--

--===============3912231658229601511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3912231658229601511==--
