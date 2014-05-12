From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH RFT] ASoC: cs42l56: Fix update mute
 register bits in cs42l56_digital_mute
Date: Mon, 12 May 2014 10:39:05 +0000
Message-ID: <535FAC8F-81B6-4779-A299-6F027AA96031@cirrus.com>
References: <1399883619.5926.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0183.outbound.protection.outlook.com [207.46.163.183])
 by alsa0.perex.cz (Postfix) with ESMTP id ABCAB26164D
 for <alsa-devel@alsa-project.org>; Mon, 12 May 2014 12:39:56 +0200 (CEST)
In-Reply-To: <1399883619.5926.2.camel@phoenix>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Handrigan, Paul" <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org



> On May 12, 2014, at 17:33, "Axel Lin" <axel.lin@ingics.com> wrote:
> 
> The new value in snd_soc_update_bits() needs to match the mask bit fields.
> Use CS42L56_MUTE/CS42L56_UNMUTE only works when the mask is 0x01.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> For example,
> *Both* below calls actually *clear* CS42L56_LO_MUTE_MASK bit (0x80).
> 
> snd_soc_update_bits(codec, CS42L56_LOB_VOLUME, CS42L56_LO_MUTE_MASK, CS42L56_MUTE);
> snd_soc_update_bits(codec, CS42L56_LOB_VOLUME, CS42L56_LO_MUTE_MASK, CS42L56_UNMUTE);
> 
> So I think use CS42L56_UNMUTE/CS42L56_MUTE is not good here.
> 
> Hi Brian,
> I don't have this h/w, so this patch needs test.
> I'd appreciate if you can review and test this patch.
> 
> Regards,
> Axel
I am traveling this week but will gladly test as soon as I get back.

Thanks


