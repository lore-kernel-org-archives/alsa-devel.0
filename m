From: "John S. Denker" <jsd@monmouth.com>
Subject: Re: usbaudio won't do 24-bit or 32-bit i/o, and won't
 do 96000 frames per second
Date: Thu, 05 Dec 2002 14:10:11 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DEFA493.9020505@monmouth.com>
References: <Pine.HPX.4.33n.0212051549290.19058-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080001070407010400060604"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0212051549290.19058-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080001070407010400060604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Clemens Ladisch wrote:

> USB devices announce their capabilities in their descriptors. Please
> post the output of lsusb and the output of "od -t x1
> /proc/bus/usb/001/xxx" (xxx is the device number; try all files
> there, the one I want to see has "1E 04" somewhere in the first
> line).

As requested:

1)    lsusb
Unknown line at line 1809
Duplicate HUT Usage Spec at line 2650
Bus 001 Device 001: ID 0000:0000 Virtual Hub
Bus 001 Device 003: ID 041e:3000 Creative Labs

2) The od is attached as a .txt file.

3) Perhaps easier to use is the output of usbview,
also attached as a .txt file.

--------------080001070407010400060604
Content-Type: text/plain;
 name="extigy-od.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="extigy-od.txt"

0000000 12 01 10 01 00 00 00 40 1e 04 00 30 00 01 01 02
0000020 00 01 09 02 1a 03 04 01 00 c0 00 09 04 00 00 01
0000040 01 01 00 00 0b 24 01 00 01 9a 01 03 01 02 03 0c
0000060 24 02 01 01 01 00 06 3f 00 00 00 15 24 06 02 01
0000100 02 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0000120 0c 24 02 03 01 01 00 06 3f 00 00 00 0c 24 02 04
0000140 02 06 00 06 3f 00 00 00 08 24 05 05 02 03 04 00
0000160 15 24 06 06 05 02 03 00 00 00 00 00 00 00 00 00
0000200 00 00 00 00 00 0c 24 02 07 03 06 00 02 03 00 00
0000220 00 0d 24 06 08 07 02 03 00 02 00 02 00 00 0c 24
0000240 02 09 01 02 00 02 03 00 00 00 0d 24 06 0a 09 02
0000260 03 00 00 00 00 00 00 09 24 05 0b 03 07 09 11 00
0000300 0d 24 06 0c 0b 02 03 00 00 00 00 00 00 09 24 03
0000320 0d 01 01 00 0c 00 11 24 04 0e 02 08 06 02 03 00
0000340 00 00 00 00 00 00 00 0f 24 07 0f 03 00 01 0e 05
0000360 37 00 00 01 01 00 1a 24 04 10 04 02 06 0f 0a 06
0000400 3f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0000420 1e 24 07 11 01 00 01 10 06 3f 00 00 01 03 00 07
0000440 03 00 03 00 0b 00 33 00 3b 00 37 00 3f 00 15 24
0000460 06 12 11 02 17 00 02 00 02 00 02 00 02 00 02 00
0000500 02 00 00 0f 24 08 1b 00 00 01 12 06 3f 00 00 01
0000520 01 00 0e 24 06 1c 1b 01 01 00 00 00 00 00 00 00
0000540 09 24 03 13 01 03 00 1c 00 09 24 03 14 02 03 00
0000560 12 00 0f 24 08 15 00 00 01 1b 06 3f 00 00 01 01
0000600 00 0e 24 06 16 15 01 01 00 00 00 00 00 00 00 0e
0000620 24 06 17 16 01 01 00 00 00 00 00 00 00 09 24 03
0000640 18 02 06 00 17 00 0e 24 06 19 16 01 01 00 00 00
0000660 00 00 00 00 09 24 03 1a 02 06 00 19 00 07 05 81
0000700 03 08 00 0a 09 04 01 00 00 01 02 00 00 09 04 01
0000720 01 02 01 02 00 00 07 24 01 01 00 01 00 0b 24 02
0000740 01 02 02 10 01 80 bb 00 09 05 02 05 c8 00 01 00
0000760 03 07 25 01 00 00 00 00 09 05 83 01 03 00 01 06
0001000 00 09 04 02 00 00 01 02 00 00 09 04 02 01 01 01
0001020 02 00 00 07 24 01 0d 00 01 00 0b 24 02 01 02 02
0001040 10 01 40 1f 00 09 05 86 05 28 00 01 00 00 07 25
0001060 01 00 00 00 00 09 04 02 02 01 01 02 00 00 07 24
0001100 01 0d 00 01 00 0b 24 02 01 02 02 10 01 80 3e 00
0001120 09 05 86 05 48 00 01 00 00 07 25 01 00 00 00 00
0001140 09 04 02 03 01 01 02 00 00 07 24 01 0d 00 01 00
0001160 0b 24 02 01 02 02 10 01 c0 5d 00 09 05 86 05 68
0001200 00 01 00 00 07 25 01 00 00 00 00 09 04 02 04 01
0001220 01 02 00 00 07 24 01 0d 00 01 00 0b 24 02 01 02
0001240 02 10 01 00 7d 00 09 05 86 05 88 00 01 00 00 07
0001260 25 01 00 00 00 00 09 04 02 05 01 01 02 00 00 07
0001300 24 01 0d 00 01 00 0b 24 02 01 02 02 10 01 80 bb
0001320 00 09 05 86 05 c8 00 01 00 00 07 25 01 00 00 00
0001340 00 09 04 03 00 00 01 02 00 00 09 04 03 01 02 01
0001360 02 00 00 07 24 01 03 00 02 10 0f 24 02 02 80 02
0001400 00 06 02 44 ac 00 80 bb 00 0a 24 03 02 10 1f 00
0001420 00 00 00 09 05 04 05 54 00 01 00 05 07 25 01 00
0001440 00 00 00 09 05 85 01 03 00 01 06 00
0001454

