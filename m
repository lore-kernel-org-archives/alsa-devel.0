From: "Lisandro Pin" <lisandro@hotmail.com>
Subject: Re: SIS7012 works but get's frozen
Date: Wed, 23 Jul 2003 01:55:35 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <BAY2-F35RPQIWDO3hRD000001e3@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>From: Takashi Iwai <tiwai@suse.de>
>To: "Lisandro Pin" <lisandro@hotmail.com>
>CC: alsa-devel@lists.sourceforge.net
>Subject: Re: [Alsa-devel] SIS7012 works but get's frozen
>Date: Tue, 22 Jul 2003 18:47:25 +0200
>
>At Tue, 22 Jul 2003 16:43:16 +0000,
>Lisandro Pin wrote:
> >
> > > >    I also have a ECS K7S5A, and i experienced something funny while
> > >trying
> > > > to play the attached file (about 45k, sorry, it's the only way :). 
>It's
> > >an
> > > > old ICQ soundclip i wanted to use to warn me of new mail, so i hope 
>i'm
> > >not
> > > > breaking any laws here; but the thing is that trying to play it 
>directly
> > > > through ALSA freezes it about 1/2 of the clip. No errors on aplay 
>(or
> > >any
> > > > other player for that sake), just a seg fault. The interesting part 
>is
> > >that
> > > > using a wrapper like arts or esd the file plays just fine.
> > >
> > >could you elaborate the status "freeze"?
> > >does machine still respond?  or a kernel panic?
> > >if it's a kernel oops, please trace it via ksymoops program.
> >
> >   No, just the program. aplay segfaults at about half the clip and XMMS
> > simply halts and needs to be killed (again, no error message). The 
>machine
> > keeps on going but ALSA is mute until the "offending" program ends.
>
>hmm, segfaults is evil.  can you get aplay in gdb running?
>you might need to set LD_PRELOAD=/usr/lib/libasound.so.2 to load the
>plugins before starting gdb.

(gdb) run ~/newmail.wav
The program being debugged has been started already.
Start it from the beginning? (y or n) y

Starting program: /usr/bin/aplay ~/newmail.wav
(no debugging symbols found)...(no debugging symbols found)...
(no debugging symbols found)...(no debugging symbols found)...[New Thread 
16384 (LWP 30679)]

Playing WAVE '/home/lys/newmail.wav' : Signed 16 bit Little Endian, Rate 
44100 Hz, Mono
(no debugging symbols found)...(no debugging symbols found)...
Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 16384 (LWP 30679)]
0x4fb68445 in snd_pcm_route_convert1_one () from /usr/lib/libasound.so.2

   Pretty useless. Could you give me some indications on how to do a quick 
make of aplay with the symbols table loaded?

> > > >   PS: Is PCM volume planned to be implemented for the
> > >SIS7012/snd-intel8x0
> > > > driver in any fashion? The driver sounds great and it's the only 
>thing
> > > > lacking...
> > >
> > >check which ac97 chip is found.  if it's a CMI chip, there is no PCM
> > >volume control indeed.
> >
> >   Nup, a SiS one.
>
>really?  please show /proc/asound/card0/ac97#0 and
>/proc/asound/card0/ac97#0regs ?

  "0-0/0: C-Media Electronics CMI9738". You were right; it lists as 
"SiS7012" in /proc/pci. My bad!

  Lys.

_________________________________________________________________
Protect your PC - get McAfee.com VirusScan Online 
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
