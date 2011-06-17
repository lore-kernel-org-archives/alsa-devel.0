From: Doug McLain <doug@nostar.net>
Subject: Re: ALSA Fireworks driver
Date: Fri, 17 Jun 2011 03:21:34 -0400
Message-ID: <4DFB007E.9090805@nostar.net>
References: <4DFAF3AC.3030506@nostar.net> <4DFAFF24.9000401@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5443924435
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jun 2011 09:22:41 +0200 (CEST)
Received: by iwc10 with SMTP id 10so2106407iwc.38
	for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2011 00:22:40 -0700 (PDT)
In-Reply-To: <4DFAFF24.9000401@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

[nostar@iggy firewire]$ cat /proc/asound/cards
  0 [NVidia         ]: HDA-Intel - HDA NVidia
                       HDA NVidia at 0xfe020000 irq 21
  1 [U0x1acc0x09    ]: USB-Audio - USB Device 0x1acc:0x09
                       USB Device 0x1acc:0x09 at usb-0000:00:02.0-1, 
full speed
  2 [U0x46d0x992    ]: USB-Audio - USB Device 0x46d:0x992
                       USB Device 0x46d:0x992 at usb-0000:00:04.1-3.2, 
high speed
  3 [AudioFire12    ]: Fireworks - AudioFire12
                       Echo Digital Audio AudioFire12 v5.0, GUID 
0014860fc44a84a6 at fw1.0, S400
[nostar@iggy firewire]$ jackd -v -R -dalsa -dhw:3
jackd 0.120.2
Copyright 2001-2009 Paul Davis, Stephane Letz, Jack O'Quinn, Torben Hohn 
and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details

getting driver descriptor from /usr/lib64/jack/jack_alsa_midi.so
getting driver descriptor from /usr/lib64/jack/jack_net.so
getting driver descriptor from /usr/lib64/jack/jack_dummy.so
getting driver descriptor from /usr/lib64/jack/jack_firewire.so
getting driver descriptor from /usr/lib64/jack/jack_alsa.so
getting driver descriptor from /usr/lib64/jack/jack_oss.so
JACK compiled with System V SHM support.
server `default' registered
registered builtin port type 32 bit float mono audio
registered builtin port type 8 bit raw midi
clock source = system clock via clock_gettime
loading driver ..
start poll on 3 fd's
new client: alsa_pcm, id = 1 type 1 @ 0xb42150 fd = -1
creating alsa driver ... hw:3|hw:3|1024|2|48000|0|0|nomon|swmeter|-|32bit
control device hw:3
ALSA: Cannot open PCM device alsa_pcm for playback. Falling back to 
capture-only mode
cannot load driver module alsa
starting server engine shutdown
freeing shared port segments
server thread back from poll
stopping server thread
last xrun delay: 0.000 usecs
max delay reported by backend: 0.000 usecs
freeing engine shared memory
max usecs: 0.000, engine deleted
cleaning up shared memory
cleaning up files
unregistering server `default'
no message buffer overruns
[nostar@iggy firewire]$ ls -l /dev/snd*
total 0
drwxr-xr-x  2 root root       80 Jun 15 20:02 by-id
drwxr-xr-x  2 root root      120 Jun 17 03:17 by-path
crw-rw----+ 1 root audio 116, 10 Jun 15 20:02 controlC0
crw-rw----+ 1 root audio 116, 12 Jun 15 20:02 controlC1
crw-rw----+ 1 root audio 116, 14 Jun 15 20:02 controlC2
crw-rw----+ 1 root audio 116, 15 Jun 17 03:17 controlC3
crw-rw----+ 1 root audio 116,  9 Jun 15 20:02 hwC0D0
crw-rw----+ 1 root audio 116,  8 Jun 15 20:02 hwC0D3
crw-rw----+ 1 root audio 116, 11 Jun 15 20:02 midiC1D0
crw-rw----+ 1 root audio 116,  7 Jun 15 20:11 pcmC0D0c
crw-rw----+ 1 root audio 116,  6 Jun 17 03:12 pcmC0D0p
crw-rw----+ 1 root audio 116,  5 Jun 15 20:03 pcmC0D1c
crw-rw----+ 1 root audio 116,  4 Jun 15 20:03 pcmC0D1p
crw-rw----+ 1 root audio 116,  3 Jun 15 20:02 pcmC0D2c
crw-rw----+ 1 root audio 116,  2 Jun 15 20:03 pcmC0D3p
crw-rw----+ 1 root audio 116, 13 Jun 15 20:03 pcmC2D0c
crw-rw----+ 1 root audio 116,  1 Jun 15 20:02 seq
crw-rw----+ 1 root audio 116, 33 Jun 15 20:02 timer


On 06/17/2011 03:15 AM, Clemens Ladisch wrote:
> Doug McLain wrote:
>> I came across your fireworks driver the other day, and would like to get
>> involved.  Has there been any discussion on this anywhere or have you
>> been completely on your own?  I did a search of alsa-devel and didn't
>> find anything, suprisingly.
>
> You should've searched ffado-devel and linux1394-devel.
>
>> It seems like native alsa support of what
>> seems to me to be the first FW device would be the talk of the town. :)
>
> *cough*
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;hb=HEAD;f=sound/firewire/Kconfig
>
>> I built the driver as a module on F15 and loaded it on my AF12, and
>> found it in /proc/asound/cards, and tried to start jack on it and it
>> failed to start for duplex, capture, or playback, just FYI.
>
> In theory, this should have worked.  What exactly does "failed" mean?
>
>
> Regards,
> Clemens
