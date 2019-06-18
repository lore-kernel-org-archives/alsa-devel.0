From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: sof_rt5682: use GFP_KERNEL
 instead of GFP_ATOMIC
Date: Tue, 18 Jun 2019 09:11:37 +0200
Message-ID: <cdb8d180-808f-62d2-4227-10e661e2f9ea@linux.intel.com>
References: <20190618070426.35405-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5E1C5F89682
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 09:11:37 +0200 (CEST)
In-Reply-To: <20190618070426.35405-1-tzungbi@google.com>
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
To: Tzung-Bi Shih <tzungbi@google.com>, broonie@kernel.org
Cc: yung-chuan.liao@linux.intel.com, alsa-devel@alsa-project.org, dgreid@google.com, cychiang@google.com
List-Id: alsa-devel@alsa-project.org

On 6/18/19 9:04 AM, Tzung-Bi Shih wrote:
> Change the memory allocation flag from GFP_ATOMIC to GFP_KERNEL because
> probe of platform device is unlikely a place where cannot sleep.
> 
> Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
> ---
> It might be a typo introduced from copied-and-pasted.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

We noticed this issue yesterday while reviewing additional changes for 
this machine driver but you beat us to it. Thanks!

> 
>   sound/soc/intel/boards/sof_rt5682.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
> index e2e5f97d9920..02138aa8a850 100644
> --- a/sound/soc/intel/boards/sof_rt5682.c
> +++ b/sound/soc/intel/boards/sof_rt5682.c
> @@ -498,7 +498,7 @@ static int sof_audio_probe(struct platform_device *pdev)
>   	int dmic_num, hdmi_num;
>   	int ret, ssp_amp, ssp_codec;
>   
> -	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
> +	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
>   	if (!ctx)
>   		return -ENOMEM;
>   
> 
