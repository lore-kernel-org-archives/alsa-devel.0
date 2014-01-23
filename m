From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: [PATCH] fix alsa-tools/hdspmixer for RME 9632 A
Date: Thu, 23 Jan 2014 20:05:00 +0100
Message-ID: <20140123190500.GQ25242@ltw.loris.tv>
References: <CADeOaFr6H_pct9bywOey2p1XVfrT3sKmSDiGO_DS0vuPpcwqUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [188.40.101.23])
 by alsa0.perex.cz (Postfix) with ESMTP id E244B265299
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2014 20:05:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CADeOaFr6H_pct9bywOey2p1XVfrT3sKmSDiGO_DS0vuPpcwqUQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Turing <mail@danielturing.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 23, 2014 at 12:38:29PM +0100, Daniel Turing wrote:


Hi!

> since i never turned up here, let me just quickly congratulate and
> thank y'all for your outstanding work on linux audio. My world
> wouldn't be as great without you!

You're welcome.

> I run a HDSP 9632 with the "AI4s-192 AIO" 4x Analog input extension
> board. It works great so far, but hdspmixer segfaults because it tries
> to show 16 channels with fltk, but doesnt care to initialize the
> channel labels for the input extension board.

Since I don't own the card in question, I cannot test the patch and
simply trust your word here.

OTOH, I have to admit I don't fully understand the patch. What you're
doing is to increment the number of output channels in case you have an
additional input module.

The input module is handled in HDSPMixerCard.cxx. Is it just a side
effect? Because semantically, it is wrong to create output destinations
just to get input channels rendered.

Why is hdspmixer segfaulting? Do you happen to have a backtrace or
explanation? This should be part of the commit message.


Minor nitpicking: I'd prefer (foo || bar) over (foo|bar). Sure, both do
the trick, but the first seems easier to read to me.


For the final patch:

   <http://www.alsa-project.org/main/index.php/GIT_Server#Occasional_Developers>

Basically: proper commit message and sent to patch@alsa-project.org),
so your attribution will always be kept.




Cheers

-- 
mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver
