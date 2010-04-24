From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: "Resource temporarily unavailable" while reading
	although poll returns POLLIN event
Date: Sun, 25 Apr 2010 07:43:15 +0800
Message-ID: <h2q4f3252891004241643j9ccd9315i9f8d6427752d471d@mail.gmail.com>
References: <4BCEE140.5060704@gmail.com> <4BCF24AC.3000301@gmail.com>
	<alpine.LNX.2.00.1004211917120.16336@eeebox2.perex-int.cz>
	<4BD02061.2010204@gmail.com>
	<k2i4f3252891004231832kcd722592hac37a667da424742@mail.gmail.com>
	<4BD3025D.1060207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f193.google.com (mail-pz0-f193.google.com
	[209.85.222.193])
	by alsa0.perex.cz (Postfix) with ESMTP id A42C52445F
	for <alsa-devel@alsa-project.org>;
	Sun, 25 Apr 2010 01:43:16 +0200 (CEST)
Received: by pzk31 with SMTP id 31so2137669pzk.16
	for <alsa-devel@alsa-project.org>; Sat, 24 Apr 2010 16:43:15 -0700 (PDT)
In-Reply-To: <4BD3025D.1060207@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/4/24 Stefan Schoenleitner <dev.c0debabe@gmail.com>

> Raymond Yau wrote:
> >>
> >>
> > Is it possible to post the output of your program when using your sound
> card
> > "hw" since your program failed with XRUN (broken pipe) on my two sound
> cards
> > ?
>
>
> Sure, no problem.
>
> However, I had to change 2 settings to get it working on my soundcard:
>
> * change period size from 160 to 320, as my soundcard does not support a
> period size of 160 frames
>
> * change buffer size from 2 periods (1280 bytes) to 1 period (640
> bytes), as my soundcard only supports a buffersize being equal to one
> period
>
>
> After that the program works fine and runs forever (see below).
>
> I'm looking forward to test it on my embedded target as well (with the
> original settings).
> If required I can post the output of that as well.
>
> cheers,
> stefan
>
>
> -------------------------------------------------------------------------------
> $ ./duplex hw
> could not sched_setscheduler: Operation not permitted
> PCM format is signed, linear, LE with 16 bits
> PCM rate 8000 - 48000 Hz
> PCM period size: 192 - 16384
> PCM buffer size: 640 - 640
> calculated buffer size: 640
> avail min: 320
> avail min after setup: 320
> start threshold: 320 frames
> stop threshold: 640 frames
> PCM format is signed, linear, LE with 16 bits
> PCM rate 4000 - 96000 Hz
> PCM period size: 32 - 32768
> PCM buffer size: 320 - 32640
> calculated buffer size: 640
> avail min: 320
> avail min after setup: 320
> start threshold: 320 frames
> stop threshold: 640 frames
> capture fds: 1, playback fds: 1
> capture poll fd: 4, playback poll fd: 5
> capture struct: fd: 4, events: POLLIN POLLERR , revents: 0
> playback struct: fd: 5, events: POLLOUT POLLERR , revents: 0
> capture avail min: 320
> playback avail min: 320
> snd_pcm_avail_update(capture): 0
> demangled poll:  on capture device
> snd_pcm_avail_update(playback): 640
> demangled poll: POLLOUT  on playback device
> wrote 320 frames
> snd_pcm_avail_update(capture): 0
> demangled poll:  on capture device
> snd_pcm_avail_update(playback): 320
> demangled poll: POLLOUT  on playback device
> wrote 320 frames
> snd_pcm_avail_update(capture): 320
> demangled poll: POLLIN  on capture device
> read 320 frames
> hexdump(): 640 bytes
> 0000    fe ff fe ff fe ff fe ff ff ff fe ff fe ff ff ff
> 0010    fe ff ff ff ff ff ff ff fe ff fe ff fe ff ff ff
> 0020    ff ff fe ff fe ff ff ff ff ff ff ff ff ff ff ff
> 0030    ff ff fe ff fe ff ff ff ff ff fe ff ff ff fe ff
> 0040    fe ff fe ff fe ff ff ff ff ff fe ff fe ff ff ff
> 0050    ff ff ff ff fe ff fe ff fe ff ff ff ff ff fe ff
> 0060    fe ff ff ff ff ff fe ff fe ff ff ff ff ff fe ff
> 0070    ff ff fe ff fe ff ff ff fe ff fe ff ff ff fe ff
> 0080    fe ff ff ff ff ff ff ff fe ff fe ff fe ff ff ff
> 0090    ff ff fe ff ff ff ff ff fe ff fe ff ff ff fe ff
> 00a0    ff ff ff ff fe ff fe ff ff ff fe ff fe ff ff ff
> 00b0    ff ff fe ff fe ff ff ff ff ff ff ff ff ff ff ff
> 00c0    ff ff ff ff ff ff ff ff ff ff ff ff ff ff fe ff
> 00d0    ff ff ff ff fe ff fe ff fe ff ff ff ff ff fe ff
> 00e0    fe ff fe ff ff ff ff ff fe ff fe ff ff ff fe ff
> 00f0    ff ff ff ff ff ff ff ff ff ff fe ff ff ff ff ff
> 0100    fe ff fe ff fe ff fe ff fe ff ff ff ff ff fe ff
> 0110    ff ff ff ff fe ff fe ff ff ff ff ff fe ff fe ff
> 0120    ff ff ff ff fe ff fe ff ff ff ff ff fe ff fe ff
> 0130    fe ff ff ff fe ff ff ff fe ff fe ff fe ff fe ff
> 0140    ff ff fe ff fe ff ff ff ff ff fe ff fe ff ff ff
> 0150    fe ff fe ff fe ff fe ff ff ff fe ff ff ff ff ff
> 0160    fe ff fe ff ff ff fe ff fe ff ff ff ff ff fe ff
> 0170    ff ff ff ff ff ff ff ff fe ff ff ff ff ff fe ff
> 0180    fe ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0190    ff ff fe ff fe ff ff ff ff ff ff ff ff ff ff ff
> 01a0    ff ff ff ff fe ff fe ff fe ff ff ff ff ff fe ff
> 01b0    fe ff fe ff ff ff fe ff fe ff ff ff ff ff ff ff
> 01c0    ff ff ff ff ff ff ff ff ff ff ff ff fe ff fe ff
> 01d0    fe ff fe ff fe ff ff ff ff ff fe ff fe ff fe ff
> 01e0    fe ff ff ff ff ff ff ff fe ff fe ff ff ff ff ff
> 01f0    fe ff fe ff ff ff ff ff ff ff ff ff ff ff fe ff
> 0200    fe ff ff ff ff ff ff ff ff ff ff ff ff ff fe ff
> 0210    ff ff ff ff fe ff fe ff ff ff ff ff ff ff ff ff
> 0220    ff ff fe ff fe ff ff ff ff ff ff ff fe ff ff ff
> 0230    ff ff ff ff fe ff ff ff ff ff ff ff ff ff ff ff
> 0240    ff ff ff ff ff ff ff ff ff ff fe ff fe ff ff ff
> 0250    ff ff fe ff ff ff ff ff ff ff ff ff ff ff fe ff
> 0260    fe ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0270    fe ff ff ff ff ff fe ff fe ff ff ff ff ff ff ff
>
> snd_pcm_avail_update(playback): 320
> demangled poll:  on playback device
> snd_pcm_avail_update(capture): 0
> demangled poll:  on capture device
> snd_pcm_avail_update(playback): 320
> demangled poll: POLLOUT  on playback device
> wrote 320 frames
> snd_pcm_avail_update(capture): 320
> demangled poll: POLLIN  on capture device
> read 320 frames
> hexdump(): 640 bytes
> 0000    ff ff ff ff fe ff ff ff ff ff ff ff ff ff ff ff
> 0010    fe ff fe ff ff ff ff ff fe ff ff ff ff ff ff ff
> 0020    ff ff ff ff fe ff ff ff ff ff fe ff ff ff ff ff
> 0030    fe ff fe ff ff ff fe ff fe ff ff ff ff ff fe ff
> 0040    fe ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0050    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0060    ff ff fe ff fe ff ff ff ff ff ff ff ff ff ff ff
> 0070    ff ff fe ff fe ff fe ff ff ff ff ff ff ff fe ff
> 0080    fe ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0090    ff ff ff ff ff ff ff ff fe ff fe ff ff ff fe ff
> 00a0    ff ff fe ff fe ff ff ff ff ff ff ff ff ff fe ff
> 00b0    fe ff fe ff fe ff fe ff fe ff fe ff ff ff ff ff
> 00c0    ff ff ff ff ff ff fe ff ff ff ff ff ff ff fe ff
> 00d0    fe ff ff ff fe ff fe ff ff ff ff ff fe ff fe ff
> 00e0    fe ff ff ff fe ff fe ff ff ff ff ff ff ff ff ff
> 00f0    ff ff ff ff fe ff ff ff ff ff ff ff ff ff ff ff
> 0100    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0110    ff ff ff ff fe ff ff ff ff ff ff ff ff ff fe ff
> 0120    ff ff ff ff fe ff ff ff ff ff fe ff fe ff ff ff
> 0130    ff ff ff ff ff ff ff ff ff ff fe ff fe ff ff ff
> 0140    fe ff ff ff ff ff fe ff ff ff ff ff fe ff fe ff
> 0150    fe ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0160    ff ff ff ff ff ff fe ff fe ff fe ff ff ff ff ff
> 0170    ff ff ff ff ff ff ff ff ff ff ff ff fe ff fe ff
> 0180    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0190    ff ff ff ff ff ff ff ff ff ff fe ff fe ff ff ff
> 01a0    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 01b0    ff ff ff ff ff ff ff ff fe ff fe ff ff ff ff ff
> 01c0    ff ff ff ff ff ff ff ff ff ff ff ff ff ff fe ff
> 01d0    ff ff ff ff ff ff ff ff fe ff ff ff ff ff ff ff
> 01e0    ff ff fe ff fe ff ff ff ff ff ff ff ff ff ff ff
> 01f0    ff ff ff ff ff ff fe ff fe ff fe ff fe ff fe ff
> 0200    fe ff fe ff fe ff ff ff fe ff ff ff ff ff fe ff
> 0210    fe ff ff ff ff ff ff ff ff ff ff ff fe ff fe ff
> 0220    ff ff ff ff ff ff ff ff ff ff fe ff ff ff ff ff
> 0230    ff ff ff ff ff ff ff ff ff ff ff ff fe ff fe ff
> 0240    fe ff ff ff ff ff ff ff ff ff ff ff ff ff fe ff
> 0250    fe ff fe ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0260    fe ff ff ff ff ff ff ff fe ff ff ff ff ff ff ff
> 0270    ff ff ff ff fe ff ff ff ff ff ff ff ff ff ff ff
>
>
How about the qualtity of the playback ?
did you speak to the mic and hear the result ?

