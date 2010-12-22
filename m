From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: dev_info() argument in sound/soc/soc_dapm.c
Date: Wed, 22 Dec 2010 16:42:01 +0200
Message-ID: <20101222164201.8108ac05.jhnikula@gmail.com>
References: <s5hzkrxvr4b.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f42.google.com (mail-bw0-f42.google.com
	[209.85.214.42])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BB0B103AF3
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 15:42:21 +0100 (CET)
Received: by bwz13 with SMTP id 13so5959273bwz.29
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 06:42:20 -0800 (PST)
In-Reply-To: <s5hzkrxvr4b.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 22 Dec 2010 15:06:44 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> Hi,
> 
> my build tests caught a warning regarding the conversion to dev_info()
> in soc-dapm.c.  dev_info() is printf style, thus you shouldn't pass
> the expanded string to the format argument.
> 
> I applied the following patch to topic/asoc branch.
> 
...

> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -110,7 +110,7 @@ static void pop_dbg(struct device *dev, u32 pop_time, const char *fmt, ...)
>  
>  	va_start(args, fmt);
>  	vsnprintf(buf, PAGE_SIZE, fmt, args);
> -	dev_info(dev, buf);
> +	dev_info(dev, "%s", buf);
>  	va_end(args);
>  
Thanks! I guess this is safer as the buf here should contain only the
characters to be printed.


-- 
Jarkko
