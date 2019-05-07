From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: Propagate
 sof_get_ctrl_copy_params() error properly
Date: Tue, 7 May 2019 14:54:11 -0500
Message-ID: <1f114472-a9c0-503a-57a2-c3a0a9bbcf30@linux.intel.com>
References: <20190507193910.23943-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2ACB4F89671
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2019 21:54:14 +0200 (CEST)
In-Reply-To: <20190507193910.23943-1-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Jaska Uimonen <jaska.uimonen@intel.com>
List-Id: alsa-devel@alsa-project.org



On 5/7/19 2:39 PM, Takashi Iwai wrote:
> This fixes a compile warning below by properly handling the error code
> from sof_get_ctrl_copy_params():
>    include/linux/kernel.h:843:43: warning: 'sparams.pl_size' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    sound/soc/sof/ipc.c:639:34: note: 'sparams.pl_size' was declared here
> 
> The function returns an error before setting sparams.pl_size, so it'd
> assign an uninitialized value at a later point.

Thanks Takashi.

I don't recall having seen this warning and this code has been around 
for a while. Does this show with a special config/compiler?

Adding Jaska since he wrote the support for large control data.

> 
> Fixes: 53e0c72d98ba ("ASoC: SOF: Add support for IPC IO between DSP and Host")
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/soc/sof/ipc.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/sof/ipc.c b/sound/soc/sof/ipc.c
> index ba1bb17a8d1e..f0b9d3c53f6f 100644
> --- a/sound/soc/sof/ipc.c
> +++ b/sound/soc/sof/ipc.c
> @@ -567,7 +567,7 @@ static int sof_set_get_large_ctrl_data(struct snd_sof_dev *sdev,
>   	size_t offset = 0;
>   	size_t msg_bytes;
>   	size_t pl_size;
> -	int err = 0;
> +	int err;
>   	int i;
>   
>   	/* allocate max ipc size because we have at least one */
> @@ -576,9 +576,13 @@ static int sof_set_get_large_ctrl_data(struct snd_sof_dev *sdev,
>   		return -ENOMEM;
>   
>   	if (send)
> -		sof_get_ctrl_copy_params(cdata->type, cdata, partdata, sparams);
> +		err = sof_get_ctrl_copy_params(cdata->type, cdata, partdata,
> +					       sparams);
>   	else
> -		sof_get_ctrl_copy_params(cdata->type, partdata, cdata, sparams);
> +		err = sof_get_ctrl_copy_params(cdata->type, partdata, cdata,
> +					       sparams);
> +	if (err < 0)
> +		return err;
>   
>   	msg_bytes = sparams->msg_bytes;
>   	pl_size = sparams->pl_size;
> 
