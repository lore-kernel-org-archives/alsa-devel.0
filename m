From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2] ALSA: korg1212: cleanup of printk
Date: Wed, 26 Nov 2014 10:27:05 -0800
Message-ID: <1417026425.19695.10.camel@perches.com>
References: <1416730251-5194-1-git-send-email-sudipm.mukherjee@gmail.com>
	 <s5hh9xottl9.wl-tiwai@suse.de> <1416849910.8797.1.camel@perches.com>
	 <20141125062132.GA3380@sudip-PC> <1416941965.8358.6.camel@perches.com>
	 <20141126104912.GA1085@sudip-PC>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141126104912.GA1085@sudip-PC>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2014-11-26 at 16:19 +0530, Sudip Mukherjee wrote:
> On Tue, Nov 25, 2014 at 10:59:25AM -0800, Joe Perches wrote:
> > On Tue, 2014-11-25 at 11:51 +0530, Sudip Mukherjee wrote:
> > > problems with this way:
> > > 1) macro name is little misleading - macro says printk, but we are using dev_dbg
> > > 2) if some one later wants to add something to this file, and doesnot want to use the variable name korg1212 in his function.
> > > 
> > > any suggestions ?
> > 
> > Some code is so old and unlikely to be ever used
> > again, it may be better to move it to an "ancient
> > and crufty" folder and forget about it.
> > 
> > This may be one of those.
> > 
> > If the debugging was written in a more current style,
> > it might look like this: (with various format/argument
> > mismatches fixed, formatting changes, etc)
> 
> ok. and can't we delete some of the messages like "DSP download is
> complete." and then printing the statename. there are lots of messages
> like that which is just printing the function name and the
> statename ..

Dunno.  Maybe somebody cares about the state of
the dsp download, but I doubt it as I suspect
the hardware isn't used much.

> and, even if i modify it a little and send it, most of the work has
> been done by you. so how do i send the patch in your name or add your
> name in the patch ? I have not done anything so my name should not be
> there.

<shrug> you started it.

I spend a couple minutes running a couple scripts.

I don't have the hardware, I've never looked at
that code before, do what you think appropriate.
