From: Nickolas <ultrageek.lloyd@gmail.com>
Subject: Re: [PATCH] - fix speaker output for toshiba nb205
	netbooks
Date: Fri, 15 Jan 2010 23:00:15 -0500
Message-ID: <20100115230015.2eb78b09@nick-PC>
References: <20100112165832.35b5d23f@nick-PC> <s5hwrzm4e1j.wl%tiwai@suse.de>
	<20100113110611.73625b1e@nick-PC> <s5haawivv1r.wl%tiwai@suse.de>
	<20100113141308.39344e5c@nick-PC>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f195.google.com (mail-yw0-f195.google.com
	[209.85.211.195])
	by alsa0.perex.cz (Postfix) with ESMTP id 3CDF61037F3
	for <alsa-devel@alsa-project.org>; Sat, 16 Jan 2010 04:59:58 +0100 (CET)
Received: by ywh33 with SMTP id 33so1109124ywh.23
	for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2010 19:59:57 -0800 (PST)
In-Reply-To: <20100113141308.39344e5c@nick-PC>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nickolas <ultrageek.lloyd@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 13 Jan 2010 14:13:08 -0500
Nickolas <ultrageek.lloyd@gmail.com> wrote:

> On Wed, 13 Jan 2010 17:17:20 +0100
> Takashi Iwai <tiwai@suse.de> wrote:
> 
> > At Wed, 13 Jan 2010 11:06:11 -0500,
> > Nickolas wrote:
> > > 
> > > On Wed, 13 Jan 2010 09:14:32 +0100
> > > Takashi Iwai <tiwai@suse.de> wrote:
> > > 
> > > > At Tue, 12 Jan 2010 16:58:32 -0500,
> > > > Nickolas wrote:
> > > > > 
> > > > > this is a quick fix i wrote up a couple days ago to fix speaker
> > > > > output on the Realtek ALC272 codec present in toshiba nb205
> > > > > netbooks.  presently, speaker output doesn't work at all on this
> > > > > model, regardless of settings in the mixer.  this is because the
> > > > > current driver thinks the speaker is at nid 0x0c instead of the
> > > > > correct 0x17.  i'm not too familiar with this hardware, so i'm not
> > > > > sure that this patch won't have any negative effects for other
> > > > > hardware.  it also seems like a messy way of fixing the problem.
> > > > > any comments or suggestions are welcome, as is testing for those who
> > > > > have this board.  diffed against the latest git.
> > > > 
> > > > Thanks for the patch.  The change looks safe to me.
> > > > 
> > > > But I'm still wondering whether model=auto doesn't work for this device.
> > > > Could you try it with the latest driver?
> > > > 
> > > > 
> > > > thanks,
> > > > 
> > > > Takashi
> > > > 
> > > 
> > > hmm, i feel stupid.  so, it works with model=auto, but why is that not implied when the model parameter isn't specified on the command line?
> > 
> > OK, that's good to hear.  IIRC, the quirk was there because it didn't work
> > with model=auto, at least, at that time.
> > 
> > I guess it's time to back to auto option again.  I'll fix now.
> > 
> > Thanks for quick testing!
> > 
> > 
> > Takashi
> 
> no problem.  i'll test all the ports later today when i have time to make sure that they work properly with model=auto, just to be sure.  thanks for the help!
> 
> Nick

sorry for the delay. it looks like everything works for the most part. there are a few problems, ie with mic input, but those are hopefully just configuration issues, but it is no worse than it was before with the quirk.  hope that helps.

Nick
