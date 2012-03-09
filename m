From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 3/3] ASoC: omap-mcbsp: make minimum period
 size larger than FIFO
Date: Fri, 09 Mar 2012 14:42:05 +0200
Message-ID: <4F59FA9D.8070009@ti.com>
References: <1331248757-3408-1-git-send-email-notasas@gmail.com>
	<1331248757-3408-4-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from psmtp.com (na3sys009aog133.obsmtp.com [74.125.149.82])
	by alsa0.perex.cz (Postfix) with ESMTP id BF9E110B990
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 13:42:25 +0100 (CET)
Received: by lahj13 with SMTP id j13so1598250lah.19
	for <alsa-devel@alsa-project.org>; Fri, 09 Mar 2012 04:42:08 -0800 (PST)
In-Reply-To: <1331248757-3408-4-git-send-email-notasas@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 03/09/2012 01:19 AM, Grazvydas Ignotas wrote:
> With a program operating in minimum sized periods, first write
> will cause a transfer that will fill mcbsp FIFO quickly, and there
> will be no more data to DMA before program manages to do another
> write. As the core considers this as underflow condition, we may
> get many underflows at the start.
> Increase minimum period size by half to deal with this problem.

Not entirely sure about the last two patch...
The implications will be big for existing user space since we are going
to limit the period size in this way (on OMAP3 McBSP2):
48K stereo: 20ms min
44.1K stereo: 21.768ms min
8K stereo: 120ms min
8K mono: 240ms min

As I recall n900 (+ MeeGo) uses 5ms period sizes in call cases on McBSP2.

So I'm a bit reluctant to ack these (it is not an issue on other McBSP
ports, and on OMAP4, but OMAP3 McBSP2 is problematic IMHO).

Jarkko: What do you think?

If this is a real issue in Pandora, could it be solved with adding
/etc/asound.conf to the filesystem, and limit the period size via that?

-- =

P=E9ter

> =

> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
>  sound/soc/omap/omap-mcbsp.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> =

> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index b9d1272..b373a0b 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -108,6 +108,17 @@ static int omap_mcbsp_hwrule_min_period_size(struct =
snd_pcm_hw_params *params,
>  	size =3D mcbsp->pdata->buffer_size;
>  =

>  	frames.min =3D size / channels->min;
> +
> +	/*
> +	 * If period is not larger than FIFO, it may be transfered faster than
> +	 * program operating in period sizes is able to send 2 periods, so
> +	 * underrun condition can be triggered at the beginning of stream.
> +	 * This is because underrun is triggered as soon as DMA has no more
> +	 * data to send, and we get this from the start if period is too small.
> +	 * To deal with this, set period larger than FIFO size.
> +	 */
> +	frames.min =3D frames.min + frames.min / 2;
> +
>  	frames.integer =3D 1;
>  	return snd_interval_refine(period_size, &frames);
>  }
