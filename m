From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc5-mm1: BUG in pci_disable_msi on attempts
 to rmmod snd_hda_intel (64-bit kernel)
Date: Wed, 6 Sep 2006 20:24:29 -0700
Message-ID: <20060906202429.6c4256fa.akpm@osdl.org>
References: <200609062259.53465.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3436C23A
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Sep 2006 05:24:41 +0200 (MEST)
In-Reply-To: <200609062259.53465.rjw@sisk.pl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <greg@kroah.com>, alsa-devel@alsa-project.org, Andi Kleen <ak@suse.de>
List-Id: alsa-devel@alsa-project.org

On Wed, 6 Sep 2006 22:59:53 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> Hi,
> 
> I get the appended BUG when I try to rmmod snd_hda_intel on 2.6.18-rc5-mm1
> (the box is an HPC nx6325).
> 
> The driver also breaks the suspend to disk (causes an oops to appear during
> the suspend phase, but I haven't been able to catch it yet).
> 

I'm told that the MSI patehs in rc5-mm1 are no good and have been redone
and replaced.  So could you please remember to retest next -mm?  Fingers
crossed, it'll be fixed then.

(Where did the taint come from?)

Thanks.

> 
> Kernel BUG at drivers/pci/msi.c:910
> invalid opcode: 0000 [1] SMP 
> last sysfs file: /power/disk
> CPU 0 
> Modules linked in: cpufreq_ondemand cpufreq_userspace cpufreq_powersave powernow_k8 freq_table af_packet button edd snd_pcm_oss snd_mixer_oss battery snd_seq snd_seq_device ac ip6t_REJECT xt_tcpudp ipt_REJECT xt_state iptable_mangle iptable_nat ip_nat iptable_filter ip6table_mangle ip_conntrack nfnetlink ip_tables ip6table_filter ip6_tables x_tables ipv6 loop dm_mod usbhid ff_memless hci_usb bluetooth snd_hda_intel bcm43xx shpchp snd_hda_codec pcmcia pci_hotplug snd_pcm firmware_class ieee80211softmac ohci1394 sdhci snd_timer snd soundcore snd_page_alloc ieee1394 mmc_core ohci_hcd i2c_piix4 yenta_socket rsrc_nonstatic pcmcia_core ide_cd i2c_core cdrom k8temp hwmon ehci_hcd usbcore ieee80211 ieee80211_crypt tg3 ext3 jbd fan thermal processor atiixp ide_disk ide_core sg
> Pid: 3684, comm: rmmod Tainted: G   M  2.6.18-rc5-mm1 #14
> RIP: 0010:[<ffffffff80326c7b>]  [<ffffffff80326c7b>] pci_disable_msi+0xdf/0x11a
> RSP: 0018:ffff810035559c68  EFLAGS: 00010202
> RAX: 0000000000000052 RBX: ffff810037145620 RCX: ffffffff804e7048
> RDX: ffff810035559a78 RSI: 0000000000000092 RDI: ffffffff804e7040
> RBP: ffff810035559c88 R08: ffffffff804e7048 R09: 0000000000000002
> R10: ffff810035559938 R11: 0000000000000000 R12: ffff810037ba7678
> R13: 0000000000000008 R14: 0000000000000880 R15: 00007fff6dc093c0
> FS:  00002ba63d1ea6d0(0000) GS:ffffffff8064e000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 00002ba63d0c6e40 CR3: 000000002f1f1000 CR4: 00000000000006e0
> Process rmmod (pid: 3684, threadinfo ffff810035558000, task ffff810034552790)
> Stack:  ffff810035559c78 0081ffff8025e80c ffff810035588b50 0000000000000280
>  ffff810035559cb8 ffffffff882f4405 ffff810035559cc8 ffff810034a25878
>  0000000000002000 0000000000002fff ffff810035559cc8 ffffffff882f449a
> Call Trace:
>  [<ffffffff882f4405>] :snd_hda_intel:azx_free+0xc3/0x14b
>  [<ffffffff882f449a>] :snd_hda_intel:azx_dev_free+0xd/0xf
>  [<ffffffff881a688b>] :snd:snd_device_free+0xea/0x157
>  [<ffffffff881a696b>] :snd:snd_device_free_all+0x73/0x98
>  [<ffffffff881a1735>] :snd:snd_card_do_free+0x7f/0x10f
>  [<ffffffff881a21ef>] :snd:snd_card_free+0xa4/0xb4
>  [<ffffffff882f4321>] :snd_hda_intel:azx_remove+0x18/0x27
>  [<ffffffff80320610>] pci_device_remove+0x25/0x3c
>  [<ffffffff80377671>] __device_release_driver+0x80/0x9c
>  [<ffffffff80377acb>] driver_detach+0xac/0xee
>  [<ffffffff80376b74>] bus_remove_driver+0x75/0x97
>  [<ffffffff80377b4a>] driver_unregister+0x15/0x21
>  [<ffffffff803207be>] pci_unregister_driver+0x13/0x8e
>  [<ffffffff882f5988>] :snd_hda_intel:alsa_card_azx_exit+0x10/0x12
>  [<ffffffff8029ada1>] sys_delete_module+0x1b5/0x1e6
>  [<ffffffff8025910e>] system_call+0x7e/0x83
> DWARF2 unwinder stuck at system_call+0x7e/0x83
> 
> Leftover inexact backtrace:
> 
> 
> 
> Code: 0f 0b 68 9e c3 42 80 c2 8e 03 eb 27 48 c7 c7 44 98 50 80 8b 
> RIP  [<ffffffff80326c7b>] pci_disable_msi+0xdf/0x11a
>  RSP <ffff810035559c68>
>  
> 
> 
> -- 
> You never change things by fighting the existing reality.
> 		R. Buckminster Fuller

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
