From: "Ivica Bukvic" <ico@fuse.net>
Subject: Re: More Midisport 2x2 troubles
Date: Thu, 3 Apr 2003 07:00:46 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000001c2f9d8$a97da0b0$ac1f830a@ICO>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: 'Clemens Ladisch' <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Guys, I am forwarding this to you as well from the alsa-user list since
right now I am looking for example code how to access the 2nd set of I/O
MIDI ports on my Midisport 2x2 (seems that having /dev/midi and
/dev/midi1 does not work any more for some reason, even though it worked
just fine in 0.9.1). Any help on this issue is greatly appreciated!

P.S. One thing I just realized is that there is something rather unclear
to me in the explanation generously provided by Clemens:

> /dev/midi0  -> card 0, device 0, subdevice 0
> /dev/amidi0 -> card 0, device 1, subdevice 0
> /dev/midi1  -> card 1, device 0, subdevice 0
> /dev/amidi1 -> card 1, device 1, subdevice 0
> /dev/midi2  -> card 2, device 0, subdevice 0
> /dev/amidi2 -> card 2, device 1, subdevice 0

since none of the amidi devices does not work on my setup (see my last
e-mail for more info) and it seems as if it should. Furthermore, what
happens when the midi interface has more than 2 I/O ports?

Ico

-----Original Message-----
Thanks for your help!

However, I am a bit confused, since this feature with /dev/midi stuff
worked like a charm just a couple weeks ago (ver. 0.9.1). So, did
something change dramatically since?

Can you also point me in the right direction where I can see a simple
ALSA code to accessing the both of the MIDI raw ports?

Thanks!

Ico

> For multiport USB MIDI interfaces, the ports are subdevices of one
midi
> device. This isn't a problem with programs using the ALSA API, but
when
> you want to use the OSS-compatible /dev/midiX ports, you cannot access
> any subdevices other than the first directly.
> 
> The mapping of OSS MIDI devices to ALSA MIDI devices is as follows:
> /dev/midi0  -> card 0, device 0, subdevice 0
> /dev/amidi0 -> card 0, device 1, subdevice 0
> /dev/midi1  -> card 1, device 0, subdevice 0
> /dev/amidi1 -> card 1, device 1, subdevice 0
> /dev/midi2  -> card 2, device 0, subdevice 0
> /dev/amidi2 -> card 2, device 1, subdevice 0
> ...
> 
> > If this is the case, then how do I access the second port.
> 
> You can load the snd-virmidi driver to create a virtual soundcard
having
> its own MIDI device, and then connect this port to the 2x2's second
MIDI
> port (with aconnect).
> 
> > In this situation the hdsp is not in use, so midisport assumes the
2nd
> > card position.
> > ...
> > options snd-usb-audio vid=0x763 pid=0x1001 index=2
> 
> It shouldn't, because the above options line tells the driver to load
at
> index 2. And if you'd use 0x1110 as product ID, it actually would. ;-)
> (0x1001 is the ID of the device without firmware.)
> 
> 
> HTH
> Clemens
> 




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
