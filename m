From: noreply@alsa-project.org
Subject: [ALSA - driver 0000142]: Onboard Envy 24PT (ice1724) probes correctly yet doesn't work.
Date: Tue, 22 Jun 2004 18:44:41 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <967f9018ca417ff4e01f2836f9e02d0e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following bug has been RESOLVED.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0142
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                bana
Assigned To:                tiwai
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - driver
Bug ID:                     142
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               Fedora Core 1
Kernel Version:             2.6.3 and 2.6.4
Resolution:                 fixed
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             03-17-2004 20:48 CET
Last Modified:              06-22-2004 18:44 CEST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    Onboard Envy 24PT (ice1724) probes correctly =
yet
doesn't work.
Description:=20
Using my onboard Via (VT1720) Envy 24PT sound chipset, I compiled the
module snd_ice1724. For some reason alsaconf can see it perfectly and
configures my modprobe.conf file right but then alsamixer, alsactl, aumix=
,
and amixer all cannot find  the card. Also a cat /proc/asound/cards shows
--no soundcards--. Is this because it is not on the PCI bus? Perhaps you
could add this card?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 bana - 03-21-2004 19:58 CET=20
----------------------------------------------------------------------
Ermm. I guess I should have made this severity Major as it is a complete
showstopper.

----------------------------------------------------------------------
 BillyBreen2k - 03-23-2004 04:53 CET=20
----------------------------------------------------------------------
I see the same thing on my Albatron K8X800 Pro II.  I also see the
following relevant errors in dmesg:

ICE1724 has not detected EEPROM
invalid EEPROM (size =3D 255)
ICE1724: probe of 0000:00:06.0 failed with error -5

----------------------------------------------------------------------
 bana - 03-23-2004 05:24 CET=20
----------------------------------------------------------------------
Yes, now that I look for them they are here:
ALSA /opt/alsa-driver-1.0.3/alsa-kernel/pci/ice1712/ice1724.c:1778:
invalid EEPR OM (size =3D 255)
ICE1724: probe of 0000:01:0f.0 failed with error -5

(you don't know how good it feels to know that someone else has my same
problem)

----------------------------------------------------------------------
 BillyBreen2k - 03-23-2004 06:44 CET=20
----------------------------------------------------------------------
Couldn't agree more -- I was very sad when I saw no one on google or Gent=
oo
forums had seen anything like this.

I poked around in the code a bit, but given my complete lack of knowledge
re: audio hardware or kernel hacking (except for reading Robert Love's
book ;-) I had no idea where to begin.  If someone more knowledgeable
needs help debugging or testing patches, I'm ready and willing.

----------------------------------------------------------------------
 perex - 03-23-2004 16:14 CET=20
----------------------------------------------------------------------
It will be difficult to support this hardware. Basically, we need to know
the connection of the AD and DA converters to GPIO pins of the Envy24 chi=
p
to determine, how we can drive this hardware.

Also, it's possible that AC'97 codecs are used instead of AD and DA
converts.
This mode is not supported in the ice1724 driver yet.

Also EEPROM should contain the vital information about hardware, but some
vendors don't assembly this piece which makes PnP more easy and deliver
this
information in their drivers (for W$, of course).

----------------------------------------------------------------------
 BillyBreen2k - 03-23-2004 18:43 CET=20
----------------------------------------------------------------------
That sounds discouraging, but I'll confess to not really having any idea
what you are talking about.  Is there anything I can do -- diagnostically=
,
with the motherboard documentation, by nagging the supplier, etc -- to
help get this hardware supported?

----------------------------------------------------------------------
 perex - 03-23-2004 18:53 CET=20
----------------------------------------------------------------------
We need to know the connections of slave chips around Envy24PT.
You might try ask the motherboard vendor to provide necessary
information.
Also, we are missing datasheet for Envy24PT (it seems that it's a
stripped
version of Envy24HT). Perhaps, you might find something on web pages at
VIA technology.

----------------------------------------------------------------------
 winjer - 03-23-2004 21:59 CET=20
----------------------------------------------------------------------
I have the same problem with a Chaintech ZNF3-150 with an onboard Envy24H=
T
(see bug 152).

I get the invalid EEPROM error too.  I've done some debugging in
sound/pci/ice1712/ice1724.c, and the subvendor provided by the EEPROM is
0xffffffff.

Taking a wild stab in the dark, this looks like the EEPROM in fact doesn'=
t
carry any useful information - so presumably this is bundled in the
windows drivers.

I'm going to keep digging, and I'll get onto the vendor.  Is there any
other useful diagnostic stuff I can get while I'm at it?

----------------------------------------------------------------------
 BillyBreen2k - 03-24-2004 00:40 CET=20
----------------------------------------------------------------------
Not that this is likely to have too much technical value, but Via's
marketing fluff at http://www.via.com.tw/en/multimedia/envy24pt.jsp
indicates that AC'97 is the typical approach used when integrating the
chip with a motherboard.  AD/DC is singled out as being used for 'higher
end applications.'

----------------------------------------------------------------------
 bana - 03-24-2004 05:01 CET=20
