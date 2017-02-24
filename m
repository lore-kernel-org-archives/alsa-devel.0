From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH] ASoC: atmel-classd: fix audio clock rate
Date: Fri, 24 Feb 2017 11:33:28 +0100
Message-ID: <1c43cc9a-162b-b4c4-ed97-5eb1476ddc4f@microchip.com>
References: <20170224071043.25522-1-songjun.wu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170224071043.25522-1-songjun.wu@microchip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Songjun Wu <songjun.wu@microchip.com>, broonie@kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

Le 24/02/2017 =E0 08:10, Songjun Wu a =E9crit :
> Fix the audio clock rate according to the datasheet.
> =

> Reported-by: Dushara Jayasinghe <dushara@successful.com.au>
> Signed-off-by: Songjun Wu <songjun.wu@microchip.com>

Yes, for sure ;-)

But with these tags:
Fixes: e0a25b6d1862 ("ASoC: atmel-classd: add the Audio Class D Amplifier")
Cc: <stable@vger.kernel.org> # 4.4+

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks!

> ---
> =

>  sound/soc/atmel/atmel-classd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/sound/soc/atmel/atmel-classd.c b/sound/soc/atmel/atmel-class=
d.c
> index 89ac5f5a93eb..7ae46c2647d4 100644
> --- a/sound/soc/atmel/atmel-classd.c
> +++ b/sound/soc/atmel/atmel-classd.c
> @@ -349,7 +349,7 @@ static int atmel_classd_codec_dai_digital_mute(struct=
 snd_soc_dai *codec_dai,
>  }
>  =

>  #define CLASSD_ACLK_RATE_11M2896_MPY_8 (112896 * 100 * 8)
> -#define CLASSD_ACLK_RATE_12M288_MPY_8  (12228 * 1000 * 8)
> +#define CLASSD_ACLK_RATE_12M288_MPY_8  (12288 * 1000 * 8)
>  =

>  static struct {
>  	int rate;
> =



-- =

Nicolas Ferre
