From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Number of subdevices on midi.
Date: Thu, 4 Apr 2002 10:01:14 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0204040948190.891-100000@pnote.perex-int.cz>
References: <3CAB5699.1927A89D@ufh.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <3CAB5699.1927A89D@ufh.se>
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

On Wed, 3 Apr 2002, Peter Enderborg wrote:

> I have tryed to get some answer from Jaroslav about subdevices on midi.
> Im trying to write a driver for midisport 8x8/s and that have 9 midi
> ports. On my hack to figure out the protocol I use virmidi to handle the
> interface to alsa. But virmidi only have four subdevices per device. I

You can set up to eight virmidi devices (snd_midi_devs parameter controls
this count). On rawmidi side, there is 16 rawmidi substreams (subdevices)
per one virmidi device. These subdevices are used for event merging 
(write) and coping (read). On sequencer side, there is one client and 
one port connected to virmidi device.

> need to see the driver for a midi interface that using all the 16
> subdevices. Since I don't get answer from Jaroslav i guess he don't have
> the time or my question is stupid. But can someone help me out? Where
> should I look?

There are two ways:

1) we can add a new mode to virmidi code which suppress copying and 
   merging and connects more sequencer ports per a sequencer client
   to rawmidi subdevices to handle such devices
2) without any change - simply use more than one virmidi card and connect 
   your code to more clients:

	modprobe snd-virmidi snd_index=1,2 snd_enable=1,1 snd_midi_devs=8,8

	(use index values as you wish)

	In this case, you should have available this routing table:

	sequencer (client:port)		rawmidi (card:device:subdevice)
	72:0				1:0:any
	73:0				1:1:any
	....				....
	79:0				1:7:any
	80:0				2:0:any
	....				...
	87:0				2:7:any


						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com