----------------------------------------------------------------------
Okay, so we need to come together and write to via to ask for the
appropriate information. Perhaps we should coordinate ourselves? I setup =
a
phpBB board at http://bhpdc-forums.dyndns.org/alsa Perex: Is there some
kind of formal letter that you use when asking vendors this info? This
would be most helpful and would make it sound a lot more professional
(rather than simply asking "do you have these things:"). Should we send
the email to Via, Chaintech, and Albatron or just via? Thanks.

Also perhaps we could ask 4Front/OSS's people for info as their drivers
autodetect my card (although they are proprietary) perhaps they would be
willing to be charitible? (worth a shot)

Also: what kind of success rate does asking for the info generally have?
Have you already received the data for the 24HT and you are just missing
the 24PT or is it rare that VIA helps out in this way (or any
manufacturer).

edited on: 03-24-04 05:01

----------------------------------------------------------------------
 perex - 03-24-2004 10:10 CET=20
----------------------------------------------------------------------
See: http://www.alsa-project.org/call.php3

Also, I tried to ask our VIA contacts to give us the VT1720 datasheet, so
please,
wait a few days.

----------------------------------------------------------------------
 bana - 03-25-2004 03:44 CET=20
----------------------------------------------------------------------
Okay, Thank you so much Perex, just keep us posted if anything comes up. =
:)

----------------------------------------------------------------------
 bana - 04-06-2004 03:08 CEST=20
----------------------------------------------------------------------
Has there been any response from VIA? Should we perhaps start thinking of
sending a separate letter?

----------------------------------------------------------------------
 perex - 04-07-2004 20:25 CEST=20
----------------------------------------------------------------------
I received possitive response but no datasheet. I sent another ping e-mai=
l.

----------------------------------------------------------------------
 bana - 04-09-2004 04:16 CEST=20
----------------------------------------------------------------------
Okay, Thank you.

----------------------------------------------------------------------
 bana - 04-25-2004 05:32 CEST=20
----------------------------------------------------------------------
perex: daemon (a member of my message board here:
http://bhpdc-forums.dyndns.org/alsa/viewtopic.php?t=3D3&postdays=3D0&post=
order=3Dasc&start=3D0
) emailed VIA and got a positive response. They are soon going to send hi=
m
the datasheet and sound very positive and cooperative (for full
transcription see the link above) Daemon will email the datasheets to you
or however you want to get them but he needs to know your email, feel fre=
e
to email him or PM him at the message board above. If you have any
questions email me at tuxpenguin at austin.rr.com

----------------------------------------------------------------------
 perex - 04-25-2004 09:50 CEST=20
----------------------------------------------------------------------
We have the identical response (we have direct contacts to VIA developers=
).
Unfortunately, VIA has not finished the datasheet yet, so we all
waiting....

----------------------------------------------------------------------
 bana - 04-25-2004 18:49 CEST=20
----------------------------------------------------------------------
*waits with baited breath*

So it looks like we just need to just play the waiting game.

----------------------------------------------------------------------
 rameyst - 04-26-2004 20:20 CEST=20
----------------------------------------------------------------------
I've gotten this error when trying to install it for my Tascam US-122
external usb... I dont know if it's the documentation i've used to instal=
l
it, or if it's the actual drivers, but i did see on the internet others
who have installed this successfully.

----------------------------------------------------------------------
 bana - 04-30-2004 00:59 CEST=20
----------------------------------------------------------------------
Daemon, it appears, has received the datasheet. Perex if you haven't
already received it then contact Daemon for a copy. Now that we have the
datasheet, what kind of time frame are we looking at for a working CVS
version?

----------------------------------------------------------------------
 bana - 05-01-2004 00:52 CEST=20
----------------------------------------------------------------------
Reminder sent to perex

Daemon, it appears, has received the datasheet. Perex if you haven't
already received it then contact Daemon for a copy. Now that we have the
datasheet, what kind of time frame are we looking at for a working CVS
version?

(Or give me your email and I will pass it on to daemon)

----------------------------------------------------------------------
 perex - 05-02-2004 12:51 CEST=20
----------------------------------------------------------------------
I got the datasheet, too. It is located at
ftp://ftp.alsa-project.org/pub/manuals/icensemble/DS_VT1720_100.pdf ..

It looks like that there are not many differences from VT1724.

edited on: 05-02-04 12:51

----------------------------------------------------------------------
 perex - 05-02-2004 12:59 CEST=20
----------------------------------------------------------------------
To all: please, send me output from this command 'lspci -d 1412:1724
-nvx'.

Thanks.

----------------------------------------------------------------------
 Robster - 05-02-2004 13:18 CEST=20
----------------------------------------------------------------------
Albatron K8X800ProII, with all the above symptoms/features ;). Thanks hea=
ps
for all your work on this!

root@val rfbrown # lspci -d 1412:1724 -nvx
0000:00:06.0 Class 0401: 1412:1724 (rev 01)
        Subsystem: 17f2:2c05
        Flags: bus master, medium devsel, latency 32, IRQ 22
        I/O ports at d000
        I/O ports at d400 [size=3D128]
        Capabilities: [80] Power Management version 1
00: 12 14 24 17 05 00 10 02 01 00 01 04 00 20 00 00
10: 01 d0 00 00 01 d4 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 f2 17 05 2c
30: 00 00 00 00 80 00 00 00 00 00 00 00 0c 01 00 00

