From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [PATCH] Fix buffer position for ATI SB4x0
Date: Mon, 2 Jun 2008 11:14:04 -0300
Message-ID: <20080602111404.3929726c@gaivota>
References: <20080529111022.102bf250@gaivota>
	<s5hod6pchui.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	by alsa0.perex.cz (Postfix) with ESMTP id E67A0245E7
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Jun 2008 16:14:18 +0200 (CEST)
In-Reply-To: <s5hod6pchui.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 29 May 2008 16:20:21 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 29 May 2008 11:10:22 -0300,
> Mauro Carvalho Chehab wrote:
> > 
> > ATI SB4x0 doesn't need any fix at position.
> 
> It's not about the position fixing but whether to use the
> position-buffer.  The devices on the blacklist are the ones that have
> no position buffer.  So, it would fall into LPIB mode, and this list
> avoids it from the beginning.

Sometimes, I get this message:

[  857.014011] hda-intel: Invalid position buffer, using LPIB read method instead.

It is weird, since this line doesn't appear always.

> > This patch solves the issue of receiving several clicks during capture on those
> > devices.
> > 
> > Tested with a Gateway Notebook MX-6453.
> 
> The click noise is often a different problem.  Did you already try
> the patch below?

This patch is already here on my testing environment.

There are a few reports I found at the net about Gateway devices with SB450 ATI
chipset. Some suggestions for working with MIC pointed the need of using
position_fix=0 to avoid the clicks on those devices.


One weird thing is that I've did this procedure, when I generated the patch:
	- tested without the patch - clicks at mic;
	- applied the patch I sent - no clicks;
	- removed the patch after your email - no clicks;
	- reapplied/removed several times - no clicks.

I'll try today to test with and without the position fix after cold boot/soft
boot/resume. Maybe there are some registers that aren't properly initialized on
some cases.

Btw, after a suspend/resume, some widgets aren't properly restored (at
mercurial tree version). For example, if I suspend with master Mute on, after
resume, mute is off (but the kmix still shows it as muted). I'm not sure if the
clicks happen after resume. I'll double check it.

Cheers,
Mauro
