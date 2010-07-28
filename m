From: Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH 09/10] oss: msnd: check request_region() return value
Date: Wed, 28 Jul 2010 22:00:02 +0200
Message-ID: <20100728200002.GP26313@bicker>
References: <1280335296-23475-1-git-send-email-segooon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1280335296-23475-1-git-send-email-segooon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kulikov Vasiliy <segooon@gmail.com>
Cc: kernel-janitors@vger.kernel.org, Andrew Veliath <andrewtv@usa.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 28, 2010 at 08:41:36PM +0400, Kulikov Vasiliy wrote:
> request_region() may fail, if so return -ENOMEM.
> 
> Signed-off-by: Kulikov Vasiliy <segooon@gmail.com>
> ---
>  sound/oss/msnd_pinnacle.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/oss/msnd_pinnacle.c b/sound/oss/msnd_pinnacle.c
> index bfaac5f..cd70b9a 100644
> --- a/sound/oss/msnd_pinnacle.c
> +++ b/sound/oss/msnd_pinnacle.c
> @@ -1400,9 +1400,13 @@ static int __init attach_multisound(void)
>  		printk(KERN_ERR LOGNAME ": Couldn't grab IRQ %d\n", dev.irq);
>  		return err;
>  	}
> -	request_region(dev.io, dev.numio, dev.name);

This should be -EBUSY as well.  The same for "[PATCH 06/10] ALSA: msnd: 
check request_region() return value"

Another way to write that would be:

-	request_region(dev.io, dev.numio, dev.name);
+	err = request_region(dev.io, dev.numio, dev.name);
+	if (err) {
+		free_irq(dev.irq, &dev);
+		return err;
+	}

regards,
dan carpenter

> +	if (request_region(dev.io, dev.numio, dev.name) == NULL) {
> +		free_irq(dev.irq, &dev);
> +		return -ENOMEM;
> +	}
