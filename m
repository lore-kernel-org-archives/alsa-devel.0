From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: ALSA 0.9.3a sequencer/rawmidi oops
Date: Wed, 14 May 2003 22:16:07 +0930 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305141246.h4ECk7232331@mercury.physics.adelaide.edu.au>
References: <s5h3cjjuf6m.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3cjjuf6m.wl@alsa2.suse.de> from "Takashi Iwai" at May 13, 2003 03:52:33 
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

Hi Takashi

> > Over the weekend I thought I'd give ALSA 0.9.3a a go.  For the most part it
> > worked fine.  However, there seems to be a bug in the sequencer or rawmidi
> > components.
> > 
> > If any application connects to a sequencer port, a oops results and the
> > machine is locked solid.  An example decoded oops is given at the end of
> > this email.  Initially I was testing using jazz++ 4.1.3 and OSS emulation,
> > but the oops occurs if pmidi is used.  Because pmidi is a native ALSA app,
> > it tends to suggest the problem is within the sequencer and/or MPU401
> > rawmidi components.  The oops given occurred when pmidi was invoked as:
> >   pmidi -p 64:0
> > where "64:0" was the port corresponding to the ens1370's external midi
> > interface.
> > 
> > ALSA 0.9.2 gives no trouble at all.
> > 
> > The soundcard in use is an Ensoniq AudioPCI (ens1370).
> > 
> > Does anyone have any ideas here?
> 
> does this still happen on the cvs version?

The current CVS version is worse.  I grabbed a version at around 0900
UT+0930 today (Wed 14 May).  I have just compiled this and loaded it.  When 
  pmidi -l
or
  pmidi -p 64:0
is run, we now get an error about being unable to open the sequencer.  Then
when 
  ls /proc/asound
is executed the kernel oopses.  It's not a hard lock - the machine keeps
going - but it's an oops non-the-less which clearly shouldn't happen.  It
seems that there is something strange lurking in the sequencer.  The decoded
oops is reproduced below.

The oops occurs irrespective of whether pmidi has been run first.  After
loadin CVS alsa, the "ls /proc/asound" command will oops even if it's the
first thing done after loading.

ksymoops 2.4.8 on i586 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20 -o /home/audio/alsa/alsa-20030514-cvs/alsa-driver/modules/ (specified)
     -m /boot/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000034
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<cc976d1d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: c43c72a0   edx: c9761940
esi: c43c72a0   edi: c3f7bfa4   ebp: 00001001   esp: c3f7bf80
ds: 0018   es: 0018   ss: 0018
Process ls (pid: 2928, stackpage=c3f7b000)
Stack: c0136ed7 c9761940 bfffe780 00001001 c43c72a0 c3f7a000 bffff7c0 00000000
       bffff7a8 c9761940 c12164a0 c3f7a000 080572d8 080572c0 00000008 00000001
       c0108813 bffff7c0 bfffe780 00001001 bffff7c0 00000000 bffff7a8 00000055
Call Trace:    [<c0136ed7>] [<c0108813>]
Code: 8b 40 34 50 8b 4c 24 10 51 8b 44 24 10 50 52 e8 bf 4e 7c f3

>>EIP; cc976d1d <[snd]snd_info_card_readlink+d/30>   <=====

>>ecx; c43c72a0 <_end+40b181c/c65c5dc>
>>edx; c9761940 <_end+944bebc/c65c5dc>
>>esi; c43c72a0 <_end+40b181c/c65c5dc>
>>edi; c3f7bfa4 <_end+3c66520/c65c5dc>
>>esp; c3f7bf80 <_end+3c664fc/c65c5dc>

Trace; c0136ed7 <sys_readlink+87/a0>
Trace; c0108813 <system_call+33/40>

Code;  cc976d1d <[snd]snd_info_card_readlink+d/30>
00000000 <_EIP>:
Code;  cc976d1d <[snd]snd_info_card_readlink+d/30>   <=====
   0:   8b 40 34                  mov    0x34(%eax),%eax   <=====
Code;  cc976d20 <[snd]snd_info_card_readlink+10/30>
   3:   50                        push   %eax
Code;  cc976d21 <[snd]snd_info_card_readlink+11/30>
   4:   8b 4c 24 10               mov    0x10(%esp,1),%ecx
Code;  cc976d25 <[snd]snd_info_card_readlink+15/30>
   8:   51                        push   %ecx
Code;  cc976d26 <[snd]snd_info_card_readlink+16/30>
   9:   8b 44 24 10               mov    0x10(%esp,1),%eax
Code;  cc976d2a <[snd]snd_info_card_readlink+1a/30>
   d:   50                        push   %eax
Code;  cc976d2b <[snd]snd_info_card_readlink+1b/30>
   e:   52                        push   %edx
Code;  cc976d2c <[snd]snd_info_card_readlink+1c/30>
   f:   e8 bf 4e 7c f3            call   f37c4ed3 <_EIP+0xf37c4ed3>


Best regards
  jonathan
-- 
* Jonathan Woithe    jwoithe@physics.adelaide.edu.au                        *
*                    http://www.physics.adelaide.edu.au/~jwoithe            *
***-----------------------------------------------------------------------***
** "Time is an illusion; lunchtime doubly so"                              **
*  "...you wouldn't recognize a subtle plan if it painted itself purple and *
*   danced naked on a harpsichord singing 'subtle plans are here again'"    *


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
