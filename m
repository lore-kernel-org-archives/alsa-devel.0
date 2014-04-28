From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: On non-rewindability of resamplers
Date: Mon, 28 Apr 2014 14:57:53 +0800
Message-ID: <CAN8ccibXtR=jc3NJjFMn88stytAhSxjNqbD5QsREDppbKDNg9Q@mail.gmail.com>
References: <5356A9B6.9060405@gmail.com> <5358FCF0.2040701@ladisch.de>
 <53597BA2.8080201@gmail.com> <5359FE72.8050605@canonical.com>
 <535A6C96.7040109@gmail.com>
 <CAN8ccibLsqb6oxai=+XOAhZ1dPwZmVVD2r3teDsz2a2_CthoOA@mail.gmail.com>
 <535B83E4.5050303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f45.google.com (mail-qg0-f45.google.com
 [209.85.192.45])
 by alsa0.perex.cz (Postfix) with ESMTP id A3C352608B7
 for <alsa-devel@alsa-project.org>; Mon, 28 Apr 2014 08:57:54 +0200 (CEST)
Received: by mail-qg0-f45.google.com with SMTP id a108so6331563qge.4
 for <alsa-devel@alsa-project.org>; Sun, 27 Apr 2014 23:57:53 -0700 (PDT)
In-Reply-To: <535B83E4.5050303@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

>
>> 3) Do pulseaudio keep a copy of client 's buffer ?
>>
>>  when do pulseauido mix two or more client's buffer ( before write to
the sound card or after receive data from client )
>>
>> seem pulse plugin is not rewindable too
>
>
> That's a limitation of the pulse plugin, originating from ioplug design.
The pulse API does allow rewinds (see the last two parameters of
pa_stream_write), but ioplug with mmap_rw = 0 essentially ignores ALSA
rewinds, i.e. it is impossible to know in alsa-plugins/pulse/*.c that a
rewind has to be processed.

Once the appl_ptr is rewinded to the nearest position from hw_ptr, it is
the responbility of the application to write at least one period of audio
immediately for some card.
http://freedesktop.org/software/pulseaudio/doxygen/streams.html

Data is routed, converted and mixed from several sources before it is
passed along to a final output

...

Playback and record streams always have a server-side buffer as part of the
data flow. The size of this buffer needs to be chosen in a compromise
between low latency and sensitivity for buffer overflows/underruns.


as pulseaudio only recommend application to use a reasonable size (e.g.
pulse plugin allow client to select extreme small buffer size which sound
card cannot support) pulse plugin should increase the constraint to a
reasonable size which are supported by most sound card

(e.g. minimum period time of snd-ymfpci is 5ms)


...
The server-side per-stream playback buffers are indexed by a write and a
read index. The application writes to the write index and the sound device
reads from the read index. The read index is increased monotonically,

How do the sound device reads from the read index ?

while the write index may be freely controlled by the application.
Subtracting the read index from the write index will give you the current
fill level of the buffer.

look like this buffer still contain the audio in original format sent by
the client if the difference is the fill level and can be used for per
stream softvolume
...

Seeking in the Playback Buffer

A client application may freely seek in the playback buffer.

PA_SEEK_RELATIVE_ON_READ - seek relative to the current read index. Use
this to write data to the output buffer that should be played as soon as
possible

what is current read index ?

do the read index mean the place which pulseaudio start to perform
reasampling, downmixing/upmixing and mixing of all clients ?


Does pulseaudio internal resampler support rewind ?
