From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [patch] ALSA: oxfw: fix a condition in
	start_stream()
Date: Fri, 27 Feb 2015 09:36:53 +0900
Message-ID: <54EFBC25.9020002@sakamocchi.jp>
References: <20150226203202.GC6820@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 06C072606D0
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 01:37:00 +0100 (CET)
In-Reply-To: <20150226203202.GC6820@mwanda>
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

Hi Dan,

On Feb 27 2015 05:32, Dan Carpenter wrote:
> Static checkers complain that this function doesn't return negative
> error codes.  The comments for amdtp_stream_wait_callback() say that we
> should stop the stream if it returns false.
> 
> Fixes: f3699e2c7745 ('ALSA: oxfw: Change the way to start stream')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks for this patch, while the error code should be assigned to
-ETIMEDOUT, as the other drivers do.

I post an alternative patch to fix them.


Thanks

Takashi Sakamoto

> diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
> index 29ccb36..ee67581 100644
> --- a/sound/firewire/oxfw/oxfw-stream.c
> +++ b/sound/firewire/oxfw/oxfw-stream.c
> @@ -172,7 +172,7 @@ static int start_stream(struct snd_oxfw *oxfw, struct amdtp_stream *stream,
>  
>  	/* Wait first packet */
>  	err = amdtp_stream_wait_callback(stream, CALLBACK_TIMEOUT);
> -	if (err < 0)
> +	if (err == 0)
>  		stop_stream(oxfw, stream);
>  end:
>  	return err;
