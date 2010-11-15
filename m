From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: Re: [PATCH] ALSA: AT73C213: Rectify misleading
	comments.
Date: Mon, 15 Nov 2010 15:50:34 +0100
Message-ID: <1289832634.18691.1.camel@hcegtvedt>
References: <1289820546-2078-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bagnes.atmel.com (smtpeu1.atmel.com [195.65.72.27])
	by alsa0.perex.cz (Postfix) with ESMTP id AF219103836
	for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2010 15:50:41 +0100 (CET)
In-Reply-To: <1289820546-2078-1-git-send-email-peda@axentia.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Rosin <peda@axentia.se>
Cc: alsa-devel@alsa-project.org, Hans-Christian Egtvedt <hcegtvedt@atmel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-11-15 at 12:29 +0100, Peter Rosin wrote: 
> The Atmel SSC can divide by even numbers, not only powers of two and
> the given values are binary, not hexadecimal.

IIRC the divide by power of two is more related to the generic clocks in
the device thatn the SSC module itself.

> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  sound/spi/at73c213.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> I'm working on a driver based on AT73C213 and have had to look up
> if the below nits were code problems or comment problems.  The Atmel
> specs tells me that the comments are wrong and this patch fixes
> those comments.
> 
> Cheers and thanks,
> Peter
> 
> diff --git a/sound/spi/at73c213.c b/sound/spi/at73c213.c
> index 1bc56b2..548e17a 100644
> --- a/sound/spi/at73c213.c
> +++ b/sound/spi/at73c213.c
> @@ -155,7 +155,7 @@ static int snd_at73c213_set_bitrate(struct snd_at73c213 *chip)
>  	if (max_tries < 1)
>  		max_tries = 1;
>  
> -	/* ssc_div must be a power of 2. */
> +	/* ssc_div must be even. */

IIRC the bitrate is controlled by a generic clock, and it has a power of
two divider possibility. Hence the comment about power of two.

<snipp other two changes that looked fine>

-- 
Hans-Christian Egtvedt
