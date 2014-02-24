From: =?ISO-8859-1?Q?Philippe_R=E9tornaz?= <philippe.retornaz@epfl.ch>
Subject: Re: [PATCH 07/11] ASoC: mc13783: Use
	SOC_ENUM_SINGLE_VIRT_DECL()
Date: Mon, 24 Feb 2014 15:28:41 +0100
Message-ID: <530B5719.8000507@epfl.ch>
References: <1393168221-23018-1-git-send-email-lars@metafoo.de>
 <1393168221-23018-8-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.epfl.ch (smtp4.epfl.ch [128.178.224.219])
 by alsa0.perex.cz (Postfix) with ESMTP id 176D326555A
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 15:28:44 +0100 (CET)
In-Reply-To: <1393168221-23018-8-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Jerry Wong <jerry.wong@maximintegrated.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Le 23/02/2014 16:10, Lars-Peter Clausen a =E9crit :
> For the upcoming consolidation for MUXs and virtual MUXs we need to mark =
virtual
> enums as such.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Tested on mx31moboard, no regression.

Thanks,

Philippe


> ---
>   sound/soc/codecs/mc13783.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
> index c605036..ec89b8f 100644
> --- a/sound/soc/codecs/mc13783.c
> +++ b/sound/soc/codecs/mc13783.c
> @@ -408,8 +408,7 @@ static const char * const adcl_enum_text[] =3D {
>   	"MC1L", "RXINL",
>   };
>
> -static SOC_ENUM_SINGLE_DECL(adcl_enum,
> -			    0, 0, adcl_enum_text);
> +static SOC_ENUM_SINGLE_VIRT_DECL(adcl_enum, adcl_enum_text);
>
>   static const struct snd_kcontrol_new left_input_mux =3D
>   	SOC_DAPM_ENUM_VIRT("Route", adcl_enum);
> @@ -418,8 +417,7 @@ static const char * const adcr_enum_text[] =3D {
>   	"MC1R", "MC2", "RXINR", "TXIN",
>   };
>
> -static SOC_ENUM_SINGLE_DECL(adcr_enum,
> -			    0, 0, adcr_enum_text);
> +static SOC_ENUM_SINGLE_VIRT_DECL(adcr_enum, adcr_enum_text);
>
>   static const struct snd_kcontrol_new right_input_mux =3D
>   	SOC_DAPM_ENUM_VIRT("Route", adcr_enum);
>
