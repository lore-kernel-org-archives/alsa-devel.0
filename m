From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 27/42] ASoC: tpa6130a2: Replace
 TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
Date: Mon, 3 Aug 2015 16:38:38 +0300
Message-ID: <55BF6EDE.1090508@ti.com>
References: <1438528810-23498-1-git-send-email-lars@metafoo.de>
 <1438528810-23498-28-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 045B2260668
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2015 15:38:47 +0200 (CEST)
In-Reply-To: <1438528810-23498-28-git-send-email-lars@metafoo.de>
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

> =

> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  sound/soc/codecs/tpa6130a2.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> =

> diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
> index 265c4c3..11d85c5 100644
> --- a/sound/soc/codecs/tpa6130a2.c
> +++ b/sound/soc/codecs/tpa6130a2.c
> @@ -259,8 +259,7 @@ static int tpa6130a2_put_volsw(struct snd_kcontrol *k=
control,
>   * TPA6130 volume. From -59.5 to 4 dB with increasing step size when goi=
ng
>   * down in gain.
>   */
> -static const unsigned int tpa6130_tlv[] =3D {
> -	TLV_DB_RANGE_HEAD(10),
> +static const DECLARE_TLV_DB_RANGE(tpa6130_tlv,
>  	0, 1, TLV_DB_SCALE_ITEM(-5950, 600, 0),
>  	2, 3, TLV_DB_SCALE_ITEM(-5000, 250, 0),
>  	4, 5, TLV_DB_SCALE_ITEM(-4550, 160, 0),
> @@ -270,8 +269,8 @@ static const unsigned int tpa6130_tlv[] =3D {
>  	12, 13, TLV_DB_SCALE_ITEM(-3040, 180, 0),
>  	14, 20, TLV_DB_SCALE_ITEM(-2710, 110, 0),
>  	21, 37, TLV_DB_SCALE_ITEM(-1960, 74, 0),
> -	38, 63, TLV_DB_SCALE_ITEM(-720, 45, 0),
> -};
> +	38, 63, TLV_DB_SCALE_ITEM(-720, 45, 0)
> +);
>  =

>  static const struct snd_kcontrol_new tpa6130a2_controls[] =3D {
>  	SOC_SINGLE_EXT_TLV("TPA6130A2 Headphone Playback Volume",
> @@ -280,12 +279,11 @@ static const struct snd_kcontrol_new tpa6130a2_cont=
rols[] =3D {
>  		       tpa6130_tlv),
>  };
>  =

> -static const unsigned int tpa6140_tlv[] =3D {
> -	TLV_DB_RANGE_HEAD(3),
> +static const DECLARE_TLV_DB_RANGE(tpa6140_tlv,
>  	0, 8, TLV_DB_SCALE_ITEM(-5900, 400, 0),
>  	9, 16, TLV_DB_SCALE_ITEM(-2500, 200, 0),
> -	17, 31, TLV_DB_SCALE_ITEM(-1000, 100, 0),
> -};
> +	17, 31, TLV_DB_SCALE_ITEM(-1000, 100, 0)
> +);
>  =

>  static const struct snd_kcontrol_new tpa6140a2_controls[] =3D {
>  	SOC_SINGLE_EXT_TLV("TPA6140A2 Headphone Playback Volume",
> =



-- =

P=E9ter
