From: "thewade" <pdman@aproximation.org>
Subject: Re: Alsa and hdspmixer segfault
Date: Fri, 1 Oct 2004 11:54:34 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200410011754.i91HsYrn001612@sanctuary.aproximation.org>
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

I downloaded the newest cvs (last night really, for me here in -6 MST),
and built it ust now. alsa-lib built fine but hdspmixer in alsa-tools
fails:

make in hdspmixer:
make[1]: Entering directory `/usr/local/src/alsa-tools/hdspmixer/src\'
if g++ -DPACKAGE_NAME=\\\"\\\" -DPACKAGE_TARNAME=\\\"\\\" -DPACKAGE_VERSION=\\\"\\\" -DPACKAGE_STRING=\\\"\\\" -DPACKAGE_BUGREPORT=\\\"\\\" -DPACKAGE=\\\"hdspmixer\\\" -DVERSION=\\\"1.6\\\" -DSTDC_HEADERS=1 -DHAVE_LIBASOUND=1  -I. -I.     -g -O2  -I/usr/local/include -I/usr/X11R6/include -fno-exceptions -MT HDSPMixerOutputs.o -MD -MP -MF \".deps/HDSPMixerOutputs.Tpo\" -c -o HDSPMixerOutputs.o HDSPMixerOutputs.cxx; \\
then mv -f \".deps/HDSPMixerOutputs.Tpo\" \".deps/HDSPMixerOutputs.Po\"; else rm -f \".deps/HDSPMixerOutputs.Tpo\"; exit 1; fi
In file included from HDSPMixerOutput.h:28,
                 from HDSPMixerOutputs.h:26,
                 from HDSPMixerOutputs.cxx:22:
/usr/include/alsa/sound/hdsp.h:35: error: `u_int32_t\' does not name a type
/usr/include/alsa/sound/hdsp.h:36: error: `u_int32_t\' does not name a type
/usr/include/alsa/sound/hdsp.h:37: error: `u_int32_t\' does not name a type
/usr/include/alsa/sound/hdsp.h:38: error: `u_int64_t\' does not name a type
/usr/include/alsa/sound/hdsp.h:39: error: `u_int64_t\' does not name a type
/usr/include/alsa/sound/hdsp.h:41: error: `u_int64_t\' does not name a type
make[1]: *** [HDSPMixerOutputs.o] Error 1
make[1]: Leaving directory `/usr/local/src/alsa-tools/hdspmixer/src\'
make: *** [all-recursive] Error 1

It turns out that gdb says its a libfltk thing I think, at least with the
current version of hdspmixer I have (Oct 1):
Starting program: /usr/local/bin/hdspmixer 
[Thread debugging using libthread_db enabled]
[New Thread 182894123680 (LWP 1231)]

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
[Switching to Thread 182894123680 (LWP 1231)]
0x0000003092b6d075 in cb2 () from /usr/lib64/libfltk.so.1.1

Should I rebuild fltk?
Thanks
-thewade


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
