From: Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH v3] ASoC: sirf-audio: Remove redundant of_match_node call
Date: Wed, 27 Mar 2019 20:03:19 +0530
Message-ID: <7273b5c0-2308-54b2-6bd5-6ad11292f8ea@codeaurora.org>
References: <20190322220031.13773-1-pakki001@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322220031.13773-1-pakki001@umn.edu>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Aditya Pakki <pakki001@umn.edu>
Cc: Barry Song <baohua@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kjlu@umn.edu, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


On 3/23/2019 3:30 AM, Aditya Pakki wrote:
> Unlike other drivers probe method, of_match_node return value
> is not used or checked. This patch removes the redundant code.

Instead could be written like "Use of `of_match_node` is redundant in 
sirf-audio-codec driver probe. Remove it."

>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh


>
> ---
> v2: Move the signed by above the version change log
> v1: A check is unnecessary as match is never used.
> ---
>   sound/soc/codecs/sirf-audio-codec.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/sound/soc/codecs/sirf-audio-codec.c b/sound/soc/codecs/sirf-audio-codec.c
> index e424499a8450..e0af21050078 100644
> --- a/sound/soc/codecs/sirf-audio-codec.c
> +++ b/sound/soc/codecs/sirf-audio-codec.c
> @@ -461,9 +461,6 @@ static int sirf_audio_codec_driver_probe(struct platform_device *pdev)
>   	struct sirf_audio_codec *sirf_audio_codec;
>   	void __iomem *base;
>   	struct resource *mem_res;
> -	const struct of_device_id *match;
> -
> -	match = of_match_node(sirf_audio_codec_of_match, pdev->dev.of_node);
>   
>   	sirf_audio_codec = devm_kzalloc(&pdev->dev,
>   		sizeof(struct sirf_audio_codec), GFP_KERNEL);