edited on: 05-02-04 13:18

----------------------------------------------------------------------
 BillyBreen2k - 05-02-2004 16:24 CEST=20
----------------------------------------------------------------------
My 'Albatron K8X800 Pro II' output:

booch root # lspci -d 1412:1724 -nvx
0000:00:06.0 Class 0401: 1412:1724 (rev 01)
        Subsystem: 17f2:2c05
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at b000
        I/O ports at b400 [size=3D128]
        Capabilities: [80] Power Management version 1
00: 12 14 24 17 05 00 10 02 01 00 01 04 00 20 00 00
10: 01 b0 00 00 01 b4 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 f2 17 05 2c
30: 00 00 00 00 80 00 00 00 00 00 00 00 0a 01 00 00

----------------------------------------------------------------------
 astrohm - 05-02-2004 17:06 CEST=20
----------------------------------------------------------------------
My Chaintech ZNF3-150:

% sudo lspci -d 1412:1724 -nvx
0000:01:0f.0 Class 0401: 1412:1724 (rev 01)
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at b800
        I/O ports at bc00 [size=3D128]
        Capabilities: [80] Power Management version 1
00: 12 14 24 17 05 00 10 02 01 00 01 04 00 20 00 00
10: 01 b8 00 00 01 bc 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ff ff ff ff
30: 00 00 00 00 80 00 00 00 00 00 00 00 0b 01 00 00

----------------------------------------------------------------------
 perex - 05-02-2004 17:19 CEST=20
----------------------------------------------------------------------
More questions:

1) What output and input jacks have your motherboard?
2) Please, see if there are any chips around the envy24pt on the
motherboard
   (you need to open the case and study it). A high resolution picture -
from
   a digital camera - with this detail will help me a lot.

Basically, VT1720 is mostly similar to VT1724 from the driver perspective=
.
Because your hardware is missing the EEPROM, I don't know about the
hardware around the main audio chip which is universal.

----------------------------------------------------------------------
 Robster - 05-02-2004 17:42 CEST=20
----------------------------------------------------------------------
Albatron K8X800 Pro II has 6 stereo jacks on the back panel. These are:
Mic-in, Line-in, Front Speakers, Surround Back, Surround Speakers,
Centre/Subwoofer. There are also a "Front Audio" header and an SPDIF
header, which connects to a SPDIF/TOS-Link riser.

I will be able to get a good photo in about 15 hours, sorry about the
delay.

----------------------------------------------------------------------
 bana - 05-02-2004 19:30 CEST=20
----------------------------------------------------------------------
Chaintech ZNF3-150 with CNR Multimedia riser card and CBOX 3 front panel
(headphone and mic jacks in a 5.5in bay)

lspci -d 1412:1724 -nvx
01:0f.0 Class 0401: 1412:1724 (rev 01)
        Subsystem: 270f:f641
        Flags: bus master, medium devsel, latency 32, IRQ 3
        I/O ports at a800
        I/O ports at ac00 [size=3D128]
        Capabilities: [80] Power Management version 1
00: 12 14 24 17 05 00 10 02 01 00 01 04 00 20 00 00
10: 01 a8 00 00 01 ac 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 0f 27 41 f6
30: 00 00 00 00 80 00 00 00 00 00 00 00 03 01 00 00

