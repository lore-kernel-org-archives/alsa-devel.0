From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re: More Midisport 2x2 troubles
Date: Thu, 03 Apr 2003 16:50:18 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0304031613060.24337-100000@studcom.urz.uni-halle.de>
References: <000001c2f9d8$a97da0b0$ac1f830a@ICO>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <000001c2f9d8$a97da0b0$ac1f830a@ICO>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ivica Bukvic <ico@fuse.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ivica Bukvic wrote:
> However, I am a bit confused, since this feature with /dev/midi stuff
> worked like a charm just a couple weeks ago (ver. 0.9.1). So, did
> something change dramatically since?

No. The USB MIDI driver has behaved in this way since 0.9.0rc4.

> Can you also point me in the right direction where I can see a simple
> ALSA code to accessing the both of the MIDI raw ports?

alsa-lib/test/rawmidi.c does some operations with both OSS and ALSA ports.
When using two ports, you'd call snd_rawmidi_open() twice and then have
two handles, similar to two file handles.
alsa-lib/test/control.c enumerates rawmidi devices.

BTW: Are you soure you want to use rawmidi ports? Many software
synthesizers create sequencer ports only.

> P.S. One thing I just realized is that there is something rather unclear
> to me in the explanation generously provided by Clemens:
>
> > /dev/midi0  -> card 0, device 0, subdevice 0
> > /dev/amidi0 -> card 0, device 1, subdevice 0
> > /dev/midi1  -> card 1, device 0, subdevice 0
> > /dev/amidi1 -> card 1, device 1, subdevice 0
> > /dev/midi2  -> card 2, device 0, subdevice 0
> > /dev/amidi2 -> card 2, device 1, subdevice 0
>
> since none of the amidi devices does not work on my setup (see my last
> e-mail for more info) and it seems as if it should.

Your two ports are subdevices 0 and 1 of card 1, device 0.
/dev/amidi1 points to device 1 which doesn't exist.

> Furthermore, what happens when the midi interface has more than 2 I/O
> ports?

If the ports are subdevices of one device, only the first can be accessed
with the OSS /dev/midiX file.
If each port is a seperate device, the first two ports can be accessed
with /dev/midiX and /dev/amidiX.

Drivers for multiport interfaces usually use the first alternative (one
device with subdevices) because there is a limit of 8 rawmidi devices per
card.


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
