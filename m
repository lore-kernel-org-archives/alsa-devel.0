From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_hda_intel error
Date: Tue, 7 Dec 2010 16:22:16 +0800
Message-ID: <AANLkTik373qL9oNqdJRet=E0tJrGNiDHEyiLjtYcYn7w@mail.gmail.com>
References: <AANLkTik8eGoD1WfJvLZtzWQ-6W=WkjxtQHjJsZ4WN9DX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F3791037E3
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 09:22:21 +0100 (CET)
Received: by eyg24 with SMTP id 24so7653941eyg.24
	for <alsa-devel@alsa-project.org>; Tue, 07 Dec 2010 00:22:17 -0800 (PST)
In-Reply-To: <AANLkTik8eGoD1WfJvLZtzWQ-6W=WkjxtQHjJsZ4WN9DX@mail.gmail.com>
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

2010/12/4 Jack Byer <ftn768@gmail.com>

> I found this message in my system logs:
>
> Dec 04 07:25:52 [pulseaudio] alsa-util.c: snd_pcm_avail_delay()
> returned strange values: delay 0 is less than avail 8.
> Dec 04 07:25:52 [pulseaudio] alsa-util.c: Most likely this is a bug in
> the ALSA driver 'snd_hda_intel'. Please report this issue to the ALSA
> developers.
> Dec 04 07:25:52 [pulseaudio] alsa-util.c: snd_pcm_dump():
> Dec 04 07:25:52 [pulseaudio] alsa-util.c: Soft volume PCM
> Dec 04 07:25:52 [pulseaudio] alsa-util.c: Control: PCM Playback Volume
> Dec 04 07:25:52 [pulseaudio] alsa-util.c: min_dB: -51
> Dec 04 07:25:52 [pulseaudio] alsa-util.c: max_dB: 0
> Dec 04 07:25:52 [pulseaudio] alsa-util.c: resolution: 256
> Dec 04 07:25:52 [pulseaudio] alsa-util.c: Its setup is:
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   stream       : CAPTURE
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   access       : MMAP_INTERLEAVED
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   format       : S16_LE
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   subformat    : STD
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   channels     : 2
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   rate         : 44100
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   exact rate   : 44100 (44100/1)
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   msbits       : 16
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   buffer_size  : 16384
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   period_size  : 8192
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   period_time  : 185759
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   tstamp_mode  : ENABLE
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   period_step  : 1
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   avail_min    : 15502
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   period_event : 0
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   start_threshold  : -1
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   stop_threshold   :
> 4611686018427387904
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   silence_threshold: 0
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   silence_size : 0
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   boundary     :
> 4611686018427387904
> Dec 04 07:25:52 [pulseaudio] alsa-util.c: Slave: Hardware PCM card 0
> 'HDA Intel' device 0 subdevice 0
> Dec 04 07:25:52 [pulseaudio] alsa-util.c: Its setup is:
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   stream       : CAPTURE
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   access       : MMAP_INTERLEAVED
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   format       : S16_LE
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   subformat    : STD
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   channels     : 2
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   rate         : 44100
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   exact rate   : 44100 (44100/1)
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   msbits       : 16
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   buffer_size  : 16384
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   period_size  : 8192
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   period_time  : 185759
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   tstamp_mode  : ENABLE
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   period_step  : 1
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   avail_min    : 15502
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   period_event : 0
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   start_threshold  : -1
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   stop_threshold   :
> 4611686018427387904
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   silence_threshold: 0
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   silence_size : 0
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   boundary     :
> 4611686018427387904
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   appl_ptr     : 135040
> Dec 04 07:25:52 [pulseaudio] alsa-util.c:   hw_ptr       : 135040
>
> I am using the driver from the 2.6.31.1 kernel
>

http://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=aba87e509898ec9ddb3e319267d7c267409ff100

Which application is recording  ?

Please provide a test case which can reproduce the problem ? (with a full
pulseaudio log )
