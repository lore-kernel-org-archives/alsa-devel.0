From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH -next] ASoC: Intel: sst_byt: remove kfree for memory allocated
 with devm_kzalloc
Date: Thu, 16 Apr 2015 17:05:33 +0300
Message-ID: <552FC1AD.7030207@linux.intel.com>
References: <1429191989-25919-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429191989-25919-1-git-send-email-weiyj_lk@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: weiyj_lk@163.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Jin Yao <yao.jin@linux.intel.com>, Jie Yang <yang.jie@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi

On 04/16/2015 04:46 PM, weiyj_lk@163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> It's not necessary to free memory allocated with devm_kzalloc
> and using kfree leads to a double free.
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>   sound/soc/intel/baytrail/sst-baytrail-ipc.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/sound/soc/intel/baytrail/sst-baytrail-ipc.c b/sound/soc/intel/baytrail/sst-baytrail-ipc.c
> index 1efb33b..a839dbf 100644
> --- a/sound/soc/intel/baytrail/sst-baytrail-ipc.c
> +++ b/sound/soc/intel/baytrail/sst-baytrail-ipc.c
> @@ -759,7 +759,6 @@ fw_err:
>   dsp_new_err:
>   	sst_ipc_fini(ipc);
>   ipc_init_err:
> -	kfree(byt);
>
>   	return err;
>   }
>
Above kfree(byt) appears to be added by accident in the commit 
48cec59b6f38 ("ASoC: Intel: Use the generic IPC/mailbox APIs in Baytrail").

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
