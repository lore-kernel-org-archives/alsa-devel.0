From: VDR User <user.vdr@gmail.com>
Subject: Regression? No sound with HDMI audio (snd-hda-intel)
	with kernel 4.15(.*)
Date: Thu, 29 Mar 2018 21:21:52 -0700
Message-ID: <CAA7C2qgheLp=0H4kx90MTDhsYCvvXYPov8-xvyWL7zvVdifRgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f66.google.com (mail-lf0-f66.google.com
 [209.85.215.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 0572E2671B9
 for <alsa-devel@alsa-project.org>; Fri, 30 Mar 2018 06:21:54 +0200 (CEST)
Received: by mail-lf0-f66.google.com with SMTP id o102-v6so11052336lfg.8
 for <alsa-devel@alsa-project.org>; Thu, 29 Mar 2018 21:21:54 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mailing <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I upgraded my Debian Sid box from kernel 4.14.31 to 4.15.14 and I no
longer get sound over HDMI with my Nividia GT430. Nvidia driver
version is 390.48. Neither the Nvidia installer nor dkms makes any
difference. My alsa-utils is 1.1.3-1 and my ~/.asoundrc is:

~$ cat .asoundrc
pcm.!default "hdmi:NVidia,1"
~$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 1: NVidia [HDA NVidia], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: NVidia [HDA NVidia], device 7: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: NVidia [HDA NVidia], device 8: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: NVidia [HDA NVidia], device 9: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

I'm using 'speaker-test -c 2 -t wav -Dhw:CARD=1,7' for testing.

After kernel 4.15.14 didn't work, I compiled kernel 4.15 and still got
no audio. I then compiled kernel 4.15-rc9 and audio worked. From there
I tried to bisect the exact patch that broke the audio but got the
following:

~$ cd /usr/src
/usr/src$ git clone https://github.com/torvalds/linux.git
/usr/src$ cd linux
/usr/src/linux$ git bisect start -- sound/hda sound/pci/hda
/usr/src/linux$ git bisect good v4.15-rc9
/usr/src/linux$ git bisect bad v4.15
No testable commit found.
Maybe you started with bad path parameters?
/usr/src/linux$

I'm not sure what went wrong there, hopefully one of you reading this
may have an idea.

It's worth noting I upgraded another near-identical system and HDMI
audio is working fine with 4.15.* on that box. That box has an Nvidia
GT520 but other than that the package versions, driver version, etc.
are all the same. Also, it's connected to a surround receiver whereas
the non-working box is connected directly to a tv.

Please let me know if any other info is needed or what I can do/try to
debug this further. Any help is greatly appreciated!
-Derek
