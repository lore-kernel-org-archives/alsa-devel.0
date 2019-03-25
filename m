From: Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH v3] ASoC: sirf-audio: Remove redundant
	of_match_node call
Date: Mon, 25 Mar 2019 19:21:42 +0530
Message-ID: <c9244500-ddce-4c8f-2086-82738a51ea0a@codeaurora.org>
References: <20190322220031.13773-1-pakki001@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 17B05F80764
 for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2019 14:51:52 +0100 (CET)
In-Reply-To: <20190322220031.13773-1-pakki001@umn.edu>
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
To: Aditya Pakki <pakki001@umn.edu>
Cc: Barry Song <baohua@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kjlu@umn.edu, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


On 3/23/2019 3:30 AM, Aditya Pakki wrote:
> Unlike other drivers probe method, of_match_node return value

Instead could be written like "Use of `of_match_node` is redundant in 
sirf-audio-codec driver probe. Remove it."

> is not used or checked. This patch removes the redundant code.
>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org 
<mailto:mojha@codeaurora.org>>

Thanks.
Mukesh


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
