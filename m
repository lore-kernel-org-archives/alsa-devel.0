From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 4/5] ASoC: fsi-hdmi: remove unneeded header
Date: Tue, 7 Sep 2010 09:06:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1009070906380.1345@axis700.grange>
References: <w3pvd6i6ois.wl%kuninori.morimoto.gx@renesas.com>
	<w3pocca6ofi.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id 1EDCA243FA
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Sep 2010 09:06:52 +0200 (CEST)
In-Reply-To: <w3pocca6ofi.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, 7 Sep 2010, Kuninori Morimoto wrote:

> Reported-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/sh/fsi-hdmi.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/sh/fsi-hdmi.c b/sound/soc/sh/fsi-hdmi.c
> index 950e3e0..fcda149 100644
> --- a/sound/soc/sh/fsi-hdmi.c
> +++ b/sound/soc/sh/fsi-hdmi.c
> @@ -11,7 +11,6 @@
>  
>  #include <linux/platform_device.h>
>  #include <sound/sh_fsi.h>

Is this header needed?

Thanks
Guennadi

> -#include <video/sh_mobile_hdmi.h>
>  
>  static struct snd_soc_dai_link fsi_dai_link = {
>  	.name		= "HDMI",
> -- 
> 1.7.0.4
> 
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
