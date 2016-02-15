From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 4/4] ASoC: Change soc-card codec_conf array
	to a list
Date: Mon, 15 Feb 2016 17:11:08 +0000
Message-ID: <20160215171108.GP18988@sirena.org.uk>
References: <1455538772-24926-1-git-send-email-vaibhav.agarwal@linaro.org>
 <1455538772-24926-5-git-send-email-vaibhav.agarwal@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0362967514892516190=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 906A42606A5
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 18:11:13 +0100 (CET)
In-Reply-To: <1455538772-24926-5-git-send-email-vaibhav.agarwal@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vaibhav Agarwal <vaibhav.agarwal@linaro.org>
Cc: peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, vinod.koul@intel.com, mengdong.lin@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============0362967514892516190==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QKpLca3blcvhMJ0W"
Content-Disposition: inline


--QKpLca3blcvhMJ0W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 15, 2016 at 05:49:32PM +0530, Vaibhav Agarwal wrote:

> +void snd_soc_add_codec_config(struct snd_soc_card *card,
> +			      struct snd_soc_codec_conf *codec_conf)
> +{
> +	mutex_lock(&client_mutex);
> +	list_add_tail(&codec_conf->list, &card->codec_conf_list);
> +	mutex_unlock(&client_mutex);
> +}

We add a configuration but we don't act on it?  That's surprising...  I
don't really have a sense of how in concrete terms this interface is
intended to work.

> +EXPORT_SYMBOL(snd_soc_add_codec_config);

All ASoC APIs are _GPL.

> +	/* add predefined codec_configs to the list */
> +	for (i = 0; i < card->num_configs; i++)
> +		snd_soc_add_codec_config(card, card->codec_conf+i);
> +

Coding style.

--QKpLca3blcvhMJ0W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWwgarAAoJECTWi3JdVIfQ5q0H/02ohIKLHPmmQt3Z3bWUFf1q
JZ8+JNMRHh8rqWYHVhhem+uegt069Zh6a5YCAtTab6sOa4pnIqjZnAsZ00kyo/2N
1qgrxX8ESA1+7QGQK7ljFzvyKtU6pUdbGwvOXQOYYVVXDI1uER0QNxP6xBRLuQ0l
RHSZziRzIAwy0KjpCjVDjjwwrSW4oITGSA1x5cl6mK+u8XUb0mDOQHqmItQ2MzFW
16OL8VKdaoUJmsyDD+5HdwRgaOzx6an205IhjJwDT84EIUJQ+IzQRLrNozbZXcNY
gTeKJftqTnPwNJjEvPnho8sJEj3CmOEQ+7xx/6rtZma+4GQUfFCgWznwziKnkz8=
=cj9h
-----END PGP SIGNATURE-----

--QKpLca3blcvhMJ0W--

--===============0362967514892516190==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0362967514892516190==--
