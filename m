From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/3] ASoC: twl4030: Remove embedded
 snd_soc_codec structs from private data structs
Date: Tue, 6 Aug 2013 16:20:41 +0300
Message-ID: <5200F829.9070209@ti.com>
References: <1375789171-12098-1-git-send-email-lars@metafoo.de>
 <1375789171-12098-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id A4B03260896
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 15:20:13 +0200 (CEST)
In-Reply-To: <1375789171-12098-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 08/06/2013 02:39 PM, Lars-Peter Clausen wrote:
> It is unused and a leftover of the pre multi-component era.
> =

> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
>  sound/soc/codecs/twl4030.c | 2 --
>  1 file changed, 2 deletions(-)
> =

> diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
> index 8e6e5b0..1e3884d 100644
> --- a/sound/soc/codecs/twl4030.c
> +++ b/sound/soc/codecs/twl4030.c
> @@ -137,8 +137,6 @@ static const u8 twl4030_reg[TWL4030_CACHEREGNUM] =3D {
>  =

>  /* codec private data */
>  struct twl4030_priv {
> -	struct snd_soc_codec codec;
> -
>  	unsigned int codec_powered;
>  =

>  	/* reference counts of AIF/APLL users */
> =



-- =

P=E9ter
