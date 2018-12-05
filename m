From: Helge Deller <deller@gmx.de>
Subject: USB speaker with CM103+ chip has left and right audio
	inverted
Date: Wed, 5 Dec 2018 17:51:41 +0100
Message-ID: <32c3efea-deb8-dc62-6139-ffae7aaea784@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 52696267B37
 for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2018 17:51:42 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

When using my Logitech LogiLink USB Speaker with Linux, the left and right audio channel is inverted.

lsusb shows
Bus 001 Device 016: ID 0d8c:0104 C-Media Electronics, Inc. CM103+ Audio Controller

dmesg gives:
kernel: usb 1-3: new full-speed USB device number 16 using xhci_hcd
kernel: usb 1-3: New USB device found, idVendor=0d8c, idProduct=0104, bcdDevice= 0.10
kernel: usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
kernel: usb 1-3: Product: USB Sound Device
kernel: usb 1-3: Manufacturer: C-Media INC.
kernel: usb 1-3: Warning! Unlikely big volume range (=9472), cval->res is probably wrong.
kernel: usb 1-3: [13] FU [PCM Playback Volume] ch = 2, val = -9473/-1/1
kernel: input: C-Media INC. USB Sound Device         as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.2/0003:0D8C:0104.0034/input/input59
kernel: hid-generic 0003:0D8C:0104.0034: input,hidraw4: USB HID v1.00 Device [C-Media INC. USB Sound Device        ] on usb-0000:00:14.0-3/input2

Is there a quirk possible?
Any idea/patch what I could test?

This is on Fedora29 with kernel 4.19.5-300.fc29.x86_64.

Thanks,
Helge
