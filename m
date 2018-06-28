From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qdsp6: qdafe: fix some off by one
	bugs
Date: Thu, 28 Jun 2018 09:36:00 +0100
Message-ID: <0c6dc870-f146-4894-ae43-882c63c16760@linaro.org>
References: <20180627085653.v5bi34k2ozkvvrsr@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 475D826799F
 for <alsa-devel@alsa-project.org>; Thu, 28 Jun 2018 10:36:02 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id e69-v6so5707136wme.2
 for <alsa-devel@alsa-project.org>; Thu, 28 Jun 2018 01:36:02 -0700 (PDT)
In-Reply-To: <20180627085653.v5bi34k2ozkvvrsr@kili.mountain>
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
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Thanks for the patch,

On 27/06/18 09:56, Dan Carpenter wrote:
> The > should be >= or we could read one element beyond the end of the
> port_maps[] array.
> 
> Fixes: 7fa2d70f9766 ("ASoC: qdsp6: q6afe: Add q6afe driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
> index 01f43218984b..69a7896cb713 100644
> --- a/sound/soc/qcom/qdsp6/q6afe.c
> +++ b/sound/soc/qcom/qdsp6/q6afe.c
> @@ -777,7 +777,7 @@ static int q6afe_callback(struct apr_device *adev, struct apr_resp_pkt *data)
>    */
>   int q6afe_get_port_id(int index)
>   {
> -	if (index < 0 || index > AFE_PORT_MAX)
> +	if (index < 0 || index >= AFE_PORT_MAX)
>   		return -EINVAL;
>   
>   	return port_maps[index].port_id;
> @@ -1014,7 +1014,7 @@ int q6afe_port_stop(struct q6afe_port *port)
>   
>   	port_id = port->id;
>   	index = port->token;
> -	if (index < 0 || index > AFE_PORT_MAX) {
> +	if (index < 0 || index >= AFE_PORT_MAX) {
>   		dev_err(afe->dev, "AFE port index[%d] invalid!\n", index);
>   		return -EINVAL;
>   	}
> @@ -1355,7 +1355,7 @@ struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id)
>   	unsigned long flags;
>   	int cfg_type;
>   
> -	if (id < 0 || id > AFE_PORT_MAX) {
> +	if (id < 0 || id >= AFE_PORT_MAX) {
>   		dev_err(dev, "AFE port token[%d] invalid!\n", id);
>   		return ERR_PTR(-EINVAL);
>   	}
> 
