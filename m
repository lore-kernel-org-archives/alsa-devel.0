From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ASoC: Support 8 bit samples in soc-util
Date: Mon, 31 Jan 2011 23:27:41 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101312325010.6272@eeebox2.perex-int.cz>
References: <1296505848-29532-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A1461037EA
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 23:27:42 +0100 (CET)
In-Reply-To: <1296505848-29532-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, 31 Jan 2011, Mark Brown wrote:

> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Is any reason to avoid using the snd_pcm_format_width() function here?

 						Jaroslav

> ---
> sound/soc/soc-utils.c |    4 ++++
> 1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
> index 1d07b93..e31d843 100644
> --- a/sound/soc/soc-utils.c
> +++ b/sound/soc/soc-utils.c
> @@ -29,6 +29,10 @@ int snd_soc_params_to_frame_size(struct snd_pcm_hw_params *params)
> 	int sample_size;
>
> 	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_S8:
> +	case SNDRV_PCM_FORMAT_U8:
> +		sample_size = 8;
> +		break;
> 	case SNDRV_PCM_FORMAT_S16_LE:
> 	case SNDRV_PCM_FORMAT_S16_BE:
> 		sample_size = 16;

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
