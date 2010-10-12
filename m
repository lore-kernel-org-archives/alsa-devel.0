From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 4/5] ASoC: fsi: Add fsi_is_play function
Date: Tue, 12 Oct 2010 10:16:19 +0100
Message-ID: <1286874979.3267.5.camel@odin>
References: <w3pvd58rv87.wl%kuninori.morimoto.gx@renesas.com>
	<w3ppqvgrv56.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1ABCA244CD
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Oct 2010 11:16:23 +0200 (CEST)
Received: by wwb28 with SMTP id 28so3824930wwb.20
	for <alsa-devel@alsa-project.org>; Tue, 12 Oct 2010 02:16:22 -0700 (PDT)
In-Reply-To: <w3ppqvgrv56.wl%kuninori.morimoto.gx@renesas.com>
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

On Tue, 2010-10-12 at 11:40 +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/sh/fsi.c |   13 +++++++++----
>  1 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
> index 2b3a50d..09a2df2 100644
> --- a/sound/soc/sh/fsi.c
> +++ b/sound/soc/sh/fsi.c
> @@ -295,6 +295,11 @@ static u32 fsi_get_info_flags(struct fsi_priv *fsi)
>  		master->info->portb_flags;
>  }
>  
> +static int fsi_is_play(struct snd_pcm_substream *substream)
> +{
> +	return substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
> +}
> +

It may be better to make this inline since it's very small.

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
