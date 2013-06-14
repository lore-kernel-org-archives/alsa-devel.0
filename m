From: someone deleted <mynameisdeleted@gmail.com>
Subject: tascam us800
Date: Fri, 14 Jun 2013 01:02:17 -0500
Message-ID: <CALA1gd+6bw6Xiaip3eNA8=xh_tZyGQFHKaJwtP9WqN2vrWNPJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f49.google.com (mail-vb0-f49.google.com
 [209.85.212.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E9E4260291
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2013 08:02:18 +0200 (CEST)
Received: by mail-vb0-f49.google.com with SMTP id 12so137226vbf.22
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2013 23:02:18 -0700 (PDT)
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

my tascam us800 works great in 3.8.0-21 except for one issue... no usb-mixer

here is output of lsusb -v
http://studio213.us/usbif.txt


here is output of alsa-info.sh
http://www.alsa-project.org/db/?f=336a5faa6233bc80a856089e657d80da1d32e081


alsamixer -c 1 shows
amixer: Mixer hw:1 load error: Connection timed out




dmesg when I do that shows


[115350.348159] cannot get ctl value: req = 0x83, wValue = 0x101, wIndex =
0x1f00, type = 4
[115351.348158] cannot get ctl value: req = 0x81, wValue = 0x101, wIndex =
0x1f00, type = 4
[115732.480250] cannot get ctl value: req = 0x83, wValue = 0x101, wIndex =
0x1f00, type = 4
[115733.480241] cannot get ctl value: req = 0x81, wValue = 0x101, wIndex =
0x1f00, type = 4




plugging in the card shows
[   45.550396] usbcore: registered new interface driver snd-usb-audio

in dmesg


any info on how I might access this usb-mixer built into this card?
