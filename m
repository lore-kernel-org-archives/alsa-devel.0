From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/6] ASoC: samsung: smdk_wm8580: Remove old platforms and
 drop mach-types usage
Date: Sat, 19 Nov 2016 16:42:33 +0100
Message-ID: <8248c49a-1108-7fce-ed99-01653e11c670@metafoo.de>
References: <1479566911-5580-1-git-send-email-krzk@kernel.org>
 <1479566911-5580-3-git-send-email-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479566911-5580-3-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/19/2016 03:48 PM, Krzysztof Kozlowski wrote:
[...]
> @@ -206,15 +204,10 @@ static int __init smdk_audio_init(void)
>  	int ret;
>  	char *str;
>  
> -	if (machine_is_smdkc100()
> -			|| machine_is_smdkv210() || machine_is_smdkc110()) {
> -		smdk.num_links = 3;
> -	} else if (machine_is_smdk6410()) {
> -		str = (char *)smdk_dai[PRI_PLAYBACK].cpu_dai_name;
> -		str[strlen(str) - 1] = '2';
> -		str = (char *)smdk_dai[PRI_CAPTURE].cpu_dai_name;
> -		str[strlen(str) - 1] = '2';
> -	}
> +	str = (char *)smdk_dai[PRI_PLAYBACK].cpu_dai_name;
> +	str[strlen(str) - 1] = '2';
> +	str = (char *)smdk_dai[PRI_CAPTURE].cpu_dai_name;
> +	str[strlen(str) - 1] = '2';

This could be further simplified by just updating the initial cpu_dai_name
string in the dai_link struct.

Especially considering that the cpu_dai_name is a string literal and the ARM
kernel now has rodata write protection enabled by default, so modifying it
will crash the kernel.
