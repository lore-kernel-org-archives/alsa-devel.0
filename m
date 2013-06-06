From: Daniel Mack <zonque@gmail.com>
Subject: Re: Generic clock divider indices
Date: Thu, 06 Jun 2013 16:31:59 +0200
Message-ID: <51B09D5F.6010803@gmail.com>
References: <51B09224.9050409@gmail.com> <20130606135605.GB9980@sirena.org.uk>
 <51B09830.7020208@gmail.com> <20130606142409.GE31367@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f44.google.com (mail-wg0-f44.google.com [74.125.82.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D982265654
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 16:31:35 +0200 (CEST)
Received: by mail-wg0-f44.google.com with SMTP id m15so1106293wgh.23
 for <alsa-devel@alsa-project.org>; Thu, 06 Jun 2013 07:31:35 -0700 (PDT)
In-Reply-To: <20130606142409.GE31367@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 06.06.2013 16:24, Mark Brown wrote:
> On Thu, Jun 06, 2013 at 04:09:52PM +0200, Daniel Mack wrote:
>> On 06.06.2013 15:56, Mark Brown wrote:
> 
>>> I don't think this is a terribly sensible idea; as soon as you start
>>> relying on these dividers in machine code you're going to run into
>>> drivers that just don't implement them either due to hardware or due to
>>> them being able to figure things out by themselves and...
> 
>> I do see that we have a way to propagate the sysclk, but how would you
>> determine the bit clock rate from a codec driver?
> 
> Usually you just set the bit clock to be whatever the minimim clock
> needed for the data is - there's helpers in soc-utils.c to get the
> number - or the next highest sensible rate if there's a division
> problem.

Hmm, but in case the codec is slave to all clocks, it must have a way to
determine what the bit clock rate (or the ratio to MCLK, respectively)
is. It can't just _set_ it. Which detail am I missing?

>> Also, the same problem with freely definable indices is true for
>> .set_sysclk() as well. Not all drivers expect the actual MCLK rate here.
> 
> Yes, and thus you start to see the problems doing this sort of stuff
> generically.  There's often also a whole bunch of different ways the
> clocking can be set up

But there's always a MCLK, a BCLK and a LRCLK. And thus, there are
always ratios between them. It might even make sense to let the core
inform the codec drivers, instead of relying on the machine code.

> which can make a material difference to the
> quality of the output and may require some system specific taste to
> choose.

I see your point, but no solution yet :)


Daniel
