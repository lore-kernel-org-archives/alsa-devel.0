From: Erich Focht <efocht@hpce.nec.com>
Subject: usx2y hangs SuSE 9.2 Pro kernel
Date: Tue, 9 Nov 2004 22:16:41 +0100
Message-ID: <200411092216.41896.efocht@hpce.nec.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I'm having trouble with my Tascam US-122. When trying to run it with
the SuSE 9.2 Pro kernel (2.6.8-24.3-default) the kernel hangs
immediately. I wonder whether the devices are tested at all with this
kernel...

Does anybody have a hint where to look at?

Regards,
Erich

PS: Here is some kdb output:

hot:/home/focht/wav # aplay -D hw:1 RHCP.wav 
Playing WAVE 'RHCP.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
underrun!!! (at Oops: 0000 [#1]
Modules linked in: nvram usbserial parport_pc lp parport speedstep_lib freq_table thermal processor fan button battery ac ipv6 snd_intel8x0 snd_ac97_codec edd snd_usb_audio usb_storage snd_usb_usx2y snd_pcm snd_timer snd_usb_lib snd_rawmidi snd_seq_device snd_hwdep snd soundcore snd_page_alloc lirc_atiusb lirc_dev joydev sg st sd_mod sr_mod scsi_mod sis_agp agpgart ide_cd cdrom ehci_hcd ohci_hcd subfs nls_cp437 vfat fat nls_utf8 ntfs evdev dm_mod sis900 usbcore ext3 jbd
CPU:    0
EIP:    0060:[<e095ff79>]    Tainted:  G  U VLI
EFLAGS: 00010246   (2.6.8-24.3-default ) 
EIP is at dl_done_list+0x49/0xe0 [ohci_hcd]
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: d71b6d80   edi: dc4a7140   ebp: dda61400   esp: c0421f3c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c0420000 task=c0382a80)
Stack: 00000000 c0421fb0 dda61400 dda61674 00000002 e082a000 e0960934 c0421fb0 
       dda61674 00000001 00000009 00000001 e08eaa86 dfe9d460 00000000 c01086d4 
       00000009 c0414c80 00000480 cdecefa0 c0108982 00000009 c0421fb0 cdecefa0 
Call Trace:
 [<e0960934>] ohci_irq+0xb4/0x150 [ohci_hcd]
 [<e08eaa86>] usb_hcd_irq+0x26/0x50 [usbcore]
 [<c01086d4>] handle_IRQ_event+0x34/0x60
 [<c0108982>] do_IRQ+0x82/0x120
 [<c0106d38>] common_interrupt+0x18/0x20
 [<c0104030>] default_idle+0x0/0x30
 [<c0104054>] default_idle+0x24/0x30
 [<c01040d1>] cpu_idle+0x31/0x40
 [<c01003c6>] rest_init+0x16/0x20
 [<c0422794>] start_kernel+0x194/0x1e0
Code: 26 00 80 7f 28 02 0f 84 9b 00 00 00 8b 0c 24 85 c9 74 6f 8b 41 1c 89 04 24 89 e8 8b 71 20 8b 79 14 89 f2 8b 5e 04 e8 57 fa ff ff <66> 8b 43 06 40 66 3b 43 04 66 89 43 06 74 5e 8d 47 20 8b 4f 20 
 least 0.029 ms l
Entering kdb (current=0xc0382a80, pid 0) Oops: Oops
due to oops @ 0xe095ff79
eax = 0x00000000 ebx = 0x00000000 ecx = 0x00000000 edx = 0x00000000 
esi = 0xd71b6d80 edi = 0xdc4a7140 esp = 0xc0421f3c eip = 0xe095ff79 
ebp = 0xdda61400 xss = 0xc0290068 xcs = 0x00000060 eflags = 0x00010246 
xds = 0x0000007b xes = 0x0000007b origeax = 0xffffffff &regs = 0xc0421f08
kdb> bkdb> btkdb> bt
Stack traceback for pid 0
0xc0382a80        0        0  1    0   R  0xc0382cb0 *swapper
ESP        EIP        Function (args)
0xc0421f3c 0xe095ff79 [ohci_hcd]dl_done_list+0x49 (0xc0421fb0)
0xc0421f58 0xe0960934 [ohci_hcd]ohci_irq+0xb4
0xc0421f70 0xe08eaa86 [usbcore]usb_hcd_irq+0x26
0xc0421f7c 0xc01086d4 handle_IRQ_event+0x34 (0x9, 0xc0421fb0, 0xcdecefa0)
0xc0421f90 0xc0108982 do_IRQ+0x82 (0xc0420000, 0x0, 0xc0104030, 0x99100, 0xc045a120)
0xc0421fb0 0xc0106d38 common_interrupt+0x18
0xc0421fe8 0xc01040d1 cpu_idle+0x31
0xc0421ff0 0xc01003c6 rest_init+0x16
0xc0421ff4 0xc0422794 start_kernel+0x194
kdb> pkdb> pskdb> ps
16 sleeping system daemon (state M) processes suppressed
Task Addr       Pid   Parent [*] cpu State Thread     Command
0xc0382a80        0        0  1    0   R  0xc0382cb0 *swapper

0xcdecaaa0        1        0  0    0   S  0xcdecacd0  init
0xdd387550     2232        1  0    0   S  0xdd387780  udevd
0xdd04c000     2621        1  0    0   S  0xdd04c230  hwscand
0xdcaa2000     3739        1  0    0   S  0xdcaa2230  hwscand
0xddef0aa0     4096        1  0    0   S  0xddef0cd0  ddclient
0xdcaa2550     4277        1  0    0   S  0xdcaa2780  syslogd
0xdd9e4550     4280        1  0    0   R  0xdd9e4780  klogd
0xdc4f3550     4304        1  0    0   S  0xdc4f3780  resmgrd
0xdd73aaa0     4312        1  0    0   S  0xdd73acd0  portmap
0xddb36000     4399        1  0    0   S  0xddb36230  sshd
0xdd587000     4444        1  0    0   S  0xdd587230  kdm
0xdd50daa0     4446        1  0    0   S  0xdd50dcd0  acpid
0xdde35550     4464     4444  0    0   S  0xdde35780  X
0xdc55c550     4466     4444  0    0   S  0xdc55c780  kdm
0xdd2c4550     4488        1  0    0   S  0xdd2c4780  powersaved
0xdd637aa0     4502        1  0    0   S  0xdd637cd0  cupsd
0xdc461000     4686        1  0    0   S  0xdc461230  master
0xdde35aa0     4707     4686  0    0   S  0xdde35cd0  pickup
more> 
0xdfa1b550     4708     4686  0    0   S  0xdfa1b780  qmgr
0xdd50d550     4709     4686  0    0   S  0xdd50d780  cleanup
0xdfa1baa0     4711     4686  0    0   S  0xdfa1bcd0  trivial-rewrite
0xdde35000     4713        1  0    0   S  0xdde35230  nscd
0xddef0000     4714        1  0    0   S  0xddef0230  nscd
0xddef0550     4715        1  0    0   S  0xddef0780  nscd
0xdd04c550     4716        1  0    0   S  0xdd04c780  nscd
0xdcaa2aa0     4717        1  0    0   S  0xdcaa2cd0  nscd
0xdd9e4000     4718        1  0    0   S  0xdd9e4230  nscd
0xd9d3c550     5121     4686  0    0   S  0xd9d3c780  local
0xd9d3c000     5327     4466  0    0   S  0xd9d3c230  kdm_greet
0xdda3c000     5499        1  0    0   S  0xdda3c230  cron
0xc1577550     5515        1  0    0   S  0xc1577780  mingetty
0xdd637000     5516        1  0    0   S  0xdd637230  mingetty
0xdd1ba000     5517        1  0    0   S  0xdd1ba230  mingetty
0xc1577000     5518        1  0    0   S  0xc1577230  mingetty
0xd99b3000     5519        1  0    0   S  0xd99b3230  mingetty
0xd9d29aa0     5520        1  0    0   S  0xd9d29cd0  mingetty
0xdd50d000     5521        1  0    0   S  0xdd50d230  login
0xddb36550     5547     5521  0    0   S  0xddb36780  bash
0xdda3c550     5571     5547  0    0   S  0xdda3c780  aplay
kdb> 
kdb> bkdb> btkdb> bt kdb> b kdb> bkdb> btkdb> btpkdb> btp kdb> btp 5kdb> btp 55kdb> btp 557kdb> btp 5571kdb> btp 5571
Stack traceback for pid 5571
0xdda3c550     5571     5547  0    0   S  0xdda3c780  aplay
ESP        EIP        Function (args)
0xd83b3e60 0xc0314a6c schedule+0x2fc (0xc04820f8, 0xc04820f8, 0xfffd22ca, 0x4b87ad6e, 0xc0123e30)
0xd83b3e98 0xc0314fd6 schedule_timeout+0x56 (0x0)
0xd83b3ec4 0xe0a3f806 [snd_usb_usx2y]snd_usX2Y_pcm_prepare+0x156 (0x282, 0x286, 0x0, 0x0, 0xc0235358)
0xd83b3edc 0xc02440fd __uart_start+0x3d
0xd83b3f1c 0xe0a5e409 [snd_pcm]snd_pcm_do_prepare+0x9 (0xe0a72180, 0xe0a721ec, 0xdffcbd94)
0xd83b3f24 0xe0a5db7d [snd_pcm]snd_pcm_action_single+0x1d
0xd83b3f38 0xe0a5dc57 [snd_pcm]snd_pcm_action_nonatomic+0x47
0xd83b3f44 0xe0a5e48e [snd_pcm]snd_pcm_prepare+0x3e
0xd83b3f54 0xe0a603fc [snd_pcm]snd_pcm_common_ioctl1+0x26c (0xc02308e1, 0xc15d7bcc, 0x25, 0xbfffc341, 0xc0235170)
0xd83b3f5c 0xe0a604cd [snd_pcm]snd_pcm_playback_ioctl1+0x4d
0xd83b3f94 0xe0a60a61 [snd_pcm]snd_pcm_playback_ioctl+0x21
kdb> 




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
