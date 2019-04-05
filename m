From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH 2/3] ASoC: fsl_utils: fix a leaked reference by adding
 missing of_node_put
Date: Fri, 5 Apr 2019 14:30:58 +0200
Message-ID: <94bbd764-9727-5e17-aab0-66738edec39f@web.de>
References: <1551169071-11639-2-git-send-email-wen.yang99@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551169071-11639-2-git-send-email-wen.yang99@zte.com.cn>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wen Yang <wen.yang99@zte.com.cn>, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Yi Wang <wang.yi59@zte.com.cn>
List-Id: alsa-devel@alsa-project.org

> @@ -71,6 +71,7 @@  int fsl_asoc_get_dma_channel(struct device_node *ssi_np,
>  	iprop = of_get_property(dma_np, "cell-index", NULL);
>  	if (!iprop) {
>  		of_node_put(dma_np);
> +		of_node_put(dma_channel_np);
>  		return -EINVAL;
>  	}
>  	*dma_id = be32_to_cpup(iprop);

How do you think about to adjust the exception handling in this function
implementation a bit more according to the Linux coding style?
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/sound/soc/fsl/fsl_utils.c?id=c705247136a523488eac806bd357c3e5d79a7acd#n16

Regards,
Markus
