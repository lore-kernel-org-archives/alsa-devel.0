From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0-t1 garbage in /proc/ioports and oops
Date: Sun, 27 Jul 2003 16:38:12 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20030727163812.75b98b02.akpm@osdl.org>
References: <20030718011101.GD15716@ruvolo.net>
	<20030717211533.77c0f943.akpm@osdl.org>
	<20030718150429.GE15716@ruvolo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20030718150429.GE15716@ruvolo.net>
To: Chris Ruvolo <chris@ruvolo.net>
Cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net, Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>
List-Id: alsa-devel@alsa-project.org

Chris Ruvolo <chris@ruvolo.net> wrote:
>
> (adding alsa-devel)
> 
> On Thu, Jul 17, 2003 at 09:15:33PM -0700, Andrew Morton wrote:
> > You could load all those modules one at a time, doing a `cat /proc/ioports'
> > after each one.  One sneaky way of doing that would be to make your
> > modprobe executable be:
> 
> Ok, this let me track it down to the ALSA snd-sbawe module.  I did not have
> isapnp compiled into the kernel and was relying on the userspace isapnp to
> configure the device (carried over from 2.4).  Apparently the module didn't
> like this.

OK, thanks for that.

>From my reading, snd_sb16_probe() is, in the case of !CONFIG_PNP, doing:

	/* block the 0x388 port to avoid PnP conflicts */
	acard->fm_res = request_region(0x388, 4, "SoundBlaster FM");

but this reservation is never undone.  So later, after the module is
unloaded, a read of /proc/ioports is oopsing when trying to access that
string "SoundBlaster FM".  Because it now resides in vfree'd memory.

The fix would be to run release_region() either at the end of
snd_sb16_probe() or on module unload.

Adam or Jaroslav, could you please take care of this?

Thanks.
