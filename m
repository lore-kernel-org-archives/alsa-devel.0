From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: trying out usb hotplugs
Date: Fri, 29 Nov 2002 12:24:50 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0211291150340.532-100000@pnote.perex-int.cz>
References: <s5h65ugzo1x.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h65ugzo1x.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 29 Nov 2002, Takashi Iwai wrote:

> At Fri, 29 Nov 2002 10:39:22 +0100 (CET),
> Jaroslav wrote:
> > 
> > On Fri, 29 Nov 2002, Takashi Iwai wrote:
> > 
> > > At Fri, 29 Nov 2002 08:52:43 +0100 (MET),
> > > Clemens Ladisch wrote:
> > > > 
> > > > Takashi Iwai wrote:
> > > > > Martin Langer wrote:
> > > > > > usb hotplug works perfect if my usbmidi client isn't aconnected to another
> > > > > > midi client. But the aconnected usb midi device still remains in the clients
> > > > > > list, after hotpluging out.
> > > > >
> > > > > yep,  when the connection exists, the connected devices (on both
> > > > > sides) are regarded as active.
> > > > 
> > > > The sequencer design allows asynchronous removal of clients.
> > > 
> > > yes, but this may still try to send some bytes to the unplugged
> > > rawmidi device at the disconnection.  i'll change rawmidi code to
> > > ignore that.
> > 
> > Well, I'm trying to solve these "hotplug" problems. Unfortunately, it 
> > seems difficult to detect, if another task is in the middle of our 
> > callback. I think that we'll end up using mutexes.
> 
> hmm, but mutex costs too much even for non-pluggable devices...
> 
> in the case of rawmidi and oss-mixer, we can put "disconnected" flag
> and ignore the access if the flag is on at the rawmidi and oss-mixer
> routines, so that the control doesn't reach to low-level functions.

Well, but if you check this flag at the beginning, then you don't know, if
hardware is away in the middle of operation. The point is, that we have
to finish the last operation and clean structures "when no task is
inside". Perhaps, atomic_t helps us.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
