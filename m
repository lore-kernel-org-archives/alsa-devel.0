From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Re: my first usb-midi experiment ends with segmentation fault
Date: Mon, 29 Jul 2002 23:51:04 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207292351.04462.plcl@telefonica.net>
References: <20020728213924.GA522@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020728213924.GA522@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: martin-langer@gmx.de
Cc: ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello!

I'm happy to see that I'm not the only MIDI guy at ALSA-USB world :)

El Dom 28 Jul 2002 23:39, Martin Langer escribió:
> my new USB-MIDI-Keyboard has two USB subclasses usb-midi and usb-audio.
> Evolution, the manufacturer, told me "it's an Audio Class compliant
> device", but I don't find a new entry in /proc/asound/seq/clients after
> loading the modules.
>
> cat /proc/bus/usb/devices
>
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
> D:  Ver= 1.00 Cls=01(audio) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=0a4d ProdID=008e Rev= 2.00
> S:  Manufacturer=Evolution Electronics Ltd.
> S:  Product=MK-249C USB MIDI keyboard
> C:* #Ifs= 2 Cfg#= 1 Atr=c0 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=00 Driver=snd-usb-audio
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=01(audio) Sub=03 Prot=00 Driver=snd-usb-midi
> E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>
>
> dmesg:
>
> usb.c: registered new driver snd-usb-audio
> usb.c: snd-usb-audio driver claimed interface dfe688c0
> usb.c: registered new driver snd-usb-midi
> snd-usb-midi: using interface 1
> snd-usb-midi: MIDIStreaming version 01.00
> snd-usb-midi: using 1 input jack(s) on endpoint 1
> snd-usb-midi: using 1 output jack(s) on endpoint 2
> snd-usb-midi: detected Evolution Electronics L MK-249C USB MIDI keyboa
> usb.c: snd-usb-midi driver claimed interface dfe688d8
>
>
>
> It's not typical to have a midi-keyboard with two subclasses, or?

IMHO, those descriptors are very close to the USB-Audio specification. Your 
keyboard presents two interfaces: an AudioControl interface (Sub=01) and a  
MIDIStreaming one (Sub=03). Perhaps the snd-usb-audio claims making a very 
quick decision based only on the AudioControl interface. The AudioStreaming 
interface is Sub=02, and your keyboard has not one.

I am using two USB MIDI devices at home, both with the snd-usb-midi driver; an  
Edirol UM-2 (semi-compliant) and a Midiman Midisport 2x2, with a nice GPL  
firmware by Lars Doelle, that tryes to follow the standard. FYI, these are my 
last device descriptors:

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  4 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0763 ProdID=1110 Rev= 0.01
S:  Manufacturer=Midiman
S:  Product=Midisport 2x2
S:  SerialNumber=Copyright (GPLv2) 2001 by Lars Doelle 
<lars.doelle@on-line.de>
C:* #Ifs= 2 Cfg#= 1 Atr=00 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=00 Driver=(none)
I:  If#= 1 Alt= 0 #EPs= 2 Cls=01(audio) Sub=03 Prot=00 Driver=snd-usb-midi
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms

As you can see, very similar to yours.

You can find the specs at http://www.usb.org/
The relevant documents about USB Audio Class and USB MIDI subclass are:
- Universal Serial Bus Revision 1.1 specification,
http://www.usb.org/developers/data/usbspec.zip
- Audio Device Document 1.0,
http://www.usb.org/developers/data/devclass/audio10.pdf
- USB MIDI Devices 1.0,
http://www.usb.org/developers/data/devclass/midi10.pdf


> ... and doing rmmod snd-usb-midi and rmmod snd-usb-audio ends here with
> Segmentation fault:
>

I can't reproduce this behaviour at home. Perhaps the jack or endpoint 
descriptor parser in snd-usb-midi gets confused for your keyboard. AFAIK, the 
MK-249C is not listed as tested or supported, though.

What I do is blacklist all the snd-usb-* and the corresponding usb oss 
modules, avoiding hotplug from loading them. Instead, the /etc/init.d/alsa 
boot script loads them, with some /etc/modules.conf lines like these:

alias char-major-14 soundcore
alias char-major-116 snd
alias snd-card-0 snd-ens1371
alias snd-card-1 snd-usb-midi
alias sound-slot-0 snd-card-0
alias sound-slot-1 snd-card-1
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss

This is not very coherent with the usual USB devices hotplugging capabilities, 
but you have the chance of setting some options. Anyway, if your device is 
not 100% standard, perhaps you have to tweak the alsa-driver/usb/usbmidi.c 
file (search for 'snd_usbmidi_usb_id_table').

Another option is to use the daemon, that runs in userspace, and perhaps can 
be easy for experiment with it, along with hotplug.
You can find it at: http://www.informatik.uni-halle.de/~ladischc/usbmidid.html


Regards,
Pedro



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
