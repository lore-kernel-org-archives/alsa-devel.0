From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH] sound/oss/pss: Fix test of unsigned in
 pss_reset_dsp() and pss_download_boot()
Date: Wed, 16 Dec 2009 17:23:03 -0700
Message-ID: <4B2979E7.7060305@boundarydevices.com>
References: <4B28085A.6020101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth02.csee.onr.siteprotect.com
	(smtpauth02.csee.onr.siteprotect.com [64.26.60.136])
	by alsa0.perex.cz (Postfix) with ESMTP id 532FC24150
	for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2009 01:23:14 +0100 (CET)
In-Reply-To: <4B28085A.6020101@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

Roel Kluin wrote:
> limit and jiffies are unsigned so the test does not work.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> Found using coccinelle: http://coccinelle.lip6.fr/
> 
> diff --git a/sound/oss/pss.c b/sound/oss/pss.c
> index 83f5ee2..9325f4d 100644
> --- a/sound/oss/pss.c
> +++ b/sound/oss/pss.c
> @@ -269,7 +269,7 @@ static int pss_reset_dsp(pss_confdata * devc)
>  	unsigned long   i, limit = jiffies + HZ/10;
>  
>  	outw(0x2000, REG(PSS_CONTROL));
> -	for (i = 0; i < 32768 && (limit-jiffies >= 0); i++)

I think
	for (i = 0; i < 32768 && ( (int)(limit-jiffies) >= 0); i++)

works better when jiffies wrap

> +	for (i = 0; i < 32768 && (limit >= jiffies); i++)
>  		inw(REG(PSS_CONTROL));
>  	outw(0x0000, REG(PSS_CONTROL));
>  	return 1;
> @@ -369,11 +369,11 @@ static int pss_download_boot(pss_confdata * devc, unsigned char *block, int size
>  		outw(0, REG(PSS_DATA));
>  
>  		limit = jiffies + HZ/10;
> -		for (i = 0; i < 32768 && (limit - jiffies >= 0); i++)
> +		for (i = 0; i < 32768 && (limit >= jiffies); i++)
>  			val = inw(REG(PSS_STATUS));
>  
>  		limit = jiffies + HZ/10;
> -		for (i = 0; i < 32768 && (limit-jiffies >= 0); i++)
> +		for (i = 0; i < 32768 && (limit >= jiffies); i++)
>  		{
>  			val = inw(REG(PSS_STATUS));
>  			if (val & 0x4000)
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
