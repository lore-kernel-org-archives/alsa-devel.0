From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: dapm: Add a dummy snd_pcm_runtime to avoid NULL
 pointer access
Date: Tue, 26 Jul 2016 14:24:12 -0700
Message-ID: <20160726212411.GA663@Asurada-Nvidia>
References: <1469561320-31853-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1469561320-31853-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 26, 2016 at 12:28:40PM -0700, Nicolin Chen wrote:
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index 8698c26..eed15ca 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -3493,6 +3493,7 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
>  	const struct snd_soc_pcm_stream *config = w->params + w->params_select;
>  	struct snd_pcm_substream substream;
>  	struct snd_pcm_hw_params *params = NULL;
> +	struct snd_pcm_runtime runtime;

Got a warning from test robot:

sound/soc/soc-dapm.c: In function 'snd_soc_dai_link_event':
sound/soc/soc-dapm.c:3614:1: warning: the frame size of 1304 bytes is larger
					than 1024 bytes [-Wframe-larger-than=]

Kzalloc() might be a better solution here.

Will send a v2. So please ignore this one.

Thanks
Nicolin
