From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [alsa-devel] [PATCH 29/33] ALSA: oxfw: use match_string() helper
Date: Tue, 22 May 2018 07:26:53 +0900
Message-ID: <fc6c89ab-a8e7-72f8-3cd6-308f21e77995@sakamocchi.jp>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-30-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526903890-35761-30-git-send-email-xieyisheng1@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yisheng Xie <xieyisheng1@huawei.com>, linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On May 21 2018 20:58, Yisheng Xie wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.
> 
> Cc: Clemens Ladisch <clemens@ladisch.de>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>   sound/firewire/oxfw/oxfw.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

For my information, use_match_string() helper was firstly introduced to
v4.6 kernel by a commit 56b060814e2d ('lib/string: introduce 
match_string() helper').

> diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
> index 413ab63..1e5b2c8 100644
> --- a/sound/firewire/oxfw/oxfw.c
> +++ b/sound/firewire/oxfw/oxfw.c
> @@ -49,7 +49,6 @@ static bool detect_loud_models(struct fw_unit *unit)
>   		"Tapco LINK.firewire 4x6",
>   		"U.420"};
>   	char model[32];
> -	unsigned int i;
>   	int err;
>   
>   	err = fw_csr_string(unit->directory, CSR_MODEL,
> @@ -57,12 +56,7 @@ static bool detect_loud_models(struct fw_unit *unit)
>   	if (err < 0)
>   		return false;
>   
> -	for (i = 0; i < ARRAY_SIZE(models); i++) {
> -		if (strcmp(models[i], model) == 0)
> -			break;
> -	}
> -
> -	return (i < ARRAY_SIZE(models));
> +	return match_string(models, ARRAY_SIZE(models), model) >= 0;
>   }
>   
>   static int name_card(struct snd_oxfw *oxfw)

Thanks

Takashi Sakamoto
