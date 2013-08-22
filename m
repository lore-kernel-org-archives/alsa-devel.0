From: Nikolay Martynov <mar.kolya@gmail.com>
Subject: CM108 head set problem
Date: Wed, 21 Aug 2013 21:17:23 -0400
Message-ID: <CALGY4fu-WhLqYV4+fQC2ik5kpYHYhA1qoeFLUcdMTT-GRWZ+dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f175.google.com (mail-vc0-f175.google.com
 [209.85.220.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 812EC261631
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2013 03:17:24 +0200 (CEST)
Received: by mail-vc0-f175.google.com with SMTP id ia10so712594vcb.20
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2013 18:17:23 -0700 (PDT)
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

Hi.

  I'm experiencing a problem with CM108 based headset. The problem
manifests itself in 'phone' software.

  When I connect the headset and run pavucontrol I can see the headset's
mic in input devices and when I say something the activity bar moves - I
sort of see that mic is producing some input for the OS. Then I try to make
a Skype call (I've set skype to use proper input and output devices). When
I make Skype call the activity bar from pavucontrol disappears and mic
stops working - the other side of the call doesn't hear me.

  Similar thing happens with Google hangout. The only difference is that
with Skype it happens immediately and with Google hangout it looks like it
only happens when I do something 'heavy'. The thing that often triggers the
problem with Google hangout is switching desktops (I have compiz running).

  I'm not entirely sure that problem is alsa related but I have this in
dmesg:

[72856.844289] usb 3-1: USB disconnect, device number 10
[72858.632109] usb 3-1: new full-speed USB device number 11 using uhci_hcd
[72858.792090] usb 3-1: New USB device found, idVendor=045e, idProduct=070f
[72858.792098] usb 3-1: New USB device strings: Mfr=0, Product=1,
SerialNumber=0
[72858.792103] usb 3-1: Product: Microsoft LifeChat LX-3000
[72858.875205] input: Microsoft LifeChat LX-3000  as
/devices/pci0000:00/0000:00:1d.1/usb3/3-1/3-1:1.3/input/input19
[72858.875399] hid-generic 0003:045E:070F.000B: input,hidraw0: USB HID
v1.00 Device [Microsoft LifeChat LX-3000 ] on usb-0000:00:1d.1-1/input3
[72876.015919] retire_capture_urb: 22 callbacks suppressed
[72876.411354] delay: estimated 133, actual 1
[72876.496315] cannot submit urb (err = -18)
[72876.496330] cannot submit urb (err = -18)
[72876.496341] cannot submit urb (err = -18)
[72876.496349] cannot submit urb (err = -18)
[72876.496357] cannot submit urb (err = -18)
[72876.496366] cannot submit urb (err = -18)
[72876.496375] cannot submit urb (err = -18)
[72876.496383] cannot submit urb (err = -18)
[72876.499076] delay: estimated 222, actual 1
[72876.587212] delay: estimated 90, actual 1
[72876.627072] delay: estimated 266, actual 1
[72876.675644] delay: estimated 353, actual 0
[72876.747102] delay: estimated 354, actual 1
[72876.851132] delay: estimated 353, actual 1
[72877.059072] delay: estimated 90, actual 1
[72877.171110] delay: estimated 353, actual 1
[72877.219082] delay: estimated 90, actual 1
[72877.299493] delay: estimated 310, actual 1
[72877.547100] delay: estimated 354, actual 1

It looks like once I get error like message 'cannot submit urb (err = -18)'
mic stops working.

I would really appreciate any help solving this problem and I would be
happy to do any testing required or provide any additional information.

I'm using Linux Mint 15 (Ubuntu 13.04) with '3.10.5' kernel from Ubuntu
mainline kernel builds. The very same problem also happens with 'standard'
kernel that comes with Ubuntu.
I have a dell inspiron 6400 laptop with core2duo CPU and ati video.

Thanks!
-- 
Martynov Nikolay.
Email: mar.kolya@gmail.com
