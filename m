From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: kbl_da7219_max98357a: Map
 BTN_0 to KEY_PLAYPAUSE
Date: Thu, 2 May 2019 11:14:47 -0500
Message-ID: <4755e1e0-ffb4-66b7-4f72-63aad8d258cd@linux.intel.com>
References: <1556777524-7437-1-git-send-email-mac.chiang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 96E56F80722
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2019 18:14:50 +0200 (CEST)
In-Reply-To: <1556777524-7437-1-git-send-email-mac.chiang@intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "mac.chiang@intel.com--cc=pierre-louis.bossart"@linux.intel.com, alsa-devel@alsa-project.org
Cc: mac.chiang@intel.com, broonie@kernel.org, chintan.m.patel@intel.com
List-Id: alsa-devel@alsa-project.org




> From: Mac Chiang <mac.chiang@intel.com>
> 
> On kbl_rt5663_max98927, commit 38a5882e4292
>      ("ASoC: Intel: kbl_rt5663_max98927: Map BTN_0 to KEY_PLAYPAUSE")
>      This key pair mapping to play/pause when playing Youtube
> 
> The Android 3.5mm Headset jack specification mentions that BTN_0 should
> be mapped to KEY_MEDIA, but this is less logical than KEY_PLAYPAUSE,
> which has much broader userspace support.
> 
> For example, the Chrome OS userspace now supports KEY_PLAYPAUSE to toggle
> play/pause of videos and audio, but does not handle KEY_MEDIA.
> 
> Furthermore, Android itself now supports KEY_PLAYPAUSE equivalently, as the
> new USB headset spec requires KEY_PLAYPAUSE for BTN_0.
> https://source.android.com/devices/accessories/headset/usb-headset-spec
> 
> The same fix is required on Chrome kbl_da7219_max98357a.
> 
> Signed-off-by: Mac Chiang <mac.chiang@intel.com>
> Reviewed-by: Benson Leung <bleung@chromium.org>
> Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Mark, to be clear it's a resend of a patch initially submitted in 2018, 
see https://patchwork.kernel.org/patch/10493135/

> ---
>   sound/soc/intel/boards/kbl_da7219_max98357a.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/kbl_da7219_max98357a.c b/sound/soc/intel/boards/kbl_da7219_max98357a.c
> index 38f6ab7..07491a0 100644
> --- a/sound/soc/intel/boards/kbl_da7219_max98357a.c
> +++ b/sound/soc/intel/boards/kbl_da7219_max98357a.c
> @@ -188,7 +188,7 @@ static int kabylake_da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
>   
>   	jack = &ctx->kabylake_headset;
>   
> -	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_MEDIA);
> +	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
>   	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
>   	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEDOWN);
>   	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOICECOMMAND);
> 
