From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH -next v2] ASoC: Intel: bytcht_es8316: use
 correct drvdata in snd_byt_cht_es8316_mc_remove()
Date: Thu, 10 Jan 2019 08:20:06 +0100
Message-ID: <7d35c9d9-f244-d010-68e9-e68d58331172@redhat.com>
References: <1547023011-8321-1-git-send-email-weiyongjun1@huawei.com>
 <1547084589-40006-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by alsa0.perex.cz (Postfix) with ESMTP id A09B5267445
 for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2019 08:20:08 +0100 (CET)
Received: by mail-ed1-f68.google.com with SMTP id b3so9413788ede.1
 for <alsa-devel@alsa-project.org>; Wed, 09 Jan 2019 23:20:08 -0800 (PST)
In-Reply-To: <1547084589-40006-1-git-send-email-weiyongjun1@huawei.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wei Yongjun <weiyongjun1@huawei.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vkoul@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 10-01-19 02:43, Wei Yongjun wrote:
> The snd_byt_cht_es8316_mc_remove() use the platform drvdata as a type
> of 'struct byt_cht_es8316_private', but snd_byt_cht_es8316_mc_probe()
> set it to 'struct snd_soc_card', as suggested by Dan Carpenter, fix
> the usage in snd_byt_cht_es8316_mc_remove().
> 
> Fixes: 0d3e91da0750 ("ASoC: Intel: bytcht_es8316: Add external speaker mux support")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Thank you for catching this, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
> v1 -> v2: fix snd_byt_cht_es8316_mc_remove() instead, suggested by Dan.
> ---
>   sound/soc/intel/boards/bytcht_es8316.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
> index cdf2061..fa9c4cf 100644
> --- a/sound/soc/intel/boards/bytcht_es8316.c
> +++ b/sound/soc/intel/boards/bytcht_es8316.c
> @@ -544,7 +544,8 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
>   
>   static int snd_byt_cht_es8316_mc_remove(struct platform_device *pdev)
>   {
> -	struct byt_cht_es8316_private *priv = platform_get_drvdata(pdev);
> +	struct snd_soc_card *card = platform_get_drvdata(pdev);
> +	struct byt_cht_es8316_private *priv = snd_soc_card_get_drvdata(card);
>   
>   	gpiod_put(priv->speaker_en_gpio);
>   	return 0;
> 
> 
> 
