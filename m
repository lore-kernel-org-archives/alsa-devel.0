From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: ALSA 0.9.3a sequencer/rawmidi oops
Date: Mon, 12 May 2003 12:43:49 +0930 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305120313.h4C3DoD05366@sprite.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi all

Over the weekend I thought I'd give ALSA 0.9.3a a go.  For the most part it
worked fine.  However, there seems to be a bug in the sequencer or rawmidi
components.

If any application connects to a sequencer port, a oops results and the
machine is locked solid.  An example decoded oops is given at the end of
this email.  Initially I was testing using jazz++ 4.1.3 and OSS emulation,
but the oops occurs if pmidi is used.  Because pmidi is a native ALSA app,
it tends to suggest the problem is within the sequencer and/or MPU401
rawmidi components.  The oops given occurred when pmidi was invoked as:
  pmidi -p 64:0
where "64:0" was the port corresponding to the ens1370's external midi
interface.

ALSA 0.9.2 gives no trouble at all.

The soundcard in use is an Ensoniq AudioPCI (ens1370).

Does anyone have any ideas here?

The oops:
> ksymoops 2.4.8 on i586 2.4.20.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.20 -o /home/audio/alsa/alsa-driver-0.9.3a/modules/ (specified)
>      -m /boot/System.map (specified)
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c011373b>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010097
> eax: c13ede84   ebx: c13ede80   ecx: 00000000   edx: 00000003
> esi: 00000001   edi: 00000001   ebp: c7a6dda8   esp: c7a6dd90
> ds: 0018   es: 0018   ss: 0018
> Process pmidi (pid: 1291, stackpage=c7a6d000)
> Stack: c13ede60 00000001 c75e8960 c13ede84 00000082 00000003 00000086 ccafc7c8
>        80006800 00000002 c12c8a60 00000000 ccb10f42 c75e8960 00000001 00000001
>        ff000000 80000068 cc2c8a60 00006800 ccb11399 c12c8a60 c757a3c0 24000001
> Call trace:    [<ccafc7c8>] [<ccb10f42>] [<ccb11399>] [<c0109b4d>] [<c0109cbe>]
>   [<c010be78>] [<ccafc847>] [<ccafc986>] [<ccb1539b>] [<ccaf8491>] [<ccaf8066>]
>   [<ccaf811e>] [<ccaf82a7>] [<ccaf235b>] [<ccaf23e7>] [<ccaf25a2>] [<c0131814>]
>   [<c01308a5>] [<c01308f3>] [<c0108813>]
> Code: 8b 01 85 45 fc 74 4e 31 c0 9c 5e fa c7 01 00 00 00 00 00 83 79
> 
> 
> >>EIP; c011373b <__wake_up+2b/98>   <=====
> 
> >>eax; c13ede84 <_end+10d8400/c7bc5dc>
> >>ebx; c13ede80 <_end+10d83fc/c7bc5dc>
> >>ebp; c7a6dda8 <_end+7758324/c7bc5dc>
> >>esp; c7a6dd90 <_end+775830c/c7bc5dc>
> 
> Trace; ccafc7c8 <[snd-rawmidi]snd_rawmidi_transmit_ack+88/90>
> Trace; ccb10f42 <[snd-ens1370]snd_ensoniq_midi_interrupt+82/d0>
> Trace; ccb11399 <[snd-ens1370]snd_audiopci_interrupt+a9/b0>
> Trace; c0109b4d <handle_IRQ_event+31/5c>
> Trace; c0109cbe <do_IRQ+72/b4>
> Trace; c010be78 <call_do_IRQ+5/d>
> Trace; ccafc847 <[snd-rawmidi]snd_rawmidi_kernel_write1+37/160>
> Trace; ccafc986 <[snd-rawmidi]snd_rawmidi_kernel_write+16/20>
> Trace; ccb1539b <[snd-seq-midi]midisynth_unuse+1b/40>
> Trace; ccaf8491 <[snd-seq]unsubscribe_port+41/90>
> Trace; ccaf8066 <[snd-seq]clear_subscriber_list+e6/180>
> Trace; ccaf811e <[snd-seq]port_delete+1e/50>
> Trace; ccaf82a7 <[snd-seq]snd_seq_delete_all_ports+97/d0>
> Trace; ccaf235b <[snd-seq]seq_free_client1+b/70>
> Trace; ccaf23e7 <[snd-seq]seq_free_client+27/a0>
> Trace; ccaf25a2 <[snd-seq]snd_seq_release+12/40>
> Trace; c0131814 <fput+4c/e0>
> Trace; c01308a5 <filp_close+59/64>
> Trace; c01308f3 <sys_close+43/54>
> Trace; c0108813 <system_call+33/40>
> 
> Code;  c011373b <__wake_up+2b/98>
> 00000000 <_EIP>:
> Code;  c011373b <__wake_up+2b/98>   <=====
>    0:   8b 01                     mov    (%ecx),%eax   <=====
> Code;  c011373d <__wake_up+2d/98>
>    2:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
> Code;  c0113740 <__wake_up+30/98>
>    5:   74 4e                     je     55 <_EIP+0x55>
> Code;  c0113742 <__wake_up+32/98>
>    7:   31 c0                     xor    %eax,%eax
> Code;  c0113744 <__wake_up+34/98>
>    9:   9c                        pushf  
> Code;  c0113745 <__wake_up+35/98>
>    a:   5e                        pop    %esi
> Code;  c0113746 <__wake_up+36/98>
>    b:   fa                        cli    
> Code;  c0113747 <__wake_up+37/98>
>    c:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
> Code;  c011374d <__wake_up+3d/98>
>   12:   00 83 79 00 00 00         add    %al,0x79(%ebx)
> 
>  <0>Kernel panic: Aiee, killing interrupt handler!

Regards 
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
