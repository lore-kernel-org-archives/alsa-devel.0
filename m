From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5645: Adds push button support
	for rt5650
Date: Mon, 20 Apr 2015 21:41:14 +0100
Message-ID: <20150420204114.GI14892@sirena.org.uk>
References: <1429497442-13021-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7905954008364483319=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D9214260654
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 22:41:23 +0200 (CEST)
In-Reply-To: <1429497442-13021-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, zhengxing@rock-chips.com, yang.a.fang@intel.com, lgirdwood@gmail.com, john.lin@realtek.com, koro.chen@mediatek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============7905954008364483319==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y0Ed1hDcWxc3B7cn"
Content-Disposition: inline


--y0Ed1hDcWxc3B7cn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 20, 2015 at 10:37:21AM +0800, Bard Liao wrote:

> --- a/sound/soc/codecs/rt5645.c
> +++ b/sound/soc/codecs/rt5645.c
> @@ -198,7 +198,6 @@ static const struct reg_default rt5645_reg[] = {
>  	{ 0xda, 0x0000 },
>  	{ 0xdb, 0x0003 },
>  	{ 0xdc, 0x0049 },
> -	{ 0xdd, 0x001b },
>  	{ 0xdf, 0x0008 },
>  	{ 0xe0, 0x4000 },
>  	{ 0xe6, 0x8000 },

That's a bit weird, why is this in here?

> +	if (rt5645->btn_jack && rt5645->codec_type == CODEC_TYPE_RT5650) {

Can we have a switch statement for the device type so it's easier to add
other devices if there's new derivatives please?

> +			btn_type = rt5645_button_detect(rt5645->codec);
> +			switch (btn_type) {
> +			case 0x8000:
> +			case 0x4000:
> +			case 0x2000:
> +				report |= SND_JACK_BTN_0;
> +				break;

Why do we mash all these values together?

--y0Ed1hDcWxc3B7cn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVNWRpAAoJECTWi3JdVIfQf/EH/2YRJf1WEr6c3jgskPyO67Qe
riSyzgYhacrqE02Qdc/MDLVjeuJmhwBcU+yAHOlE0Wp8QqFczvNb7mA/xP80Acg3
ZRJSDYmNkxirKyzVPrvtrwfPtI+DOA0xa/bVEP3ictCl5gVXc2HBlAoqWXIpwG4a
ZmjrS3VpI0d3XgOgQlmMZUxsCaxvjmgQZicKpXAP+Ygoq/b34LwN2BcmpBWZ7ogo
Sg1eLTICyPUagpM6fGSfsBPiQ6tih61MlvA5PhIX57vpYDmqZEV2Iz5ueWQXKcfq
zo5zTp9LtBgUORcKuzRov3ATbPMBDFXW4AVWw1OhFOqcbKFuUBBrAY+kOAzrdyA=
=//vO
-----END PGP SIGNATURE-----

--y0Ed1hDcWxc3B7cn--

--===============7905954008364483319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7905954008364483319==--
