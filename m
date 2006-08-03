From: Krivenok Dmitry <_asr_@inbox.ru>
Subject: Re: =?koi8-r?b?VmlydHVhbCBzb3VuZCBjYXJk?=
Date: Thu, 03 Aug 2006 18:56:12 +0400
Message-ID: <E1G8ecO-000BoU-00._asr_-inbox-ru@f61.mail.ru>
References: <s5h1wrxhoet.wl%tiwai=40suse.de>
Reply-To: Krivenok Dmitry <_asr_@inbox.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: =?koi8-r?Q?<s5h1wrxhoet.wl%tiwai=40suse.de>?=
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



-----Original Message-----
From: Takashi Iwai <tiwai@suse.de>
To: Krivenok Dmitry <_asr_@inbox.ru>
Date: Thu, 03 Aug 2006 16:41:46 +0200
Subject: Re: Re[8]: [Alsa-devel] Virtual sound card

> 
> At Thu, 03 Aug 2006 18:36:32 +0400,
> Krivenok Dmitry wrote:
> > 
> > > > This is mplayer's log:
> > > > krivenok-home ~ # strace mplayer Uno_momento.mp3  2>log2
> > > > krivenok-home ~ # grep  snd log2
> > > > open("/dev/snd/controlC0", O_RDWR)      = 5
> > > > open("/dev/snd/pcmC0D0p", O_RDWR|O_NONBLOCK) = 6
> > > > 
> > > > OK :)
> > > > 
> > > > P.S.
> > > > Is there a way to use separate files for in/out?
> > > 
> > > You can define different PCMs for playback and capture and bind them
> > > using asym plugin, such as:
> > > 
> > > pcm.!hw {
> > > 	type asym
> > > 	playback.pcm {
> > > 		type file
> > > 		slave.pcm {
> > > 			type hw
> > > 			card 0
> > > 		}
> > > 		file "foo.out"
> > > 	}
> > > 	capture.pcm {
> > > 		type file
> > > 		slave.pcm {
> > > 			type hw
> > > 			card 0
> > > 		}
> > > 		file "foo.in"
> > > 	}
> > > }
> > > 
> > 
> > It works with skype and mplayer, but aplay crashs (SegFault):
> 
> Ouch.  Could you get a backtrace via gdb?
> 

krivenok-home linvac # gdb aplay
GNU gdb 6.4
Copyright 2005 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i386-pc-linux-gnu"...(no debugging symbols found)
Using host libthread_db library "/lib/libthread_db.so.1".

(gdb) r /tmp/12345
Starting program: /usr/bin/aplay /tmp/12345
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
[Thread debugging using libthread_db enabled]
[New Thread 16384 (LWP 5522)]
Playing WAVE '/tmp/12345' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Warning: rate is not accurate (requested = 44100Hz, got = 48000Hz)

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 16384 (LWP 5522)]
0x401f8533 in strchr () from /lib/libc.so.6
(gdb) bt
#0  0x401f8533 in strchr () from /lib/libc.so.6
#1  0x0805049d in ?? ()
#2  0x00000000 in ?? ()
(gdb)



> 
> Takashi
> 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
