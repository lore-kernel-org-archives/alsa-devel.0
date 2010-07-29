From: errordeveloper@gmail.com
Subject: Re: PROPOSAL: Layer Signal Processing Architecture
Date: Thu, 29 Jul 2010 22:44:54 +0100
Message-ID: <20100729214454.GB14426@00110101.home>
References: <20100729202024.GA14426@00110101.home>
	<4C51E9F1.3090601@faberman.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 87CEF1039D5
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jul 2010 23:45:12 +0200 (CEST)
Received: by wyb42 with SMTP id 42so564246wyb.38
	for <alsa-devel@alsa-project.org>; Thu, 29 Jul 2010 14:45:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C51E9F1.3090601@faberman.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 29, 2010 at 10:52:01PM +0200, Florian Faber wrote:
> On 07/29/10 22:20, Ilya D wrote:
> 
> > it's not to replace ALSA, but just to bring a different approach for
> > design engineers of professional audio applications.
> > we all know that these days a lot manufactuares chose Linux
> > for their Mixing Consoles (such as Midas, Lawo, Calrec and others),
> > also other products use Linux, but there might be only a few who use
> > ALSA (as far as i could find out there rather NONE in pro-audio Linux devices).
> 
> What for would I use ALSA in a mixing console? In a mixing console I
> control the user interface and a bunch of external DSP units.

sure, ALSA doesn't fit in.

so the idea is to implement a cross-platform approach (even if the
number of platforms it would span about two or three DSPs)
> 
> Besides, audio interfaces become less important in pro audio with
> upcoming transport over ethernet.
sure, there we are talking about endpoints.

> 
> > ALSA had been designed for conventional sound-cards (largely) also there
> > drivers for RME, DigiGram and other pro-interfaces,
> > but the hardware is still proprietary and it isn't quite flexible.
> 
> What do you want to say with the latter? They are just interfaces, what
> more should they do?
> 
yep, sure. but i was talking about a card that would have configurable
processing block, and the implementation of each block could be updated
by the user.

> > Another motivating factor is upcomming completition of AVB ethernet
> > standard from IETF/IEEE, there had been no publicaly avaliable code
> > for this, nor i could find any discussions of how it could be
> > implemented in Linux. However i have contact with a professor Richard
> > Foss from Rhodes University, and there they have implemented a library
> > and packet generator for AVB, though they haven't yet published this code.
> 
> You cannot do AVB in software.
well, i'm sure you can fake it, it won't be the best,
but with some optimization you could surely implement it so
that it would allow at least one channel each way!

> 
> > There also hasn't heppend any wide adoption of OSC, and may be OSC is
> > not that great?
> 
> That depends on the job. For the purpose you stated - no it is not.
well ..i didn't quite mention what the principle of ACMP are,
it's still work in progress at very early stage, because i don't have
the time to write everything down propertly right now.
> 
> 
> Flo
> -- 
> Machines can do the work, so people have time to think.
> public key DA43FEF4          x-hkp://wwwkeys.eu.pgp.net
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
