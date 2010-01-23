From: David Fries <david@fries.net>
Subject: Re: [PATCH] modem.conf Off-hook improve behavior
Date: Sat, 23 Jan 2010 00:06:20 -0600
Message-ID: <20100123060620.GA19304@spacedout.fries.net>
References: <20091225202238.GA12403@spacedout.fries.net>
	<s5h1vhi8l9s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from SpacedOut.fries.net (SpacedOut.fries.net [67.64.210.234])
	by alsa0.perex.cz (Postfix) with ESMTP id 449FF103814
	for <alsa-devel@alsa-project.org>; Sat, 23 Jan 2010 07:06:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h1vhi8l9s.wl%tiwai@suse.de>
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

On Fri, Jan 22, 2010 at 11:51:59AM +0100, Takashi Iwai wrote:
> At Fri, 25 Dec 2009 14:22:38 -0600,
> David Fries wrote:
> > On a side note, do any of the alsa voice/software modems support
> > notifying userspace when the line is ringing?  I'm using intel8x0m,
> > not that I think it matters here.
> 
> I don't know of any, too.

I have a patch adding a mixer control to provide Ring Detection
notification when the ring GPIO pin is going crazy.  That's used to
indicate when a local phone went off hook, but only the first time
after being on hook for an extended time, or when a local phone goes
back on hook, when the modem goes on hook or off hook, when a local
user dials pulse (not tone), or if going crazy for an extended period
of time the line might actually be ringing.  In practice it has been
very reliable as long as you ignore the short pulses, other than when
someone is pulse dialing that is.

I also hooked up Caller ID and Loop Current Sense which is used to
detect remote hangup (or a local phone going off hook when Caller ID
is enabled).  It is working, but it needs some cleanup before it is
ready to be submitted.  As dealing with the interrupts is more
hardware specific I'm also thinking of moving setting up the sticky
and interrupt mask setup from snd_ac97_modem_build to someplace in the
intel8x0m.c file.  Dealing with the hardware to get a usable ring
indication out makes me long for the days when you could just wait for
RING and the modem hid he details.

I have some changes to Asterisk as well to make use of it, though it
is suffering from some audio glitches and isn't as far along.

-- 
David Fries <david@fries.net>
http://fries.net/~david/ (PGP encryption key available)
