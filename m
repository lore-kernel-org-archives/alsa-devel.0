From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Re:  Re: More Midisport 2x2 troubles
Date: Fri, 4 Apr 2003 19:05:48 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304041905.49017.plcl@telefonica.net>
References: <E191InJ-0002m0-00@sc8-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E191InJ-0002m0-00@sc8-sf-list2.sourceforge.net>
Content-Disposition: inline
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

On Friday 04 April 2003 06:21, Ivica Bukvic wrote:

> Yet, I still cannot get the second port of the Midisport 2x2 to become
> available no matter what. /proc/asound/cards lists only one midisport
> 2x2 device (which is ok, I guess, since even Fernando's webpage mentions
> that this is the case with the latest CVS stuff), but even in the
> /proc/asound/card2 (which is indexed as such) it only lists one midi
> port. Same is the case with the /dev/snd/midi* stuff.
>
> I would at this point like to know if this is a bug (so that I can stop
> wasting time on it) and if so, will it be addressed any time soon, and
> furthermore what will be the future approach to this issue, will the
> notion of assigning one /dev/midi device for each port prevail, or will
> we have to access other ports on the same device through alsa's
> hw:0,<subdevice> kind of approach, or perhaps something completely
> different.

Hi,

I think that the USB audio/midi driver did not change its behavior since 
0.9.0rc4, and Clemens (who wrote the midi part) already explained the basic 
concepts. The second MIDI port in a Midisport2x2 is not a device, but a 
sub-subdevice, and its difficult to work with it using OSS tools. That's why 
I am using the VirMIDI driver to access it. The VirMIDI driver copies its 
inputs to its output ports, and also has OSS support. To clarify, let me show 
an example. This is the relevant part of my /etc/modules.conf:

alias snd-card-0 snd-ens1371
alias snd-card-1 snd-usb-audio
alias snd-card-2 snd-usb-audio
alias snd-card-3 snd-virmidi
options snd cards_limit=4
options snd-ens1371 index=0 
options snd-usb-audio index=1,2 vid=0x0763,0x0582 pid=0x1110,0x0005 
options snd-virmidi index=3 midi_devs=2
alias sound-slot-0 snd-card-0
alias sound-slot-1 snd-card-1
alias sound-slot-2 snd-card-2
alias sound-slot-3 snd-card-3

With this setup, my Midisport2x2 is the ALSA client 72 (no matter which USB 
port i used to plug it). This is what I get from /proc/asound/seq/clients:

Client  64 : "Rawmidi 0 - ES1371" [Kernel]
  Port   0 : "ES1371" (RWeX)
Client  72 : "Rawmidi 1 - Midisport 2x2" [Kernel]
  Port   0 : "Midisport 2x2 Port 0" (RWeX)
  Port   1 : "Midisport 2x2 Port 1" (RWeX)
Client  80 : "Rawmidi 2 - UM-2" [Kernel]
  Port   0 : "UM-2 Port 0" (RWeX)
  Port   1 : "UM-2 Port 1" (RWeX)
Client  88 : "Virtual Raw MIDI 3-0" [Kernel]
  Port   0 : "VirMIDI 3-0" (RWeX)
Client  89 : "Virtual Raw MIDI 3-1" [Kernel]
  Port   0 : "VirMIDI 3-1" (RWeX)

In the OSS raw MIDI world:
/dev/midi00 (14, 2) is the ES1371 MIDI port
/dev/midi01 (14, 18) is the Midisport2x2 1st port
/dev/midi02 (14, 34) is the UM-2 1st port
/dev/midi03 (14, 50) is the 1st VirMIDI port
/dev/amidi3 (14, 61) is the 2nd VirMIDI port

There is nothing usable on /dev/amidi0, /dev/amidi1 or /dev/amidi2.
To play with the second port of the Midisport2x2 and OSS, you first connect 
the VirMIDI client to the Midisport 2nd port with something like this:

$ aconnect 88:0 72:1

Now, everything you send to /dev/midi03 is played on the second Midisport 
output port. To record, you should make another connection:

$ aconnect 72:1 88:0

And now you can read from /dev/midi03 what is received from the second 
Midisport input port.

To use the ALSA rawmidi API with these ports, you must remember that there 
aren't subdevices, but sub-subdevices. In my case:

ES1371 MIDI port is "hw:0", or "default"
Midisport2x2 1st port is "hw:1,0,0"
Midisport2x2 2nd port is "hw:1,0,1"
UM-2 1st port is "hw:2,0,0"
UM-2 2nd port is "hw:2,0,1"
VirMIDI 1st port is "hw:3,0"
VirMIDI 2nd port is "hw:3,1"

As you can see, there is lot of fun. Enjoy ;-)

Regards,
Pedro

-- 
ALSA Library Bindings for Pascal
http://alsapas.alturl.com



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
