From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] cs4231-lib: replace common delay loop by
 function
Date: Wed, 05 Sep 2007 21:11:09 +0200
Message-ID: <46DEFF4D.1010903@gmail.com>
References: <20070905190911.34f41d66.krzysztof.h1@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id D155110388B
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Sep 2007 21:17:38 +0200 (CEST)
In-Reply-To: <20070905190911.34f41d66.krzysztof.h1@wp.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09/05/2007 07:09 PM, Krzysztof Helt wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This patch replaces a common delay loop by a function.
> It also uses ARRAY_SIZE macro for the rates table.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> ---

> +static void snd_cs4231_wait(struct snd_cs4231 *chip)
>  {
>  	int timeout;
> -	unsigned char tmp;
>  
>  	for (timeout = 250;
>  	     timeout > 0 && (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT);
>  	     timeout--)
>  	     	udelay(100);
> +}

Like the inb() pulled out into the body of the for as you did for ad1848 a 
bit better, but otherwise:

Acked-by: Rene Herman <rene.herman@gmail.com>
