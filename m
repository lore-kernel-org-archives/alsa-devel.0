From: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH] ASoC: codecs: Fix to avoid potential NULL pointer
 dereferences
Date: Fri, 22 Mar 2019 16:47:54 +0000
Message-ID: <23781985-7747-730c-764d-1565a511cb67@arm.com>
References: <20190319005805.13823-1-pakki001@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190319005805.13823-1-pakki001@umn.edu>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Aditya Pakki <pakki001@umn.edu>
Cc: Barry Song <baohua@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kjlu@umn.edu, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 19/03/2019 00:58, Aditya Pakki wrote:
> In sirf_audio_codec_driver_probe, of_match_node may fail and return a
> NULL pointer. The patch avoids a potential NULL pointer dereference.

Actually 'match' isn't used in this function...  So there's no chance of
a NULL dereference. You might as well remove the call.

Steve

> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  sound/soc/codecs/sirf-audio-codec.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/codecs/sirf-audio-codec.c b/sound/soc/codecs/sirf-audio-codec.c
> index e424499a8450..fd2bbd6a3c58 100644
> --- a/sound/soc/codecs/sirf-audio-codec.c
> +++ b/sound/soc/codecs/sirf-audio-codec.c
> @@ -464,6 +464,8 @@ static int sirf_audio_codec_driver_probe(struct platform_device *pdev)
>  	const struct of_device_id *match;
>  
>  	match = of_match_node(sirf_audio_codec_of_match, pdev->dev.of_node);
> +	if (!match)
> +		return -ENXIO;
>  
>  	sirf_audio_codec = devm_kzalloc(&pdev->dev,
>  		sizeof(struct sirf_audio_codec), GFP_KERNEL);
> 
