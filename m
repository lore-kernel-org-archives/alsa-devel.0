From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [Xen-devel] [PATCH] ALSA: xen-front: freeing an
	error pointer
Date: Wed, 30 May 2018 14:14:58 +0300
Message-ID: <588658f1-520f-be06-3ad5-9b97e3f8e866@gmail.com>
References: <20180530103655.bnjzq2jpfrjjwvvj@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f68.google.com (mail-lf0-f68.google.com
 [209.85.215.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B82B2676DC
 for <alsa-devel@alsa-project.org>; Wed, 30 May 2018 13:15:01 +0200 (CEST)
Received: by mail-lf0-f68.google.com with SMTP id n18-v6so3656202lfh.10
 for <alsa-devel@alsa-project.org>; Wed, 30 May 2018 04:15:00 -0700 (PDT)
In-Reply-To: <20180530103655.bnjzq2jpfrjjwvvj@kili.mountain>
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
To: Dan Carpenter <dan.carpenter@oracle.com>, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Cc: xen-devel@lists.xenproject.org, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On 05/30/2018 01:36 PM, Dan Carpenter wrote:
> kfree() doesn't accept error pointers so I've set "str" to NULL on these
> paths.
>
> Fixes: fd3b36045c2c ("ALSA: xen-front: Read sound driver configuration from Xen store")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/sound/xen/xen_snd_front_cfg.c b/sound/xen/xen_snd_front_cfg.c
> index 38c7e1eefbb9..68dcd7d1f09e 100644
> --- a/sound/xen/xen_snd_front_cfg.c
> +++ b/sound/xen/xen_snd_front_cfg.c
> @@ -306,6 +306,7 @@ static int cfg_get_stream_type(const char *path, int index,
>   	str = xenbus_read(XBT_NIL, stream_path, XENSND_FIELD_TYPE, NULL);
>   	if (IS_ERR(str)) {
>   		ret = PTR_ERR(str);
> +		str = NULL;
>   		goto fail;
>   	}
>   
> @@ -347,6 +348,7 @@ static int cfg_stream(struct xen_snd_front_info *front_info,
>   	str = xenbus_read(XBT_NIL, stream_path, XENSND_FIELD_TYPE, NULL);
>   	if (IS_ERR(str)) {
>   		ret = PTR_ERR(str);
> +		str = NULL;
>   		goto fail;
>   	}
>   
>
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xenproject.org
> https://lists.xenproject.org/mailman/listinfo/xen-devel
Thank you for your patch,
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
