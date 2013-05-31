From: Joe Perches <joe@perches.com>
Subject: Re: [alsa-devel] Improving or replacing snd_printk()
Date: Fri, 31 May 2013 00:38:01 -0700
Message-ID: <1369985881.10556.54.camel@joe-AO722>
References: <Pine.LNX.4.44L0.1305301411370.1137-100000@iolanthe.rowland.org>
	 <51A79F25.6040007@perex.cz> <s5hr4gniri4.wl%tiwai@suse.de>
	 <1369983967.10556.48.camel@joe-AO722> <s5hip1zipde.wl%tiwai@suse.de>
	 <1369985409.10556.51.camel@joe-AO722> <s5hd2s7iouz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hd2s7iouz.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Alan Stern <stern@rowland.harvard.edu>, alsa-devel@alsa-project.org, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2013-05-31 at 09:35 +0200, Takashi Iwai wrote:
> At Fri, 31 May 2013 00:30:09 -0700, Joe Perches wrote:
> > On Fri, 2013-05-31 at 09:23 +0200, Takashi Iwai wrote:
> > > At Fri, 31 May 2013 00:06:07 -0700, Joe Perches wrote:
> > > > On Fri, 2013-05-31 at 08:37 +0200, Takashi Iwai wrote:
> > > > > I think most of snd_printd() and snd_printdd() can be kept as is.
> > > > > These are just debug messages, after all.
> > > > Some of those are emitted at levels other than KERN_DEBUG.
> > > > I think that odd.
> > > Yeah, they aren't good, but it's a different topic.
> > 
> > Not really, I think it's systemic and fallout from
> > accretive implementation rather than design.
> 
> Maybe.
> 
> But you shouldn't mix up with the fix for the missing verbosity and
> the fix for wrong KERN_ prefix, at least, in the patch level.  They
> need to be fixed individually.

I think that's best too.

I don't see the complexity/hell in adding functions
for specific types of struct * to reduce the complexity
of the code though.  Centralizing those indirections
into functions also generally reduces overall code size.
