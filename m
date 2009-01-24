From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] Turtle Beach Multisound Classic/Pinnacle
 driver (4th rev)
Date: Sat, 24 Jan 2009 16:42:40 +0100
Message-ID: <20090124164240.38cbe823.krzysztof.h1@poczta.fm>
References: <20090124133528.05da0507.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 09B141037FA
	for <alsa-devel@alsa-project.org>; Sat, 24 Jan 2009 16:39:27 +0100 (CET)
In-Reply-To: <20090124133528.05da0507.krzysztof.h1@poczta.fm>
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
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 24 Jan 2009 13:35:28 +0100
Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> +	.buffer_bytes_max =	0x3000,
> +	.period_bytes_min =	0x40,
> +	.period_bytes_max =	0x1800,
> +	.periods_min =		2,
> +	.periods_max =		3,

I have investigated the max_periods number 
and at least some code called from the interrupt
assumes no more then 3 periods in the buffer.
I do not understand the code enough to change
this.

Regards,
Krzysztof


----------------------------------------------------------------------
Zobacz gry internetowe dla dzieci!
sprawdz >>>http://link.interia.pl/f202c
