From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 3/5] ASoC: dapm: Append "Autodisable" to
 autodisable widget names
Date: Thu, 30 Apr 2015 19:40:42 +0200
Message-ID: <5542691A.9050204@metafoo.de>
References: <1430411912-6599-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1430411912-6599-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-225.synserver.de (smtp-out-225.synserver.de
 [212.40.185.225])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BFCA260418
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 19:40:41 +0200 (CEST)
In-Reply-To: <1430411912-6599-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 04/30/2015 06:38 PM, Charles Keepax wrote:
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index beb48b6..e557018 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -308,11 +308,19 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
>   {
>   	struct dapm_kcontrol_data *data;
>   	struct soc_mixer_control *mc;
> +	const char *name;
> +	int ret;
>
>   	data = kzalloc(sizeof(*data), GFP_KERNEL);
>   	if (!data)
>   		return -ENOMEM;
>
> +	name = kasprintf(GFP_KERNEL, "%s %s", kcontrol->id.name, "Autodisable");

We should only allocate the name if we create a widget, otherwise we are 
going to leak the memory.

> +	if (!name) {
> +		ret = -ENOMEM;
> +		goto err_data;
> +	}
> +
>   	INIT_LIST_HEAD(&data->paths);
>
