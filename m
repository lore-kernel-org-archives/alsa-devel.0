From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: MOTU Midi Express XT driver
Date: Thu, 30 Jun 2011 17:34:34 +0200
Message-ID: <130e12ff39b.-3928454424886384200.-4172847127217991853@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id 9704224581
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Jun 2011 17:34:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello all,

I'm currently trying to write a driver for the MOTU Midi Express XT. The problem I have is that the device has same idVendor and idProduct as the MOTU FastLane Quad MIDI Interface (for which already a driver exists in snd-usbmidi). If I do an lsusb, I see that the field iProduct identifies the device as a Midi Express XT. But I found no way of matching to iProduct in the usb_device_id structure. Is there a possibility to do so? Otherwise I'm thinking of patching snd-usbmidi in a way that it differentiates between the devices there.

Thanks,
Torsten


Here the lsusb output:
Bus 004 Device 003: ID 07fd:0001 Mark of the Unicorn FastLane Quad MIDI Interface
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass         1
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x07fd Mark of the Unicorn
  idProduct          0x0001 FastLane Quad MIDI Interface
  bcdDevice            1.32
  iManufacturer           0
  iProduct              119 MIDI Express XT
  iSerial                 0
  bNumConfigurations      1
...
