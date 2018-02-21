From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 06/11] ASoC: rt5651: Improve headphone vs
 headset detection
Date: Wed, 21 Feb 2018 12:05:57 +0000
Message-ID: <20180221120557.GE8334@sirena.org.uk>
References: <20180220221511.22861-1-hdegoede@redhat.com>
 <20180220221511.22861-6-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2990219876326880257=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C5AA926756F
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 13:06:04 +0100 (CET)
In-Reply-To: <20180220221511.22861-6-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============2990219876326880257==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d8Lz2Tf5e5STOWUP"
Content-Disposition: inline


--d8Lz2Tf5e5STOWUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 20, 2018 at 11:15:06PM +0100, Hans de Goede wrote:

> This commit ports my work to make this reliable on the rt5640 over to the
> rt5651, making the following OVCD changes, each of which has been tested
> individually and each of which has shown to be necessary on the rt5651:

It's a big rewrite everything commit :(

> +/*
> + * Note we do not toggle the RT5651_MIC1_OVCD_EN bit in these 2 functions,
> + * to ensure reliable OVCD operation it *must* be enabled before enabling
> + * the supplies, which may already be enabled.
> + */
> +static void rt5651_enable_micbias1_ovcd(struct snd_soc_codec *codec)
> +{

I'm finding this comment pretty confusing - it would probably be clearer
if it said something like "since the supplies may also be enabled by
other DAPM operations we toggle the bit in $PLACE instead and only make
sure the supplies are enabled here".

> +static bool rt5651_jack_inserted(struct snd_soc_codec *codec)
> +{

BTW all these changes are in terms of snd_soc_codec not
snd_soc_component, we're trying to move everytihng up a level so that
all devices are components.  A bunch of refactoring went in just after
the merge window doing that.

--d8Lz2Tf5e5STOWUP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqNYKQACgkQJNaLcl1U
h9A5rQf/TTDYORB9b56k+Wa/vk1F77z2HFPxyaqrWanDxSnDoJSXWRv+vfm5oa3X
uub2un45Jp1kZWTzxgu5D+AzPBa5vT6ziPoHmsooI1LZD9+Z+GL1j6mFwbBWelBm
yHQQ9Nq3KtQteFbBmvfVvRqEZ7Mvz1S3iAoPs0qYrBZBvFTTRG2ELLcsTmpRbyMK
KEWIq2d66p1Nu7nAo1bMf7jFqonrWNA9R5n9XX7Ny16K4y99NwX3l2NAf/ZQ8O4Q
7udtUueqJl28rh8WDZMiUtEq43izd100o1Sr112k0EnEhUNP4EFzX6AsTrfidrHJ
FX9NUBZln4pdar+GkMrZqHvrzskBJA==
=pxhU
-----END PGP SIGNATURE-----

--d8Lz2Tf5e5STOWUP--

--===============2990219876326880257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2990219876326880257==--
