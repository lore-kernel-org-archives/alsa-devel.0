From: Anders <andersosterholt@gmail.com>
Subject: Re: Conexant test code.
Date: Thu, 9 Nov 2006 00:08:27 +0000 (UTC)
Message-ID: <loom.20061109T004419-619@post.gmane.org>
References: <1162633963.24604.163.camel@razman>
	<454DEAFA.3030509@cse.unsw.edu.au>
	<b12092cb0611050603v89aa3c9vd19cb0ad173e5ad7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I can confirm this behavior.

HP dv3000, Subsystem: 103c:30b2

model=test gives some kind of kernel problem that brakes alsa:
It's ubuntu patched kernel 2.6.17-10-generic #2 SMP Fri Oct 13 18:45:35,
in case that's relevant.
dmesg:
[17179844.140000] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) \
-> IRQ 66
[17179844.140000] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[17179844.264000] ALSA \
/home/anders/Desktop/alsa/alsa-driver-1.0.13/pci/hda/hda_codec.c:1741: \
hda_codec: model 'test' is selected
[17179844.420000] BUG: unable to handle kernel paging request at virtual \
address fffffff8
[17179844.420000]  printing eip:
[17179844.420000] f8f3771e
[17179844.420000] *pde = 00004067
[17179844.420000] Oops: 0000 [#1]
[17179844.420000] SMP 
[17179844.420000] Modules linked in: snd_hda_intel snd_hda_codec snd_pcm \
snd_timer snd snd_page_alloc ipv6 binfmt_misc i915 drm speedstep_centrino \
cpufreq_userspace cpufreq_stats freq_table cpufreq_powersave cpufreq_ondemand \
cpufreq_conservative video tc1100_wmi sony_acpi sbs pcc_acpi i2c_ec i2c_core \
hotkey dev_acpi container button battery asus_acpi ac af_packet sbp2 \
parport_pc lp parport joydev tsdev sdhci mmc_core e100 mii sg ipw3945 psmouse \
hw_random ieee80211 ieee80211_crypt shpchp pci_hotplug serio_raw intel_agp \
agpgart soundcore evdev ext3 jbd ohci1394 ieee1394 ehci_hcd uhci_hcd usbcore \
ide_generic sd_mod ata_piix libata scsi_mod ide_cd cdrom piix generic thermal \
processor fan fbcon tileblit font bitblit softcursor vesafb capability \
commoncap
[17179844.420000] CPU:    1
[17179844.420000] EIP:    0060:[<f8f3771e>]    Not tainted VLI
[17179844.420000] EFLAGS: 00010297   (2.6.17-10-generic #2) 
[17179844.420000] EIP is at snd_hda_ch_mode_info+0x2e/0x50 [snd_hda_codec]
[17179844.420000] eax: ffffffff   ebx: 00000000   ecx: 00000000   edx: f17f3e04
[17179844.420000] esi: f5ea56d4   edi: f63e7160   ebp: f17f3e04   esp: f17f3dc4
[17179844.420000] ds: 007b   es: 007b   ss: 0068
[17179844.420000] Process alsactl \
(pid: 6297, threadinfo=f17f2000 task=f5d78560)
[17179844.420000] Stack: f8e1de67 f8f45c98 f63e7014 f8f43c48 00000000 \
f63e7014 f8e1bc09 f17f3e34 
[17179844.420000]        f17ce84c f17f3f44 c0178953 bfeefca0 f1b83a54 \
00000001 f17ce114 f17d4e80 
[17179844.420000]        00000001 00000000 00000000 00000000 00000000 \
00000000 00000000 00000000 
[17179844.420000] Call Trace:
[17179844.420000]  <f8e1de67> snd_hidden_kfree+0x77/0xa0 [snd]  <f8f43c48> \
conexant_ch_mode_info+0x18/0x20 [snd_hda_codec]
[17179844.420000]  <f8e1bc09> snd_ctl_ioctl+0x509/0xc80 [snd]  <c0178953> \
do_lookup+0x53/0x160
[17179844.420000]  <c0158f41> __handle_mm_fault+0x211/0x900  <c0168f25> \
nameidata_to_filp+0x35/0x40
[17179844.420000]  <f8e1b700> snd_ctl_ioctl+0x0/0xc80 [snd]  <c017d5eb> \
do_ioctl+0x2b/0x90
[17179844.420000]  <c017d6ac> vfs_ioctl+0x5c/0x2b0  <c017d972> \
sys_ioctl+0x72/0x90
[17179844.420000]  <c0102fbb> sysenter_past_esp+0x54/0x79 
[17179844.420000] Code: 8b 44 24 10 3b 42 54 c7 42 40 03 00 00 00 c7 42 48 01 \
00 00 00 89 42 50 77 06 83 e8 01 89 42 54 8b 42 54 c7 44 24 04 98 5c f4 f8 \
<8b> 04 c1 89 44 24 08 8d 42 58 89 04 24 e8 50 d2 2a c7 31 c0 83 
[17179844.420000] EIP: [<f8f3771e>] snd_hda_ch_mode_info+0x2e/0x50 \
[snd_hda_codec] SS:ESP 0068:f17f3dc4
[17179844.420000]  


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
