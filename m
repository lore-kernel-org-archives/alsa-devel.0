From: Rohit Kumar <rohitkr@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH v7 16/24] ASoC: qdsp6: q6asm: Add support to
 audio stream apis
Date: Fri, 4 May 2018 12:41:56 +0530
Message-ID: <f3b3d90b-6504-328e-c9f4-a3b3f085d9dc@codeaurora.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-17-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180501120820.11016-17-srinivas.kandagatla@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, bgoswami@codeaurora.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, rohkumar@qti.qualcomm.com, gregkh@linuxfoundation.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, david.brown@linaro.org, linux-arm-kernel@lists.infradead.org, spatakok@qti.qualcomm.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 5/1/2018 5:38 PM, Srinivas Kandagatla wrote:
> +static int __q6asm_run(struct audio_client *ac, uint32_t flags,
> +	      uint32_t msw_ts, uint32_t lsw_ts, bool wait)
> +{
> +	struct asm_session_cmd_run_v2 *run;
> +	struct apr_pkt *pkt;
> +	int pkt_size, rc;
> +	void *p;
> +
> +	pkt_size = APR_HDR_SIZE + sizeof(*run);
> +	p = kzalloc(pkt_size, GFP_KERNEL);
Should be GFP_ATOMIC as this API is also called from interrupt context
> +	if (!p)
> +		return -ENOMEM;
> +
[..]
> +int q6asm_read(struct audio_client *ac)
> +{
> +	struct asm_data_cmd_read_v2 *read;
> +	struct audio_port_data *port;
> +	struct audio_buffer *ab;
> +	struct apr_pkt *pkt;
> +	int pkt_size;
> +	int rc = 0;
> +	void *p;
> +
> +	if (!(ac->io_mode & ASM_SYNC_IO_MODE))
> +		return 0;
> +
> +	pkt_size = APR_HDR_SIZE + sizeof(*read);
> +	p = kzalloc(pkt_size, GFP_KERNEL);
same here. GFP_ATOMIC
> +	if (!p)
> +		return -ENOMEM;
[..]
> +int q6asm_write_async(struct audio_client *ac, uint32_t len, uint32_t msw_ts,
> +		       uint32_t lsw_ts, uint32_t flags)
> +{
> +	struct asm_data_cmd_write_v2 *write;
> +	struct audio_port_data *port;
> +	struct audio_buffer *ab;
> +	struct apr_pkt *pkt;
> +	int pkt_size;
> +	int rc = 0;
> +	void *p;
> +
> +	pkt_size = APR_HDR_SIZE + sizeof(*write);
> +	p = kzalloc(pkt_size, GFP_KERNEL);
GFP_ATOMIC
> +	if (!p)
> +		return -ENOMEM;
>
Thanks,
Rohit

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
