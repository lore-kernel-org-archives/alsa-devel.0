From: Ryan Dunn <oryandunn.ml@gmail.com>
Subject: Re: module snd-atiixp issue with
	suspend/hibernate/resume
Date: Mon, 4 May 2009 20:21:24 -0400
Message-ID: <bf4fda4a0905041721u7ca45f3exd9bce86a9967aa30@mail.gmail.com>
References: <bf4fda4a0904282106u7fd3ed03s8d1234423abd679@mail.gmail.com>
	<75b66ecd0904291942u3b352dbj74e5de00ebdf167b@mail.gmail.com>
	<bf4fda4a0904292143s34744db8xbf0b4524567d772@mail.gmail.com>
	<s5h1vralmag.wl%tiwai@suse.de>
	<bf4fda4a0904300449v7a5db4d6vfdf2f772ce102543@mail.gmail.com>
	<bf4fda4a0904301912g3e4f0d86vc32e8a301ff34c19@mail.gmail.com>
	<bf4fda4a0904301924t3aa4b763rba084b829f5dd334@mail.gmail.com>
	<s5hab5t9wr8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f170.google.com (mail-fx0-f170.google.com
	[209.85.220.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 6EBE524498
	for <alsa-devel@alsa-project.org>;
	Tue,  5 May 2009 02:21:25 +0200 (CEST)
Received: by fxm18 with SMTP id 18so4692970fxm.32
	for <alsa-devel@alsa-project.org>; Mon, 04 May 2009 17:21:24 -0700 (PDT)
In-Reply-To: <s5hab5t9wr8.wl%tiwai@suse.de>
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

Thanks Takashi, I appreciate your help so far.  I would normally agree with
you that it is a BIOS issue, however, the machine is a dualboot with WinXP,
where the mute LED works properly after a resume.  Do you have any other
suggestions on where the issue may be?  I hate to keep bugging the list for
such a small issue, but I'm not familiar with the code at all.  When I get
more free time, I'll try to trace through the resume path to see if I can
find anything.  How does the driver actually toggle the LED?  Is the
register a physical register on the card that the hardware reads?  Or does
the code do something else to toggle the LED?

Ryan

On Mon, May 4, 2009 at 3:02 AM, Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 30 Apr 2009 22:24:35 -0400,
> Ryan Dunn wrote:
> >
> > I apologize for the list spam.  I didn't realize that this bit is only
> set
> > when the led is on.  So with that here are diffs of the regs with and
> without
> > mute enabled, before and after suspend.
> > Before suspend:
> > diff regs_w-quirk.txt regs_w-quirk+mute.txt
> > 2c2
> > < 0:02 = 1e1e
> > ---
> > > 0:02 = 9e1e
> > 20c20
> > < 0:26 = 000f
> > ---
> > > 0:26 = 800f
> >
> > After resume:
> > diff regs_w-quirk_after_resume.txt regs_w-quirk_after_resume+mute.txt
> > 2c2
> > < 0:02 = 1e1e
> > ---
> > > 0:02 = 9e1e
> > 20c20
> > < 0:26 = 000f
> > ---
> > > 0:26 = 800f
> >
> > So it looks as if the registers are all ok after a resume, but the LED
> doesn't
> > turn back on.
>
> Then I'd say it's rather a BIOS problem.
>
>
> Takashi
>
