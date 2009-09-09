From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH] To avoid the divide by zero error during
 the first	execution, initialize the data type.
Date: Wed, 09 Sep 2009 13:47:06 -0700
Message-ID: <4AA8144A.10105@boundarydevices.com>
References: <1252527563-15074-1-git-send-email-avm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth00.csee.onr.siteprotect.com
	(smtpauth00.csee.onr.siteprotect.com [64.26.60.144])
	by alsa0.perex.cz (Postfix) with ESMTP id D5098103870
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Sep 2009 22:47:15 +0200 (CEST)
In-Reply-To: <1252527563-15074-1-git-send-email-avm@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: avm@ti.com
Cc: davinci-linux-open-source@linux.davincidsp.com, Arun Mani <a0270733@dal.design.ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

avm@ti.com wrote:
> From: Arun Mani <a0270733@gtcx26221.gt.design.ti.com>
> 
> Signed-off-by: Arun Mani <a0270733@gtcx26221.gt.design.ti.com>
> ---
>  sound/soc/davinci/davinci-i2s.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
> index b1ea52f..61b1763 100644
> --- a/sound/soc/davinci/davinci-i2s.c
> +++ b/sound/soc/davinci/davinci-i2s.c
> @@ -104,10 +104,12 @@ enum {
>  
>  static struct davinci_pcm_dma_params davinci_i2s_pcm_out = {
>  	.name = "I2S PCM Stereo out",
> +	.data_type = 2, //Initialize the data type for playback to avoid divide by zero

You should have ".acnt = 2" also for consistency.
>  };
>  
>  static struct davinci_pcm_dma_params davinci_i2s_pcm_in = {
>  	.name = "I2S PCM Stereo in",
> +	.data_type = 2, //Initialize the data type for playback to avoid divide by zero
>  };
>  
>  struct davinci_mcbsp_dev {

And if the 1st stream is an 8-bit audio stream, will it initialize it incorrectly ???
Of course, we have formats = SNDRV_PCM_FMTBIT_S16_LE, currently so it's not an issue yet...

I don't see how data_type is not being set in davinci_i2s_hw_params
before being used in davinci_pcm_prepare.

Can prepare be called before hw_params ?

There is a "return -EINVAL" in davinci_i2s_hw_params with a
"printk(KERN_WARNING "davinci-i2s: unsupported PCM format\n")" before it.

Do you see this message in your log ?


Thanks
Troy