Refer to your pulseaudio log , PA use "front" device for playback/capture
but your test use "hw"

D: alsa-util.c: Trying front:0 with SND_PCM_NO_AUTO_FORMAT ...
I: module-alsa-source.c: Successfully opened device front:0.
I: module-alsa-source.c: Successfully enabled mmap() mode.
I: (alsa-lib)control.c: Invalid CTL front:0
I: alsa-util.c: Unable to attach to mixer front:0: No such file or directory
I: alsa-util.c: Successfully attached to mixer 'hw:0'
I: alsa-util.c: Cannot find mixer control "Capture" or mixer control is
no combination of switch/volume.
I: alsa-util.c: Using mixer control "Mic"

...


sink_name=alsa_output.pci_
1102_4_sound_card_0_alsa_playback_0 tsched=0'
D: alsa-util.c: Trying front:0 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying front:0 without SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying plug:front:0 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Trying plug:front:0 without SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: alsa-util.c: PCM device plug:front:0 refused our hw parameters:
Device or resource busy
...
D: alsa-util.c: Trying hw:0 as last resort...
D: alsa-util.c: Trying hw:0 with SND_PCM_NO_AUTO_FORMAT ...
I: module-alsa-sink.c: Successfully opened device hw:0.
I: module-alsa-sink.c: Successfully enabled mmap() mode.
I: alsa-util.c: Successfully attached to mixer 'hw:0'
I: alsa-util.c: Cannot find mixer control "Master" or mixer control is
no combination of switch/volume.
W: alsa-util.c: Cannot find fallback mixer control "PCM" or mixer
control is no combination of switch/volume.
I: alsa-util.c: Using mixer control "PCM".




Do you mean that you suspect the problem is related to alsa-pulse plugin or
PA server ?
