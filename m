From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Re: MIDI+USB - one way?
Date: Sat, 3 Aug 2002 01:28:52 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200208030128.53390.plcl@telefonica.net>
References: <20020802001554.48f2f13a.mis@creazone.com> <3D4ABCA6.9E126597@ladisch.de> <3D4AD766.4030908@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D4AD766.4030908@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>, Clemens Ladisch <clemens@ladisch.de>, Lars Doelle <lars.doelle@on-line.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

El Vie 02 Ago 2002 21:03, Patrick Shirkey escribió:
> Hey.
>
> I am just about ready to release the new alsa docs to the general public .
>
> Can you guys tell me what the differences are in installing the card
> compared to the standard template. thx.
>
> http://www.alsa-project.org/alsa-doc/
>
> (just open up a couple of pages and you should see what I mean).

First, I need to say that perhaps I'm not the best source of information, as 
I've been here, or as an ALSA user for a short time, and because my poor 
english. So please, if I'm wrong on something let me know and correct my 
mistakes.

I suppose that you want to know about the MIDI only devices, and specifically  
the Midiman MidisportNxN. 

MIDI only devices (without digital audio) are not new. The first I had, a long 
time ago, was a Roland MPU-401. And as the newer ones, it had only MIDI 
ports, not digital audio, nor mixer. As a general rule, a template for these 
devices (kmod / modules.conf section) can be something like this:

        # ALSA portion
        alias char-major-116 snd
        alias snd-card-0 snd-usb-midi
        # module options should go here

        # OSS/Free portion
        alias char-major-14 soundcore
        alias sound-slot-0 snd-card-0

        # card #1
        alias sound-service-0-1 snd-seq-oss
        alias sound-service-0-8 snd-seq-oss

Also, there is not need to mention alsamixer nor snd-pcm-oss, snd-mixer-oss  
or some other audio only program. Volume and other sound parameters are  
usually embedded inside the MIDI stream. 

About the .asoundrc file, I think that it has nothing to do with these 
devices, but perhaps I'm wrong and it has some useful function for MIDI.

There are a few devices supposed to work with snd-usb-midi driver that have 
also an Audio function, though, as the Roland/Edirol SC-8820 and SC-8850. In 
this case, the audio portion of that devices need the snd-usb-audio driver. 
You can put both buttons in the driver column for these devices as they need 
two drivers simultaneously.

As a side note, the name "card" is not very appropiate in the USB land. They 
are all external devices, (MIDI adaptors, keyboards, drum controllers and 
surely soon guitars, wind controllers, etc.), connected by the USB cable to 
the computer or USB hub. Another surprising issue is that in the ALSA 
soundcard matrix there is no one Roland/Edirol device. The snd-usb-driver 
works with a couple of MIDI  adapters and synthesizers from Roland, as you 
can see at Clemens page: 
http://www.informatik.uni-halle.de/~ladischc/usbmidid.html

We have also a report from Martin Langer, that his MK-249C USB MIDI keyboard 
from Evolution Electronics Ltd. works with the snd-usb-midi driver.
http://www.evolution.co.uk/products/keyboards_01.htm

Finally, some points about the Midiman MidisportNxN. For the "chipset" column, 
you can mention here "ezusb" (or better, "Cypress AN2131", see:  
http://www.cypress.com/products/datasheet.cfm?partnum=AN2131SC for technical 
reference manuals and developement kits). This chipset is widely used in USB 
peripherals, not only MIDI ones, and it is related to Intel 8051 chip.

As an example, I know that Midiman has some USB MIDI keyboards using ezusb, 
that perhaps can work with snd-usb-midi.
USB Keystations: http://www.midiman.net/products/midiman/keystations.php
Steinberg has also a ezusb compatible USB MIDI Adaptor:
http://www.harmony-central.com/Newp/1999/USB-2-MIDI-Interface.html

As some other devices built around the ezusb circuits, the MidisportNxN 
devices need a firmware program to be loaded from the host thru the USB 
cable. Midiman did not released his firmware for Linux, but we are using a 
nice GPL one, by Lars Doelle, that can be obtained from: 
http://member.nifty.ne.jp/Breeze/softwares/unix/bin/usbmidi-20020324.tar.gz

Inside the tarball, there is a testing/Midisport directory with sources, 
documents and two files: ezusbmidi1x1.ihx and ezusbmidi2x2.ihx
These are the precompiled firmware programs for Midisport1x1 and 2x2. For 4x4 
and 8x8, you can put a "coming soon" advice :),  as they had not yet been 
released.

A good place to put the ezusbmidiNxN.ihx files is the 
/usr/share/usb/ezusbmidi/ directory, according to the Linux Standard Base. 
But you can put it elsewhere, fixing the appropiate scripts.
To load the firmware into the device, the Linux-hotplug utility 'fxload' can 
be used. The best way to do so is letting hotplug to take care of that, but 
first, you need to install hotplug, and edit some files (as root).

# pico /etc/hotplug/usb.usermap
ezusbmidi    0x0003 0x0763 0x1010 0 0 0 0 0 0 0 0 0
ezusbmidi    0x0003 0x0763 0x1001 0 0 0 0 0 0 0 0 0
ezusbmidi    0x0003 0x0763 0x1020 0 0 0 0 0 0 0 0 0
ezusbmidi    0x0003 0x0763 0x1030 0 0 0 0 0 0 0 0 0

# pico /etc/hotplug/usb/ezusbmidi
#!/bin/sh
FIRMWARE=
FLAGS=
LOADER=/sbin/fxload
# pre-renumeration device IDs
case $PRODUCT in
# Midisport 1x1
763/1010/*)
    FIRMWARE=/usr/share/usb/ezusbmidi/ezusbmidi1x1.ihx
    ;;
# Midisport 2x2
763/1001/*)
    FIRMWARE=/usr/share/usb/ezusbmidi/ezusbmidi2x2.ihx
    ;;
esac
# quit unless we were called to download some firmware
if [ "$FIRMWARE" = "" ]; then
    if [ -x /usr/bin/logger ]; then
        /usr/bin/logger -t $0 "there is not a firmware for $PRODUCT ??"
    fi
    exit 1
fi
# missing firmware?
if [ ! -r $FIRMWARE ]; then
    if [ -x /usr/bin/logger ]; then
        /usr/bin/logger -t $0 "missing $FIRMWARE for $PRODUCT ??"
    fi
    exit 1
fi
# missing loader?
if [ ! -x $LOADER ]; then
    if [ -x /usr/bin/logger ]; then
        /usr/bin/logger -t $0 "missing $LOADER ??"
    fi
    exit 1
fi
if [ -x /usr/bin/logger ]; then
    /usr/bin/logger -t $0 "load $FIRMWARE for $PRODUCT to $DEVICE"
fi
$LOADER $FLAGS -I $FIRMWARE


Regards,
Pedro



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
