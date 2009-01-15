From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/1] ALSA: ASoC: DaVinci: Fix SFFSDR init
	bug.
Date: Thu, 15 Jan 2009 13:20:38 -0800
Message-ID: <200901151320.39035.david-b@pacbell.net>
References: <20090108121613.1ef53112.hugo@hugovil.com>
	<1232051992-31817-1-git-send-email-hugo@hugovil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp107.sbc.mail.gq1.yahoo.com (smtp107.sbc.mail.gq1.yahoo.com
	[67.195.14.110]) by alsa0.perex.cz (Postfix) with SMTP id D19B910389E
	for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2009 22:20:41 +0100 (CET)
In-Reply-To: <1232051992-31817-1-git-send-email-hugo@hugovil.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: davinci-linux-open-source@linux.davincidsp.com, Hugo Villeneuve <hugo@hugovil.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thursday 15 January 2009, Hugo Villeneuve wrote:
> Removed call to machine_is_sffsdr() in module init
> function because it always returns zero and causes
> GCC to optimise and remove all functions of the module.
> 
> Signed-off-by: Hugo Villeneuve <hugo@hugovil.com>

NAK.  Enable the SFF board in Kconfig, and it won't
be returning false.  If you don't enable it, you
can't possibly be running on an SFF board, and so
there's no reason to include any of these function...


> ---
>  sound/soc/davinci/davinci-sffsdr.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/davinci/davinci-sffsdr.c b/sound/soc/davinci/davinci-sffsdr.c
> index 1bbde3e..3e8e6cd 100644
> --- a/sound/soc/davinci/davinci-sffsdr.c
> +++ b/sound/soc/davinci/davinci-sffsdr.c
> @@ -115,9 +115,6 @@ static int __init sffsdr_init(void)
>  {
>  	int ret;
>  
> -	if (!machine_is_sffsdr())
> -		return -EINVAL;
> -
>  	sffsdr_snd_device = platform_device_alloc("soc-audio", 0);
>  	if (!sffsdr_snd_device) {
>  		printk(KERN_ERR "platform device allocation failed\n");
> -- 
> 1.5.4.5
> 
> 
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source@linux.davincidsp.com
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
> 
> 
