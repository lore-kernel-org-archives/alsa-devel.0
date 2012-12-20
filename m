From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH RFT] ASoC: sta529: Fix update register bits
	in sta529_set_dai_fmt
Date: Thu, 20 Dec 2012 15:47:38 +0530
Message-ID: <50D2E5C2.3010306@st.com>
References: <1355991445.11688.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog114.obsmtp.com (eu1sys200aog114.obsmtp.com
 [207.126.144.137])
 by alsa0.perex.cz (Postfix) with ESMTP id DAD1C2651A8
 for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2012 11:17:46 +0100 (CET)
In-Reply-To: <1355991445.11688.2.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hello Axel,

On 12/20/2012 1:47 PM, Axel Lin wrote:
> Both the mask and mode settings are wrong in current code.
>
> According to the datasheet:
>
> S2PCFG0 (0x0A)
> BIT[3:1] DATA_FORMAT
>          serial interface protocol format:
>          000: left Justified
>          001: I2S (default)
>          010: right justified
>          100: PCM no delay
>          101: PCM delay
>          111: DSP
>
> Thus fixes the defines for LEFT_J_DATA_FORMAT, I2S_DATA_FORMAT, and
> RIGHT_J_DATA_FORMAT.
> Also adds define for DATA_FORMAT_MSK.
>
> Signed-off-by: Axel Lin<axel.lin@ingics.com>
> ---
> Hi Rajeev,
> I don't have this hardware, can you test this patch?

Thanks for pointing it out. I have tested it and is working fine.

Acked-By: Rajeev Kumar <rajeev-dlh.kumar@st.com>

> Thanks,
> Axel
>   sound/soc/codecs/sta529.c |    9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/codecs/sta529.c b/sound/soc/codecs/sta529.c
> index ab355c4..40c07be 100644
> --- a/sound/soc/codecs/sta529.c
> +++ b/sound/soc/codecs/sta529.c
> @@ -74,9 +74,10 @@
>   				SNDRV_PCM_FMTBIT_S32_LE)
>   #define	S2PC_VALUE		0x98
>   #define CLOCK_OUT		0x60
> -#define LEFT_J_DATA_FORMAT	0x10
> -#define I2S_DATA_FORMAT		0x12
> -#define RIGHT_J_DATA_FORMAT	0x14
> +#define DATA_FORMAT_MSK		0x0E
> +#define LEFT_J_DATA_FORMAT	0x00
> +#define I2S_DATA_FORMAT		0x02
> +#define RIGHT_J_DATA_FORMAT	0x04


>   #define CODEC_MUTE_VAL		0x80
>
>   #define POWER_CNTLMSAK		0x40
> @@ -289,7 +290,7 @@ static int sta529_set_dai_fmt(struct snd_soc_dai *codec_dai, u32 fmt)
>   		return -EINVAL;
>   	}
>
> -	snd_soc_update_bits(codec, STA529_S2PCFG0, 0x0D, mode);
> +	snd_soc_update_bits(codec, STA529_S2PCFG0, DATA_FORMAT_MSK, mode);
>
>   	return 0;
>   }
