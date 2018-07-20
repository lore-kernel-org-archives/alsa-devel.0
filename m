From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: AMD: Add a fix voltage regulator for
 DA7219 and ADAU7002
Date: Fri, 20 Jul 2018 13:18:16 +0100
Message-ID: <20180720121816.GD10784@sirena.org.uk>
References: <1532068715-2992-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2813769744762866919=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D3C9426772E
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2018 14:18:37 +0200 (CEST)
In-Reply-To: <1532068715-2992-1-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, djkurtz@chromium.org, Liam Girdwood <lgirdwood@gmail.com>, Wei Yongjun <weiyongjun1@huawei.com>, "Mukunda,
 Vijendar" <Vijendar.Mukunda@amd.com>, Alexander.Deucher@amd.com, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============2813769744762866919==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BI5RvnYi6R4T2M87"
Content-Disposition: inline


--BI5RvnYi6R4T2M87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 20, 2018 at 02:38:11PM +0800, Akshu Agrawal wrote:

>  static int cz_probe(struct platform_device *pdev)
>  {
>  	int ret;
>  	struct snd_soc_card *card;
>  	struct acp_platform_info *machine;
> +	static bool regulators_registered;
> +
> +	if (!regulators_registered) {
> +		ret = platform_device_register(&acp_da7219_regulator);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Failed to register regulator: %d\n",
> +				ret);
> +			return ret;
> +		}
> +		regulators_registered = true;
> +	}

You should be unregistering the regulator in your remove function, not
doing this hack here.  I'd also expect to see the card made the parent
of the device that gets registered.

--BI5RvnYi6R4T2M87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltR0wcACgkQJNaLcl1U
h9AbcAf9Fo9ThI5pEiQ3xKKD0YZk9HfxvxQMV9aGNR2pdVyXzGb4qsIc3Iudax1B
h4VIUfmGjPmA62O2Pw5PjSJ+yqb+gn6Rxy6KcXPgZ1b5hBavB0CHAqyD4SGKSZSf
Yn1i1HqYYWZ+ag0fYM3CIEKyQAV2vWRbOgWQadWsKj8qBUoVSFE7IvsKVDZtalxv
9hkCekoKBZcaeuby9ovPkIM5x7gMQfORmarUpbv5xzHai+yeNPl5BlGYVV1GyYoi
69F4PMy5PkV60tH4ALBAAYJMOSWdbLIWkoMivl+4yxCiuNEXBPsEifaXm/ZHqymU
nw9f8D0WNWeFz60XTZCCrTjcqxMkww==
=AQ8P
-----END PGP SIGNATURE-----

--BI5RvnYi6R4T2M87--

--===============2813769744762866919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2813769744762866919==--
