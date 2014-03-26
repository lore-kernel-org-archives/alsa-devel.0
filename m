From: Leonardo Gabrielli <l.gabrielli@univpm.it>
Subject: Re: twl4030 latency update
Date: Wed, 26 Mar 2014 10:35:16 +0100
Message-ID: <53329F54.3030305@univpm.it>
References: <532ACD4A.3080508@univpm.it> <532AEEA6.20704@ti.com>
 <532AFBDD.8040407@univpm.it> <532BE58A.2010701@ti.com>
 <5331CFF9.20402@univpm.it> <53328F4C.8030205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f46.google.com (mail-ee0-f46.google.com [74.125.83.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C1A5265121
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 10:35:23 +0100 (CET)
Received: by mail-ee0-f46.google.com with SMTP id t10so1386262eei.5
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 02:35:23 -0700 (PDT)
In-Reply-To: <53328F4C.8030205@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 26/03/2014 09:26, Peter Ujfalusi wrote:
> Can you elaborate on the corrupted/scrambled audio? I just don't see how it
> can happen. Can you get the /proc/asound/card0/pcm0p/sub0/hw_params when you
> have the audio quality issue?
Hello,
Here you are:

cat /proc/asound/card0/pcm0p/sub0/hw_params
access: MMAP_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 22050 (22050/1)
period_size: 512
buffer_size: 1024

And this is jack output:

jackd -P62 -t2000 -dalsa -dhw:0 -r22050 -p512 -n2 -s -S -i2 -o2 &

jackd 0.124.1
Copyright 2001-2009 Paul Davis, Stephane Letz, Jack O'Quinn, Torben Hohn 
and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details

JACK compiled with System V SHM support.
loading driver ..
apparent rate = 22050
creating alsa driver ... 
hw:0|hw:0|512|2|22050|2|2|nomon|swmeter|soft-mode|16bit
configuring for 22050Hz, period = 512 frames (23.2 ms), buffer = 2 periods
ALSA: final selected sample format for capture: 16bit little-endian
ALSA: use 2 periods for capture
ALSA: final selected sample format for playback: 16bit little-endian
ALSA: use 2 periods for playback

I can send you saomething to get it clearer. I recorded  a 10Hz sine 
wave with jaaa. The wave is totally scrambled (probably buffers are not 
read in order). But it may well be an issue with jack.

When the output sounds correct (256 period) hw_param is:
cat /proc/asound/card0/pcm0p/sub0/hw_params
access: MMAP_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 22050 (22050/1)
period_size: 256
buffer_size: 768


> I can not run jackd on the board anymore (with linux-next at least):
> FATAL: cannot locate cpu MHz in /proc/cpuinfo

Yes, there's been a recent fix to that (you can checkout the latest 
jackd from git repos, see this thread: 
http://lists.jackaudio.org/private.cgi/jack-devel-jackaudio.org/2014-March/012167.html

Or maybe you can just start jackd specifying a different clock with the 
-c switch i.e.
jackd -P62 -t2000 -c s -dalsa -dhw:0 -r22050 -p512 -n2 -s -S -i2 -o2 &
