From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: ALSA 0.9.3a sequencer/rawmidi oops
Date: Sun, 18 May 2003 21:31:40 +0930 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305181201.h4IC1eY24870@mercury.physics.adelaide.edu.au>
References: <s5hk7crduqr.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk7crduqr.wl@alsa2.suse.de> from "Takashi Iwai" at May 16, 2003 12:57:32 
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi takashi

> > > > > > Over the weekend I thought I'd give ALSA 0.9.3a a go.  For the most part it
> > > > > > worked fine.  However, there seems to be a bug in the sequencer or rawmidi
> > > > > > components.
> > > > > > 
> > > > > > If any application connects to a sequencer port, a oops results and the
> > > > > > machine is locked solid. ... ALSA 0.9.2 gives no trouble at all.
> > > > > > 
> > > > > > The soundcard in use is an Ensoniq AudioPCI (ens1370).
> > > > > > 
> > > > > > Does anyone have any ideas here?
> > > > > 
> > > > > does this still happen on the cvs version?
> > > > 
> > > > The current CVS version is worse.  I grabbed a version at around 0900
> > > > UT+0930 today (Wed 14 May).  I have just compiled this and loaded it.  When 
> > > >   pmidi -l
> > > > or
> > > >   pmidi -p 64:0
> > > > is run, we now get an error about being unable to open the sequencer.  Then
> > > > when 
> > > >   ls /proc/asound
> > > > is executed the kernel oopses.  It's not a hard lock - the machine keeps
> > > > going - but it's an oops non-the-less which clearly shouldn't happen.  It
> > > > seems that there is something strange lurking in the sequencer.  The decoded
> > > > oops is reproduced below.
> > > 
> > > yep, there is a bug in the recent cvs version.
> > > right now i fixed it and committed.  please update your tree again.
> > 
> > I grabbed an update at 1700 UT+0930 on 15 Mat 2003.  The kernel oops when
> > accessing /proc/asound/ is gone now.  However, there are still major
> > problems with this release:
> >  1) trying to access any of the pseudo files under /proc/asound results
> >     in "no such device" errors.
> 
> hmm, i saw this phenomenon once but after rebuilding the latest
> drivers it doesn't appear any more.

Ok.  I have some more information which I'm hoping will help us track this
problem down.

Firstly, I have grabbed a CVS snapshot at around 1500 UT+0930 on 18 May
2003.  I have repeated all my tests with this snapshot.  The alsa-driver
was configured using
  ./configure --with-sequencer=yes --with-oss=yes \
     --with-kernel=/home/audio/src/linux-2.4.20 \
     --with-cards=mpu401,ens1370,dt019x

The tests were conducted with the ens1370 card - the dt019x components were
not loaded.  As can be seen, this is under kernel 2.4.20.

The machine loaded the alsa modules with no errors.

I have run the snddevices script to create the static alsa device nodes.

Doing an "ls" of /proc/asound does not produce the oops which plagued
earlier CVS versions.  In fact, that particular bug was also in 0.9.3a
release.  However, attempting to "cat" *any* file under the /proc/asound
hierarchy still produced "no such device".  The directory structure is
created fine and can be navigated with no trouble.  It's just that it's
impossible to view the contents of any of the pseudo-files displayed
therein.  In other words, simply compiling the latest version of the driver
has not cured this problem for me - there's obviously some other lingering
problem.

This latest snapshot has cured the kernel oops I reported earlier regarding
pmidi.  I have not yet checked to see if pmidi can actually output anything,
but not having "pmidi -l" oops is a good start.

However, there seems to be serious problems with the pcm components of the
current CVS version.  Using "wavplay" through the ALSA OSS emulation layer
produces an oops and locks the machine solid.  The oops is in __wake_up().
Using the native aplay is slightly better - it still oopses, but at least
the machine isn't locked solid.  The oops is still in __wake_up().  Both
decoded oopses are included at the end of this email.

Now, the interesting thing about the pcm oops is that it occurs in
__wake_up().  This is actually the same endpoint of the original oops I
reported with the sequencer.  This might have since been fixed (as mentioned
above), so it's likely that whatever fix was applied to the sequencer
component is also needed to the pcm interface.

