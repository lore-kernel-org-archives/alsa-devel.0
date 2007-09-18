From: Krzysztof Helt <krzysztof.h1@gmail.com>
Subject: Re: [PATCH] ad1838/cs4231 -- fix MCE timeout upon
 initial load
Date: Tue, 18 Sep 2007 09:33:38 +0200
Message-ID: <20070918093338.a194182f.krzysztof.h1@gmail.com>
References: <46E58D01.9080809@gmail.com>
	<Pine.LNX.4.58.0709170325380.27377@shell4.speakeasy.net>
	<46EF18FF.7070906@gmail.com>
	<Pine.LNX.4.58.0709171757500.27377@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 95F6824468
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 09:26:17 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id b21so1189218nfd
	for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2007 00:26:17 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.58.0709171757500.27377@shell4.speakeasy.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: Takashi Iwai <tiwai@suse.de>, devel <alsa-devel@alsa-project.org>, ALSA@alsa-project.org, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 17 Sep 2007 19:32:11 -0700 (PDT)
Trent Piepho <xyzzy@speakeasy.org> wrote:

> Simplest fix.
> 
> Signed-off-by: Trent Piepho <xyzzy@speakeasy.org>
> 
> diff -r 50502c13d2cf isa/ad1848/ad1848_lib.c
> --- a/isa/ad1848/ad1848_lib.c	Mon Sep 17 19:08:32 2007 +0200
> +++ b/isa/ad1848/ad1848_lib.c	Mon Sep 17 19:19:52 2007 -0700
> @@ -236,7 +236,9 @@ static void snd_ad1848_mce_down(struct s
>  	 * calibration process to start. Needs upto 5 sample periods on AD1848
>  	 * which at the slowest possible rate of 5.5125 kHz means 907 us.
>  	 */
> +	spin_unlock_irqrestore(&chip->reg_lock, flags);
>  	msleep(1);
> +	spin_lock_irqsave(&chip->reg_lock, flags);
>  
>  	snd_printdd("(2) jiffies = %lu\n", jiffies);
>  

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
