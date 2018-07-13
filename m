From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qdsp6: q6routing: off by one in
	routing_hw_params()
Date: Fri, 13 Jul 2018 16:42:47 +0100
Message-ID: <24d37072-bd4f-677f-5216-cca9d040f98a@linaro.org>
References: <20180713151100.x5usbqhlhrzjmeoq@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id B1E90267727
 for <alsa-devel@alsa-project.org>; Fri, 13 Jul 2018 17:42:49 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id h20-v6so9755448wmb.4
 for <alsa-devel@alsa-project.org>; Fri, 13 Jul 2018 08:42:49 -0700 (PDT)
In-Reply-To: <20180713151100.x5usbqhlhrzjmeoq@kili.mountain>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Niklas Cassel <niklas.cassel@linaro.org>
List-Id: alsa-devel@alsa-project.org



On 13/07/18 16:11, Dan Carpenter wrote:
> The data->port_data[] array has AFE_MAX_PORTS elements so the check
> should be >= instead of > or we write one element beyond the end of the
> array.
> 
> Fixes: e3a33673e845 ("ASoC: qdsp6: q6routing: Add q6routing driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Thanks for the fix,

Acked-by: Srinivas Kandgatla <srinivas.kandagatla@linaro.org>

> 
> diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
> index 35269b492761..0e7cf9e35d51 100644
> --- a/sound/soc/qcom/qdsp6/q6routing.c
> +++ b/sound/soc/qcom/qdsp6/q6routing.c
> @@ -927,7 +927,7 @@ static int routing_hw_params(struct snd_pcm_substream *substream,
>   	else
>   		path_type = ADM_PATH_LIVE_REC;
>   
> -	if (be_id > AFE_MAX_PORTS)
> +	if (be_id >= AFE_MAX_PORTS)
>   		return -EINVAL;
>   
>   	session = &data->port_data[be_id];
> 