Ports: Line in, Line out, and Microphone next to backpanel USB ports. The=
n
on multimedia riser card (see picture below) there are 2 firewire, 1
SPDIF, one center/bass, 1 surr L/R and 1 ALT L/R. Then finally on the
front (with the 5 1/2 inch bay extension there is a microphone and
headphone jack.

For Pictures, here is a panoramic kinda view with everything around it:
http://bhpdc-forums.dyndns.org/mnt/usbkey/dcim/img_1506.jpg of notable
interest is the broadcom gigabit lan on the right and a tiny Via VT1616 o=
n
the left (next to the riser card) and here:
http://bhpdc-forums.dyndns.org/mnt/usbkey/dcim/img_1513.jpg is a better
picture of that VT1616. Here:
http://bhpdc-forums.dyndns.org/mnt/usbkey/dcim/img_1514.jpg is a look at
the CNR multimedia riser card (it came with the motherboard). Please tell
us if there is anything more you need.

(I can't upload the pictures here for some php error reason)

edited on: 05-02-04 19:30

----------------------------------------------------------------------
 perex - 05-02-2004 19:53 CEST=20
----------------------------------------------------------------------
bana, all: I found also this:
http://tech-report.com/reviews/2004q1/maddog-entertainer/index.x?pg=3D2

It describes soundcard with VT1616 and WM8728 (Wolfson codec is on the
bana's multimedia riser card). It clarifies what I though: The AC'97 mode
is separated from the I2S mode.

I can try to enable the AC'97 mode at least. For I2S mode I need to know
the wiring from WM8728 to GPIO pins of Envy24PT.

----------------------------------------------------------------------
 bana - 05-03-2004 00:47 CEST=20
----------------------------------------------------------------------
Hmm, so basically you can try to enable half (ac97 and not I2S) of our
hardware kinda? How do we go about finding the wiring from the Wolfson to
the VT1616? I took some super closeups of the area in question (in case
you can do a visual wiring trace):
http://bhpdc-forums.dyndns.org/mnt/usbkey/dcim/img_1517.jpg
http://bhpdc-forums.dyndns.org/mnt/usbkey/dcim/img_1515.jpg and
http://bhpdc-forums.dyndns.org/mnt/usbkey/dcim/img_1520.jpg Should we
email Chaintech/Albatron directly? or is this still a VIA problem?

----------------------------------------------------------------------
 bana - 05-03-2004 01:15 CEST=20
----------------------------------------------------------------------
Hmm, is this what you are looking for?
http://www.wolfsonmicro.com/products/digital_audio/dacs/WM8728/ and the
corresponding datasheet:
http://www.wolfsonmicro.com/uploads/documents/WM8728.pdf or do you need t=
o
know the interconnections?

(I am guessing the problem lies in the explanation of page 33 in the
datasheet? With the fact that the GPIO settings depend on the EEPROM
whereas it doesn't have an EEPROM?)

edited on: 05-03-04 01:15

----------------------------------------------------------------------
 tiwai - 05-03-2004 19:15 CEST=20
----------------------------------------------------------------------
usually the WM codecs are controlled over I2C (SPI mode) through
the GPIO pins of Envy chip.  the connection information is not
described in EEPROM, anyway, so we'll need to know by ourselves.

the best way is : try to give pressure to the mobo vendor
to tell us the pin connection information!


alternatively, you can check the pin connection between Envy and
WM chips on your mobo by yourself (using a loupe and tracking the
wiring on mobo).  the pin numbers of the chips are found in the
datasheets.  likely there should be 3 wires connected between them.
or, it might be over Envy's I2C pins, instead of EEPROM.

----------------------------------------------------------------------
 bana - 05-04-2004 00:51 CEST=20
----------------------------------------------------------------------
[snip]
 (using a loupe and tracking the wiring on mobo)
[/snip]
What is a loupe? Can a multimeter be used instead? I will try to contact
mobo vendor as well.

----------------------------------------------------------------------
 Robster - 05-04-2004 07:16 CEST=20
----------------------------------------------------------------------
Heh... a loupe is one of those magnifying glasses that photographers and
jewellers use... they couldn't use a multimeter instead, although we coul=
d
;-)

I'm contacting Albatron for info on the K8X800 Pro II.

----------------------------------------------------------------------
 Robster - 05-04-2004 08:52 CEST=20
----------------------------------------------------------------------
OK, I traced out the connections on my K8X800 Pro II (which has the
"standard" VT1720/VT1616/WM8728), although only to the Wolfson chip. I
take it that the VT1616 interface is already understood: if I'm not
correct, let me know and I'll see if I can trace that as well (although
I'm a bit cross-eyed at the moment :-)

Anyway:
WM8728 pin #    Description     VT1720 pin #    Description
1               LRCIN           109             SPSYNC
2               DIN             106             PSDOUT[1]
3               BCKIN           110             SPSCLK
4               MCLK            112             SPMCLKOUT
18              SDIDEM          70              SDA
19              SCK             71              SCL

That's it. I couldn't find any connection between the WM8728's pins 15
(CSBIWL), 16 (MODE), 17 (MUTEB), or 20 (LATI2S), and the VT1720 (also non=
e
of them appeared to be connected to DGND or DVDD either).

Hope this helps!

<edit> great, the board doesn't support tabs. Ah well, hopefully it still
makes sense.

edited on: 05-04-04 08:52

----------------------------------------------------------------------
 bana - 05-05-2004 01:51 CEST=20
----------------------------------------------------------------------
Great work Robster! Lets hope thats what we need (do we need to do it for
the Chaintech as well or should they be the same?) I am going to go ahead
and email chaintech anyway though (couldn't hurt).

----------------------------------------------------------------------
 Robster - 05-05-2004 09:02 CEST=20
----------------------------------------------------------------------
I had a look at sound/pci/ice1712/ice1724.c to see if I could fudge it in=
to
making some sound, but I don't know what the EEPROM usually contains on a=
n
Envy 24HT so I was a bit lost.

Also, I got a reply from Albatron directing me to Via's Linux audio drive=
r
download page, which of course doesn't have anything for Envy 24PT so tha=
t
wasn't useful. I've sent them another message pointing this out to them,
I'll report if anything useful happens.

----------------------------------------------------------------------
 Vladimir Dyakov - 05-08-2004 08:36 CEST=20
----------------------------------------------------------------------
Hi, I have the problem like that with AudioTrak Maya44 MKII. I have
submitted new bug, see
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0263

----------------------------------------------------------------------
 bana - 05-12-2004 02:55 CEST=20
----------------------------------------------------------------------
Perex, sorry to bother you but any news regarding the AC'97 mode yet? I a=
m
willing to test code if you want, or whatever else you need. I still have
not recieved a reply from Chaintech, I will give them a few more days and
then re send the message. Thanks.

----------------------------------------------------------------------
 tiwai - 05-18-2004 20:53 CEST=20
----------------------------------------------------------------------
ok i made an experimental patch, attached here (vt1720_mobo.dif).

note that it's to the very latest ALSA CVS version.  you'll likely
need to wait for tomorrow until the anonymous CVS tree on sourceforge
gets sync'ed.

the patch adds only AC97 codec support.
if Robster's report is correct, WM codec is connected to SPDOUT[1],
and controlled over I2C of VT1720 (not the 3-wire over GPIO as i
guessed).  that's why it has no EEPROM.
then we'll need to know the I2C address of WM codec...

also, i don't know whether one can mix AC97 and I2S transfer mode
at the same time.

----------------------------------------------------------------------
 Robster - 05-18-2004 21:19 CEST=20
----------------------------------------------------------------------
Aha, thanks very much tiwai. I'll try this out as soon as I can.

>From page 11 of the WM8728 datasheet:
"The address for the device in 2-wire mode is 001101X (binary) with the
last bit selectable. The CSBIWL pin indicates the final bit of the chip
address. The LATI2S pin should be time to either DGND or DVSS to avoid
noise toggling the interface into 3-wire mode."

I will find out later what the state of the CSBIWL pin on my mobo is, but
it would probably make sense to autodetect it (can't be that hard to try
both?). I already mentioned that I didn't see any connection between
CSBIWL or LATI2S, and DGND or VSS, but presumably there's some resistance
in there.

----------------------------------------------------------------------
 bana - 05-20-2004 06:24 CEST=20
----------------------------------------------------------------------
Well I don't know how to compile CVS (tried and failed) and if you want t=
o
try and help me my full log is here:
http://bhpdc-forums.dyndns.org/alsa.txt Perhaps someone used to this can
help me or try it themselves? Is the patch command patch -p1 <
/path/to/patch while in CVSROOT?

----------------------------------------------------------------------
 Robster - 05-21-2004 06:44 CEST=20
----------------------------------------------------------------------
Here's what I did:
- checked out the source from alsa-project CVS
- applied tiwai's patch (I did it manually, I'm hopeless with patching an=
d
it was very simple anyway)
- downloaded the Linux kernel 2.6.6-mm4 source
- softlinked /usr/src/linux to /usr/src/linux-2.6.6-mm4
- went to /usr/src/linux/sound
- cp -a /path/to/alsa-cvs/alsa-kernel/ * .
- config'd and built kernel with ice-1724 modules

The kernel built without errors or warnings, which I took as a good sign.
Now I still don't have sound, but the message in /var/log/messages says
nothing about EEPROM anymore, it just says

May 21 16:47:10 val ICE1724: probe of 0000:00:06.0 failed with error -16

when I modprobe snd_ice1724. I'll look into it further.

----------------------------------------------------------------------
 Robster - 05-21-2004 10:19 CEST=20
----------------------------------------------------------------------
Oh, forgot a very important point: the first time I modprobe'd the new
module, it made a click in my speakers. That's gotta be a good sign :)

----------------------------------------------------------------------
 orac100 - 05-22-2004 10:37 CEST=20
----------------------------------------------------------------------
Robster, the following post of mine [22May04] to the Via Envy24PT for ALS=
A
BB may help you:

I've managed to get some sound out of my onboard VT1724PT from my Albatro=
n
PX865PE ProII.=20

How? Get the latest ALSA CVS source from sf.net, and apply the VT1720 MOB=
O
patch from tiwai (see the ALSA bug-track entry for this problem).=20

Attempting to load this didn't work. I was getting a similiar error to th=
e
modprobe error that Robster is reporting.=20

After some debugging, I determined that the setup of the SPDIF controls i=
n
snd_vt1724_probe() was failing. Even though the hardcoded EEPROM config
doesn't specify a SPDIF support, this was being overwritten by
snd_vt1724_chip_init() which reads the setup back from the VT1724PT.=20

Forcing 'ice->eeprom.data[ICE_EEP2_SPDIF] =3D 0;' at the end of
snd_vt1724_chip_init() fixes the initialisation issues.=20

Now when I load the snd_ice1724 module it all loads without errors, and
after unmutting the volume and PCM settings, I can play standard .au
files.=20

So it appears to work.... but not perfectly. Attempting to play .wav file=
s
generates the correct sounds, but there is an awfull lot of crackle/pops.

----------------------------------------------------------------------
 Robster - 05-23-2004 06:32 CEST=20
----------------------------------------------------------------------
The "Via Envy24PT for ALSA BB"? I'd be grateful if you could give me more
information about how to find this beast!

I did as you said, and sure enough I get sound from XMMS through the ALSA
output plugin, and it sounds really awful... but any sound is better than
none! KDE tells me it can't find /dev/dsp, and Return to Castle
Wolfenstein is silent, but that is probably to do with my udev setup.

So, definite progress. Thanks for your input - I'd be debugging it myself
but for Lack of Time (tm) so I'm dependent on people such as yourself.

----------------------------------------------------------------------
 bana - 05-23-2004 06:42 CEST=20
----------------------------------------------------------------------
Robster: I started the Envy24 PT BB as I wanted a place where we could me=
et
and determine what to do next (as a supplement to these bugnotes) you can
find it here: http://bhpdc-forums.dyndns.org/alsa I am very happy to hear
of the progress that you made orac, I believe we are getting close.

----------------------------------------------------------------------
 tiwai - 05-24-2004 14:55 CEST=20
----------------------------------------------------------------------
please check /proc/asound/card0/pcm0p/sub0/hw_params for both
well and badly working cases.  if it depends on the sample rate,
try the attached patch (ice-ac97-fix.dif).

----------------------------------------------------------------------
 Robster - 05-24-2004 22:05 CEST=20
----------------------------------------------------------------------
OK,  /proc/asound/card0/pcm0p/sub0/hw_params contained the single word
"Closed" - I guess I should have looked when it was playing something, bu=
t
that didn't occur to me. Anyway, I applied the patch and now XMMS sounds
*perfect*. A thousand thank-you's!

So, when listening to a song, I get the following in /proc.../hw_params:

access: MMAP_INTERLEAVED
format: S32_LE
subformat: STD
channels: 2
rate: 44100 (44100/1)
period_size: 1104
buffer_size: 32768
tick_time: 1000

I'll try to sort out the /dev/dsp thing later.

----------------------------------------------------------------------
 Robster - 05-25-2004 10:16 CEST=20
----------------------------------------------------------------------
OK, all I had to do was mknod /dev/dsp and /dev/mixer, and now I have sou=
nd
in KDE and XMMS. I've only tested the line out socket, because I don't
have a surround sound setup.

Return to Castle Wolfenstein now dies rather than just running with no
sound, but I have some ideas about why that is. I mention RtCW
specifically because it seems to be rather picky about sound.

Bana, how is it going for you?

----------------------------------------------------------------------
 tiwai - 05-25-2004 11:57 CEST=20
----------------------------------------------------------------------
ok, the patch is on CVS, will appear in 1.0.5-rc2 or -final.

----------------------------------------------------------------------
 orac100 - 05-25-2004 22:32 CEST=20
----------------------------------------------------------------------
tiwai, the ice-ac97-rate-fix.dif patch did the trick for me as well. I no=
w
have sound from various media (.au, .wav, .mp3, DVD) all without
snap/crackle/pop effects. Thanks!!!

I'll pickup the latest CVS updates later today, and then see what the
problem with the SPDIF setup is - even if it exists any more.

----------------------------------------------------------------------
 bana - 05-26-2004 03:48 CEST=20
----------------------------------------------------------------------
............. I am so ridiculously happy... :D I don't think music has ev=
er
sounded so sweet. This is incredibly awesome. Thank you so much perex,
robster, orac100, and tiwai! I have completely working xmms sound (haven'=
t
tested anything else but will look at that later). To follow my steps
exactly to get sound without having to recompile the kernel, then look
below:

   1. su into root
   2. mkdir /opt/alsa
   3. cd /opt/alsa
   4. cvs -d ':pserver:anonymous@cvs.alsa-project.org:/cvsroot/alsa'
login
   5. cvs -z3 -d ':pserver:anonymous@cvs.alsa-project.org:/cvsroot/alsa'
co -P .
   6. now stay where you are and do a ./configure --with-cards=3Dice1724
--with-sequencer=3Dyes;make;make install
   7. cd into alsa-driver
   8. ./configure --with-cards=3Dice1724 --with-sequencer=3Dyes;make;make
install (again)
   9. either unload all your alsa modules and reload them or reboot
  10. test the functionality by a cat /proc/asound/cards (If you see
something, it is a green light )

Now we just have to work on getting games, midi, speakers and spidf
working.

(This is with the Chaintech ZNF3-150)

----------------------------------------------------------------------
 winjer - 05-26-2004 12:41 CEST=20
----------------------------------------------------------------------
> 1. su into root
> 2. mkdir /opt/alsa
> 3. cd /opt/alsa
> 4. cvs -d ':pserver:anonymous@cvs.alsa-project.org:/cvsroot/alsa' login
> 5. cvs -z3 -d ':pserver:anonymous@cvs.alsa-project.org:/cvsroot/alsa' c=
o
-P .
> 6. now stay where you are and do a ./configure --with-cards=3Dice1724
--with-sequencer=3Dyes;make;make install

I get as far as point 5, but no configure script is present in the root o=
f
the cvs checkout, so ./configure doesn't work.  Can you give me some
pointers?

doug.

----------------------------------------------------------------------
 bana - 05-26-2004 20:24 CEST=20
----------------------------------------------------------------------
Hmm, I don't either, I don't think you need to configure in the CVSROOT,
just make (and maybe not even make install), I was not really sure what
was and was not needed so try just continuing on.

----------------------------------------------------------------------
 orac100 - 05-26-2004 21:25 CEST=20
----------------------------------------------------------------------
winjer, step 6 of bana's instructions should just be 'make' (from
/opt/alsa), and don't worry about steps 7 or 8 (the make at step 6 will d=
o
the install)

----------------------------------------------------------------------
 bana - 05-31-2004 19:23 CEST=20
----------------------------------------------------------------------
So is the support added in 1.0.5 and 1.0.5a? There is no mention of it on
the front page: "2004-05-31  	1.0.5a driver release | bugfix for the
"hang-up" problem in the ALSA driver initialization
2004-05-28 	1.0.5 release | mostly bug-fixes and cleanups"

Also, should this bug be closed and issues with /dev/dsp be opened in a
new bug report?

And lastly: Where is the page for this soundcard going to fall under? IC
Ensemble? or VIA? It is somewhat confusing as to which one it is more
'close' to.

----------------------------------------------------------------------
 h3retic - 06-12-2004 08:45 CEST=20
----------------------------------------------------------------------
Hi.=20

I'm using the Envy chip on the Albatron K8X800 Pro II board for AMD 64,
with the AMD_64 version of Mandrake...

The sound, of course, didn't work out of the box, so I'm glad I found thi=
s
thread.
The problem I'm having though is that when I do a cvs update and run
'make', I get this:

[snip]
checking for ALSA LDFLAGS...  -lasound -lm -ldl
checking for libasound headers version >=3D 0.9.0... found.
checking for snd_seq_create_event in -lasound... no
configure: error: No linkable libasound was found.
make[1]: Entering directory `/opt/alsa/alsa-utils'
make[1]: *** No rule to make target `install'.  Stop.
make[1]: Leaving directory `/opt/alsa/alsa-utils'

And the compilation stops. I had to do a bunch of things to get this far
as well, adjusting for previous errors, however, I stuck at this error.

Now, the funny thing is, I actually have /dev/dsp, and can get sound now,
through both mpg123 and xmms. However, the songs play noticably faster
than they  should, in either application...

I can actually get the correct tone and pitch in mpg123 by adding the
speed options -d and -h like so:

mpg123 -h 8 -d 7 Jack\ Johnson\ -\ Flake.mp3

And the song plays at the correct speed and pitch. If my math is up to
snuff, this is around 12-13% too fast. Of course using this method, the
sound is terrible, with nasty audible 'hiccups'.

Other than the speed/pitch problem, the sound is actually pretty good whe=
n
played back normally.

Thanks,=20

Al

----------------------------------------------------------------------
 bana - 06-12-2004 20:42 CEST=20
----------------------------------------------------------------------
heretic: I believe it is no longer needed to use the CVS ALSA packages.
1.0.5a works fine for me and should give you a clean compile (as long as
you are doing it right).

----------------------------------------------------------------------
 winjer - 06-18-2004 18:22 CEST=20
----------------------------------------------------------------------
Finally found the time to try and get this working again, and I've just
built from 1.0.5a using a pristine 2.6.7 kernel.org kernel, and it works =
a
treat on my ZNF3-150.  I see:

0 [ZNF3150        ]: ICE1724 - Chaintech ZNF3-150
                     Chaintech ZNF3-150 at 0xac00, irq 11

in /proc/asound/cards, and I have some very nice sound coming out of it
too!  I couldn't get it to work with a debian kernel, so presumably
there's something funny going on in debian land.

Thanks hugely ALSA guys, the excellent onboard sound was one of the
reasons I got this mobo, so finally actually hearing it is really
satisfying :)

----------------------------------------------------------------------
 tiwai - 06-22-2004 18:44 CEST=20
----------------------------------------------------------------------
Ok, let's close this bug now for now.

For the missing features, please open another bug.
Otherwise it'll be too long and hard to read.

Bug History
Date Modified  Username       Field                    Change            =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
03-17-04 20:48 bana           New Bug                                    =
 =20
03-17-04 20:48 bana           Distribution              =3D> Fedora Core =
1  =20
03-17-04 20:48 bana           Kernel Version            =3D> 2.6.3 and 2.=
6.4=20
03-21-04 19:58 bana           Bugnote Added: 0000651                     =
 =20
03-23-04 04:53 BillyBreen2k   Bugnote Added: 0000654                     =
 =20
03-23-04 05:24 bana           Bugnote Added: 0000655                     =
 =20
03-23-04 06:44 BillyBreen2k   Bugnote Added: 0000656                     =
 =20
03-23-04 16:14 perex          Bugnote Added: 0000664                     =
 =20
03-23-04 18:43 BillyBreen2k   Bugnote Added: 0000687                     =
 =20
03-23-04 18:53 perex          Bugnote Added: 0000689                     =
 =20
03-23-04 21:59 winjer         Bugnote Added: 0000693                     =
 =20
03-24-04 00:40 BillyBreen2k   Bugnote Added: 0000694                     =
 =20
03-24-04 01:00 bana           Bugnote Added: 0000695                     =
 =20
03-24-04 01:01 bana           Bugnote Edited: 0000695                    =
 =20
03-24-04 02:35 bana           Bugnote Edited: 0000695                    =
 =20
03-24-04 02:35 bana           Bugnote Edited: 0000695                    =
 =20
03-24-04 05:01 bana           Bugnote Edited: 0000695                    =
 =20
03-24-04 10:10 perex          Bugnote Added: 0000697                     =
 =20
03-25-04 03:44 bana           Bugnote Added: 0000705                     =
 =20
04-06-04 03:08 bana           Bugnote Added: 0000756                     =
 =20
04-07-04 20:09 perex          Status                   new =3D> confirmed=
   =20
04-07-04 20:25 perex          Bugnote Added: 0000765                     =
 =20
04-09-04 04:16 bana           Bugnote Added: 0000773                     =
 =20
04-09-04 06:30 astrohm        Bug Monitored: astrohm                     =
 =20
04-25-04 05:32 bana           Bugnote Added: 0000932                     =
 =20
04-25-04 09:50 perex          Bugnote Added: 0000934                     =
 =20
04-25-04 18:49 bana           Bugnote Added: 0000942                     =
 =20
04-26-04 20:20 rameyst        Bugnote Added: 0000954                     =
 =20
04-30-04 00:59 bana           Bugnote Added: 0000970                     =
 =20
05-01-04 00:52 bana           Bug Monitored: perex                       =
 =20
05-01-04 00:52 bana           Bugnote Added: 0000984                     =
 =20
05-02-04 09:43 perex          Bugnote Added: 0001002                     =
 =20
05-02-04 12:51 perex          Bugnote Edited: 0001002                    =
 =20
05-02-04 12:59 perex          Bugnote Added: 0001006                     =
 =20
05-02-04 13:14 Robster        Bugnote Added: 0001007                     =
 =20
05-02-04 13:18 Robster        Bugnote Edited: 0001007                    =
 =20
05-02-04 13:19 Robster        Bug Monitored: Robster                     =
 =20
05-02-04 16:24 BillyBreen2k   Bugnote Added: 0001010                     =
 =20
05-02-04 17:06 astrohm        Bugnote Added: 0001011                     =
 =20
05-02-04 17:19 perex          Bugnote Added: 0001012                     =
 =20
05-02-04 17:42 Robster        Bugnote Added: 0001013                     =
 =20
05-02-04 19:03 bana           Bugnote Added: 0001014                     =
 =20
05-02-04 19:07 bana           Bugnote Edited: 0001014                    =
 =20
05-02-04 19:30 bana           Bugnote Edited: 0001014                    =
 =20
05-02-04 19:53 perex          Bugnote Added: 0001015                     =
 =20
05-03-04 00:47 bana           Bugnote Added: 0001017                     =
 =20
05-03-04 01:14 bana           Bugnote Added: 0001018                     =
 =20
05-03-04 01:15 bana           Bugnote Edited: 0001018                    =
 =20
05-03-04 19:15 tiwai          Bugnote Added: 0001032                     =
 =20
05-04-04 00:51 bana           Bugnote Added: 0001034                     =
 =20
05-04-04 07:16 Robster        Bugnote Added: 0001036                     =
 =20
05-04-04 08:49 Robster        Bugnote Added: 0001038                     =
 =20
05-04-04 08:52 Robster        Bugnote Edited: 0001038                    =
 =20
05-05-04 01:51 bana           Bugnote Added: 0001047                     =
 =20
05-05-04 09:02 Robster        Bugnote Added: 0001049                     =
 =20
05-08-04 08:36 Vladimir DyakovBugnote Added: 0001071                     =
 =20
05-12-04 02:55 bana           Bugnote Added: 0001089                     =
 =20
05-18-04 20:53 tiwai          Bugnote Added: 0001145                     =
 =20
05-18-04 20:53 tiwai          File Added: vt1720_mobo.dif                =
   =20
05-18-04 21:19 Robster        Bugnote Added: 0001146                     =
 =20
05-20-04 06:24 bana           Bugnote Added: 0001157                     =
 =20
05-21-04 06:44 Robster        Bugnote Added: 0001160                     =
 =20
05-21-04 10:19 Robster        Bugnote Added: 0001161                     =
 =20
05-22-04 10:37 orac100        Bugnote Added: 0001167                     =
 =20
05-23-04 06:32 Robster        Bugnote Added: 0001177                     =
 =20
05-23-04 06:42 bana           Bugnote Added: 0001178                     =
 =20
05-24-04 14:55 tiwai          Bugnote Added: 0001184                     =
 =20
05-24-04 14:55 tiwai          File Added: ice-ac97-rate-fix.dif          =
      =20
 =20
05-24-04 22:05 Robster        Bugnote Added: 0001198                     =
 =20
05-25-04 10:16 Robster        Bugnote Added: 0001200                     =
 =20
05-25-04 11:57 tiwai          Bugnote Added: 0001201                     =
 =20
05-25-04 22:32 orac100        Bugnote Added: 0001239                     =
 =20
05-26-04 03:48 bana           Bugnote Added: 0001244                     =
 =20
05-26-04 12:41 winjer         Bugnote Added: 0001248                     =
 =20
05-26-04 20:24 bana           Bugnote Added: 0001261                     =
 =20
05-26-04 21:25 orac100        Bugnote Added: 0001262                     =
 =20
05-31-04 19:23 bana           Bugnote Added: 0001286                     =
 =20
06-12-04 08:45 h3retic        Bugnote Added: 0001300                     =
 =20
06-12-04 20:42 bana           Bugnote Added: 0001302                     =
 =20
06-18-04 18:02 Apostolos DimitromanolakisBug Monitored: Apostolos
Dimitromanolakis                   =20
06-18-04 18:22 winjer         Bugnote Added: 0001320                     =
 =20
06-22-04 18:44 tiwai          Bugnote Added: 0001331                     =
 =20
06-22-04 18:44 tiwai          Assigned To               =3D> tiwai       =
   =20
06-22-04 18:44 tiwai          Resolution               open =3D> fixed   =
   =20
06-22-04 18:44 tiwai          Status                   confirmed =3D> res=
olved
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
