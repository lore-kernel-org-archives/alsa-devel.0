From: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v3] ASoC: sirf-audio: Remove redundant of_match_node call
Date: Mon, 25 Mar 2019 11:10:37 +0000
Message-ID: <31ca2c4d-668d-9448-bb67-516d1a45b6a7@arm.com>
References: <20190322220031.13773-1-pakki001@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322220031.13773-1-pakki001@umn.edu>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Aditya Pakki <pakki001@umn.edu>
Cc: Barry Song <baohua@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kjlu@umn.edu, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 22/03/2019 22:00, Aditya Pakki wrote:
> Unlike other drivers probe method, of_match_node return value
> is not used or checked. This patch removes the redundant code.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Reviewed-by: Steven Price <steven.price@arm.com>

> 
> ---
> v2: Move the signed by above the version change log
> v1: A check is unnecessary as match is never used.
> ---
>  sound/soc/codecs/sirf-audio-codec.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/sirf-audio-codec.c b/sound/soc/codecs/sirf-audio-codec.c
> index e424499a8450..e0af21050078 100644
> --- a/sound/soc/codecs/sirf-audio-codec.c
> +++ b/sound/soc/codecs/sirf-audio-codec.c
> @@ -461,9 +461,6 @@ static int sirf_audio_codec_driver_probe(struct platform_device *pdev)
>  	struct sirf_audio_codec *sirf_audio_codec;
>  	void __iomem *base;
>  	struct resource *mem_res;
> -	const struct of_device_id *match;
> -
> -	match = of_match_node(sirf_audio_codec_of_match, pdev->dev.of_node);
>  
>  	sirf_audio_codec = devm_kzalloc(&pdev->dev,
>  		sizeof(struct sirf_audio_codec), GFP_KERNEL);
> 
