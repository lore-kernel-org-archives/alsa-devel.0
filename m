From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH -next] ASoC: Intel: bytcht_es8316: Set correct platform
 drvdata in snd_byt_cht_es8316_mc_probe()
Date: Wed, 9 Jan 2019 10:33:38 +0100
Message-ID: <21a053d4-ed3c-5dce-9630-e72c783914ae@redhat.com>
References: <1547023011-8321-1-git-send-email-weiyongjun1@huawei.com>
 <20190109092924.GB1743@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109092924.GB1743@kadam>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Wei Yongjun <weiyongjun1@huawei.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 09-01-19 10:29, Dan Carpenter wrote:
> I think the correct fix is actually this (untested):

Right, I'm pretty sure the soc framework depends on dev_get_drvdata
returning the snd_soc_card and I forgot about this when adding
the remove function.

Wei Yongjun, thank you for catching this.

Dan, thank you for the correct version of the patch :)

Dan, can you do an official submission of the correct version of the
patch, with a Reported-by: Wei Yongjun <weiyongjun1@huawei.com>
or shall I submit your version upstream ?

Regards,

Hans


> 
> diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
> index cdf2061e7613..fa9c4cf97686 100644
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
