From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 3/5] ASoC: qcom: add sdm845 sound card support
Date: Mon, 9 Jul 2018 10:06:13 +0100
Message-ID: <39104e1f-d976-b51d-aa02-932c264070ba@linaro.org>
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
 <1530870195-13576-4-git-send-email-rohitkr@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530870195-13576-4-git-send-email-rohitkr@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rohit kumar <rohitkr@codeaurora.org>, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Minor Nits...

On 06/07/18 10:43, Rohit kumar wrote:
> +struct sdm845_snd_data {
> +	struct snd_soc_card *card;
> +	struct regulator *vdd_supply;
> +	uint32_t pri_mi2s_clk_count;
> +	uint32_t quat_tdm_clk_count;
> +};
> +
> +
Unnecessary extra line..
> +static unsigned int tdm_slot_offset[8] = {0, 4, 8, 12, 16, 20, 24, 28};
> +
> 
> +static struct platform_driver sdm845_snd_driver = {
> +	.probe = sdm845_snd_platform_probe,
> +	.remove = sdm845_snd_platform_remove,
> +	.driver = {
> +		.name = "msm-snd-sdm845",
> +		.pm = &sdm845_pm_ops,
> +		.owner = THIS_MODULE,
setting owner is not required here!

> +		.of_match_table = sdm845_snd_device_id,
> +	},
> +};
