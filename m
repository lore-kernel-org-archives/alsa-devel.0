From: ted <ted@2600.COM>
Subject: Re: No sound output on PowerBook Titanium II (TAS3001c)
 - resend (subscribed now)
Date: Tue, 22 Jul 2003 12:34:52 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.NEB.4.44.0307221221410.2916-100000@phalse.2600.com>
References: <s5hznj7gche.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hznj7gche.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 22 Jul 2003, Takashi Iwai wrote:

> > I've been unable to get the latest stable ALSA to produce any sound at
> > all.  I even tried the "loading+unloading dmasound_pmac first" trick, but
> > to no avail.  Everything looks fine, but applications using ALSA refuse to
> > work or crash.  Using OSS emulation appears to work, but there's no sound
> > output at all (yes, I've tried maxing out the mixer controls).
> >
> > Any ideas?
> >
> > The kernel driver seems to work pretty well, but it only supports a single
> > DSP device (which is rather annoying at times, especially since you
> > apparently need one for even just console beeps).
> >
> > System is a PowerBook Titanium II w/ TAS3001c.  Let me know if you need
> > more info.  Thanks!
>
> please tell me the kernel version.  then i can compare the source of
> dmasound_pmac to fix the alsa code.

I use Ben's stable tree (from http://www.penguinppc.org/dev/kernel.shtml).
I'd be happy to test any code changes.  Just let me know.  Thanks!



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
