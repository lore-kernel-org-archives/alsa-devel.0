From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: buffer_size return by
	snd_pcm_hw_params_get_buffer_size_max
Date: Sun, 8 May 2011 21:49:48 +0800
Message-ID: <BANLkTik6Yn+uMs+Tkzxy0U2wwweANzzqMw@mail.gmail.com>
References: <BANLkTikFON0YKxv5iT6ECX+xMFfRMhYypA@mail.gmail.com>
	<s5hd3l2th4s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E8071037F8
	for <alsa-devel@alsa-project.org>;
	Sun,  8 May 2011 15:49:49 +0200 (CEST)
Received: by fxm5 with SMTP id 5so3596861fxm.38
	for <alsa-devel@alsa-project.org>; Sun, 08 May 2011 06:49:48 -0700 (PDT)
In-Reply-To: <s5hd3l2th4s.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/4/4 Takashi Iwai <tiwai@suse.de>

> At Mon, 4 Apr 2011 11:54:45 +0800,
> Raymond Yau wrote:
> >
> > it seem that the value return by snd_pcm_hw_params_get_buffer_size_max()
> > depend on /proc/asound/Intel/pcm0p/sub0/prealloc
> >
> > Is it a bug in alsa-lib or snd-hda-intel driver
>
> No bug.  This is the designed behavior.
>
>
> Takashi
>

This explain why my hda-intel fail in tsched=0 but work quite well in
tsched=1



I: module-suspend-on-idle.c: Sink alsa_output.1.analog-stereo idle for too
long, suspending ...
D: sink.c: Suspend cause of sink alsa_output.1.analog-stereo is 0x0004,
suspending
E: alsa-util.c: snd_pcm_dump():
E: alsa-util.c: Soft volume PCM
E: alsa-util.c: Control: PCM Playback Volume
E: alsa-util.c: min_dB: -51
E: alsa-util.c: max_dB: 0
E: alsa-util.c: resolution: 256
E: alsa-util.c: Its setup is:
E: alsa-util.c:   stream       : PLAYBACK
E: alsa-util.c:   access       : MMAP_INTERLEAVED
E: alsa-util.c:   format       : S16_LE
E: alsa-util.c:   subformat    : STD
E: alsa-util.c:   channels     : 2
E: alsa-util.c:   rate         : 44100
E: alsa-util.c:   exact rate   : 44100 (44100/1)
E: alsa-util.c:   msbits       : 16
E: alsa-util.c:   buffer_size  : 16384
E: alsa-util.c:   period_size  : 8192
E: alsa-util.c:   period_time  : 185759
E: alsa-util.c:   tstamp_mode  : ENABLE
E: alsa-util.c:   period_step  : 1
E: alsa-util.c:   avail_min    : 8192
E: alsa-util.c:   period_event : 1
E: alsa-util.c:   start_threshold  : -1
E: alsa-util.c:   stop_threshold   : 1073741824
E: alsa-util.c:   silence_threshold: 0
E: alsa-util.c:   silence_size : 0
E: alsa-util.c:   boundary     : 1073741824
E: alsa-util.c: Slave: Hardware PCM card 1 'HDA Intel' device 0 subdevice 0
E: alsa-util.c: Its setup is:
E: alsa-util.c:   stream       : PLAYBACK
E: alsa-util.c:   access       : MMAP_INTERLEAVED
E: alsa-util.c:   format       : S16_LE
E: alsa-util.c:   subformat    : STD
E: alsa-util.c:   channels     : 2
E: alsa-util.c:   rate         : 44100
E: alsa-util.c:   exact rate   : 44100 (44100/1)
E: alsa-util.c:   msbits       : 16
E: alsa-util.c:   buffer_size  : 16384
E: alsa-util.c:   period_size  : 8192
E: alsa-util.c:   period_time  : 185759
E: alsa-util.c:   tstamp_mode  : ENABLE
E: alsa-util.c:   period_step  : 1
E: alsa-util.c:   avail_min    : 8192
E: alsa-util.c:   period_event : 1
E: alsa-util.c:   start_threshold  : -1
E: alsa-util.c:   stop_threshold   : 1073741824
E: alsa-util.c:   silence_threshold: 0
E: alsa-util.c:   silence_size : 0
E: alsa-util.c:   boundary     : 1073741824
E: alsa-util.c:   appl_ptr     : 163888
E: alsa-util.c:   hw_ptr       : 227328
I: alsa-sink.c: Underrun!
I: alsa-sink.c: Device suspended...
I: module-suspend-on-idle.c: Sink alsa_output.0.analog-stereo idle for too
long, suspending ...
D: sink.c: Suspend cause of sink alsa_output.0.analog-stereo is 0x0004,
suspending
I: alsa-sink.c: Device suspended...
