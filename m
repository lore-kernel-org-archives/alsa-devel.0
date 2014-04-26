From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: On non-rewindability of resamplers
Date: Sat, 26 Apr 2014 16:01:08 +0600
Message-ID: <535B83E4.5050303@gmail.com>
References: <5356A9B6.9060405@gmail.com>	<5358FCF0.2040701@ladisch.de>	<53597BA2.8080201@gmail.com>	<5359FE72.8050605@canonical.com>	<535A6C96.7040109@gmail.com>
 <CAN8ccibLsqb6oxai=+XOAhZ1dPwZmVVD2r3teDsz2a2_CthoOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f173.google.com (mail-lb0-f173.google.com
 [209.85.217.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BD2526089A
 for <alsa-devel@alsa-project.org>; Sat, 26 Apr 2014 12:04:16 +0200 (CEST)
Received: by mail-lb0-f173.google.com with SMTP id l4so3773624lbv.18
 for <alsa-devel@alsa-project.org>; Sat, 26 Apr 2014 03:04:15 -0700 (PDT)
In-Reply-To: <CAN8ccibLsqb6oxai=+XOAhZ1dPwZmVVD2r3teDsz2a2_CthoOA@mail.gmail.com>
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

26.04.2014 07:32, Raymond Yau wrote:
> 2014-04-25 22:09 GMT+08:00 Alexander E. Patrakov <patrakov@gmail.com 
> <mailto:patrakov@gmail.com>>:
>
>     25.04.2014 12:19, David Henningsson wrote:
>
>         I understand that you have a mathematically perfect approach
>         to this, as
>         well as other algorithms. This would indeed be the best goal,
>         but given
>         an imperfect world, where we're forced to choose between
>           1) no rewinding at all
>           2) imperfect rewinding in the sense that it sometimes can
>         produce
>         hearable artifacts
>
>         ...I'm not sure 1) is always the right choice...
>
>
>     Understood. But IMHO (2) with a warning would be better than the
>     current situation of (2) without any indication of the problem.
>
>
> Does extplug or ioplug plugin support rewind ?
>
> http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_external_plugins.html
>

Both plugins currently pretend to support rewind. Extplug shouldn't do 
that at all if we are talking about perfect handling of rewinds, and is 
OK as it is if we accept an imperfect output of the correct length (but 
I don't want to accept this). Ioplug shouldn't support rewind if mmap_rw 
== 0, and I can't say yet what to do with mmap_rw == 1. Running the test 
program posted earlier in this thread on top of lfloat + jack produces 
silence (good!), but, depending on the jack settings, the program either 
hangs or runs faster than it should. So still a bug, but I am not sure 
if it is of some fundamental nature.

> 1) DCA plugin convert 6 channel to compress audio at fixed sample rate
>
> seem only allow sequential write and no random write
>

Right. The same applies to any LADSPA plugin.

Still, there is a funny thing that I want to share. Even though the 
dcaenc library only allows sequential writes, here is what happens on 
ALSA rewind followed by a write. When processing a rewind, extplug moves 
the slave application pointer. Upon reveiving a write, extplug submits 
the newly-written data for encoding, and then writes the result (which 
unfortunately contains some samples from the rewound part of the sound) 
over the previously encoded data, thus correctly discarding part of the 
old data. So the end result is of the correct length, with one or two 
broken DTS frames (copy-pasted from old and new DTS data) in the middle. 
Still bad, but this is different from the ioplug-based a52 plugin, which 
simply ignores rewinds, but pretends that it succeeds.

> 2)  The I/O-type plugin is a PCM plugin to work as the input or output 
> terminal point, i.e. as a user-space PCM driver.
>
> mmap_rw specifies whether the plugin behaves in the pseudo mmap mode. 
> When this value is set to 1, the plugin creates always a local buffer 
> and performs read/write calls using this buffer as if it's mmapped.
>
> does this mean ioplug can have its own local buffer which is different 
> from the slave ?
>

Ioplug doesn't have a slave. It just transfers data to somewhere.

> e.g. a52_pointer seem use delay of the slave
>

What a52 has is not really a slave in the traditional ALSA sense. And 
the encoder in ffmpeg allows only sequential writes.

> 3) Do pulseaudio keep a copy of client 's buffer ?
>
>  when do pulseauido mix two or more client's buffer ( before write to 
> the sound card or after receive data from client )
>
> seem pulse plugin is not rewindable too
>

That's a limitation of the pulse plugin, originating from ioplug design. 
The pulse API does allow rewinds (see the last two parameters of 
pa_stream_write), but ioplug with mmap_rw = 0 essentially ignores ALSA 
rewinds, i.e. it is impossible to know in alsa-plugins/pulse/*.c that a 
rewind has to be processed.

-- 
Alexander E. Patrakov
