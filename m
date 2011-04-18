From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ALSA: add a module alias to the FSI driver
Date: Mon, 18 Apr 2011 09:55:55 +0100
Message-ID: <1303116955.3523.1.camel@odin>
References: <Pine.LNX.4.64.1104152015190.18593@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id AA5211037F2
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Apr 2011 10:55:59 +0200 (CEST)
Received: by wwf26 with SMTP id 26so4187419wwf.20
	for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2011 01:55:59 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1104152015190.18593@axis700.grange>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, Simon@alsa-project.org, linux-sh@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus Damm <damm@opensource.se>, Horman <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-04-15 at 20:17 +0200, Guennadi Liakhovetski wrote:
> This patch enables FSI driver autoloading on sh-mobile systems.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>  sound/soc/sh/fsi.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
> index 0c9997e..88b669c 100644
> --- a/sound/soc/sh/fsi.c
> +++ b/sound/soc/sh/fsi.c
> @@ -1321,3 +1321,4 @@ module_exit(fsi_mobile_exit);
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("SuperH onchip FSI audio driver");
>  MODULE_AUTHOR("Kuninori Morimoto <morimoto.kuninori@renesas.com>");
> +MODULE_ALIAS("platform:fsi-pcm-audio");

Acked-by: Liam Girdwood <lrg@ti.com>
