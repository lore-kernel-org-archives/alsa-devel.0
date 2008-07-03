From: Ben Stanley <Ben.Stanley@exemail.com.au>
Subject: ca0106 SPDIF Output Problems
Date: Thu, 03 Jul 2008 22:09:12 +1000
Message-ID: <1215086952.30056.190.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.po.exetel.com.au (pecan.exetel.com.au [220.233.0.17])
	by alsa0.perex.cz (Postfix) with ESMTP id B5AA7248E1
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jul 2008 14:09:16 +0200 (CEST)
Received: from 168.78.233.220.exetel.com.au ([220.233.78.168]
	helo=[192.168.1.2]) by smtp.po.exetel.com.au with esmtp (Exim 4.68)
	(envelope-from <Ben.Stanley@exemail.com.au>) id 1KENcf-00069d-5D
	for alsa-devel@alsa-project.org; Thu, 03 Jul 2008 22:09:13 +1000
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

Hi,

I am having some problems getting sound out of a ca0106 card using
SPDIF. I have enabled SPDIF output using alsamixer. Some programs
produce sound, and others stubbornly don't.

I need some hints about what to try next, what information I could look
at, to be able to diagnose some factor common to the failures, and
hopefully the cause.

I am familiar with part of the driver, I have already written a patch
which used to enable 44.1kHz output on an earlier Ubuntu.

Anyway, the details are all recorded below. I would appreciate it if a
patient person could have a look through and throw me some ideas.

Thanks,
Ben Stanley.


I did a git checkout yesterday and built alsa 1.0.17rc3 on Ubuntu 8.04
kernel 2.6.24-19-generic.

I used the following configure options:
./configure --with-debug=full --with-cards=ca0106
--with-moddir=/lib/modules/`uname -r`/alsa-driver-orig

(I am using the --with-moddir to avoid clobbering the distro alsa
modules. I am selecting which modules to use by editing /etc/depmod.conf
and changing the priority order, and then re-running depmod. I can
verify the result by checking /var/lib/`uname -r`/modules.dep .)

Everything builds and installs without any warnings or errors.

So, after all that, I tested three applications:
MythTV
xine
speaker-test

My sound output is via SPDIF to a Yamaha RX-V557 digital amplifier.

I only get sound out of MythTV. I get nothing out of xine (playing
flacs) or out of speaker-test. However, I do get signal out of xine
playing DVDs.

Details:
================================================================
speaker-test --device-hw:0,0 --channels=2 --rate=48000
This should work, but instead it produces no SPDIF output. The amplifier
shows no digital signals.

root@mythtv:/proc/asound/card0/pcm0p/sub0# cat hw_params 
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 48000 (48000/1)
period_size: 4096
buffer_size: 16384

================================================================
Testing with xine playing a 44100Hz stereo S16_LE flac:
root@mythtv:/proc/asound/card0/pcm0p/sub0# cat hw_params 
access: MMAP_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 48000 (48000/1)
period_size: 1024
buffer_size: 8192

The amplifier says 'Unknown Digital', NO SOUND PRODUCED.

================================================================Testing
with xine playing 'Riverdance' DVD in DTS surround with AC3 Passthrough:
Sound output WORKS
Amplifier says 48kHz DTS
root@mythtv:/proc/asound/card0/pcm0p/sub0# cat hw_params 
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 48000 (48000/1)
period_size: 2048
buffer_size: 16384

================================================================
Running MythTV: Configured to open ALSA:hw:0,0 directly.
root@mythtv:/proc/asound/card0/pcm0p/sub0# cat hw_params 
access: MMAP_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 48000 (48000/1)
period_size: 8192
buffer_size: 16384

The amplifier identifies this as a 48kHz PCM signal.
Sound output WORKS.
================================================================

As a general observation, this problem was present in Ubuntu 7.10, but
was 'intermittent' (I used to be able to get speaker-test and xine
playing flacs to work most of the time.) The failures now seem to be
permanent after upgrading to Ubuntu 8.04, whether latest alsa-git is
installed or not.

Now, I need some ideas for what to look for here. I can't see
differentiating factor between things that work and things that do not.
Perhaps I need to look at some registers.
I don't know what relationship the files at 
/proc/asound/CA0106/ca0106_reg*
have to the registers declared in
alsa-kmirror/pcm/ca0106/ca0106.h
but I think I understand the registers from the header file.

Ideas please?

Once I get this sorted out I can test my patch allowing 44100Hz sampling
rates to be output to SPDIF. At the moment this bug is preventing me
from testing...

Thanks,
Ben Stanley.
