From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH RFT] ASoC: cs42l56: Fix new value argument
 in snd_soc_update_bits calls
Date: Thu, 22 May 2014 12:56:54 -0500
Message-ID: <alpine.DEB.2.02.1405221248370.10781@heelrod>
References: <1400033616.10054.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0238.outbound.protection.outlook.com [207.46.163.238])
 by alsa0.perex.cz (Postfix) with ESMTP id 31737265613
 for <alsa-devel@alsa-project.org>; Thu, 22 May 2014 19:55:25 +0200 (CEST)
In-Reply-To: <1400033616.10054.2.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 13 May 2014, Axel Lin wrote:

>
> The new value argument needs proper shift to match the mask bit fields.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> Hi Brian,
> This patch replaces
> [PATCH RFT] ASoC: cs42l56: Fix update mute register bits in cs42l56_digital_mute.
> I just found more places of snd_soc_update_bits calls needs fix.
> Regards,
> Axel
> sound/soc/codecs/cs42l56.c | 71 ++++++++++++++++++----------------------------
> sound/soc/codecs/cs42l56.h | 14 ++++-----
> 2 files changed, 35 insertions(+), 50 deletions(-)
>
> diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
> index 5bb134b..c0be526 100644
> --- a/sound/soc/codecs/cs42l56.c
> +++ b/sound/soc/codecs/cs42l56.c
> {
> 	struct snd_soc_codec *codec = dai->codec;
> +	unsigned int mask;
>
> 	if (mute) {
> 		/* Hit the DSP Mixer first */
> -		snd_soc_update_bits(codec, CS42L56_DSP_MUTE_CTL,
> -				    CS42L56_ADCAMIX_MUTE_MASK |
> -				CS42L56_ADCBMIX_MUTE_MASK |
> -				CS42L56_PCMAMIX_MUTE_MASK |
> -				CS42L56_PCMBMIX_MUTE_MASK |
> -				CS42L56_MSTB_MUTE_MASK |
> -				CS42L56_MSTA_MUTE_MASK,
> -				CS42L56_MUTE);
> +		mask = CS42L56_ADCAMIX_MUTE_MASK | CS42L56_ADCBMIX_MUTE_MASK |
> +		       CS42L56_PCMAMIX_MUTE_MASK | CS42L56_PCMBMIX_MUTE_MASK |
> +		       CS42L56_MSTB_MUTE_MASK | CS42L56_MSTA_MUTE_MASK;
> +		snd_soc_update_bits(codec, CS42L56_DSP_MUTE_CTL, mask, mask);
> +

I see where my MUTE is not actually doing what I want and since this is 
for just .digital_mute, I would rather just declare a MUTE_ALL define 
instead of adding variables to the function

> 		snd_soc_update_bits(codec, CS42L56_LOB_VOLUME,
> -				CS42L56_LO_MUTE_MASK,
> -				CS42L56_MUTE);
> +				    CS42L56_LO_MUTE_MASK, CS42L56_LO_MUTE_MASK);

Yes, this is my fault for not understanding this correctly. I don't like 
it and think odd you have to do it like this BTW.

>
>
> 	} else {
> -		snd_soc_update_bits(codec, CS42L56_DSP_MUTE_CTL,
> -				    CS42L56_ADCAMIX_MUTE_MASK |
> -				CS42L56_ADCBMIX_MUTE_MASK |
> -				CS42L56_PCMAMIX_MUTE_MASK |
> -				CS42L56_PCMBMIX_MUTE_MASK |
> -				CS42L56_MSTB_MUTE_MASK |
> -				CS42L56_MSTA_MUTE_MASK,
> -				CS42L56_UNMUTE);
> -		snd_soc_update_bits(codec, CS42L56_MISC_ADC_CTL,
> -				CS42L56_ADCA_MUTE_MASK |
> -				CS42L56_ADCB_MUTE_MASK,
> -				CS42L56_UNMUTE);

This should work fine.

> -				CS42L56_UNMUTE);
> +				    CS42L56_LO_MUTE_MASK, 0);
What is the difference here? Consistency?

> 	}
> 	return 0;
> }
> diff --git a/sound/soc/codecs/cs42l56.h b/sound/soc/codecs/cs42l56.h
> index ad2b50a..d2f68c6 100644
> --- a/sound/soc/codecs/cs42l56.h
> +++ b/sound/soc/codecs/cs42l56.h
> @@ -80,19 +80,21 @@
> #define CS42L56_PDN_HPB_MASK		0xc0
>
> /* serial port and clk masks */
> -#define CS42L56_MASTER_MODE		1
> -#define CS42L56_SLAVE_MODE		0
> +#define CS42L56_MASTER_MODE		(1 << 6)
> +#define CS42L56_SLAVE_MODE		(0 << 6)
> #define CS42L56_MS_MODE_MASK		0x40
> -#define CS42L56_SCLK_INV		1
> +#define CS42L56_SCLK_INV		(1 << 5)
> #define CS42L56_SCLK_INV_MASK		0x20
> #define CS42L56_SCLK_MCLK_MASK		0x18
> +#define CS42L56_MCLK_PREDIV		(1 << 6)
Your way off on this one. It is the third bit in the register

In general for myself I am trying to get away from the "shift" defines and 
use something more meaningful with just a value. I have not tested yet as 
I just got back into the office. This is just a quick look which is way 
overdue. My appologies.

I will test to verify the rest on Monday hopefully but as is there are 
errors that have to be corrected.

Thanks!
Brian
