From: valdis.kletnieks@vt.edu
Subject: Re: [PATCH 11/11] ASoC: wm8994: Mark expected switch fall-through
Date: Fri, 03 Aug 2018 12:26:49 -0400
Message-ID: <30613.1533313609@turing-police.cc.vt.edu>
References: <cover.1533151956.git.gustavo@embeddedor.com>
 <8e3df79b1dca92d49fd9d5c97391d31814ab40f9.1533151956.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1533313609_3353P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8e3df79b1dca92d49fd9d5c97391d31814ab40f9.1533151956.git.gustavo@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

--==_Exmh_1533313609_3353P
Content-Type: text/plain; charset=us-ascii

On Wed, 01 Aug 2018 14:56:16 -0500, "Gustavo A. R. Silva" said:

> diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
> index 7fdfdf3..62f8c5b 100644
> --- a/sound/soc/codecs/wm8994.c
> +++ b/sound/soc/codecs/wm8994.c
> @@ -2432,6 +2432,7 @@ static int wm8994_set_dai_sysclk(struct snd_soc_dai *dai,
>  			snd_soc_component_update_bits(component, WM8994_POWER_MANAGEMENT_2,
>  					    WM8994_OPCLK_ENA, 0);
>  		}
> +		/* fall through */
>
>  	default:
>  		return -EINVAL;

Wait, what? This looks like the sort of bug -Wimplicit-fallthrough is supposed
to catch.  Unless for 'case WM8994_SYSCLK_OPCLK:' we actually do want to do a
whole bunch of snd_soc_component_update_bits() calls and then return -EINVAL
whether or not that case succeeded?



--==_Exmh_1533313609_3353P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBW2SCSY0DS38y7CIcAQLkVAgAnBZwfgNeHjXkgKpbmkH97cvtiknlB8cM
XzXz8o32fyAfDSWNJFRaymMPigJ0+PnyiEqX0Tcr9dMcwBOzLEBkvVC2BWxNkD80
KwnnE6hJfT/oVg4Ugn6UFboqkqTHMeu3np5WysjFH++2l53Zp0MxNWpZAV/qYo+4
31eysJLdoWVgspMESFkMu9wJyBiM2sNRHu1dDUM95CfgmLnQVUAfNhmhdg+JQTJu
RTLdNrTcxbV47Dac3giaatfk0cTjJ7b8Qp+N9r7EQlucvcQzsemgvI/8YMo96e89
l1FtSzU0VtZyYk5CDXLKs4OXNSVaojXyfIFfp5jojFhYmDetDoSl3A==
=x0wR
-----END PGP SIGNATURE-----

--==_Exmh_1533313609_3353P--
