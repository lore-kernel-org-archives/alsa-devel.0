From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Wed, 18 Aug 2004 19:37:16 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0408181918160.1769@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0408181538550.24798-100000@studcom.urz.uni-halle.de>
 <1092842830.13603.3.camel@localhost.localdomain> <20040818181350.2b38e875@mango.fruits.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B3EC2233
	for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2004 19:44:08 +0200 (MEST)
In-Reply-To: <20040818181350.2b38e875@mango.fruits.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Shaya Potter <spotter@cs.columbia.edu>, Clemens Ladisch <clemens@ladisch.de>, Mauro Romano Trajber <trajber@terra.com.br>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 18 Aug 2004, Florian Schmidt wrote:

> On Wed, 18 Aug 2004 08:27:10 -0700
> Shaya Potter <spotter@cs.columbia.edu> wrote:
> 
> > A question I've asked, but haven't gotten an answer is why do we have
> > to resort to dmix (i.e. something handled in userspace, and hence
> > subject to the scheduler's whims as only one process can have control
> > over the device) instead of being handled by the kernel driver itself
> > (and hence not subject to the scheduler's whims as much)

Really? If you have no new samples for playback, you cannot mix them.
This situation is same for kernel and user space and depends on the 
scheduler.

> I know how much the ALSA developers favor the modular approach having sw
> mixing done in userspace. I think this is suboptimal for several
> reasons:
> 
> 1] the scheduling problems you mentioned

No, the actual dmix implementation does not use mutexes, so rescheduling 
is not required.

> 2] legacy OSS apps need to be run via aoss which still stinks for many
> apps

It's really problem, but it's problem that we need a compatibility with 
broken API (no library at the initial stage of design, so we cannot 
emulate OSS API directly without using hacks).

Also at this time, nobody helped me to improve the liboss (aoss) code in 
some serious way. I ask why? Nobody uses it? Nobody wants this layer 
fully functional?

I have another idea how we can solve this issue - a network sound driver, 
but this will add the scheduling problems including the throughput of the 
network layer, of course.

> 3] the user has to edit configuration files, which is a showstopper for
> newbies and people who have never had to follow a rigorous syntax.

It's not a goal. In 90% of cases, you may simply use plug:dmix device 
which is already defined in the global configuration files.

When integrated lisp is used, we'll solve the remaining 10% hardware 
constraints.

> I would suggest writing another "dummy" soundcard module which would
> sit "ontop" of the normal alsa driver and which does nothing but provide
> sw mixing access [including the needed resampling and mixing]. 

It's not easy task and again, do we need to code it in the kernel space?
Benefits? Target users?

I think that we should provide the functionality (mixing) for all APIs, 
but the latency issues which mixing might invoke are not a serious 
problem. It's similar to graphics cards. You'll get better results with an 
accelerator (in case of sound with hardware having the mixing capability).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
