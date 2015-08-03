From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 28/42] ASoC: twl4030: Replace
 TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
Date: Mon, 3 Aug 2015 16:38:54 +0300
Message-ID: <55BF6EEE.2090400@ti.com>
References: <1438528810-23498-1-git-send-email-lars@metafoo.de>
 <1438528810-23498-29-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 2299E265328
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2015 15:39:01 +0200 (CEST)
In-Reply-To: <1438528810-23498-29-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Brian Austin <brian.austin@cirrus.com>, Support Opensource <support.opensource@diasemi.com>, Anish Kumar <yesanishhere@gmail.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 08/02/2015 06:19 PM, Lars-Peter Clausen wrote:
> DECLARE_TLV_DB_RANGE() has the advantage over using TLV_DB_RANGE_HEAD()
> that it automatically calculates the number of items in the TLV and is
> hence less prone to manual error.
> =

> Generate using the following coccinelle script
> =

> // <smpl>
> @@
> declarer name DECLARE_TLV_DB_RANGE;
> identifier tlv;
> constant x;
> @@
> -unsigned int tlv[] =3D {
> -	TLV_DB_RANGE_HEAD(x),
> +DECLARE_TLV_DB_RANGE(tlv,
> 	...
> -};
> +);
> // </smpl>

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  sound/soc/codecs/twl4030.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> =

> diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
> index 90f5f04..2713e18 100644
> --- a/sound/soc/codecs/twl4030.c
> +++ b/sound/soc/codecs/twl4030.c
> @@ -524,12 +524,11 @@ static const struct snd_kcontrol_new twl4030_dapm_a=
bypassv_control =3D
>  	SOC_DAPM_SINGLE("Switch", TWL4030_REG_VDL_APGA_CTL, 2, 1, 0);
>  =

>  /* Digital bypass gain, mute instead of -30dB */
> -static const unsigned int twl4030_dapm_dbypass_tlv[] =3D {
> -	TLV_DB_RANGE_HEAD(3),
> +static const DECLARE_TLV_DB_RANGE(twl4030_dapm_dbypass_tlv,
>  	0, 1, TLV_DB_SCALE_ITEM(-3000, 600, 1),
>  	2, 3, TLV_DB_SCALE_ITEM(-2400, 0, 0),
> -	4, 7, TLV_DB_SCALE_ITEM(-1800, 600, 0),
> -};
> +	4, 7, TLV_DB_SCALE_ITEM(-1800, 600, 0)
> +);
>  =

>  /* Digital bypass left (TX1L -> RX2L) */
>  static const struct snd_kcontrol_new twl4030_dapm_dbypassl_control =3D
> =



-- =

P=E9ter
