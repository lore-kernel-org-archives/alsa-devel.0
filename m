From: Banajit Goswami <bgoswami@codeaurora.org>
Subject: Re: [PATCH v7 16/24] ASoC: qdsp6: q6asm: Add support to audio stream
 apis
Date: Wed, 9 May 2018 03:16:54 -0700
Message-ID: <3296bc93-8790-3780-064c-d87422c644a9@codeaurora.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-17-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180501120820.11016-17-srinivas.kandagatla@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com, lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com
List-Id: alsa-devel@alsa-project.org

On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch adds support to open, write and media format commands
> in the q6asm module.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/qdsp6/q6asm.c | 839 ++++++++++++++++++++++++++++++++++++++++++-
>   sound/soc/qcom/qdsp6/q6asm.h |  49 +++
>   2 files changed, 887 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
> index 5a573e927a5e..a3073de235e1 100644
> --- a/sound/soc/qcom/qdsp6/q6asm.c
> +++ b/sound/soc/qcom/qdsp6/q6asm.c
> @@ -10,6 +10,8 @@
<snip>
>   EXPORT_SYMBOL_GPL(q6asm_audio_client_alloc);
>   
> +static int q6asm_ac_send_cmd_sync(struct audio_client *ac, struct apr_pkt *pkt)
> +{
> +	struct apr_hdr *hdr = &pkt->hdr;
> +	int rc;
> +
> +	mutex_lock(&ac->lock);
> +	ac->result.opcode = 0;
> +	ac->result.status = 0;
> +
> +	rc = apr_send_pkt(ac->adev, pkt);
> +	if (rc < 0)
> +		goto err;
> +
> +	rc = wait_event_timeout(ac->cmd_wait,
> +				(ac->result.opcode == hdr->opcode), 5 * HZ);
> +	if (!rc) {
> +		dev_err(ac->dev, "CMD timeout\n");
> +		rc =  -ETIMEDOUT;
> +		goto err;
> +	}
else set rc to 0 to avoid returning >0 value.

LGTM otherwise.
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
