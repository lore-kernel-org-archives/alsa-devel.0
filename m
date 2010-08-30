From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: fsi: modify compile error
Date: Mon, 30 Aug 2010 15:35:09 +0100
Message-ID: <1283178909.3055.118.camel@odin>
References: <w3ppqx0jpbk.wl%kuninori.morimoto.gx@renesas.com>
	<w3pocckjpa7.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E98C10385C
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Aug 2010 16:35:11 +0200 (CEST)
Received: by wyb32 with SMTP id 32so6472421wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 30 Aug 2010 07:35:11 -0700 (PDT)
In-Reply-To: <w3pocckjpa7.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-08-30 at 19:40 +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  include/sound/sh_fsi.h |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/include/sound/sh_fsi.h b/include/sound/sh_fsi.h
> index 3fd6456..fa60cbd 100644
> --- a/include/sound/sh_fsi.h
> +++ b/include/sound/sh_fsi.h
> @@ -114,7 +114,4 @@ struct sh_fsi_platform_info {
>  	int (*set_rate)(int is_porta, int rate); /* for master mode */
>  };
>  
> -extern struct snd_soc_dai_driver fsi_soc_dai[2];
> -extern struct snd_soc_platform_driver fsi_soc_platform;
> -
>  #endif /* __SOUND_FSI_H */

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
