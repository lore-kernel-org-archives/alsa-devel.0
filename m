From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/5] ASoC: Allow platform drivers to have
	no ops structure
Date: Wed, 27 Apr 2011 19:49:55 +0200
Message-ID: <4DB85743.1080806@metafoo.de>
References: <1303925257-26920-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 5032D243A8
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Apr 2011 19:50:04 +0200 (CEST)
In-Reply-To: <1303925257-26920-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, patches@opensource.wolfsonmicro.com, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 04/27/2011 07:27 PM, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-core.c |   49 ++++++++++++++++++++++++++++++-------------------
>  1 files changed, 30 insertions(+), 19 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index a6f37d4..cb93b79 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -545,6 +545,12 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
>  
>  	mutex_lock(&pcm_mutex);
>  
> +	/* CODEC<->CODEC DAI link, no CPU interface */
> +	if (rtd->dai_link->no_cpu) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
>  	/* startup the audio subsystem */
>  	if (cpu_dai->driver->ops->startup) {
>  		ret = cpu_dai->driver->ops->startup(substream, cpu_dai);

This hunk looks as if it belongs to a different series. There is currently no
'no_cpu' field in the snd_soc_dai_link struct.

- Lars
