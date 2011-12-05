From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/5] ASoC: Hold runtime PM references to
 components of active DAIs
Date: Mon, 05 Dec 2011 10:01:07 +0200
Message-ID: <4EDC7A43.5040409@ti.com>
References: <1323043291-6797-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog103.obsmtp.com (na3sys009aog103.obsmtp.com
	[74.125.149.71]) by alsa0.perex.cz (Postfix) with ESMTP id 9C78124415
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 09:01:05 +0100 (CET)
Received: by faar15 with SMTP id r15so256291faa.33
	for <alsa-devel@alsa-project.org>; Mon, 05 Dec 2011 00:01:02 -0800 (PST)
In-Reply-To: <1323043291-6797-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: alsa-devel@alsa-project.org

On 12/05/2011 02:01 AM, Mark Brown wrote:
> Every device that implements runtime power management for DAIs is doing
> it in pretty much the same way: in the startup callback they take a
> runtime PM reference and then in the shutdown callback they release that
> reference, keeping the device active while the DAI is active. Given the
> frequency with which this is done and the obviousness of the need to keep
> the device active in this period factor the code out into the core, taking
> references on the device for each CPU DAI, CODEC DAI and DMA device in the
> core.
> =

> As runtime PM is reference counted this shouldn't interfere with any
> other reference holding by the drivers, and since (in common with the
> existing implementations) we don't check for errors on enabling it
> shouldn't matter if the device actually has runtime PM enabled or not.
> =

> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-pcm.c |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
> =

> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 49aa71e..8aa7cec 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -19,6 +19,7 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/delay.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  #include <linux/workqueue.h>
>  #include <sound/core.h>
> @@ -77,6 +78,10 @@ static int soc_pcm_open(struct snd_pcm_substream *subs=
tream)
>  	struct snd_soc_dai_driver *codec_dai_drv =3D codec_dai->driver;
>  	int ret =3D 0;
>  =

> +	pm_runtime_get_sync(cpu_dai->dev);
> +	pm_runtime_get_sync(codec_dai->dev);
> +	pm_runtime_get_sync(platform->dev);
> +
>  	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);

I think it is better to move the pm_runtime_get_sync calls after the
mutex_lock_nested() to be really safe (and to not change the way DAI
drivers were handling the pm_runtime).

-- =

P=E9ter
