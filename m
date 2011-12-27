From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Allocate PCM operations dynamically
 to support multiple DAIs
Date: Tue, 27 Dec 2011 10:34:02 +0000
Message-ID: <20111227103401.GB2870@opensource.wolfsonmicro.com>
References: <CANh+=Y8HVjkChnMQLzHmGbpbxRu3wxqbUDp2SQ3SpQhpC-0oug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 731152465C
	for <alsa-devel@alsa-project.org>; Tue, 27 Dec 2011 11:34:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CANh+=Y8HVjkChnMQLzHmGbpbxRu3wxqbUDp2SQ3SpQhpC-0oug@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sangsu Park <sangsu@gmail.com>
Cc: sbkim73@samsung.com, alsa-devel@alsa-project.org, lrg@ti.com, sangsu4u.park@samsung.com
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 27, 2011 at 04:49:46PM +0900, Sangsu Park wrote:
> > On Fri, Dec 23, 2011 at 10:37:51AM +0900, Sangbeom Kim wrote:

> +       struct snd_pcm_ops *soc_pcm_ops = platform->driver->ops;
>         struct snd_pcm *pcm;
>         char new_name[64];
>         int ret = 0, playback = 0, capture = 0;
> 
>         if (playback)
> -               snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &soc_pcm_ops);
> +               snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, soc_pcm_ops);
> 
>         if (capture)
> -               snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &soc_pcm_ops);
> +               snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, soc_pcm_ops);

> But, it seems to make mutex dead lock.
> When starting playback, it tells some messages.

We still need to use the indirections in the SoC ops in the same way as
we do at present so that the DAI drivers and DAPM get called as well.
