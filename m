From: David Ronis <ronis@ronispc.chem.mcgill.ca>
Subject: Re: oops with lastest CVS
Date: Tue, 21 Oct 2003 13:40:28 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <16277.28556.173719.822845@ronispc.chem.mcgill.ca>
References: <16270.56145.993028.272116@ronispc.chem.mcgill.ca>
	<s5hr81cdkz2.wl@alsa2.suse.de>
	<16272.4463.761860.986431@ronispc.chem.mcgill.ca>
	<s5hismnenuh.wl@alsa2.suse.de>
Reply-To: david.ronis@mcgill.ca
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hismnenuh.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


OK, I discovered one of my problems (a dumb one, at that); I'd
aparently broken part of my build script and wasn't updating the
alsa-kernel subtree properly.  I backed out the change in init.c and
updated/rebuilt.  I still get an kernel oops, but was left running and
was able to get kysmoops to give something; here's what I get:

ksymoops 2.4.1 on i686 2.4.22.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol IO_APIC_get_PCI_irq_vector_R__ver_IO_APIC_get_PCI_irq_vector not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol snd_pcm_devices  , snd-pcm says cc8d3ae0, /lib/modules/2.4.22/kernel/sound/acore/snd-pcm.o says cc8d36c0.  Ignoring /lib/modules/2.4.22/kernel/sound/acore/snd-pcm.o entry
Warning (compare_maps): mismatch on symbol snd_pcm_link_rwlock  , snd-pcm says cc8d3be0, /lib/modules/2.4.22/kernel/sound/acore/snd-pcm.o says cc8d37c0.  Ignoring /lib/modules/2.4.22/kernel/sound/acore/snd-pcm.o entry
Warning (compare_maps): mismatch on symbol snd_cards  , snd says cc8ae9e0, /lib/modules/2.4.22/kernel/sound/acore/snd.o says cc8ae820.  Ignoring /lib/modules/2.4.22/kernel/sound/acore/snd.o entry
Warning (compare_maps): mismatch on symbol snd_cards_count  , snd says cc8ae9c0, /lib/modules/2.4.22/kernel/sound/acore/snd.o says cc8ae800.  Ignoring /lib/modules/2.4.22/kernel/sound/acore/snd.o entry
Warning (compare_maps): mismatch on symbol snd_ecards_limit  , snd says cc8ae964, /lib/modules/2.4.22/kernel/sound/acore/snd.o says cc8ae7a4.  Ignoring /lib/modules/2.4.22/kernel/sound/acore/snd.o entry
Warning (compare_maps): mismatch on symbol snd_major  , snd says cc8ae968, /lib/modules/2.4.22/kernel/sound/acore/snd.o says cc8ae7a8.  Ignoring /lib/modules/2.4.22/kernel/sound/acore/snd.o entry
Warning (compare_maps): mismatch on symbol snd_mixer_oss_notify_callback  , snd says cc8aea08, /lib/modules/2.4.22/kernel/sound/acore/snd.o says cc8ae848.  Ignoring /lib/modules/2.4.22/kernel/sound/acore/snd.o entry
Warning (compare_maps): mismatch on symbol snd_seq_root  , snd says cc8aea14, /lib/modules/2.4.22/kernel/sound/acore/snd.o says cc8ae854.  Ignoring /lib/modules/2.4.22/kernel/sound/acore/snd.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says cc88d510, /lib/modules/2.4.22/kernel/fs/lockd/lockd.o says cc88c7d0.  Ignoring /lib/modules/2.4.22/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says cc880ccc, /lib/modules/2.4.22/kernel/net/sunrpc/sunrpc.o says cc88098c.  Ignoring /lib/modules/2.4.22/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says cc880cd0, /lib/modules/2.4.22/kernel/net/sunrpc/sunrpc.o says cc880990.  Ignoring /lib/modules/2.4.22/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says cc880cd4, /lib/modules/2.4.22/kernel/net/sunrpc/sunrpc.o says cc880994.  Ignoring /lib/modules/2.4.22/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says cc880cc8, /lib/modules/2.4.22/kernel/net/sunrpc/sunrpc.o says cc880988.  Ignoring /lib/modules/2.4.22/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): ip_conntrack symbol GPLONLY_ip_conntrack_expect_find_get not found in /lib/modules/2.4.22/kernel/net/ipv4/netfilter/ip_conntrack.o.  Ignoring /lib/modules/2.4.22/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): ip_conntrack symbol GPLONLY_ip_conntrack_expect_put not found in /lib/modules/2.4.22/kernel/net/ipv4/netfilter/ip_conntrack.o.  Ignoring /lib/modules/2.4.22/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): ip_conntrack symbol GPLONLY_ip_conntrack_find_get not found in /lib/modules/2.4.22/kernel/net/ipv4/netfilter/ip_conntrack.o.  Ignoring /lib/modules/2.4.22/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): ip_conntrack symbol GPLONLY_ip_conntrack_put not found in /lib/modules/2.4.22/kernel/net/ipv4/netfilter/ip_conntrack.o.  Ignoring /lib/modules/2.4.22/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): mismatch on symbol ip_conntrack_hash  , ip_conntrack says cc8618d4, /lib/modules/2.4.22/kernel/net/ipv4/netfilter/ip_conntrack.o says cc8613a0.  Ignoring /lib/modules/2.4.22/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says cc8490f4, /lib/modules/2.4.22/kernel/drivers/usb/usbcore.o says cc848b74.  Ignoring /lib/modules/2.4.22/kernel/drivers/usb/usbcore.o entry
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c0113b58
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0113b58>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: c8309d84   ebx: c67ea000   ecx: 00000000   edx: 00000003
esi: c8309d84   edi: c2741820   ebp: c67ebf20   esp: c67ebf00
ds: 0018   es: 0018   ss: 0018
Process amixer (pid: 18841, stackpage=c67eb000)
Stack: cbf3d1e0 c8309c00 c2741820 c8309d88 cc8ae7c0 00000001 00000286 00000003 
       c8309d4c cc8a880a c2741820 00000000 00000282 c8309d5c c8309d5c c8456820 
       c8309c00 cc8aa0dd c8309c00 c2741820 00000000 c8456840 c8309d5c c2741820 
