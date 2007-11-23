From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [RFC] virtual master control (1/3)
Date: Fri, 23 Nov 2007 22:48:02 +0200
Message-ID: <200711232248.02739.maximlevitsky@gmail.com>
References: <472A113B.7030406@redhat.com> <s5hlk8oswjf.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0711231927030.8325@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 7EE22246E2
	for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2007 21:48:25 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id b21so2658256nfd
	for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2007 12:48:24 -0800 (PST)
In-Reply-To: <Pine.LNX.4.61.0711231927030.8325@tm8103.perex-int.cz>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Friday 23 November 2007 20:36:32 Jaroslav Kysela wrote:
> On Fri, 23 Nov 2007, Takashi Iwai wrote:
> 
> > At Mon, 19 Nov 2007 12:13:28 +0100,
> > I wrote:
> > > 
> > > > > > If not, then it is better  to remove it/remame to VolumeKnob
> > > > >
> > > > > Agreed.  I'd like to take a safer way if you don't insist...
> > > > Great, it is probably the best to have a virtual master volume.
> > > > Just one question, it will be probably enabled for devices that don't have a 
> > > > master volume (or have it broken like the STAC), right?,
> > > > And when you expect it to be merged?
> > > 
> > > Hopefully will be posted in this week after a small brush up.
> > 
> > OK, here is a series of the patch I promised.
> > 
> > The first one is the patch to add virtual master controls.
> > 
> > ===
> > 
> > [PATCH] Add virtual master control
> > 
> > This patch adds the routines to create virtual master controls.
> > A virtual master control can have multiple slave controls that
> > are supposed to be identical type.  The master volume will add the
> > master attenuation and the master switch will add the master mute
> > switch.
> > 
> > ---
> 
> I'm really not sure if I like to see such extensions in kernel. We have 
> now user control elements and a small daemon written in C or python will 
> do exactly same job and will be more flexible.
> 
> 						Jaroslav

Hi,

Well, first big thanks for those patches.

Secondary I strongly disagree that the above can be implemented in userspace easily.
Sure you can have a program that adjusts the volume of all outputs, and creates a virtual
userspace control, but the change in volume of outputs will be visible to userspace.
For example moving the master volume will move the front/surround/LFE/.... sliders,
and it is no good.

What this patch does, it actually modifies the code for those 'slave' amps, so the master volume is 
taken in account.

I will test it now on my system.

I hope this gets merged,
	Best regards,
		Maxim Levitsky
