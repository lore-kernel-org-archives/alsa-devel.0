From: "thewade" <pdman@aproximation.org>
Subject: Re: Alsa and hdspmixer segfault
Date: Fri, 1 Oct 2004 17:03:08 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200410012303.i91N38me002162@sanctuary.aproximation.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Heres what I get when I run:
gdb hdspmixer
run
bt

GNU gdb Red Hat Linux (6.1post-1.20040607.8rh)
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type \"show copying\" to see the conditions.
There is absolutely no warranty for GDB.  Type \"show warranty\" for details.
This GDB was configured as \"x86_64-redhat-linux-gnu\"...Using host libthread_db library \"/lib64/tls/libthread_db.so.1\".

(gdb) run
Starting program: /usr/local/bin/hdspmixer 
[Thread debugging using libthread_db enabled]
[New Thread 182894123680 (LWP 3385)]

HDSPMixer 1.6 - Copyright (C) 2003 Thomas Charbonnel <thomas@undata.org>
This program comes with ABSOLUTELY NO WARRANTY
HDSPMixer is free software, see the file COPYING for details

Looking for HDSP cards :
Card 0 : SiS SI7012 at 0xe800, irq 169
Card 1 : RME Hammerfall DSP + Multiface at 0x40800000, irq 209
Multiface found !
1 Hammerfall DSP card found.
Initializing default presets

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 182894123680 (LWP 3377)]
0x0000003092b6d075 in cb2 () from /usr/lib64/libfltk.so.1.1
(gdb) bt
#0  0x0000003092b6d075 in cb2 () from /usr/lib64/libfltk.so.1.1
#1  0x0000003092b6cc56 in innards () from /usr/lib64/libfltk.so.1.1
#2  0x0000003092b6cdf0 in fl_draw_image () from /usr/lib64/libfltk.so.1.1
#3  0x0000003092b6d34c in fl_draw_pixmap () from /usr/lib64/libfltk.so.1.1
#4  0x0000003092b6d099 in fl_draw_pixmap () from /usr/lib64/libfltk.so.1.1
#5  0x0000003092b3d37e in Fl_Group::draw_child () from /usr/lib64/libfltk.so.1.1
#6  0x00000000004126b0 in HDSPMixerIOMixer::draw (this=0x58b0a0) at HDSPMixerIOMixer.cxx:79
#7  0x0000003092b3d37e in Fl_Group::draw_child () from /usr/lib64/libfltk.so.1.1
#8  0x0000003092b3d275 in Fl_Group::draw_children () from /usr/lib64/libfltk.so.1.1
#9  0x0000003092b3d2d4 in Fl_Group::draw () from /usr/lib64/libfltk.so.1.1
#10 0x0000003092b3d37e in Fl_Group::draw_child () from /usr/lib64/libfltk.so.1.1
#11 0x0000003092b5041b in Fl_Scroll::draw_clip () from /usr/lib64/libfltk.so.1.1
#12 0x0000003092b50bb6 in Fl_Scroll::draw () from /usr/lib64/libfltk.so.1.1
#13 0x0000003092b3d37e in Fl_Group::draw_child () from /usr/lib64/libfltk.so.1.1
#14 0x0000003092b3d275 in Fl_Group::draw_children () from /usr/lib64/libfltk.so.1.1
#15 0x0000003092b3d2d4 in Fl_Group::draw () from /usr/lib64/libfltk.so.1.1
#16 0x0000003092b60dda in Fl_Window::draw () from /usr/lib64/libfltk.so.1.1
#17 0x0000003092b36f09 in Fl_Double_Window::flush () from /usr/lib64/libfltk.so.1.1
#18 0x0000003092b36e0b in Fl_Double_Window::flush () from /usr/lib64/libfltk.so.1.1
#19 0x0000003092b2af29 in Fl::flush () from /usr/lib64/libfltk.so.1.1
#20 0x0000003092b2abdd in Fl::wait () from /usr/lib64/libfltk.so.1.1
#21 0x0000003092b2acde in Fl::run () from /usr/lib64/libfltk.so.1.1
#22 0x000000000040c489 in main (argc=1, argv=0x7fbffff848) at hdspmixer.cxx:86


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
