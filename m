From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [PATCH] ALSA: xen: ensure nul-terminated device
	name
Date: Tue, 29 May 2018 08:48:51 +0300
Message-ID: <2469af3f-df85-fbca-a486-566f9aaa436d@gmail.com>
References: <20180528160011.2989632-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f196.google.com (mail-wr0-f196.google.com
 [209.85.128.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 8333A267172
 for <alsa-devel@alsa-project.org>; Tue, 29 May 2018 07:48:54 +0200 (CEST)
Received: by mail-wr0-f196.google.com with SMTP id u12-v6so23252177wrn.8
 for <alsa-devel@alsa-project.org>; Mon, 28 May 2018 22:48:54 -0700 (PDT)
In-Reply-To: <20180528160011.2989632-1-arnd@arndb.de>
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
To: Arnd Bergmann <arnd@arndb.de>, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: xen-devel@lists.xenproject.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 05/28/2018 06:59 PM, Arnd Bergmann wrote:
> gcc-8 warns that pcm_instance->name is not necessarily terminated correctly
> if the input is more than 80 characters long or lacks a termination byte
> itself:
>
> In function 'strncpy',
>      inlined from 'cfg_device' at sound/xen/xen_snd_front_cfg.c:399:3,
>      inlined from 'xen_snd_front_cfg_card' at sound/xen/xen_snd_front_cfg.c:509:9:
> include/linux/string.h:254:9: error: '__builtin_strncpy' specified bound 80 equals destination size [-Werror=stringop-truncation]
>    return __builtin_strncpy(p, q, size);
>
> Using strlcpy() instead of strncpy() makes this a bit safer.
>
> Fixes: fd3b36045c2c ("ALSA: xen-front: Read sound driver configuration from Xen store")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   sound/xen/xen_snd_front_cfg.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/xen/xen_snd_front_cfg.c b/sound/xen/xen_snd_front_cfg.c
> index 38c7e1eefbb9..684b5f1d51ac 100644
> --- a/sound/xen/xen_snd_front_cfg.c
> +++ b/sound/xen/xen_snd_front_cfg.c
> @@ -396,7 +396,7 @@ static int cfg_device(struct xen_snd_front_info *front_info,
>   
>   	str = xenbus_read(XBT_NIL, device_path, XENSND_FIELD_DEVICE_NAME, NULL);
>   	if (!IS_ERR(str)) {
> -		strncpy(pcm_instance->name, str, sizeof(pcm_instance->name));
> +		strlcpy(pcm_instance->name, str, sizeof(pcm_instance->name));
>   		kfree(str);
>   	}
>   
Thank you for your patch,
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
