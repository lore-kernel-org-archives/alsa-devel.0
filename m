From: Patrick Boettcher <patrick.boettcher@desy.de>
Subject: DigiDesign MBox USB Audio device
Date: Sun, 4 Apr 2004 19:25:34 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0404041840230.21649@pub2.ifh.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello ml,

I borrowed a DigiDesign MBox USB Audio device from a friend of mine, with
the aim to get this thing running in Linux. The Mbox is a high-quality
device for professional recording and playing back. (at least the product
description is promissing this)

I quite new to programming a device, but I have some knowledge about usb
and kernel. As of today, I have a short C file, setting the (hopefully)
correct usb configuration on the correct interface. A control led on the
device named "usb" is turned on after doing this. In Windows a special
Software (Pro Tools LE) uses the device directly without a driver, but
there is a Wave and ASIO driver. I'm using a usbsnoop program to do some
basic sniffing. Logs are really big :/.

After plugging in, the device shows like this in /proc/bus/usb/devices:

T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0dba ProdID=1000 Rev= 0.20
S:  Manufacturer=Digidesign Inc
S:  Product=Mbox USB Audio Device copyright Digidesign 2001
C:* #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=480mA
I:  If#= 0 Alt= 0 #EPs= 0 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
I:  If#= 1 Alt= 0 #EPs= 0 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
I:  If#= 1 Alt= 1 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
E:  Ad=81(I) Atr=05(Isoc) MxPS= 304 Ivl=1ms
E:  Ad=02(O) Atr=05(Isoc) MxPS= 304 Ivl=1ms

I configure the AltSetting 1 on Interface 1, then the usb led is turned
on.

After talking to some more experienced guys, I know, that there has to be
a sound chip, so I opened the device and among some A/D and D/A converter
I found a "cs8427" chip. I suppose this is the one.
After looking into sound directory in linux, I saw "i2c/cs8427.c" and
"i2c/cs8427.h".

My personal goal is to give something back to the community (even the
device is not wide spreaded) and to train myself in usb programming.

OK, this is my current point of knowledge. I write this mail hoping to get
some answers to my uncountable questions. :)

Firt of all some basic questions:

1. How should a go on?

2. Can I use somehow the i2c/cs8427.c?

3. How does communication with the device should work? Where should I have
a look on? Some pointers? All I know from sniffing, a lot of data is
written to and read by the driver using isochronous transfers.

4. Am I totally wrong (here)? :) Should I contact another mailing list or
a special person?

Thanks to all in advance, who'll read this mail and a lot more thanks
to everyone, who will be able to help me, getting along with the device.

Patrick


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
