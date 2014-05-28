From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [patch 2/2] ALSA: fireworks: small leak on error
 path
Date: Thu, 29 May 2014 06:57:55 +0900
Message-ID: <53865BE3.3010602@sakamocchi.jp>
References: <20140528164246.GC1824@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id EF100265696
 for <alsa-devel@alsa-project.org>; Wed, 28 May 2014 23:58:02 +0200 (CEST)
In-Reply-To: <20140528164246.GC1824@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

(May 29 2014 01:42), Dan Carpenter wrote:
> There was a typo here so we return directly instead of freeing "hwinfo".
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewd-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Tested-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

> diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
> index 8e856cc..996fdc4 100644
> --- a/sound/firewire/fireworks/fireworks.c
> +++ b/sound/firewire/fireworks/fireworks.c
> @@ -157,7 +157,7 @@ get_hardware_info(struct snd_efw *efw)
>  	/* Hardware metering. */
>  	if (hwinfo->phys_in_grp_count  > HWINFO_MAX_CAPS_GROUPS ||
>  	    hwinfo->phys_out_grp_count > HWINFO_MAX_CAPS_GROUPS) {
> -		return -EIO;
> +		err = -EIO;
>  		goto end;
>  	}
>  	efw->phys_in = hwinfo->phys_in;
