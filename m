From: <Joerg-Cyril.Hoehle@t-systems.com>
Subject: Re: How to send non-SysEx system messages via ALSA?
Date: Wed, 13 Mar 2013 14:36:48 +0100
Message-ID: <8E4C156DA5797D418DBFADFD8CE655A422BA54AFC9@HE113481.emea1.cds.t-internal.com>
References: <8E4C156DA5797D418DBFADFD8CE655A422BA54AFBB@HE113481.emea1.cds.t-internal.com>
 <513B90A9.7070309@gmail.com> <513BA324.8090109@ladisch.de>,
 <CAPbw_hzj9oR=QT-7F80ALGj4LCa=io+myC-ne8rctSPU07H=kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tcmail13.telekom.de (tcmail13.telekom.de [80.149.113.165])
 by alsa0.perex.cz (Postfix) with ESMTP id A95F2261717
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2013 14:37:26 +0100 (CET)
In-Reply-To: <CAPbw_hzj9oR=QT-7F80ALGj4LCa=io+myC-ne8rctSPU07H=kg@mail.gmail.com>
Content-Language: de-DE
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gabrbedd@gmail.com, clemens@ladisch.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Gabriel Beddingfield wrote:

>>>Inspecting the source, it looks like the kernel seq driver drops the
>>>non-standard 'Tick' message (0xF9).  The only way I know to send it is
>>>to use the rawmidi API.  [Anybody: please correct me if I'm wrong here.]
>>> Since Wine is sending/receiving midi data (without timing) that is to
>>> be sent/received _immediately_ -- you might find life easier by using
>>> the rawmidi api.

Indeed, that sounded like a perfect match.

>> But this would work only with rawmidi devices; hardware synthesizers
>> (OPL3/4/Emu10k1) and any software applications would be excluded
>> (without contortions like snd-virmidi).

OTOH, that sounds like a killer argument against rawmidi.

>Correct me if I'm wrong, but his options are:
>  1. Drop support for any non-standard midi byte streams
>      (e.g. "Tick") by using the seq API, or
>  2. Drop the ability to have a virtual midi device by using the rawmidi A=
PI.
>The choice is up to him.

Wine's CoreAudio MIDI driver for MacOS already drives two different API,
one called CoreMidi and another one for the built-in SW-synth. So WineALSA
could do something similar.

However, my current knowledge does not allow me to infer when to open rawmi=
di
and when the seq interface.  Likewise, Wine presents
all MIDI interfaces as MIDI_PORT to applications and barely knows a differe=
nce
between things like Timidity / FluidSynth and HW serial ports.

How would I distinguish and decide which API to use?

Heck, I even find it funny that Timidity and FluidSynth declare different c=
apabilities bits.

Presumably most people use MIDI in Wine to allow
music from games to play.  At least, that's my case, so I toyed with
Timidity and FluidSynth.

However, there are some pro Wine users with real MIDI hardware.
These guys found bugs in Wine in the past, such as
the 2-byte MTC not being generated or getting through, or a KORG
editor SW hanging after sending a strange SysEx F0 ... F7 00 00 00
(terminated by three NUL bytes!).  That's why I want to handle those
cases well too, not just the SW-synth case.  Thus I'd like to be able
to generate and send correct system messages and do something
reasonable with weird data like the above trailing 00 00 00 bytes.

Solved MTC bug in Wine
http://bugs.winehq.org/show_bug.cgi?id=3D26928
Open SysEx+00 00 00 bug in Wine
http://bugs.winehq.org/show_bug.cgi?id=3D33126

Regards,
 J=F6rg H=F6hle
