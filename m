From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: PCM multi A/V Sync bug on SMP system
Date: Fri, 30 Apr 2010 13:09:12 +0200
Message-ID: <4BDABA58.3090200@ladisch.de>
References: <n2i20f65d531004242207zde83c421gac35d243420dcaff@mail.gmail.com>	<m2z20f65d531004271228gc2ab0716na68845e9b262a839@mail.gmail.com>
	<y2l20f65d531004281312ja49b333eha47fd0cb9c5b0e01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 6441A103804
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 13:09:20 +0200 (CEST)
In-Reply-To: <y2l20f65d531004281312ja49b333eha47fd0cb9c5b0e01@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Keith Chew <keith.chew@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Keith Chew wrote:
> In pcm_dmix_i386.c, we have:
> 
> 				if (!strncmp(line, "processor", 9))
> 					smp++;
> 
> I have commented out the smp++, so that it thinks that I am on a uni
> processor. Voila, so AV sync issues!
> 
> My question now is what are the implications of this change? Looking
> at pcm_dmix_i386.h, it uses locks on an SMP system, but exclude them
> if not SMP. Do we still need this lock, even if I am on a dual core,
> ie 1 processor 2 cores?

Dual-core processors behave like two separate processors, i.e., they
still have separate caches, so we still need to synchronize memory
accesses to ensure that they happen in the correct order.

I'd guess that the memory bus synchronization of the three dmix devices
makes the memory accesses too slow.  What is the CPU utilization of
mplayer with and without SMP?


Regards,
Clemens
