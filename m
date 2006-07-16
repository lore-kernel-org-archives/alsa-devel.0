From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002220]: emu10k1 crash on PCI hotplug
Date: Sun, 16 Jul 2006 04:46:13 +0200
Message-ID: <008365f2fe75f6555e6a250c06bc604f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9DFED177
	for <alsa-devel@alsa-project.org>;
	Sun, 16 Jul 2006 04:46:13 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2220> 
======================================================================
Reported By:                fizban
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2220
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             06-19-2006 02:03 CEST
Last Modified:              07-16-2006 04:46 CEST
======================================================================
Summary:                    emu10k1 crash on PCI hotplug
Description: 
With the new docking support in 2.6.17, my laptop's docking station is now
hotplugabble, and thus so is the SB 512 PCI in it. However, while
undocking the system seems to work correctly, docking it again causes the
following Oops:

EIP is at snd_emu10k1_ptr_write+0xb/0x89 [snd_emu10k1]
eax: 00000000   ebx: c8194000   ecx: 00000000   edx: 00000019
esi: 00000019   edi: 00000000   ebp: 00000000   esp: cfae1c50
ds: 007b   es: 007b   ss: 0068
Process kacpid_notify (pid: 11271, threadinfo=cfae1000 task=cfbd6540)
Stack: d087b7b4 c8194000 00000000 00000000 00000000 d14f05b0 0000ff00
cf6e3c00 
       c8194000 d150a31e 00000286 cf6e3c00 00000286 cee77400 cf2f4800
d150b30c 
       cf6e3c00 00000286 d150a06e cee77494 cdef8000 d14f0120 d14f0c2a
cf6e3c00 
Call Trace:
 <d14f05b0> free_voice+0x23/0x83 [snd_emu10k1_synth]  <d150a31e>
snd_emux_terminate_all+0x3b/0x6c [snd_emux_synth]
 <d150b30c> snd_emux_detach_seq+0xf/0x3b [snd_emux_synth]  <d150a06e>
snd_emux_free+0x42/0x74 [snd_emux_synth]
 <d14f0120> snd_emu10k1_synth_new_device+0xf3/0x127 [snd_emu10k1_synth] 
<d112e0e9> init_device+0x4d/0x82 [snd_seq_device]
 <d112e28e> find_driver+0xe9/0xf1 [snd_seq_device]  <d112e3a3>
snd_seq_device_dev_register+0x29/0x35 [snd_seq_device]
 <d113cbc0> snd_device_register_all+0x20/0x42 [snd]  <d113979f>
snd_card_register+0xe/0x21b [snd]
 <d087a5ed> snd_hwdep_new+0xa3/0xb1 [snd_hwdep]  <d150bdef>
snd_emux_init_hwdep+0x8f/0x9e [snd_emux_synth]
 <d150a161> snd_emux_register+0xc1/0x10a [snd_emux_synth]  <d150a000>
sf_sample_new+0x0/0x1e [snd_emux_synth]
 <d150a01e> sf_sample_free+0x0/0x8 [snd_emux_synth]  <d14f0113>
snd_emu10k1_synth_new_device+0xe6/0x127 [snd_emu10k1_synth]
 <d112e0e9> init_device+0x4d/0x82 [snd_seq_device]  <d112e28e>
find_driver+0xe9/0xf1 [snd_seq_device]
 <d112e3a3> snd_seq_device_dev_register+0x29/0x35 [snd_seq_device] 
<d113cbc0> snd_device_register_all+0x20/0x42 [snd]
 <d113979f> snd_card_register+0xe/0x21b [snd]  <d11723a4>
snd_card_emu10k1_probe+0x2fd/0x324 [snd_emu10k1]
 <c01dba41> pci_device_probe+0x36/0x57  <c02281f1>
driver_probe_device+0x45/0x9a
 <c02abc70> klist_next+0x2d/0x36  <c0228246> __device_attach+0x0/0x5
 <c0227c1a> bus_for_each_drv+0x32/0x58  <c0228296>
device_attach+0x4b/0x5b
 <c0228246> __device_attach+0x0/0x5  <c0227b42> bus_add_device+0x27/0xcd
 <c02270ef> device_add+0xcc/0x12d  <c01d8a32> pci_bus_add_device+0xb/0x30
 <c01d8a6c> pci_bus_add_devices+0x15/0x93  <c01d8aba>
pci_bus_add_devices+0x63/0x93
 <c01dfdfd> acpiphp_enable_slot+0x2f1/0x3d0  <c02061e0>
acpi_ut_update_ref_count+0x4b/0xa0
 <c01dfffd> handle_hotplug_event_func+0x6f/0x12f  <c01fc1b5>
acpi_ex_exit_interpreter+0xa/0x2f
 <c01f0b54> acpi_evaluate_integer+0x98/0xa2  <c01dff8e>
handle_hotplug_event_func+0x0/0x12f
 <c0209e73> hotplug_dock_devices+0x21/0x79  <c01f0359>
acpi_os_execute_thread+0x0/0x1a
 <c0209f7b> dock_notify+0x7b/0x15d  <c0207fc8> acpi_bus_notify+0x17/0x46
 <c01f574a> acpi_ev_notify_dispatch+0x49/0x52  <c01f0365>
acpi_os_execute_thread+0xc/0x1a
 <c0124166> kthread+0x91/0xbd  <c01240d5> kthread+0x0/0xbd
 <c0101005> kernel_thread_helper+0x5/0xb 
Code: e0 21 c2 d3 ea eb 11 9c 59 fa 8b 57 04 89 d8 ef 83 c2 04 ed 89 c2 51
9d 59 89 d0 5b 5e 5f 5d c3 55 89 c5 57 56 89 d6 53 83 ec 04 <83> 78 10 01
8b 7c 24 18 19 c0 83 e1 3f 25 00 00 00 f8 05 00 00 
EIP: [<d1177739>] snd_emu10k1_ptr_write+0xb/0x89 [snd_emu10k1] SS:ESP
0068:cfae1c50

======================================================================

----------------------------------------------------------------------
 tiwai - 06-29-06 18:21 
----------------------------------------------------------------------
This is hard to fix.  The driver accesses io to turn off the voices
properly at removing while there is no real hardware to access.
If it's USB, we have disconnect callback.  But for PCI, there is no
difference from remove and disconnect.

----------------------------------------------------------------------
 fizban - 07-16-06 04:46 
----------------------------------------------------------------------
I don't think that's the problem: the attached patch keeps it from crashing
(and the crash is on _redocking_, anyways, not the inital removal). But
this patch isn't a real fix, since it unregisters the snd-emu10k1-synth
driver entirely, forcing an un/reload cycle of snd-emu10k1-synth.ko to get
back MIDI. Nonetheless, I think this demonstrates that the problem is
simply that somehow the synth is not being fully deleted in the PCI
->remove() callback. I simply lack the ALSA-foo to trace through all the
windy code paths that are supposed to end up deleting the seqencer parts
along with the card.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-19-06 02:03 fizban         New Issue                                    
06-29-06 18:21 tiwai          Note Added: 0010685                          
07-16-06 04:40 fizban         File Added: emu10k1-not-a-real-fix.diff           
        
07-16-06 04:46 fizban         Note Added: 0011028                          
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
