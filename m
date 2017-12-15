From: "Kumar, Abhijeet" <abhijeet.kumar@intel.com>
Subject: RE: [PATCH] ASoC: nau8825: fix issue that pop noise when start
 capture
Date: Fri, 15 Dec 2017 08:21:15 +0000
Message-ID: <60213CA7255C53479ADE3BCF0360117F02E60DAB@PGSMSX103.gar.corp.intel.com>
References: <1513019426-9623-1-git-send-email-abhijeet.kumar@intel.com>
 <5A3376E7.2080602@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5A3376E7.2080602@nuvoton.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Bhumika Goyal <bhumirks@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "anatol.pomozov@gmail.com" <anatol.pomozov@gmail.com>, "mhkuo@nuvoton.com" <mhkuo@nuvoton.com>, "wuchengli@google.com" <wuchengli@google.com>, "cychiang@google.com" <cychiang@google.com>, "Chiang, Mac" <mac.chiang@intel.com>, "YHCHuang@nuvoton.com" <YHCHuang@nuvoton.com>, "CTLIN0@nuvoton.com" <CTLIN0@nuvoton.com>, "WTLI@nuvoton.com" <WTLI@nuvoton.com>
List-Id: alsa-devel@alsa-project.org

Need some help on next steps 
Who will do the review and patch merge?
Should i add any other mailing list to this thread?


-----Original Message-----
From: John Hsu [mailto:KCHSU0@nuvoton.com] 
Sent: Friday, December 15, 2017 12:47 PM
To: Kumar, Abhijeet <abhijeet.kumar@intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>; Jaroslav Kysela <perex@perex.cz>; Takashi Iwai <tiwai@suse.com>; Bhumika Goyal <bhumirks@gmail.com>; alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org; anatol.pomozov@gmail.com; mhkuo@nuvoton.com; wuchengli@google.com; cychiang@google.com; Chiang, Mac <mac.chiang@intel.com>; YHCHuang@nuvoton.com; CTLIN0@nuvoton.com; WTLI@nuvoton.com
Subject: Re: [PATCH] ASoC: nau8825: fix issue that pop noise when start capture

On 12/12/2017 3:10 AM, abhijeet.kumar@intel.com wrote:
> From: Abhijeet Kumar <abhijeet.kumar@intel.com>
>
> In skylake platform, we hear a loud pop noise(0 dB) at start of audio 
> capture power up sequence. This patch removes the pop noise from the 
> recording by adding a delay before enabling ADC.
>
> Signed-off-by: Abhijeet Kumar <abhijeet.kumar@intel.com>
> ---
>  sound/soc/codecs/nau8825.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c 
> index 714ce17da717..e853a6dfd33b 100644
> --- a/sound/soc/codecs/nau8825.c
> +++ b/sound/soc/codecs/nau8825.c
> @@ -905,6 +905,7 @@ static int nau8825_adc_event(struct 
> snd_soc_dapm_widget *w,
>
>       switch (event) {
>       case SND_SOC_DAPM_POST_PMU:
> +             msleep(125);
>               regmap_update_bits(nau8825->regmap, NAU8825_REG_ENA_CTRL,
>                       NAU8825_ENABLE_ADC, NAU8825_ENABLE_ADC);
>               break;

The solution is fine for me. It's verified in my device and indeed helps to reduce the capture pop noise. I think the little delay is acceptable.



===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.
