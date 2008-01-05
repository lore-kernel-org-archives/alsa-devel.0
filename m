From: "Ning Zhang" <ning.zhang06@gmail.com>
Subject: can not access the alsa driver
Date: Sat, 5 Jan 2008 22:42:03 +0800
Message-ID: <48a1cba90801050642s47db1bcbj6c6624536eda5949@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B01D24600
	for <alsa-devel@alsa-project.org>; Sat,  5 Jan 2008 15:42:04 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so10728984wag.8
	for <alsa-devel@alsa-project.org>; Sat, 05 Jan 2008 06:42:03 -0800 (PST)
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
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dear all,
I wrote an alsa device driver for my arm_based platform. Then I cross
compiled the alsa-lib-1.0.15, and build an application (static) with the
lib.
I build the driver in the kernel, so after the kernel booted, I can get
these information:

# cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.14rc1 (Tue Jan 09
09:56:17 2007 UTC).

cat /proc/asound/devices
  0: [ 0]   : control
 16: [ 0- 0]: digital audio playback
 24: [ 0- 0]: digital audio capture
 33:        : timer

# cat /proc/asound/cards
 0 [XYZ       ]: XYZ - ARM
                      XYZ  at 0xc485e000 0xc4870000 irq 57

( I did not found /dev/snd  or /dev/dsp )

But when I run the application, I got these errors:
# /tmp/pcm_play_arm_s default
ALSA lib pcm.c:2145:(snd_pcm_open_noupdate) Unknown PCM default
Playback open error: No such file or directory

I googled the Internet, and add two files manually :

# cat /etc/alsa/alsa.conf
pcm.default{
        type hw
        card 0
}

# cat ~/.asoundrc
pcm.default {
        type hw
        card 0
}

But I still can not let the application to access the pcm device, this time
I got the following information:

# /tmp/pcm_play_arm_s default
cannot open audio device default (No such file or directory)

Here are my questions:
1, When we install the alsa-lib, we can get some libs, besides those, do we
also get some config files according to the local linux environment and
alsa-lib will use these config files to access the real driver? If that, how
can I install the alsa-lib to a embedded platform directly or what config
files should I port to embedded platform?

2, Must I edit ~/.asoundrc and /etc/alsa/alsa.conf ? In my situation, what
should I do ? Is somebody so kind can give me a simple template?

Because I am a newbie in alsa world, I must make some mistakes, so I am
lookinf forward to your advice.

Thanks in advance for your help.

David.