So to summarise findings regarding the CVS ALSA version under kernel 2.4.20:
 1) no files under /proc/asound can be displayed: they all give "no such
    device errors".
 2) the oops which used to be triggered by "pmidi -l" may have been fixed.
 3) using wavplay (via ALSA OSS emulation) or aplay (native ALSA app) causes
    a kernel oops in __wake_up() (decoded oopses at end of email).  It's
    possible that the pcm component of ALSA needs the same fix which may
    have been applied to the sequencer component to fix the oops I reported
    at the start of this thread.

Regards
  jonathan

=============================
Oops from wavplay invocation:
ksymoops 2.4.8 on i586 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20 -o /tmp/alsa-20030518-cvs/ (specified)
     -m /boot/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c011373b>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010097
eax: c12ddcac   ebx: c12ddca8   ecx: 00000000   edx: 00000003
esi: 00000004   edi: 00000001   ebp: c02cdecc   esp: c02cfeb4
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02cf000)
Stack: 00000000 00000004 c12c8b60 cf2ddcac 00000082 00000003 cc98eaec cc9847d6
       c12c8b60 00000004 cc98eaec 00000000 c12ddc00 c12c8b60 cc98480d cc98eaec
       c12c8b60 00000004 ffffffe0 cc984a04 cc98eaec c12c8b60 00000004 cc98be7b
Call Trace:    [<cc98eaec>] [<cc9847d8>] [<cc98eaec>] [<cc98480d>] [<cc98eaec>]
  [<cc984a04>] [<cc98eaec>] [<cc98be7b>] [<ccb93679>] [<cc98ae9c>] [<cc9b138b>]
  [<c0109b4d>] [<c0109cbe>] [<c0106e10>] [<c010be78>] [<c0106e10>] [<c0106e33>]
  [<c0106e97>] [<c0105000>] [<c0105027>]
Code: 8b 01 85 45 fc 74 4e 31 c0 9c 5e fa c7 01 00 00 00 00 83 79


>>EIP; c011373b <__wake_up+2b/98>   <=====

>>eax; c12ddcac <_end+fc8228/c65c5dc>
>>ebx; c12ddca8 <_end+fc8224/c65c5dc>
>>ebp; c02cdecc <_edata+568/69c>
>>esp; c02cfeb4 <init_task_union+1eb4/2000>

Trace; cc98eaec <[snd-pcm]snd_pcm_action_stop+0/c>
Trace; cc9847d8 <[snd-pcm]snd_pcm_action_single+38/40>
Trace; cc98eaec <[snd-pcm]snd_pcm_action_stop+0/c>
Trace; cc98480d <[snd-pcm]snd_pcm_action+2d/30>
Trace; cc98eaec <[snd-pcm]snd_pcm_action_stop+0/c>
Trace; cc984a04 <[snd-pcm]snd_pcm_stop+14/20>
Trace; cc98eaec <[snd-pcm]snd_pcm_action_stop+0/c>
Trace; cc98be7b <[snd-pcm]snd_pcm_update_hw_ptr_interrupt+13b/1d0>
Trace; ccb93679 <[usb-uhci]rh_int_timer_do+3d/44>
Trace; cc98ae9c <[snd-pcm]snd_pcm_period_elapsed+6c/c0>
Trace; cc9b138b <[snd-ens1370]snd_audiopci_interrupt+9b/b0>
Trace; c0109b4d <handle_IRQ_event+31/5c>
Trace; c0109cbe <do_IRQ+72/b4>
Trace; c0106e10 <default_idle+0/28>
Trace; c010be78 <call_do_IRQ+5/d>
Trace; c0106e10 <default_idle+0/28>
Trace; c0106e33 <default_idle+23/28>
Trace; c0106e97 <cpu_idle+3f/54>
Trace; c0105000 <_stext+0/0>
Trace; c0105027 <rest_init+27/28>

Code;  c011373b <__wake_up+2b/98>
00000000 <_EIP>:
Code;  c011373b <__wake_up+2b/98>   <=====
   0:   8b 01                     mov    (%ecx),%eax   <=====
