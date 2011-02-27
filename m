From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: hdspmixer segfault (1.0.24+)
Date: Sat, 26 Feb 2011 16:55:24 -0800
Message-ID: <4D69A0FC.60400@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.stanford.edu (smtp4.Stanford.EDU [171.67.219.84])
	by alsa0.perex.cz (Postfix) with ESMTP id 37F272451F
	for <alsa-devel@alsa-project.org>; Sun, 27 Feb 2011 01:55:34 +0100 (CET)
Received: from smtp.stanford.edu (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id 0444ADE05
	for <alsa-devel@alsa-project.org>; Sat, 26 Feb 2011 16:55:31 -0800 (PST)
Received: from cm-mail.stanford.edu (cm-mail.Stanford.EDU [171.64.197.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.stanford.edu (Postfix) with ESMTPS id BA4F4DDE4
	for <alsa-devel@alsa-project.org>; Sat, 26 Feb 2011 16:55:28 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
List-Id: alsa-devel@alsa-project.org

Hi, I'm getting a segfault from hdspmixer using the current git 
alsa-tools (1.0.23 works, 1.0.24+ does not). See below for a backtrace. 
I'm running 2.6.33.x rt30, could this be the problem? (a dependency on 
newer kernels?)

-- Fernando



$ gdb ./hdspmixer/src/hdspmixer
GNU gdb (GDB) Fedora (7.2-41.fc14)
Copyright (C) 2010 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later 
<http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "i686-redhat-linux-gnu".
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>...
Reading symbols from 
/scratch/nando/alsa-tools/alsa-tools.git/hdspmixer/src/hdspmixer...done.
(gdb) run
Starting program: 
/scratch/nando/alsa-tools/alsa-tools.git/hdspmixer/src/hdspmixer
[Thread debugging using libthread_db enabled]

HDSPMixer 1.6 - Copyright (C) 2003 Thomas Charbonnel <thomas@undata.org>
This program comes with ABSOLUTELY NO WARRANTY
HDSPMixer is free software, see the file COPYING for details

Looking for RME cards:
Card 0: RME Hammerfall DSP + Multiface at 0xe9200000, irq 19
Multiface found!
Card 1: HDA Intel at 0xe9300000 irq 32
1 RME cards card found.
Initializing default presets

Program received signal SIGSEGV, Segmentation fault.
HDSPMixerPresets::restore_preset (this=0x81fe500, prst=1) at 
HDSPMixerPresets.cxx:176
176		    basew->inputs->strips[i]->pan->pos[z] = 
basew->inputs->strips[i]->data[card][speed][p]->pan_pos[z];
Missing separate debuginfos, use: debuginfo-install 
alsa-lib-1.0.24-1.fc14.i686 expat-2.0.1-10.fc13.i686 
fltk-1.1.10-2.fc14.i686 fontconfig-2.8.0-2.fc14.i686 
freetype-2.4.2-4.fc14.i686 glibc-2.13-1.i686 libX11-1.3.4-3.fc14.i686 
libXau-1.0.6-1.fc14.i686 libXext-1.1.2-2.fc14.i686 
libXft-2.1.14-1.fc13.i686 libXinerama-1.1-2.fc13.i686 
libXrender-0.9.6-1.fc14.i686 libgcc-4.5.1-4.fc14.i686 
libstdc++-4.5.1-4.fc14.i686 libxcb-1.7-1.fc14.i686
(gdb) bt
#0  HDSPMixerPresets::restore_preset (this=0x81fe500, prst=1) at 
HDSPMixerPresets.cxx:176
#1  0x080552de in HDSPMixerPresets::preset_change (this=0x81fe500, p=1) 
at HDSPMixerPresets.cxx:258
#2  0x0804b436 in readregisters_cb (arg=0x80a0710) at HDSPMixerWindow.cxx:67
#3  0x4dd311d3 in Fl::wait(double) () from /usr/lib/libfltk.so.1.1
#4  0x4dd313e4 in Fl::run() () from /usr/lib/libfltk.so.1.1
#5  0x0804af34 in main (argc=1, argv=0xbffff284) at hdspmixer.cxx:114
(gdb)
