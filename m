From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5616: add rt5616 codec driver
Date: Sat, 19 Dec 2015 12:01:33 +0000
Message-ID: <20151219120133.GJ5727@sirena.org.uk>
References: <1450162661-23186-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5401443156943123912=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C2C4A26044E
 for <alsa-devel@alsa-project.org>; Sat, 19 Dec 2015 13:01:51 +0100 (CET)
In-Reply-To: <1450162661-23186-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, zhengxing@rock-chips.com, lgirdwood@gmail.com, john.lin@realtek.com, zhengsq@rock-chips.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============5401443156943123912==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TDAnSvu4oNjXIbzm"
Content-Disposition: inline


--TDAnSvu4oNjXIbzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 15, 2015 at 02:57:41PM +0800, Bard Liao wrote:

A couple of very minor issues with the control names here but otherwise
this looks good - I'll apply this, please send followup patches fixing
these:

> +	/* IN1/IN2 Control */
> +	SOC_SINGLE_TLV("IN1 Boost", RT5616_IN1_IN2,
> +		RT5616_BST_SFT1, 8, 0, bst_tlv),
> +	SOC_SINGLE_TLV("IN2 Boost", RT5616_IN1_IN2,
> +		RT5616_BST_SFT2, 8, 0, bst_tlv),

These should be " Boost Volume".

> +	/* ADC Boost Volume Control */
> +	SOC_DOUBLE_TLV("ADC Boost Gain", RT5616_ADC_BST_VOL,
> +			RT5616_ADC_L_BST_SFT, RT5616_ADC_R_BST_SFT,
> +			3, 0, adc_bst_tlv),

Boost Volume (like the comments says!).

--TDAnSvu4oNjXIbzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWdUccAAoJECTWi3JdVIfQXKsH/2uVhCO6Ljjud66LDVKNHdFE
unvMtlAh6JnegSsDuaWEpXM4xbiV+GVjw7whUdWmmKt+E6our5GsziK/pDp1uKb2
sapVwz88JHVU1iRaEeeU26tDyJErSKjQd3l4NXFREg2bMxKfZiA33jch3G3TpL7L
1c4qpCRv4Z5bZZh/phcjI+oIqZqqRCPCtc2jowCxrL2PfQ+8MT5mgrUa05/W0LL3
TQ6IJGcV0JbvyETilHlJqT47zlFekZmpq6lF3UC8g/xaZ6IoXIaQJtpfSnWCib7d
W70K3OVo+com3cEYFCX3JJXvnf3kCUXCgSXe81MNFfBts/v9/rIVyPCcv1D9+a8=
=fHMb
-----END PGP SIGNATURE-----

--TDAnSvu4oNjXIbzm--

--===============5401443156943123912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5401443156943123912==--
