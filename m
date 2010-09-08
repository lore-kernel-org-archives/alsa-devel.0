From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 5/5] ASoC: fsi-ak4642: modiry platform_name
Date: Wed, 08 Sep 2010 12:08:50 +0100
Message-ID: <1283944130.3097.97.camel@odin>
References: <w3pvd6i6ois.wl%kuninori.morimoto.gx@renesas.com>
	<w3pmxru6ofb.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 1854224487
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Sep 2010 13:08:56 +0200 (CEST)
Received: by wyb32 with SMTP id 32so7093277wyb.38
	for <alsa-devel@alsa-project.org>; Wed, 08 Sep 2010 04:08:55 -0700 (PDT)
In-Reply-To: <w3pmxru6ofb.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Guennadi <g.liakhovetski@gmx.de>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-09-07 at 15:46 +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/sh/fsi-ak4642.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/sh/fsi-ak4642.c b/sound/soc/sh/fsi-ak4642.c
> index 53836ca..a7d2686 100644
> --- a/sound/soc/sh/fsi-ak4642.c
> +++ b/sound/soc/sh/fsi-ak4642.c
> @@ -32,7 +32,7 @@ static struct snd_soc_dai_link fsi_dai_link = {
>  	.cpu_dai_name	= "fsia-dai", /* fsi A */
>  	.codec_dai_name	= "ak4642-hifi",
>  #ifdef CONFIG_MACH_AP4EVB
> -	.platform_name	= "sh_fsi2.0",
> +	.platform_name	= "sh_fsi2",
>  	.codec_name	= "ak4642-codec.0-0013",
>  #else
>  	.platform_name	= "sh_fsi.0",

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
