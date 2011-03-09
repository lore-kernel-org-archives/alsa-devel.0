From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [BUG] WARNING: at fs/sysfs/dir.c:455 sysfs_add_one+0x83/0x95
Date: Wed, 09 Mar 2011 11:44:39 -0500
Message-ID: <1299689079.15854.251.camel@gandalf.stny.rr.com>
References: <1299685189.15854.182.camel@gandalf.stny.rr.com>
	 <20110309155309.GA30598@suse.de>
	 <1299687658.15854.227.camel@gandalf.stny.rr.com>
	 <s5hfwqwnt9s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hfwqwnt9s.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Greg KH <gregkh@suse.de>, Jaroslav Kysela <perex@perex.cz>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-03-09 at 17:38 +0100, Takashi Iwai wrote:
> At Wed, 09 Mar 2011 11:20:58 -0500,
> Steven Rostedt wrote:
> > 
> > On Wed, 2011-03-09 at 07:53 -0800, Greg KH wrote:
> > 
> > > > This was for a 386 build. I could give a .config and full dmesg if
> > > > needed.
> > > 
> > > I think the sound developers (now on CC: would probably like to see
> > > that.)
> > 
> > http://rostedt.homelinux.com/private/mitest-boot-randconfig-fail-20110209042837/config
> > 
> > http://rostedt.homelinux.com/private/mitest-boot-randconfig-fail-20110209042837/dmesg
> 
> Could you try the patch below?  Totally untested.
> 

Will do, but first I'll make sure that this is reproducible on every
boot.

Thanks,

-- Steve
