From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Number of subdevices on midi.
Date: Sun, 7 Apr 2002 22:22:42 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0204072220340.1002-100000@pnote.perex-int.cz>
References: <3CACB7CB.50CCD428@ufh.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <3CACB7CB.50CCD428@ufh.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Peter Enderborg <pme@ufh.se>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 4 Apr 2002, Peter Enderborg wrote:

> Jaroslav Kysela wrote:
> 
> > On Wed, 3 Apr 2002, Peter Enderborg wrote:
> >
> > > I have tryed to get some answer from Jaroslav about subdevices on midi.
> > > Im trying to write a driver for midisport 8x8/s and that have 9 midi
> > > ports. On my hack to figure out the protocol I use virmidi to handle the
> > > interface to alsa. But virmidi only have four subdevices per device. I
> >
> > You can set up to eight virmidi devices (snd_midi_devs parameter controls
> > this count). On rawmidi side, there is 16 rawmidi substreams (subdevices)
> > per one virmidi device. These subdevices are used for event merging
> > (write) and coping (read). On sequencer side, there is one client and
> > one port connected to virmidi device.
> >
> > > need to see the driver for a midi interface that using all the 16
> > > subdevices. Since I don't get answer from Jaroslav i guess he don't have
> > > the time or my question is stupid. But can someone help me out? Where
> > > should I look?
> >
> > There are two ways:
> >
> > 1) we can add a new mode to virmidi code which suppress copying and
> >    merging and connects more sequencer ports per a sequencer client
> >    to rawmidi subdevices to handle such devices
> > 2) without any change - simply use more than one virmidi card and connect
> >    your code to more clients:
> >
> 
> That is what I do now. But it is not pretty. My plan is to do a real driver
> not a virmidi user.
> 
> 
> >
> >         modprobe snd-virmidi snd_index=1,2 snd_enable=1,1 snd_midi_devs=8,8
> >
> >         (use index values as you wish)
> >
> 
> Have you done that? This is what I get.
> 
> [root@pescadero pme]# /sbin/modprobe snd-virmidi snd_enable=1,1
> snd_midi_devs=8,8
> /lib/modules/2.4.16/misc/snd-virmidi.o: init_module: No such device
> Hint: insmod errors can be caused by incorrect module parameters, including
> invalid IO or IRQ parameters
> /lib/modules/2.4.16/misc/snd-virmidi.o: insmod
> /lib/modules/2.4.16/misc/snd-virmidi.o failed
> /lib/modules/2.4.16/misc/snd-virmidi.o: insmod snd-virmidi failed

Oops. I've fixed this problem in CVS. Change SNDRV_RAWMIDI_DEVICES in 
alsa-kernel/include/rawmidi.h to 8.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com
