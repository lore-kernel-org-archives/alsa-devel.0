From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: sh: fix build error: terminate the
 platform device ID list
Date: Tue, 05 Oct 2010 16:59:42 +0100
Message-ID: <1286294382.3111.101.camel@odin>
References: <Pine.LNX.4.64.1010051749040.31708@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 483DE24519
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Oct 2010 17:59:44 +0200 (CEST)
Received: by wwi18 with SMTP id 18so92209wwi.2
	for <alsa-devel@alsa-project.org>; Tue, 05 Oct 2010 08:59:43 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1010051749040.31708@axis700.grange>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-10-05 at 17:54 +0200, Guennadi Liakhovetski wrote:
> Platform driver ID table must be zero-element terminated.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>  sound/soc/sh/fsi.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
> index 82c6190..dd99633 100644
> --- a/sound/soc/sh/fsi.c
> +++ b/sound/soc/sh/fsi.c
> @@ -1216,6 +1216,7 @@ static struct fsi_core fsi2_core = {
>  static struct platform_device_id fsi_id_table[] = {
>  	{ "sh_fsi",	(kernel_ulong_t)&fsi1_core },
>  	{ "sh_fsi2",	(kernel_ulong_t)&fsi2_core },
> +	{},
>  };
>  MODULE_DEVICE_TABLE(platform, fsi_id_table);
>  

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