Code;  c011373d <__wake_up+2d/98>
   2:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  c0113740 <__wake_up+30/98>
   5:   74 4e                     je     55 <_EIP+0x55>
Code;  c0113742 <__wake_up+32/98>
   7:   31 c0                     xor    %eax,%eax
Code;  c0113744 <__wake_up+34/98>
   9:   9c                        pushf
Code;  c0113745 <__wake_up+35/98>
   a:   5e                        pop    %esi
Code;  c0113746 <__wake_up+36/98>
   b:   fa                        cli
Code;  c0113747 <__wake_up+37/98>
   c:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
Code;  c011374d <__wake_up+3d/98>
  12:   83 79 00 00               cmpl   $0x0,0x0(%ecx)

=============================
Oops occuring after aplay:
ksymoops 2.4.8 on i586 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20 -o /tmp/alsa-20030518-cvs/ (specified)
     -m /boot/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c011373b>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010097
eax: c9c66388   ebx: c9c66384   ecx: 00000000   edx: 00000003
esi: c7ad6460   edi: 00000001   ebp: c7439f44   esp: c7439f2c
ds: 0018   es: 0018   ss: 0018
Process aplay (pid: 426, stackpage=c7439000)
Stack: c9b5c860 c7ad6460 c9c66200 c9c66388 00000286 00000003 c7adb4e0 cc97625d
       c7ad6460 00000019 cc9776e4 c9c66200 c7ad6460 c9c6635c c7ad6460 c9b05c20
       c12162e0 c8a2ec20 c0131814 c9b05c20 c7ad6460 c7ad6460 00000000 c799f080
Call Trace:    [<cc97625d>] [<cc9776e4>] [<c0131814>] [<c01308a5>] [<c01308f3>]
  [<c0108813>]
Code: 8b 01 85 45 fc 74 4e 31 c0 9c 5e fa c7 01 00 00 00 00 83 79


>>EIP; c011373b <__wake_up+2b/98>   <=====

>>eax; c9c66388 <_end+9950904/c65c5dc>
>>ebx; c9c66384 <_end+9950900/c65c5dc>
>>esi; c7ad6460 <_end+77c09dc/c65c5dc>
>>ebp; c7439f44 <_end+71244c0/c65c5dc>
>>esp; c7439f2c <_end+71244a8/c65c5dc>

Trace; cc97625d <[snd]snd_card_file_remove+6d/90>
Trace; cc9776e4 <[snd]snd_ctl_release+d4/f0>
Trace; c0131814 <fput+4c/e0>
Trace; c01308a5 <filp_close+59/64>
Trace; c01308f3 <sys_close+43/54>
Trace; c0108813 <system_call+33/40>

Code;  c011373b <__wake_up+2b/98>
00000000 <_EIP>:
Code;  c011373b <__wake_up+2b/98>   <=====
   0:   8b 01                     mov    (%ecx),%eax   <=====
Code;  c011373d <__wake_up+2d/98>
   2:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  c0113740 <__wake_up+30/98>
   5:   74 4e                     je     55 <_EIP+0x55>
Code;  c0113742 <__wake_up+32/98>
   7:   31 c0                     xor    %eax,%eax
Code;  c0113744 <__wake_up+34/98>
   9:   9c                        pushf
Code;  c0113745 <__wake_up+35/98>
   a:   5e                        pop    %esi
Code;  c0113746 <__wake_up+36/98>
   b:   fa                        cli
Code;  c0113747 <__wake_up+37/98>
   c:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
Code;  c011374d <__wake_up+3d/98>
  12:   83 79 00 00               cmpl   $0x0,0x0(%ecx)

-- 
* Jonathan Woithe    jwoithe@physics.adelaide.edu.au                        *
*                    http://www.physics.adelaide.edu.au/~jwoithe            *
***-----------------------------------------------------------------------***
** "Time is an illusion; lunchtime doubly so"                              **
*  "...you wouldn't recognize a subtle plan if it painted itself purple and *
*   danced naked on a harpsichord singing 'subtle plans are here again'"    *


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
