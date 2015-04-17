From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Playback - Overwrite buffer with silence
Date: Fri, 17 Apr 2015 08:57:17 +0800
Message-ID: <CAN8cciasebtivM-4pD=G_MpfwvvLtDckeRq1KKwnbCsKHeX+Cw@mail.gmail.com>
References: <5529421B.7050601@gmail.com> <55297E6E.20302@ladisch.de>
 <14caac41f10.2759.f6cded7c48a54b1428bcde82a72ee7d7@gmail.com>
 <552A0974.1000005@ladisch.de>
 <14cb33de7e8.2759.f6cded7c48a54b1428bcde82a72ee7d7@gmail.com>
 <552D0A01.6050308@ladisch.de>
 <14cb8fa84c0.2759.f6cded7c48a54b1428bcde82a72ee7d7@gmail.com>
 <CAN8ccibpiKiLXDvjTGGUe8ZkdOvp=9N6QoOrJPLnPmkNWZjOhg@mail.gmail.com>
 <552EBB90.8040707@gmail.com> <552EBEBA.9000108@ladisch.de>
 <55300038.6010507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f177.google.com (mail-ob0-f177.google.com
 [209.85.214.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D5AA260452
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 02:57:19 +0200 (CEST)
Received: by obbeb7 with SMTP id eb7so56405756obb.3
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2015 17:57:18 -0700 (PDT)
In-Reply-To: <55300038.6010507@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nilhcraiv <nilhcraiv@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

>>
>> The allowed values of the hardware parameters depend on the hardware's
>> capabilities.
>
>
> OK but, overwrite the buffer with silence depend of software, no? Why the
buffer is not overwrite with silence with this pcm setup? It is as
documentation.
>
> PCM:
>
> ALSA <-> PulseAudio PCM I/O Plugin
> Its setup is:
>   stream       : PLAYBACK
>   access       : RW_INTERLEAVED
>   format       : S16_LE
>   subformat    : STD
>   channels     : 1
>   rate         : 48000
>   exact rate   : 48000 (48000/1)
>   msbits       : 16
>   buffer_size  : 720
>   period_size  : 240
>   period_time  : 5000
>   tstamp_mode  : NONE
>   period_step  : 1
>   avail_min    : 240
>   period_event : 0
>   start_threshold  : 240
>   stop_threshold   : 720
>   silence_threshold: 0
>   silence_size : 6485183463413514240
>   boundary     : 6485183463413514240
>
>

Pulse plugin 's minimum periods is three.

len = decoder(&decoded_data,t_data);

pcmreturn = snd_pcm_writei(pcm_handle, decoded_data, len);/*In most cases
there are UNDERRUN...*/

If  len > 720 (buffer_size), you need to write three periods, start
playback,  receive data, peform decode while waiting for the sound
card/plugin playback one period and write another period

Pulseaudio is a sound server which mix several playback streams, silence
size may has no effect since the alsa sink may use different period
size/buffer size or disable period wakeup when using timer scheduling
