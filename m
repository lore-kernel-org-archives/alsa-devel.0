From: Daniel Turing <mail@danielturing.com>
Subject: Fwd: [PATCH] fix alsa-tools/hdspmixer for RME 9632 A
Date: Mon, 27 Jan 2014 10:54:00 +0100
Message-ID: <CADeOaFp0NyzFppc78jm-Nz3KFUWtamaBA8UdJy6YkP=+5=YWKg@mail.gmail.com>
References: <CADeOaFr6H_pct9bywOey2p1XVfrT3sKmSDiGO_DS0vuPpcwqUQ@mail.gmail.com>
 <20140123190500.GQ25242@ltw.loris.tv>
 <CADeOaFomxBuURg+byWKtxyv5nRVCXjdFKH8En8fpSt-7+oRbYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f54.google.com (mail-oa0-f54.google.com
 [209.85.219.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F463261724
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2014 10:54:00 +0100 (CET)
Received: by mail-oa0-f54.google.com with SMTP id i4so6453445oah.13
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2014 01:54:00 -0800 (PST)
In-Reply-To: <CADeOaFomxBuURg+byWKtxyv5nRVCXjdFKH8En8fpSt-7+oRbYw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

Sorry, this should've been CC'd to the list, forwarding here:

---------- Forwarded message ----------
From: Daniel Turing <mail@danielturing.com>
Date: Mon, Jan 27, 2014 at 10:52 AM
Subject: Re: [PATCH] fix alsa-tools/hdspmixer for RME 9632 A
To: Adrian Knoth <adi@drcomp.erfurt.thur.de>


Adi,

thanks for getting back to me on this.

On Thu, Jan 23, 2014 at 8:05 PM, Adrian Knoth <adi@drcomp.erfurt.thur.de> wrote:
> OTOH, I have to admit I don't fully understand the patch. What you're
> doing is to increment the number of output channels in case you have an
> additional input module.
>
> The input module is handled in HDSPMixerCard.cxx. Is it just a side
> effect? Because semantically, it is wrong to create output destinations
> just to get input channels rendered.
>
> Why is hdspmixer segfaulting? Do you happen to have a backtrace or
> explanation? This should be part of the commit message.
I admit i don't fully understand hdspmixer ;)

Here's the backtrace of the segfault in the unpatched version:
[dan@demo2 hdspmixer]$ gdb src/hdspmixer
GNU gdb (GDB) 7.6.2
Copyright (C) 2013 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-unknown-linux-gnu".
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>...
Reading symbols from
/home/dan/alsa-tools/alsa-tools-1.0.27/hdspmixer/src/hdspmixer...done.
(gdb) r
Starting program: /home/dan/alsa-tools/alsa-tools-1.0.27/hdspmixer/src/hdspmixer
warning: no loadable sections found in added symbol-file
system-supplied DSO at 0x7ffff7ffa000
warning: Could not load shared library symbols for linux-vdso.so.1.
Do you need "set solib-search-path" or "set sysroot"?
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/usr/lib/libthread_db.so.1".

HDSPMixer 1.11 - Copyright (C) 2003 Thomas Charbonnel <thomas@undata.org>
This program comes with ABSOLUTELY NO WARRANTY
HDSPMixer is free software, see the file COPYING for details

Looking for RME cards:
Card 0: RME Hammerfall HDSP 9632 at 0xfebf0000, irq 17
HDSP 9632 found!
1 RME cards card found.
Initializing default presets

Program received signal SIGSEGV, Segmentation fault.
0x00007ffff71399eb in fl_draw(char const*, int, int, int, int,
unsigned int, Fl_Image*, int) () from /usr/lib/libfltk.so.1.3
(gdb) bt
#0  0x00007ffff71399eb in fl_draw(char const*, int, int, int, int,
unsigned int, Fl_Image*, int) () from /usr/lib/libfltk.so.1.3
#1  0x000000000040aa73 in HDSPMixerSelector::draw (this=0x6a8a50) at
HDSPMixerSelector.cxx:180
#2  0x00007ffff70f0709 in Fl_Group::draw_child(Fl_Widget&) const ()
from /usr/lib/libfltk.so.1.3
#3  0x000000000040a647 in HDSPMixerIOMixer::draw (this=0x6a2360) at
HDSPMixerIOMixer.cxx:79
#4  0x00007ffff70f0709 in Fl_Group::draw_child(Fl_Widget&) const ()
from /usr/lib/libfltk.so.1.3
#5  0x00007ffff70f08fb in Fl_Group::draw_children() () from
/usr/lib/libfltk.so.1.3
#6  0x00007ffff70f0709 in Fl_Group::draw_child(Fl_Widget&) const ()
from /usr/lib/libfltk.so.1.3
#7  0x00007ffff711108b in Fl_Scroll::draw_clip(void*, int, int, int,
int) () from /usr/lib/libfltk.so.1.3
#8  0x00007ffff7111d29 in Fl_Scroll::draw() () from /usr/lib/libfltk.so.1.3
#9  0x00007ffff70f0709 in Fl_Group::draw_child(Fl_Widget&) const ()
from /usr/lib/libfltk.so.1.3
#10 0x00007ffff70f08fb in Fl_Group::draw_children() () from
/usr/lib/libfltk.so.1.3
#11 0x00007ffff70e9707 in Fl_Double_Window::flush(int) () from
/usr/lib/libfltk.so.1.3
#12 0x00007ffff70db362 in Fl::flush() () from /usr/lib/libfltk.so.1.3
#13 0x00007ffff70dc1c5 in Fl::wait(double) () from /usr/lib/libfltk.so.1.3
#14 0x00007ffff70dc2fd in Fl::run() () from /usr/lib/libfltk.so.1.3
#15 0x0000000000404433 in main (argc=1, argv=0x7fffffffeb88) at
hdspmixer.cxx:122
(gdb)

It crashes when it tries to render the mixer labels for the inputs
(top row). Hdspmixer correctly shows 16 channels, but fails to
initialize the right amount of labels (in HDSPMixerSelector::draw(),
mvalue()->label() is NULL or some illegal low address value like 0x20
for the last four channels).

So i dont think the labels initialized in HDSPMixerSelector::setLabels
only relate to outputs, instead they seem to double for inputs and
outputs.

I'm sorry that i have only limited time and energy to work on this. If
the patch would go thru as it is, i can try to jump thru the hoops for
"Occasional Developers" though.

Best,
-daniel


--
from the desk of Daniel Turing
see also: http://danielturing.com


-- 
from the desk of Daniel Turing
see also: http://danielturing.com
