From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ASoC: es8316: limit headphone mixer volume
Date: Sun, 25 Aug 2019 19:38:15 +0200
Message-ID: <943932bf-2042-2a69-c705-b8e090e96377@redhat.com>
References: <20190824210426.16218-1-katsuhiro@katsuster.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190824210426.16218-1-katsuhiro@katsuster.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Katsuhiro Suzuki <katsuhiro@katsuster.net>, Mark Brown <broonie@kernel.org>, David Yang <yangxiaohua@everest-semi.com>, Daniel Drake <drake@endlessm.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 24-08-19 23:04, Katsuhiro Suzuki wrote:
> This patch limits Headphone mixer volume to 4 from 7.
> Because output sound suddenly becomes very loudly with many noise if
> set volume over 4.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>

Higher then 4 not working matches my experience, see this comment from
the UCM file: alsa-lib/src/conf/ucm/codecs/es8316/EnableSeq.conf :

# Set HP mixer vol to -6 dB (4/7) louder does not work
cset "name='Headphone Mixer Volume' 4"

Limiting this to the actual working range at the kernel level seems
sensible:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   sound/soc/codecs/es8316.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
> index 8dfb5dbeebbf..bc4141e1eb7f 100644
> --- a/sound/soc/codecs/es8316.c
> +++ b/sound/soc/codecs/es8316.c
> @@ -91,7 +91,7 @@ static const struct snd_kcontrol_new es8316_snd_controls[] = {
>   	SOC_DOUBLE_TLV("Headphone Playback Volume", ES8316_CPHP_ICAL_VOL,
>   		       4, 0, 3, 1, hpout_vol_tlv),
>   	SOC_DOUBLE_TLV("Headphone Mixer Volume", ES8316_HPMIX_VOL,
> -		       0, 4, 7, 0, hpmixer_gain_tlv),
> +		       0, 4, 4, 0, hpmixer_gain_tlv),
>   
>   	SOC_ENUM("Playback Polarity", dacpol),
>   	SOC_DOUBLE_R_TLV("DAC Playback Volume", ES8316_DAC_VOLL,
> 
