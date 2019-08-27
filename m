From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH 2/6] ASoC: Intel: Fix use of potentially uninitialized
 variable
Date: Tue, 27 Aug 2019 21:18:37 +0200
Message-ID: <a1ce2e69-d93a-93e8-8bbf-07c27e52124f@intel.com>
References: <20190827141712.21015-1-amadeuszx.slawinski@linux.intel.com>
 <20190827141712.21015-3-amadeuszx.slawinski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827141712.21015-3-amadeuszx.slawinski@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= <amadeuszx.slawinski@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, linux-kernel@vger.kernel.org, =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= <amadeuszx.slawinski@intel.com>
List-Id: alsa-devel@alsa-project.org

On 2019-08-27 16:17, Amadeusz Sławiński wrote:
> From: Amadeusz Sławiński <amadeuszx.slawinski@intel.com>
> 
> If ipc->ops.reply_msg_match is NULL, we may end up using uninitialized
> mask value.
> 
> reported by smatch:
> sound/soc/intel/common/sst-ipc.c:266 sst_ipc_reply_find_msg() error: uninitialized symbol 'mask'.
> 
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@intel.com>
> ---
>   sound/soc/intel/common/sst-ipc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/intel/common/sst-ipc.c b/sound/soc/intel/common/sst-ipc.c
> index 1186a03a88d6..6068bb697e22 100644
> --- a/sound/soc/intel/common/sst-ipc.c
> +++ b/sound/soc/intel/common/sst-ipc.c
> @@ -223,6 +223,8 @@ struct ipc_message *sst_ipc_reply_find_msg(struct sst_generic_ipc *ipc,
>   
>   	if (ipc->ops.reply_msg_match != NULL)
>   		header = ipc->ops.reply_msg_match(header, &mask);
> +	else
> +		mask = (u64)-1;

Please see linux/limits.h and check if this can't be replaced by an 
equivalent found there.

>   
>   	if (list_empty(&ipc->rx_list)) {
>   		dev_err(ipc->dev, "error: rx list empty but received 0x%llx\n",
> 
