From: David Ronis <ronis@ronispc.chem.mcgill.ca>
Subject: oops with lastest CVS
Date: Thu, 16 Oct 2003 13:54:25 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <16270.56145.993028.272116@ronispc.chem.mcgill.ca>
Reply-To: david.ronis@mcgill.ca
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
List-Id: alsa-devel@alsa-project.org

I've had a problem subscribing, so my appologies if you get two copies
of this.  

In any event...

I've been following the CVS-alsa on a i686-linux-gnu Sony Viao laptop.
About the time I upgraded my OS to Slackware 9.0 and the kernel to
2.4.22, it stopped working--usually with my machine hanging.
Occasionally it doesn't and today (using today's CVS) I was able to
get kysmoops to give some useful information (appended below).

I'm using a kernel with the lowlatency and preemptive patches (for
2.4.22) applied.

I build alsa using a script, the key parts of which are:

function BuildIn ()
{
    echo
    echo Building in $1...
    echo
    cd alsa-$1*
    if [ ! -e config.status ]; then
	if [ ! -x configure ]; then
	    ./cvscompile $2
	else
	    ./configure $2
	fi
    fi
    if [ $? != 0 ]; then
	exit 1
    fi
    make
    if [ $? != 0 ]; then
	exit 1
    fi
    cd ..
    InstallIn $1
}

BuildIn lib "--with-debug=no --with-gnu-ld"

BuildIn driver "--with-cards=nm256 --with-sequencer=yes"

BuildIn oss "--disable-alsatest --with-gnu-ld"

#BuildIn tools "--disable-alsatest --with-gnu-ld"

BuildIn utils "--disable-alsatest --with-gnu-ld"

and only use the nm256 driver.

Here's what I get:

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
Warning (compare_maps): mismatch on symbol snd_pcm_devices  , snd-pcm says cc8cda00, /lib/modules/2.4.22/kernel/sound/acore/snd-pcm.o says cc8cd5e0.  Ignoring /lib/modules/2.4.22/kernel/sound/acore/snd-pcm.o entry
Warning (compare_maps): mismatch on symbol snd_pcm_link_rwlock  , snd-pcm says cc8cdb00, /lib/modules/2.4.22/kernel/sound/acore/snd-pcm.o says cc8cd6e0.  Ignoring /lib/modules/2.4.22/kernel/sound/acore/snd-pcm.o entry
Warning (compare_maps): mismatch on symbol snd_cards  , snd says cc8a89e0, /lib/modules/2.4.22/kernel/sound/acore/snd.o says cc8a8820.  Ignoring /lib/modules/2.4.22/kernel/sound/acore/snd.o entry
Warning (compare_maps): mismatch on symbol snd_cards_count  , snd says cc8a89c0, /lib/modules/2.4.22/kernel/sound/acore/snd.o says cc8a8800.  Ignoring /lib/modules/2.4.22/kernel/sound/acore/snd.o entry
Warning (compare_maps): mismatch on symbol snd_ecards_limit  , snd says cc8a8964, /lib/modules/2.4.22/kernel/sound/acore/snd.o says cc8a87a4.  Ignoring /lib/modules/2.4.22/kernel/sound/acore/snd.o entry
Warning (compare_maps): mismatch on symbol snd_major  , snd says cc8a8968, /lib/modules/2.4.22/kernel/sound/acore/snd.o says cc8a87a8.  Ignoring /lib/modules/2.4.22/kernel/sound/acore/snd.o entry
Warning (compare_maps): mismatch on symbol snd_mixer_oss_notify_callback  , snd says cc8a8a08, /lib/modules/2.4.22/kernel/sound/acore/snd.o says cc8a8848.  Ignoring /lib/modules/2.4.22/kernel/sound/acore/snd.o entry
Warning (compare_maps): mismatch on symbol snd_seq_root  , snd says cc8a8a14, /lib/modules/2.4.22/kernel/sound/acore/snd.o says cc8a8854.  Ignoring /lib/modules/2.4.22/kernel/sound/acore/snd.o entry
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
eax: c826d984   ebx: c5fb4000   ecx: 00000000   edx: 00000003
esi: c826d984   edi: c8205f20   ebp: c5fb5f20   esp: c5fb5f00
ds: 0018   es: 0018   ss: 0018
Process aplay (pid: 8535, stackpage=c5fb5000)
Stack: c30a8a00 c826d800 c8205f20 c826d988 cc8a87c0 00000001 00000286 00000003 
       c826d94c cc8a27ea c8205f20 00000000 00000282 c826d95c c826d95c c1cab520 
       c826d800 cc8a40dd c826d800 c8205f20 00000000 c1cab540 c826d95c c8205f20 
Call Trace:    [<cc8a87c0>] [<cc8a27ea>] [<cc8a40dd>] [<c0136bc4>] [<c0135827>]
  [<c013588b>] [<c0106d9b>]
Code: 8b 01 85 45 fc 74 6a c7 45 f0 00 00 00 00 9c 5f fa ff 43 04 

>>EIP; c0113b58 <__wake_up+48/ec>   <=====
Trace; cc8a87c0 <[snd]snd_fops+0/44>
Trace; cc8a27ea <[snd]snd_card_file_remove+aa/d0>
Trace; cc8a40dd <[snd]snd_ctl_release+11d/140>
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

David


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
