From: Andrew Burgess <aab@cichlid.com>
Subject: Re: snd-usb-audio hacking
Date: Fri, 18 Jul 2003 11:43:17 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307181843.h6IIhH804797@athlon.cichlid.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi said:

>> I have a Griffin USB iMic that hard hangs 2.4.21ac just by running arecord and
>> then ^C. I got no response here a few weeks ago...

>does this happen still with the latest cvs?

Yes. I just tried alsa 9.2, 9.4, 9.5 and cvs all with 2.4.22-pre6

I'm running:
  arecord -D imic --rate 44100 -f S16_LE - | aplay -
and then press ^C

I have gotten sound from this thing at one point. If I run arecord with
the -d <delay> and let it exit by itself it does not oops!!!!!

0.9.2 gives an error immediately, something about invalid sync pipe.
No oops but also no sound.

Others seem to give the same oops (always BUG in spinlock.h anyway) and then a hard lockup. 

>From my handwritten notes:

BUG ...include/asm/spinlock.h:86
process: aplay

I type in the backtrace by hand to ksymoops (this for alsa-cvs):

  >>EIP; c011b14f <__wake_up+8f/d0>   <=====
  Trace; e0972d8e <[usb-ohci]dl_del_list+4ce/520>
  Trace; c01e312f <scrup+14f/160>
  Trace; e09741e7 <[usb-ohci]hc_interrupt+1c7/350>
  Trace; c0109509 <handle_IRQ_event+69/a0>
  Trace; c01097fa <do_IRQ+ea/190>
  Trace; c0117149 <smp_apic_timer_interrupt+129/130>
  Trace; c010c718 <call_do_IRQ+5/d>
  Trace; e0bb15f2 <[snd-timer]snd_timer_open+192/1f0>
  Trace; e0bb25ac <[snd-timer]snd_timer_interrupt+34c/3f0>
  Trace; e0bb2a71 <[snd-timer]snd_timer_dev_register+1a1/1b0>
  Trace; c014c257 <fput+167/190>
  Trace; c0131734 <zap_page_range+1c4/1d0>
  Trace; c0134992 <unmap_fixup+1f2/200>
  Trace; c0134cce <do_munmap+27e/300>
  Trace; c0149f69 <filp_close+b9/120>
  Trace; c0134d93 <sys_munmap+43/70>
  Trace; c0107b0f <system_call+33/38>

I get some warnings from ksymoops so here is the full output FYI:


root@athlon:/root # ksymoops<oops
ksymoops 2.4.0 on i686 2.4.22-pre6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-pre6/ (default)
     -m /boot/System.map-2.4.22-pre6 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol snd_pcm_devices  , snd-pcm says e0bd2f80, /lib/modules/2.4.22-pre6/kernel/sound/acore/snd-pcm.o says e0bd2b40.  Ignoring /lib/modules/2.4.22-pre6/kernel/sound/acore/snd-pcm.o entry
Warning (compare_maps): ip_conntrack symbol GPLONLY_ip_conntrack_expect_find_get not found in /lib/modules/2.4.22-pre6/kernel/net/ipv4/netfilter/ip_conntrack.o.  Ignoring /lib/modules/2.4.22-pre6/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): ip_conntrack symbol GPLONLY_ip_conntrack_expect_put not found in /lib/modules/2.4.22-pre6/kernel/net/ipv4/netfilter/ip_conntrack.o.  Ignoring /lib/modules/2.4.22-pre6/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): ip_conntrack symbol GPLONLY_ip_conntrack_find_get not found in /lib/modules/2.4.22-pre6/kernel/net/ipv4/netfilter/ip_conntrack.o.  Ignoring /lib/modules/2.4.22-pre6/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): ip_conntrack symbol GPLONLY_ip_conntrack_put not found in /lib/modules/2.4.22-pre6/kernel/net/ipv4/netfilter/ip_conntrack.o.  Ignoring /lib/modules/2.4.22-pre6/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): mismatch on symbol ip_conntrack_hash  , ip_conntrack says e098b034, /lib/modules/2.4.22-pre6/kernel/net/ipv4/netfilter/ip_conntrack.o says e098aa80.  Ignoring /lib/modules/2.4.22-pre6/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): mismatch on symbol md_size  , md says e0a02040, /lib/modules/2.4.22-pre6/kernel/drivers/md/md.o says e0a01dc0.  Ignoring /lib/modules/2.4.22-pre6/kernel/drivers/md/md.o entry
Warning (compare_maps): mismatch on symbol mddev_map  , md says e0a01840, /lib/modules/2.4.22-pre6/kernel/drivers/md/md.o says e0a015c0.  Ignoring /lib/modules/2.4.22-pre6/kernel/drivers/md/md.o entry
Warning (compare_maps): mismatch on symbol snd_ecards_limit  , snd says e099f960, /lib/modules/2.4.22-pre6/kernel/sound/acore/snd.o says e099f6e0.  Ignoring /lib/modules/2.4.22-pre6/kernel/sound/acore/snd.o entry
Warning (compare_maps): mismatch on symbol snd_major  , snd says e099f964, /lib/modules/2.4.22-pre6/kernel/sound/acore/snd.o says e099f6e4.  Ignoring /lib/modules/2.4.22-pre6/kernel/sound/acore/snd.o entry
Warning (compare_maps): mismatch on symbol snd_mixer_oss_notify_callback  , snd says e099f9c0, /lib/modules/2.4.22-pre6/kernel/sound/acore/snd.o says e099f740.  Ignoring /lib/modules/2.4.22-pre6/kernel/sound/acore/snd.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says e096e678, /lib/modules/2.4.22-pre6/kernel/drivers/usb/usbcore.o says e096e0b8.  Ignoring /lib/modules/2.4.22-pre6/kernel/drivers/usb/usbcore.o entry
EIP:    0010:[<c011b14f>]
Using defaults from ksymoops -t elf32-i386 -a i386
Call Trace:    [<e0972d8e>] [<c01e312f>] [<e09741e7>] [<c0109509>] [<c01097fa>] [<c0117149>] [<c010c718>] [<e0bb15f2>] [<e0bb25ac>] [<e0bb2a71>] [<c014c257>] [<c0131734>] [<c0134992>] [<c0134cce>] [<c0149f69>] [<c0134d93>] [<c0107b0f>]
Warning (Oops_read): Code line not seen, dumping what data is available

>>EIP; c011b14f <__wake_up+8f/d0>   <=====
Trace; e0972d8e <[usb-ohci]dl_del_list+4ce/520>
Trace; c01e312f <scrup+14f/160>
Trace; e09741e7 <[usb-ohci]hc_interrupt+1c7/350>
Trace; c0109509 <handle_IRQ_event+69/a0>
Trace; c01097fa <do_IRQ+ea/190>
Trace; c0117149 <smp_apic_timer_interrupt+129/130>
Trace; c010c718 <call_do_IRQ+5/d>
Trace; e0bb15f2 <[snd-timer]snd_timer_open+192/1f0>
Trace; e0bb25ac <[snd-timer]snd_timer_interrupt+34c/3f0>
Trace; e0bb2a71 <[snd-timer]snd_timer_dev_register+1a1/1b0>
Trace; c014c257 <fput+167/190>
Trace; c0131734 <zap_page_range+1c4/1d0>
Trace; c0134992 <unmap_fixup+1f2/200>
Trace; c0134cce <do_munmap+27e/300>
Trace; c0149f69 <filp_close+b9/120>
Trace; c0134d93 <sys_munmap+43/70>
Trace; c0107b0f <system_call+33/38>


14 warnings issued.  Results may not be reliable.

Thank you very much!



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
