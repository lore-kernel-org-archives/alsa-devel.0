From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 5/7] S3C AUDIO: Add header to pass platform
	data to	device drivers
Date: Mon, 16 Nov 2009 10:49:41 +0000
Message-ID: <20091116104941.GW23772@trinity.fluff.org>
References: <1257914722-4507-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from trinity.fluff.org (trinity.fluff.org [89.16.178.74])
	by alsa0.perex.cz (Postfix) with ESMTP id ED8F8244E4
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 11:49:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1257914722-4507-1-git-send-email-jassi.brar@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassi.brar@samsung.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 11, 2009 at 01:45:22PM +0900, Jassi Brar wrote:

Please put something here! Even if it just a slightly expanded version
of the patch title.

> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>

This could be merged to the alsa tree, we can move it once the other
changes are made.

> ---
>  arch/arm/plat-s3c/include/plat/audio.h |   17 +++++++++++++++++
>  1 files changed, 17 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-s3c/include/plat/audio.h
> 
> diff --git a/arch/arm/plat-s3c/include/plat/audio.h b/arch/arm/plat-s3c/include/plat/audio.h
> new file mode 100644
> index 0000000..f22d23b
> --- /dev/null
> +++ b/arch/arm/plat-s3c/include/plat/audio.h
> @@ -0,0 +1,17 @@
> +/* arch/arm/plat-s3c/include/plat/audio.h
> + *
> + * Copyright (c) 2009 Samsung Electronics Co. Ltd
> + * Author: Jaswinder Singh <jassi.brar@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/**
> + * struct s3c_audio_pdata - common platform data for audio device drivers
> + * @cfg_gpio: Callback function to setup mux'ed pins in I2S/PCM/AC97 mode
> + */
> +struct s3c_audio_pdata {
> +	int (*cfg_gpio)(struct platform_device *);
> +};
> -- 
> 1.6.2.5
> 

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
