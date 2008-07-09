From: tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Subject: Re: [PATCH] ALSA driver for SGI O2 audio board
Date: Wed, 9 Jul 2008 20:31:38 +0200
Message-ID: <20080709183138.GA21872@alpha.franken.de>
References: <20080704234559.C959CFB63A@solo.franken.de>
	<s5hy74dvga5.wl%tiwai@suse.de>
	<20080709175059.GA10046@alpha.franken.de>
	<s5hprpm61cx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by alsa0.perex.cz (Postfix) with ESMTP id C867C244A1
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Jul 2008 20:57:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hprpm61cx.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 10, 2008 at 02:15:26AM +0200, Takashi Iwai wrote:
> At Wed, 9 Jul 2008 19:50:59 +0200,
> > > If there are shared interrupts, they could be called before the
> > > initialization below.  So, safer to move after the init.
> > 
> > they can't be shared and it's already done before any hardware init.
> 
> Then any reason to pass IRQF_SHARED?

of course not. I'll remove it.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
