From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [patch] ALSA: line6: fix a crash in
	line6_hwdep_write()
Date: Wed, 12 Oct 2016 15:41:22 +0900
Message-ID: <edf28b5a-ef21-e5c6-3791-8988ad0672fb@sakamocchi.jp>
References: <20161012062140.GT12841@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id F211E266A39
 for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2016 08:41:24 +0200 (CEST)
In-Reply-To: <20161012062140.GT12841@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Jaroslav Kysela <perex@perex.cz>, Andrej Krutak <dev@andree.sk>
Cc: alsa-devel@alsa-project.org, kbuild test robot <fengguang.wu@intel.com>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Oct 12 2016 15:21, Dan Carpenter wrote:
> The error checking here is messed up so we could end up dereferencing
> -EFAULT.
>
> Fixes: a16039cbf1a1 ('ALSA: line6: Add hwdep interface to access the POD control messages')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

> diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
> index 14e587e..90009c0 100644
> --- a/sound/usb/line6/driver.c
> +++ b/sound/usb/line6/driver.c
> @@ -604,8 +604,8 @@ line6_hwdep_write(struct snd_hwdep *hwdep, const char __user *data, long count,
>  	}
>
>  	data_copy = memdup_user(data, count);
> -	if (IS_ERR(ERR_PTR))
> -		return -ENOMEM;
> +	if (IS_ERR(data_copy))
> +		return PTR_ERR(data_copy);
>
>  	rv = line6_send_raw_message(line6, data_copy, count);
