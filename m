From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v1] ASoC: Intel: kbl_da7219_max98927: fix the audio jack
 button remapping
Date: Fri, 7 Dec 2018 11:57:13 -0600
Message-ID: <90b46425-5dbd-2ba7-d57d-270d0ab68632@linux.intel.com>
References: <20181207090552.105205-1-zhuohao@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181207090552.105205-1-zhuohao@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Zhuohao Lee <zhuohao@chromium.org>, alsa-devel@alsa-project.org
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vkoul@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Dan Carpenter <dan.carpenter@oracle.com>, Max Chang <changmax@chromium.org>, Oder Chiou <oder_chiou@realtek.com>, linux-kernel@vger.kernel.org, "Zhi, Yong" <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org


On 12/7/18 3:05 AM, Zhuohao Lee wrote:
>  From the da7219 spec, the button A, B, C and D are remapped to
> 0, 1, 2 and 3 respectively where button A is KEY_PLAYPAUSE,
> B is KEY_VOLUMEUP, C is KEY_VOLUMEDOWN and D is KEY_VOICECOMMAND

Ok, but could fix all da7219-based machine drivers then, the mappings 
are completely inconsistent:

kbl_da7219_max98357a.c:    snd_jack_set_key(jack->jack, SND_JACK_BTN_0, 
KEY_MEDIA);
kbl_da7219_max98357a.c:    snd_jack_set_key(jack->jack, SND_JACK_BTN_1, 
KEY_VOLUMEUP);
kbl_da7219_max98357a.c:    snd_jack_set_key(jack->jack, SND_JACK_BTN_2, 
KEY_VOLUMEDOWN);
kbl_da7219_max98357a.c:    snd_jack_set_key(jack->jack, SND_JACK_BTN_3, 
KEY_VOICECOMMAND);
kbl_da7219_max98927.c:    snd_jack_set_key(jack->jack, SND_JACK_BTN_0, 
KEY_PLAYPAUSE);
kbl_da7219_max98927.c:    snd_jack_set_key(jack->jack, SND_JACK_BTN_1, 
KEY_VOICECOMMAND);
kbl_da7219_max98927.c:    snd_jack_set_key(jack->jack, SND_JACK_BTN_2, 
KEY_VOLUMEUP);
kbl_da7219_max98927.c:    snd_jack_set_key(jack->jack, SND_JACK_BTN_3, 
KEY_VOLUMEDOWN);

Thanks!

>
> Change-Id: I67f929f226883bd289cb7beb0a7b23f40e7121e2
You want to remove those Change-Ids for upstream.
> Signed-off-by: Zhuohao Lee <zhuohao@chromium.org>
> Signed-off-by: Max Chang  <changmax@chromium.org>
> ---
>   sound/soc/intel/boards/kbl_da7219_max98927.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/intel/boards/kbl_da7219_max98927.c b/sound/soc/intel/boards/kbl_da7219_max98927.c
> index 3fa1c3ca6d37..d3531f0eb357 100644
> --- a/sound/soc/intel/boards/kbl_da7219_max98927.c
> +++ b/sound/soc/intel/boards/kbl_da7219_max98927.c
> @@ -262,9 +262,9 @@ static int kabylake_da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
>   
>   	jack = &ctx->kabylake_headset;
>   	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
> -	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
> -	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
> -	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
> +	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
> +	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEDOWN);
> +	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOICECOMMAND);
>   
>   	da7219_aad_jack_det(component, &ctx->kabylake_headset);
>   
