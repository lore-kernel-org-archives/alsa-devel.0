From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [patch] ALSA: bebob: sizeof() vs ARRAY_SIZE() typo
Date: Thu, 29 May 2014 06:58:25 +0900
Message-ID: <53865C01.3040400@sakamocchi.jp>
References: <20140528164330.GD1824@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id AA55A26567C
 for <alsa-devel@alsa-project.org>; Wed, 28 May 2014 23:58:28 +0200 (CEST)
In-Reply-To: <20140528164330.GD1824@mwanda>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

(May 19 2014 01:43), Dan Carpenter wrote:
> ARRAY_SIZE() was intended here instead of sizeof().  The
> "bridgeco_freq_table" array holds integers so the original condition is
> never true.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewd-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Tested-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

> diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
> index 514c7c9..bc4f827 100644
> --- a/sound/firewire/bebob/bebob_stream.c
> +++ b/sound/firewire/bebob/bebob_stream.c
> @@ -749,7 +749,7 @@ parse_stream_formation(u8 *buf, unsigned int len,
>  		if (buf[2] == bridgeco_freq_table[i])
>  			break;
>  	}
> -	if (i == sizeof(bridgeco_freq_table))
> +	if (i == ARRAY_SIZE(bridgeco_freq_table))
>  		return -ENOSYS;
>  
>  	/* Avoid double count by different entries for the same rate. */
