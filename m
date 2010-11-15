From: Peter Rosin <peda@lysator.liu.se>
Subject: Re: [PATCH] ALSA: AT73C213: Rectify misleading
	comments.
Date: Mon, 15 Nov 2010 19:52:31 +0100
Message-ID: <4CE1816F.6080000@lysator.liu.se>
References: <1289820546-2078-1-git-send-email-peda@axentia.se>
	<1289832634.18691.1.camel@hcegtvedt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 616022452E
	for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2010 19:52:43 +0100 (CET)
In-Reply-To: <1289832634.18691.1.camel@hcegtvedt>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Cc: alsa-devel@alsa-project.org, Peter Rosin <peda@axentia.se>, Hans-Christian Egtvedt <hcegtvedt@atmel.com>
List-Id: alsa-devel@alsa-project.org

Den 2010-11-15 15:50 skrev Hans-Christian Egtvedt:
> On Mon, 2010-11-15 at 12:29 +0100, Peter Rosin wrote: 
>> The Atmel SSC can divide by even numbers, not only powers of two and
>> the given values are binary, not hexadecimal.
> 
> IIRC the divide by power of two is more related to the generic clocks in
> the device thatn the SSC module itself.
> 
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  sound/spi/at73c213.c |    6 +++---
>>  1 files changed, 3 insertions(+), 3 deletions(-)
>>
>> I'm working on a driver based on AT73C213 and have had to look up
>> if the below nits were code problems or comment problems.  The Atmel
>> specs tells me that the comments are wrong and this patch fixes
>> those comments.
>>
>> Cheers and thanks,
>> Peter
>>
>> diff --git a/sound/spi/at73c213.c b/sound/spi/at73c213.c
>> index 1bc56b2..548e17a 100644
>> --- a/sound/spi/at73c213.c
>> +++ b/sound/spi/at73c213.c
>> @@ -155,7 +155,7 @@ static int snd_at73c213_set_bitrate(struct snd_at73c213 *chip)
>>  	if (max_tries < 1)
>>  		max_tries = 1;
>>  
>> -	/* ssc_div must be a power of 2. */
>> +	/* ssc_div must be even. */
> 
> IIRC the bitrate is controlled by a generic clock, and it has a power of
> two divider possibility. Hence the comment about power of two.

The way I read it is that the driver looks for a divider for the SSC that
is compatible with a power-of-two divider for chip->board->dac_clk.
But the divider for the SSC need not be a power of two, it just needs to
be even.  On the AT91SAM9261-EK board the SSC clock is inherited from
the same clock as dac_clk, and in that case the SSC clock must have a
power of two divider as it has to be 8x the dac_clk which in turn has
to be a power of two divider.  This is apparent from this snippet

		/* 256 / (2 * 16) = 8 */
		dac_rate_new = 8 * (ssc_rate / ssc_div);

in the do-while loop.  So in that case it ssc_div must indeed be a power
of two.  It is not unlikely that ssc_div is always a power of two for
all real boards featuring an at73c213.

However, from the driver point of view, there is nothing that requires
the SSC clock and the dac_clk to be based on the same clock, and if they
are unrelated it is entirely possible that ssc_div does not end up a
power of two.  The driver code is prepped for this case and happily runs
along with any even ssc_div that fits the bill.

My point is that the "ssc_div must be a power of 2" comment is
misleading in that this is an external (to the driver) constraint that
has nothing to do with the driver code.  This constraint is also not
universally true, and the comment just makes it harder to follow what
the driver code is doing.

Heck, the comment is right before a statement that makes ssc_div even
using some bit manipulations.  IMHO, the comment *should* describe what
the bit manipulations are doing, and not some external constraint.

The current comment just makes you wonder if the code or the comment is
wrong.

Cheers,
Peter