Call Trace:    [<cc8ae7c0>] [<cc8a880a>] [<cc8aa0dd>] [<c0136bc4>] [<c0135827>]
  [<c013588b>] [<c0106d9b>]
Code: 8b 01 85 45 fc 74 6a c7 45 f0 00 00 00 00 9c 5f fa ff 43 04 

>>EIP; c0113b58 <__wake_up+48/ec>   <=====
Trace; cc8ae7c0 <[snd]snd_fops+0/44>
Trace; cc8a880a <[snd]snd_card_file_remove+aa/d0>
Trace; cc8aa0dd <[snd]snd_ctl_release+11d/140>
Trace; c0136bc4 <fput+4c/f8>
Trace; c0135827 <filp_close+93/a0>
Trace; c013588b <sys_close+57/7c>
Trace; c0106d9b <system_call+33/38>
Code;  c0113b58 <__wake_up+48/ec>
00000000 <_EIP>:
Code;  c0113b58 <__wake_up+48/ec>   <=====
   0:   8b 01                     mov    (%ecx),%eax   <=====
Code;  c0113b5a <__wake_up+4a/ec>
   2:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  c0113b5d <__wake_up+4d/ec>
   5:   74 6a                     je     71 <_EIP+0x71>
Code;  c0113b5f <__wake_up+4f/ec>
   7:   c7 45 f0 00 00 00 00      movl   $0x0,0xfffffff0(%ebp)
Code;  c0113b66 <__wake_up+56/ec>
   e:   9c                        pushf  
Code;  c0113b67 <__wake_up+57/ec>
   f:   5f                        pop    %edi
Code;  c0113b68 <__wake_up+58/ec>
  10:   fa                        cli    
Code;  c0113b69 <__wake_up+59/ec>
  11:   ff 43 04                  incl   0x4(%ebx)


21 warnings issued.  Results may not be reliable.

For what it's worth, I also get the messages

Before the oops:

PCI: Found IRQ 9 for device 00:08.1
PCI: Sharing IRQ 9 with 00:0a.0
nm256: Mapping port 1 from 0x24c5a0 - 0x25a800

After:
<6>note: amixer[18841] exited with preempt_count 1

I can comment out the wake_up call again.  What do you think?

David

Takashi Iwai writes:
 > At Fri, 17 Oct 2003 11:57:35 -0400,
 > David Ronis wrote:
 > > 
 > > Hi Takashi,
 > > 
 > > You wrote:
 > > 
 > >  > i don't see any obvious bug there.
 > >  > what happens if you comment out the lines
 > >  > 
 > >  > 	if (card->files == NULL)
 > >  > 		wake_up(&card->shutdown_sleep);
 > >  > 
 > >  > in alsa-kernel/core/init.c:661 ?
 > >  > 
 > > 
 > > I did this, rebuilt/installed, and ran aplay; the system froze.  I
 > > rebooted and tried again.  It froze again, but this time I saw the
 > > kernel oops on the screen.  (seems to be a NULL pointer dereference
 > > problem).  There was also an additional line:
 > > 
 > > 	  <6>note:  amixer[1048] exited with preempt_count 4
 > > 				 ...
 > > 	  <6>note:  rplayd[1048] exited with preempt_count 4
 > 
 > hmm, there might unblanced spinlocks.
 > 
 > 
 > Takashi


-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
