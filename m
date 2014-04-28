From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: On non-rewindability of resamplers
Date: Mon, 28 Apr 2014 23:31:56 +0600
Message-ID: <535E908C.4030509@gmail.com>
References: <5356A9B6.9060405@gmail.com>	<5358FCF0.2040701@ladisch.de>	<53597BA2.8080201@gmail.com>	<5359FE72.8050605@canonical.com>	<535A6C96.7040109@gmail.com>	<CAN8ccibLsqb6oxai=+XOAhZ1dPwZmVVD2r3teDsz2a2_CthoOA@mail.gmail.com>	<535B83E4.5050303@gmail.com>
 <CAN8ccibXtR=jc3NJjFMn88stytAhSxjNqbD5QsREDppbKDNg9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f42.google.com (mail-la0-f42.google.com
 [209.85.215.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 570AF261ACA
 for <alsa-devel@alsa-project.org>; Mon, 28 Apr 2014 19:35:05 +0200 (CEST)
Received: by mail-la0-f42.google.com with SMTP id mc6so4188566lab.29
 for <alsa-devel@alsa-project.org>; Mon, 28 Apr 2014 10:35:04 -0700 (PDT)
In-Reply-To: <CAN8ccibXtR=jc3NJjFMn88stytAhSxjNqbD5QsREDppbKDNg9Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

28.04.2014 12:57, Raymond Yau wrote:
>
>  >
>  >> 3) Do pulseaudio keep a copy of client 's buffer ?
>  >>
>  >>  when do pulseauido mix two or more client's buffer ( before write
> to the sound card or after receive data from client )
>  >>
>  >> seem pulse plugin is not rewindable too
>  >
>  >
>  > That's a limitation of the pulse plugin, originating from ioplug
> design. The pulse API does allow rewinds (see the last two parameters of
> pa_stream_write), but ioplug with mmap_rw = 0 essentially ignores ALSA
> rewinds, i.e. it is impossible to know in alsa-plugins/pulse/*.c that a
> rewind has to be processed.
>
> Once the appl_ptr is rewinded to the nearest position from hw_ptr, it is
> the responbility of the application to write at least one period of
> audio immediately for some card.

Yes, of course, provided that the rewind succeeds.

> http://freedesktop.org/software/pulseaudio/doxygen/streams.html
>
> Data is routed, converted and mixed from several sources before it is
> passed along to a final output
>
> ...
>
> Playback and record streams always have a server-side buffer as part of
> the data flow. The size of this buffer needs to be chosen in a
> compromise between low latency and sensitivity for buffer
> overflows/underruns.
>
>
> as pulseaudio only recommend application to use a reasonable size (e.g.
> pulse plugin allow client to select extreme small buffer size which
> sound card cannot support) pulse plugin should increase the constraint
> to a reasonable size which are supported by most sound card
>
> (e.g. minimum period time of snd-ymfpci is 5ms)

On most sound cards, PulseAudio uses timer-based scheduling and thus is 
not subject to any period-size limitations. As far as I can see, 
snd_ymfpci does not include SNDRV_PCM_INFO_BATCH, and thus will be used 
in this mode. In addition, it has an implementation of 
snd_ymfpci_playback_pointer that seems to look at the hardware, which is 
good. So effective period times less than 5 ms should work on this card.

> ...
> The server-side per-stream playback buffers are indexed by a write and a
> read index. The application writes to the write index and the sound
> device reads from the read index. The read index is increased monotonically,
>
> How do the sound device reads from the read index ?

read index is just another word for hw_ptr if one talks about the sink 
buffer. When that buffer becomes almost empty, it is refilled by mixing 
all currently playing streams. You can try to follow the code starting 
from pa_sink_render().

> while the write index may be freely controlled by the application.
> Subtracting the read index from the write index will give you the
> current fill level of the buffer.
>
> look like this buffer still contain the audio in original format sent by
> the client if the difference is the fill level and can be used for per
> stream softvolume
> ...
>
> Seeking in the Playback Buffer
>
> A client application may freely seek in the playback buffer.
>
> PA_SEEK_RELATIVE_ON_READ - seek relative to the current read index. Use
> this to write data to the output buffer that should be played as soon as
> possible
>
> what is current read index ?

It is the point in the buffer that corresponds to the point in time that 
the hardware currently plays. Or maybe a better (but not equivalent) 
definition would be a point rewinding past which does not make sense 
because of the immediate underrun in the final hardware.

Seeking to 0 samples relatively to the current read index means "I want 
to play this buffer right now instead of whatever junk of unknown length 
that I sent before".

> do the read index mean the place which pulseaudio start to perform
> reasampling, downmixing/upmixing and mixing of all clients ?

No. PulseAudio tries to resample and mix as much as possible in advance, 
in hope that it will be able to undo all that work if needed.

> Does pulseaudio internal resampler support rewind ?

PulseAudio uses libraries such as speex and libsamplerate, and has a 
copy of the ffmpeg resampler as well. None of these libraries support 
rewinds. But PulseAudio has some code to work around that, and does 
achieve an imperfect result of approximately correct length. See 
pa_sink_input_process_rewind() - it resets the resampler, resulting in 
an audible click, if a seek is performed.

-- 
Alexander E. Patrakov