> sound/soc/codecs/cs42l56.c | 65 ++++++++++++++++++----------------------------
> sound/soc/codecs/cs42l56.h |  2 --
> 2 files changed, 25 insertions(+), 42 deletions(-)
> 
> diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
> index 5bb134b..ecb2fed 100644
> --- a/sound/soc/codecs/cs42l56.c
> +++ b/sound/soc/codecs/cs42l56.c
> @@ -839,62 +839,47 @@ static int cs42l56_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
> static int cs42l56_digital_mute(struct snd_soc_dai *dai, int mute)
> {
>    struct snd_soc_codec *codec = dai->codec;
> +    unsigned int mask;
> 
>    if (mute) {
>        /* Hit the DSP Mixer first */
> -        snd_soc_update_bits(codec, CS42L56_DSP_MUTE_CTL,
> -                    CS42L56_ADCAMIX_MUTE_MASK |
> -                CS42L56_ADCBMIX_MUTE_MASK |
> -                CS42L56_PCMAMIX_MUTE_MASK |
> -                CS42L56_PCMBMIX_MUTE_MASK |
> -                CS42L56_MSTB_MUTE_MASK |
> -                CS42L56_MSTA_MUTE_MASK,
> -                CS42L56_MUTE);
> +        mask = CS42L56_ADCAMIX_MUTE_MASK | CS42L56_ADCBMIX_MUTE_MASK |
> +               CS42L56_PCMAMIX_MUTE_MASK | CS42L56_PCMBMIX_MUTE_MASK |
> +               CS42L56_MSTB_MUTE_MASK | CS42L56_MSTA_MUTE_MASK;
> +        snd_soc_update_bits(codec, CS42L56_DSP_MUTE_CTL, mask, mask);
> +
>        /* Mute ADC's */
> -        snd_soc_update_bits(codec, CS42L56_MISC_ADC_CTL,
> -                CS42L56_ADCA_MUTE_MASK |
> -                CS42L56_ADCB_MUTE_MASK,
> -                CS42L56_MUTE);
> +        mask = CS42L56_ADCA_MUTE_MASK | CS42L56_ADCB_MUTE_MASK;
> +        snd_soc_update_bits(codec, CS42L56_MISC_ADC_CTL, mask, mask);
> +
>        /* HP And LO */
>        snd_soc_update_bits(codec, CS42L56_HPA_VOLUME,
> -                CS42L56_HP_MUTE_MASK,
> -                CS42L56_MUTE);
> +                    CS42L56_HP_MUTE_MASK, CS42L56_HP_MUTE_MASK);
>        snd_soc_update_bits(codec, CS42L56_HPB_VOLUME,
> -                CS42L56_HP_MUTE_MASK,
> -                CS42L56_MUTE);
> +                    CS42L56_HP_MUTE_MASK, CS42L56_HP_MUTE_MASK);
>        snd_soc_update_bits(codec, CS42L56_LOA_VOLUME,
> -                CS42L56_LO_MUTE_MASK,
> -                CS42L56_MUTE);
> +                    CS42L56_LO_MUTE_MASK, CS42L56_LO_MUTE_MASK);
>        snd_soc_update_bits(codec, CS42L56_LOB_VOLUME,
> -                CS42L56_LO_MUTE_MASK,
> -                CS42L56_MUTE);
> +                    CS42L56_LO_MUTE_MASK, CS42L56_LO_MUTE_MASK);
> 
> 
>    } else {
> -        snd_soc_update_bits(codec, CS42L56_DSP_MUTE_CTL,
> -                    CS42L56_ADCAMIX_MUTE_MASK |
> -                CS42L56_ADCBMIX_MUTE_MASK |
> -                CS42L56_PCMAMIX_MUTE_MASK |
> -                CS42L56_PCMBMIX_MUTE_MASK |
> -                CS42L56_MSTB_MUTE_MASK |
> -                CS42L56_MSTA_MUTE_MASK,
> -                CS42L56_UNMUTE);
> -        snd_soc_update_bits(codec, CS42L56_MISC_ADC_CTL,
> -                CS42L56_ADCA_MUTE_MASK |
> -                CS42L56_ADCB_MUTE_MASK,
> -                CS42L56_UNMUTE);
> +        mask = CS42L56_ADCAMIX_MUTE_MASK | CS42L56_ADCBMIX_MUTE_MASK |
> +               CS42L56_PCMAMIX_MUTE_MASK | CS42L56_PCMBMIX_MUTE_MASK |
> +               CS42L56_MSTB_MUTE_MASK | CS42L56_MSTA_MUTE_MASK;
> +        snd_soc_update_bits(codec, CS42L56_DSP_MUTE_CTL, mask , 0);
> +
> +        mask = CS42L56_ADCA_MUTE_MASK | CS42L56_ADCB_MUTE_MASK;
> +        snd_soc_update_bits(codec, CS42L56_MISC_ADC_CTL, mask, 0);
> +
>        snd_soc_update_bits(codec, CS42L56_HPA_VOLUME,
> -                CS42L56_HP_MUTE_MASK,
> -                CS42L56_UNMUTE);
> +                    CS42L56_HP_MUTE_MASK, 0);
>        snd_soc_update_bits(codec, CS42L56_HPB_VOLUME,
> -                CS42L56_HP_MUTE_MASK,
> -                CS42L56_UNMUTE);
> +                    CS42L56_HP_MUTE_MASK, 0);
>        snd_soc_update_bits(codec, CS42L56_LOA_VOLUME,
> -                CS42L56_LO_MUTE_MASK,
> -                CS42L56_UNMUTE);
> +                    CS42L56_LO_MUTE_MASK, 0);
>        snd_soc_update_bits(codec, CS42L56_LOB_VOLUME,
> -                CS42L56_LO_MUTE_MASK,
> -                CS42L56_UNMUTE);
> +                    CS42L56_LO_MUTE_MASK, 0);
>    }
>    return 0;
> }
> diff --git a/sound/soc/codecs/cs42l56.h b/sound/soc/codecs/cs42l56.h
> index ad2b50a..4997587 100644
> --- a/sound/soc/codecs/cs42l56.h
> +++ b/sound/soc/codecs/cs42l56.h
> @@ -116,8 +116,6 @@
> #define CS42L56_DEEMPH_MASK        0x40
> #define CS42L56_PLYBCK_GANG_MASK    0x10
> #define CS42L56_PCM_INV_MASK        0x0c
> -#define CS42L56_MUTE            1
> -#define CS42L56_UNMUTE            0
> #define CS42L56_ADCAMIX_MUTE_MASK    0x40
> #define CS42L56_ADCBMIX_MUTE_MASK    0x80
> #define CS42L56_PCMAMIX_MUTE_MASK    0x10
> -- 
> 1.8.3.2
> 
> 
> 
