From: David Fries <dfries@mail.win.org>
Subject: Re: opl kernel panic
Date: Mon, 31 Mar 2003 07:16:47 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030331131646.GA5225@spacedout.fries.net>
References: <20030330000156.GA16202@spacedout.fries.net> <s5hwuifj3ql.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hwuifj3ql.wl@alsa2.suse.de>
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

It is easily possible I didn't, although I'm not sure how I would find
out.  I just compiled a newer kernel yesterday, I'll reboot, compile
alsa and report back.  Thanks for pointing that out.  Something like
that is probably in the FAQ right?

On Mon, Mar 31, 2003 at 11:16:02AM +0200, Takashi Iwai wrote:
> At Sat, 29 Mar 2003 18:01:56 -0600,
> David Fries wrote:
> > 
> > I just updated the alsa-driver from cvs today and I'm using a stock
> > 2.4.18 kernel on my laptop which is an older Pentium MMX system.
> > 
> > The only option I gave cvscompile was --with-cards= for the opl cards.
> > 
> > modprobe snd-opl3sa2 port=0x370 wss_port=0x530 fm_port=0x388 midi_port=0x330 irq=5 dma1=1 dma2=0
> > 
> > After three reboots I have determined that it doesn't crash just on
> > processes accessing the sound card it crashes randomly on any process.
> > I would manually load the module, on the oops I captured I ran
> > alsamixer which is the process that oopsed, copied /proc/ksyms, dmesg,
> > and rebooted as the last time I tried to decode the oops without
> > rebooting ksymoops was unable to run due to crashes.
> 
> did you use the same gcc version for alsa and kernel?
> 
> 
> Takashi

-- 
David Fries <dfries@mail.win.org>
http://fries.net/~david/pgpkey.txt


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
