From: Abdelghani Ouchabane <abdelghani@ezono.com>
Subject: Re: "modprobe snd_hda_intel" crashes on my hardware
Date: Tue, 27 Sep 2011 07:46:58 +0200
Message-ID: <4E816352.4080808@ezono.com>
References: <4E816239.5090507@ezono.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ezo.ezono.com (ezo.ezono.com [50.22.105.208])
	by alsa0.perex.cz (Postfix) with ESMTP id E079E243DC
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 09:47:04 +0200 (CEST)
Received: from [82.119.190.67] (port=58103 helo=sugi.ezono.net)
	by ezo.ezono.com with esmtpa (Exim 4.69)
	(envelope-from <abdelghani@ezono.com>) id 1R8SNb-0001a1-5j
	for alsa-devel@alsa-project.org; Tue, 27 Sep 2011 02:47:03 -0500
In-Reply-To: <4E816239.5090507@ezono.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hallo,

  additional info :  kernel-2.6.40.3-0.fc15.i686  uses alsa-driver-1.0.24


Abdelghani Ouchabane wrote:
> Description of problem:
>
> I have a customized sound hardware, it looks that it doesn't follow the
> standard 100 %.
>
> I had to patch the sound driver under fedora 9 ( 
> 2.6.27.25-78.2.56.fc9.i686 ),
> exactly I patched ./sound/pci/hda/patch_via.c by forcing the driver to 
> program
> the codec. It was working fine in Fedora 9.
>
> But in Fedora 15, I have tried the patch the 
> ./sound/pci/hda/patch_via.c, but
> unfortunately the path doesn't work.
>
> Please : could you help me to figure out how to patch
> ./sound/pci/hda/patch_via.c to make sound works in my hardware.
>
>
> Version-Release number of selected component (if applicable):
>
> kernel-2.6.40.3-0.fc15.i686.rpm
>
>
> Additional info:
>
> **************************************************************************************************************************************************************************** 
>
>
> dmesg log :
>
> [   95.366164] HDA Intel 0000:00:1b.0: PCI INT A -> Link[LNKA] -> GSI 10
> (level, low) -> IRQ 10
> [   95.366209] HDA Intel 0000:00:1b.0: setting latency timer to 64
> [   95.398391] hda_codec: Cannot set up configuration from BIOS.  
> Using genenic
> mode...
> [   95.398470] BUG: unable to handle kernel NULL pointer dereference 
> at  (null)
> [   95.398477] IP: [<f83740ac>] via_build_pcms+0x60/0xdc 
> [snd_hda_codec_via]
> [   95.398494] *pde = 3173f067 *pte = 00000000 [   95.398501] Oops: 
> 0000 [#1] PREEMPT [   95.398509] Modules linked in: snd_hda_codec_via 
> snd_hda_intel(+)
> snd_hda_codec snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd 
> soundcore
> snd_page_alloc ipv6 fakephp cgosdrv(P) joydev mcs7830 usbnet mii 
> usbtouchscreen
> iTCO_wdt i2c_i801 pciehp iTCO_vendor_support serio_raw xfs i915 
> drm_kms_helper
> drm i2c_algo_bit i2c_core video [last unloaded: scsi_wait_scan]
> [   95.398558] [   95.398564] Pid: 4208, comm: modprobe Tainted: 
> P           2.6.40.3-0.119.delos.i686 #1  [   95.398572] EIP: 
> 0060:[<f83740ac>] EFLAGS: 00010246 CPU: 0
> [   95.398581] EIP is at via_build_pcms+0x60/0xdc [snd_hda_codec_via]
> [   95.398587] EAX: f174f000 EBX: 00000000 ECX: 00000000 EDX: dd58f400
> [   95.398592] ESI: f837c760 EDI: f174f120 EBP: f17afd28 ESP: f17afd20
> [   95.398597]  DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068
> [   95.398603] Process modprobe (pid: 4208, ti=f17ae000 task=f0e5be30
> task.ti=f17ae000)
> [   95.398607] Stack:
> [   95.398610]  dd58f400 00000001 f17afd68 f81ef28a 00000050 f81f6511 
> f16aa960
> f16aa968
> [   95.398622]  00000001 11061708 2d646e73 2d616468 65646f63 64692d63 
> 3031313a
> dd58f400
> [   95.398634]  f578642c 00000001 f17afd78 f81f5aaf f171da00 f5786424 
> f17afde4
> f816e6fd
> [   95.398645] Call Trace:
> [   95.398665]  [<f81ef28a>] snd_hda_codec_build_pcms+0x25/0x230
> [snd_hda_codec]
> [   95.398685]  [<f81f5aaf>] snd_hda_build_pcms+0x17/0x2e [snd_hda_codec]
> [   95.398699]  [<f816e6fd>] azx_probe+0x9a6/0xa44 [snd_hda_intel]
> [   95.398713]  [<f816d1cd>] ? azx_pcm_open+0x1c8/0x1c8 [snd_hda_intel]
> [   95.398725]  [<f816d394>] ? azx_acquire_irq+0x9b/0x9b [snd_hda_intel]
> [   95.398737]  [<f816dbb9>] ? kzalloc.constprop.5+0x14/0x14 
> [snd_hda_intel]
> [   95.398749]  [<f816db45>] ? azx_resume+0xfa/0xfa [snd_hda_intel]
> [   95.398761]  [<f816d9e7>] ? azx_init_chip+0x1d5/0x1d5 [snd_hda_intel]
> [   95.398775]  [<c05dfcc1>] pci_device_probe+0x5e/0xa7
> [   95.398787]  [<c06616ef>] driver_probe_device+0x121/0x1fc
> [   95.398794]  [<c05dfc39>] ? pci_match_device+0x5d/0x68
> [   95.398802]  [<c0661812>] __driver_attach+0x48/0x64
> [   95.398810]  [<c0660931>] bus_for_each_dev+0x42/0x6b
> [   95.398817]  [<c0661350>] driver_attach+0x1f/0x23
> [   95.398824]  [<c06617ca>] ? driver_probe_device+0x1fc/0x1fc
> [   95.398832]  [<c0660fcb>] bus_add_driver+0xca/0x210
> [   95.398840]  [<c0661c2a>] driver_register+0x84/0xe3
> [   95.398848]  [<c05e03f7>] __pci_register_driver+0x34/0x91
> [   95.398862]  [<f820c017>] alsa_card_azx_init+0x17/0x19 [snd_hda_intel]
> [   95.398871]  [<c0401173>] do_one_initcall+0x8b/0x138
> [   95.398878]  [<f820c000>] ? 0xf820bfff
> [   95.398889]  [<c045945f>] sys_init_module+0x12bd/0x14dc
> [   95.398905]  [<c07c0e94>] syscall_call+0x7/0xb
> [   95.398909] Code: 00 f3 a5 8d b8 f0 00 00 00 8b 48 50 8b 70 3c 0f 
> b7 09 66
> 89 88 cc 00 00 00 b9 0c 00 00 00 f3 a5 8b 88 9c 00 00 00 66 83 78 5c 
> 00 <0f> b7
> 09 66 89 88 fc 00 00 00 8b 48 64 89 88 c8 00 00 00 75 0a [   
> 95.398972] EIP: [<f83740ac>] via_build_pcms+0x60/0xdc [snd_hda_codec_via]
> SS:ESP 0068:f17afd20
> [   95.398984] CR2: 0000000000000000
> [   95.488158] ---[ end trace e7a4603bcd7d8946 ]---
>
> **************************************************************************************************************************************************************************** 
>
>
> lspci -v :
>
> 00:1b.0 Audio device: Intel Corporation N10/ICH 7 Family High 
> Definition Audio
> Controller (rev 02)
> Flags: bus master, fast devsel, latency 0, IRQ 10
> Memory at fea38000 (64-bit, non-prefetchable) [size=16K]
> Capabilities: [50] Power Management version 2
> Capabilities: [60] MSI: Enable- Count=1/1 Maskable- 64bit+
> Capabilities: [70] Express Root Complex Integrated Endpoint, MSI 00
> Capabilities: [100] Virtual Channel
> Capabilities: [130] Root Complex Link
> Kernel driver in use: HDA Intel
> Kernel modules: snd-hda-intel
>
> **************************************************************************************************************************************************************************** 
>
>
> * Please, I need your great help to make my sound card works as I did for
> Fedora 9.
>
>   * Or any workaround.
>
>
>   * If you need any information, please don't hesitate.
>
> **************************************************************************************************************************************************************************** 
>
>
> * I have used the attached patch to force the driver to program the code.
>
> **************************************************************************************************************************************************************************** 
>
>
>
> Thanks a lot in advance.
>
>
