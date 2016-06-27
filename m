From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 06/11] ASoC: dapm: Create API to add a single
	route element
Date: Mon, 27 Jun 2016 19:02:06 +0100
Message-ID: <20160627180206.GG17217@sirena.org.uk>
References: <1466999284-14782-1-git-send-email-subhransu.s.prusty@intel.com>
 <1466999284-14782-7-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6325595091205156876=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CE5FA2665BB
 for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2016 20:02:11 +0200 (CEST)
In-Reply-To: <1466999284-14782-7-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6325595091205156876==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bFsKbPszpzYNtEU6"
Content-Disposition: inline


--bFsKbPszpzYNtEU6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 27, 2016 at 09:17:59AM +0530, Subhransu S. Prusty wrote:

>  int snd_soc_dapm_add_routes(struct snd_soc_dapm_context *dapm,
>  			    const struct snd_soc_dapm_route *route, int num);
> +int snd_soc_dapm_add_route_single(struct snd_soc_dapm_context *dapm,
> +			    const struct snd_soc_dapm_route *route);

Just snd_soc_dapm_add_route() and rename the existing internal function.

--bFsKbPszpzYNtEU6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXcWocAAoJECTWi3JdVIfQKk4H/2X9oeDOtNHL3P2WL+ETHYzd
BGWrLJxLL/tCRiekohPf5Y8C1DqxHhYi1CAzL+/RpmKJg4YxbtqnKgn2mit74Bji
z6xZLWHLysM/IMvj3YirZNgkojYtoQvUtJ685W2PmnNiuHvl39AnneU++Hr8qE78
ATxbpf/JqoT7rLCq7aRvR2RHYqu11kXZp+p83HktK0fmGtDPQogiogpt/skkxkjZ
Na0kbCFfcpgLq2pSRW5cGO/KI356Y1UcOHc0mqAa81NY/LiIskdTB15gzmmglVJl
U/C79baJ3ZG0AAW5agMB5ybVLW6sJ5obQmXbxJQJBg5/yu7MYeWph/HDpBoXOhk=
=asbs
-----END PGP SIGNATURE-----

--bFsKbPszpzYNtEU6--

--===============6325595091205156876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6325595091205156876==--
