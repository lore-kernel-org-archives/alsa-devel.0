From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] ad1848_lib: replace common delay loop by
 function
Date: Wed, 05 Sep 2007 00:41:25 +0200
Message-ID: <46DDDF15.8040606@gmail.com>
References: <20070904235332.ca7a3c56.krzysztof.h1@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 3288B103967
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Sep 2007 00:47:49 +0200 (CEST)
In-Reply-To: <20070904235332.ca7a3c56.krzysztof.h1@wp.pl>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/04/2007 11:53 PM, Krzysztof Helt wrote:

> +static void snd_ad1848_ready(struct snd_ad1848 *chip)

Same request for a name change -- "ready" sounds boolean to me...

> -#if 0
> -	printk("codec out - reg 0x%x = 0x%x\n", chip->mce_bit | reg, value);
> -#endif

Grrrrrr.

Rene.
