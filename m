From: "Natalie Protasevich" <protasnb@gmail.com>
Subject: [BUG] USB sounds card doesn't work - Device
	0x4fa:0x4201
Date: Thu, 27 Mar 2008 16:50:25 -0700
Message-ID: <32209efe0803271650m2951ba2dq8530dd93eaad9d42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 91B5C103810
	for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2008 00:50:26 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id l27so4056341fgb.44
	for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2008 16:50:26 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello ALSA developers,

This problem with the USB sounds card has been reported a while ago,
and just been confirmed with latest kernel.
====================================================================
$ cat /proc/asound/cards
 0 [I82801DBICH4   ]: ICH4 - Intel 82801DB-ICH4
                      Intel 82801DB-ICH4 with AD1981B at 0xc0000c00, irq 11
 1 [U0x4fa0x4201   ]: USB-Audio - USB Device 0x4fa:0x4201
                      USB Device 0x4fa:0x4201 at usb-0000:00:1d.1-2, full speed

If I attempt to play a song using mpg123 or xmms, I get nothing, only maybe
click at beggining. I'm using in-kernel OSS emulation.

pavel@amd:/mnt/mp3.ptacek/Tanita_Tikaram$ cat /proc/asound/card1/pcm0p/info
card: 1
device: 0
subdevice: 0
stream: PLAYBACK
id: USB Audio
name: USB Audio
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1
pavel@amd:/mnt/mp3.ptacek/Tanita_Tikaram$

I tried unmuting everything using aumix.

cat /bin/bash > /dev/dsp1

fails to produce any sound, too.
===================================================================


Full bug report is here : http://bugzilla.kernel.org/show_bug.cgi?id=6576
It sure needs some helping hand, maybe someone can take a look into this.

Thanks,
--Natalie