--------------080001070407010400060604
Content-Type: text/plain;
 name="usbview.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="usbview.txt"

Sound Blaster Extigy
Manufacturer: Creative Technology Ltd.
Speed: 12Mb/s (full)
USB Version:  1.10
Device Class: 00(>ifc )
Device Subclass: 00
Device Protocol: 00
Maximum Default Endpoint Size: 64
Number of Configurations: 1
Vendor Id: 041e
Product Id: 3000
Revision Number:  1.00

Config Number: 1
	Number of Interfaces: 4
	Attributes: c0
	MaxPower Needed:   0mA

	Interface Number: 0
		Name: snd-usb-audio
		Alternate Number: 0
		Class: 01(audio) 
		Sub Class: 1
		Protocol: 0
		Number of Endpoints: 1

			Endpoint Address: 81
			Direction: in
			Attribute: 3
			Type: Int.
			Max Packet Size: 8
			Interval:  10ms

	Interface Number: 1
		Name: snd-usb-audio
		Alternate Number: 0
		Class: 01(audio) 
		Sub Class: 2
		Protocol: 0
		Number of Endpoints: 0

	Interface Number: 1
		Name: snd-usb-audio
		Alternate Number: 1
		Class: 01(audio) 
		Sub Class: 2
		Protocol: 0
		Number of Endpoints: 2

			Endpoint Address: 02
			Direction: out
			Attribute: 5
			Type: Isoc
			Max Packet Size: 200
			Interval:   1ms

			Endpoint Address: 83
			Direction: in
			Attribute: 1
			Type: Isoc
			Max Packet Size: 3
			Interval:   1ms

	Interface Number: 2
		Name: snd-usb-audio
		Alternate Number: 0
		Class: 01(audio) 
		Sub Class: 2
		Protocol: 0
		Number of Endpoints: 0

	Interface Number: 2
		Name: snd-usb-audio
		Alternate Number: 1
		Class: 01(audio) 
		Sub Class: 2
		Protocol: 0
		Number of Endpoints: 1

			Endpoint Address: 86
			Direction: in
			Attribute: 5
			Type: Isoc
			Max Packet Size: 40
			Interval:   1ms

	Interface Number: 2
		Name: snd-usb-audio
		Alternate Number: 2
		Class: 01(audio) 
		Sub Class: 2
		Protocol: 0
		Number of Endpoints: 1

			Endpoint Address: 86
			Direction: in
			Attribute: 5
			Type: Isoc
			Max Packet Size: 72
			Interval:   1ms

	Interface Number: 2
		Name: snd-usb-audio
		Alternate Number: 3
		Class: 01(audio) 
		Sub Class: 2
		Protocol: 0
		Number of Endpoints: 1

			Endpoint Address: 86
			Direction: in
			Attribute: 5
			Type: Isoc
			Max Packet Size: 104
			Interval:   1ms

	Interface Number: 2
		Name: snd-usb-audio
		Alternate Number: 4
		Class: 01(audio) 
		Sub Class: 2
		Protocol: 0
		Number of Endpoints: 1

			Endpoint Address: 86
			Direction: in
			Attribute: 5
			Type: Isoc
			Max Packet Size: 136
			Interval:   1ms

	Interface Number: 2
		Name: snd-usb-audio
		Alternate Number: 5
		Class: 01(audio) 
		Sub Class: 2
		Protocol: 0
		Number of Endpoints: 1

			Endpoint Address: 86
			Direction: in
			Attribute: 5
			Type: Isoc
			Max Packet Size: 200
			Interval:   1ms

	Interface Number: 3
		Name: snd-usb-audio
		Alternate Number: 0
		Class: 01(audio) 
		Sub Class: 2
		Protocol: 0
		Number of Endpoints: 0

	Interface Number: 3
		Name: snd-usb-audio
		Alternate Number: 1
		Class: 01(audio) 
		Sub Class: 2
		Protocol: 0
		Number of Endpoints: 2

			Endpoint Address: 04
			Direction: out
			Attribute: 5
			Type: Isoc
			Max Packet Size: 84
			Interval:   1ms

			Endpoint Address: 85
			Direction: in
			Attribute: 1
			Type: Isoc
			Max Packet Size: 3
			Interval:   1ms

--------------080001070407010400060604--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
