From: Banajit Goswami <bgoswami@codeaurora.org>
Subject: Re: [PATCH v7 15/24] ASoC: qdsp6: q6asm: Add support to memory map
 and unmap
Date: Wed, 9 May 2018 01:23:51 -0700
Message-ID: <39933a04-7249-24ec-9ece-c3edd82e7d6c@codeaurora.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-16-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180501120820.11016-16-srinivas.kandagatla@linaro.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, rohkumar@qti.qualcomm.com, gregkh@linuxfoundation.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, david.brown@linaro.org, linux-arm-kernel@lists.infradead.org, spatakok@qti.qualcomm.com, perex@perex.cz, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch adds support to memory map and unmap regions commands in
> q6asm module.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/qdsp6/q6asm.c | 349 +++++++++++++++++++++++++++++++++++++++++++
>   sound/soc/qcom/qdsp6/q6asm.h |   5 +
>   2 files changed, 354 insertions(+)
>
> diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
> index c9526d2e59d2..5a573e927a5e 100644
> --- a/sound/soc/qcom/qdsp6/q6asm.c
> +++ b/sound/soc/qcom/qdsp6/q6asm.c
> @@ -18,10 +18,45 @@
>   #include "q6dsp-errno.h"
>   #include "q6dsp-common.h"
<snip>
> +
> +/**
> + * q6asm_map_memory_regions() - map memory regions in the dsp.
> + *
> + * @dir: direction of audio stream
> + * @ac: audio client instanace
> + * @phys: physcial address that needs mapping.
> + * @period_sz: audio period size
> + * @periods: number of periods
> + *
> + * Return: Will be an negative value on failure or zero on success
> + */
> +int q6asm_map_memory_regions(unsigned int dir, struct audio_client *ac,
> +			     phys_addr_t phys,
> +			     size_t period_sz, unsigned int periods)
> +{
> +	struct audio_buffer *buf;
> +	unsigned long flags;
> +	int cnt;
> +	int rc;
> +
> +	spin_lock_irqsave(&ac->buf_lock, flags);
> +	if (ac->port[dir].buf) {
> +		dev_err(ac->dev, "Buffer already allocated\n");
> +		spin_unlock_irqrestore(&ac->buf_lock, flags);
> +		return 0;
> +	}
> +
> +	buf = kzalloc(((sizeof(struct audio_buffer)) * periods), GFP_ATOMIC);
> +	if (!buf) {
> +		spin_unlock_irqrestore(&ac->buf_lock, flags);
> +		return -ENOMEM;
> +	}
> +
> +
Remove extra blank line.

Otherwise LGTM.
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
