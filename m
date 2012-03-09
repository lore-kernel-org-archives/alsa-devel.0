From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/3] ASoC: omap-mcbsp: fix
	snd_pcm_hw_rule_add arguments
Date: Fri, 09 Mar 2012 12:08:35 +0200
Message-ID: <4F59D6A3.7020904@ti.com>
References: <1331248757-3408-1-git-send-email-notasas@gmail.com>
	<1331248757-3408-2-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from psmtp.com (na3sys009aog137.obsmtp.com [74.125.149.18])
	by alsa0.perex.cz (Postfix) with ESMTP id 18CCB103A85
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 11:08:42 +0100 (CET)
Received: by lahj13 with SMTP id j13so2072854lah.33
	for <alsa-devel@alsa-project.org>; Fri, 09 Mar 2012 02:08:39 -0800 (PST)
In-Reply-To: <1331248757-3408-2-git-send-email-notasas@gmail.com>
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
> We are setting SNDRV_PCM_HW_PARAM_BUFFER_SIZE based on
> SNDRV_PCM_HW_PARAM_CHANNELS, not vice versa.

The intention is to set the buffer size based on the channels here.
This is needed because of the McBSP internal FIFO operation.
It is word based. As example on McBSP2 has 1280 word FIFO.
In mono stream it is 1280 sample long.
In stereo it is 640 (stereo) sample long.
In four channel mode it is 320 (4 channel) sample long.

> This bug didn't
> have much impact because the rules are evaluated multiple times
> by the core, and intended value got set eventually.
> =

> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
>  sound/soc/omap/omap-mcbsp.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index 10eb645..207365c 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -142,10 +142,10 @@ static int omap_mcbsp_dai_startup(struct snd_pcm_su=
bstream *substream,
>  		* smaller buffer than the FIFO size to avoid underruns
>  		*/
>  		snd_pcm_hw_rule_add(substream->runtime, 0,
> -				    SNDRV_PCM_HW_PARAM_CHANNELS,
> +				    SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
>  				    omap_mcbsp_hwrule_min_buffersize,
>  				    mcbsp,
> -				    SNDRV_PCM_HW_PARAM_BUFFER_SIZE, -1);
> +				    SNDRV_PCM_HW_PARAM_CHANNELS, -1);
>  =

>  		/* Make sure, that the period size is always even */
>  		snd_pcm_hw_constraint_step(substream->runtime, 0,


-- =

P=E9ter
