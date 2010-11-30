From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: sh: fsi-ak4642: Add FSI port and
	ak464x selection
Date: Tue, 30 Nov 2010 11:31:38 +0000
Message-ID: <1291116698.3293.13.camel@odin>
References: <w3p7hfvbkyl.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 89B1810394B
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 12:31:41 +0100 (CET)
Received: by wwe15 with SMTP id 15so5733252wwe.20
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 03:31:41 -0800 (PST)
In-Reply-To: <w3p7hfvbkyl.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-11-30 at 11:32 +0900, Kuninori Morimoto wrote:
> Current FSI-Ak4642 device had niche settings which were
> FSI2-A-AK4643 and FSI-A-AK4642.
> This patch add platform_device_id which can control
> FSI/FSI2, PortA/PortB, AK4642/AK4643 from platform data.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

but 

>  static struct snd_soc_dai_link fsi_dai_link = {
> -	.name		= "AK4642",
> -	.stream_name	= "AK4642",
> -	.cpu_dai_name	= "fsia-dai", /* fsi A */
> +	/* .name */
> +	/* .stream_name */
> +	/* .cpu_dai_name */

it looks like you forgot to delete these comments.

>  	.codec_dai_name	= "ak4642-hifi",
> -#ifdef CONFIG_MACH_AP4EVB
> -	.platform_name	= "sh_fsi2",
> -	.codec_name	= "ak4642-codec.0-0013",
> -#else
> -	.platform_name	= "sh_fsi.0",
> -	.codec_name	= "ak4642-codec.0-0012",
> -#endif
> +	/* .platform_name */
> +	/* .codec_name */

ditto.

>  	.init		= fsi_ak4642_dai_init,
>  	.ops		= NULL,

no need to set ops to NULL here.

>  };
> @@ -50,14 +52,30 @@ static struct snd_soc_card fsi_soc_card  = {
>  

Could you send an incremental update that fixes these issues.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
