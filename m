From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Experimental USB audio support
Date: Thu, 30 May 2002 14:49:49 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CF5BD7D.A852184D@boosthardware.com>
References: <s5hy9e2hk02.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


At this point I cannot access any of the channels using amixer. This
card has 4 channels I/O but the devices in /proc/asound suggest that
only 3 are being accessed.

Also the only file that shows up in the dirs for card2 card3 and car4 is
'id'  which just says card2 card3 or card4.

Here's the relevant output from lsusb

----
# lsusb -t                     
Bus#  2
`-Dev#   1 Vendor 0x0000 Product 0x0000
Bus#  1
`-Dev#   1 Vendor 0x0000 Product 0x0000
  |-Dev#   4 Vendor 0x0763 Product 0x2001
  `-Dev#   2 Vendor 0x09da Product 0x0006

----
# lsusb -vv -d 0x0763:0x2001

Bus 001 Device 004: ID 0763:2001 Midiman 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            0 Interface
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0763 Midiman
  idProduct          0x2001 
  bcdDevice            1.01
  iManufacturer           1 M Audio
  iProduct                2 USB AudioSport Quattro (tm)
  iSerial                 0 
  bNumConfigurations      1
cannot get config descriptor 0, Connection timed out (110)
  Language IDs: (length=4)
     0409 English(US)
----


-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
=======================================================================

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
