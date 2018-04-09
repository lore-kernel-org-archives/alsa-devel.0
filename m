From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] sound: soc: intel: bxt_da7219_max98357a:
 Replace GFP_ATOMIC with GFP_KERNEL in broxton_audio_probe
Date: Mon, 9 Apr 2018 13:57:43 -0500
Message-ID: <482591fb-bf12-2e0a-e0ef-2ae0b4095000@linux.intel.com>
References: <1523270781-22627-1-git-send-email-baijiaju1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523270781-22627-1-git-send-email-baijiaju1990@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, sathyanarayana.nujella@intel.com, Adam.Thomson.Opensource@diasemi.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

On 4/9/18 5:46 AM, Jia-Ju Bai wrote:
> broxton_audio_probe() is never called in atomic context.
> This function is only set as ".probe" in "struct platform_driver".
> 
> Despite never getting called from atomic context,
> broxton_audio_probe() calls devm_kzalloc() with GFP_ATOMIC,
> which waits busily for allocation.
> GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
> to avoid busy waiting and improve the possibility of sucessful allocation.

[answering for the series]
Humm, this is interesting.
If indeed we can afford to sleep then the change should be done on ALL 
14 boards in sound/soc/intel/boards which follow the same code pattern.
If we cannot sleep then then none of these changes should be applied.
Liam and Vinod?

> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>   sound/soc/intel/boards/bxt_da7219_max98357a.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
> index ce35ec7..f4361b7 100644
> --- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
> +++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
> @@ -585,7 +585,7 @@ static int broxton_audio_probe(struct platform_device *pdev)
>   {
>   	struct bxt_card_private *ctx;
>   
> -	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
> +	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
>   	if (!ctx)
>   		return -ENOMEM;
>   
> 
