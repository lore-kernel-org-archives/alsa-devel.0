From: Maximilian Engelhardt <maxi@daemonizer.de>
Subject: Re: [FFADO-devel] Call for testing: ALSA driver for Fireworks/BeBoB
	based devices
Date: Sun, 02 Feb 2014 00:49:23 +0100
Message-ID: <3203598.M2Em43oa5Y@eisbaer>
References: <525B624B.4060906@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5474534086610333356=="
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <525B624B.4060906@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, linux-audio-dev@lists.linuxaudio.org, "ffado-devel@lists.sf.net" <ffado-devel@lists.sf.net>
List-Id: alsa-devel@alsa-project.org


--===============5474534086610333356==
Content-Type: multipart/signed; boundary="nextPart1515850.jJSNxuC9xH";
	micalg="pgp-sha512"; protocol="application/pgp-signature"


--nextPart1515850.jJSNxuC9xH
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Monday 14 October 2013 12:17:31 Takashi Sakamoto wrote:
> Hi all,
>=20
> This is a call for testing my ALSA driver for Fireworks/BeBoB based d=
evices.
>=20
> Please test 'snd-fireworks' for Fireworks and 'snd-bebob' for BeBoB i=
f
> you have some devices listed in the end of this mail.
>=20
> Status:
> - still under development
> - Without snd-dice and Clemens' development (I must do this later)
>=20
> Functionality:
> - playback/capturing (full duplex) with PCM/MIDI interface
> - hardware metering for some devices with CONTROL interface
> - switching clock source/digital interface/digital mode with CONTROL
> interface
> - print hardware status with PROC interface
>=20
> Note:
> - Don't use simultaneously 'ALSA PCM/MIDI playback/capture' and 'jack=
d
> with Firewire (FFADO) backend'. Both of them try connecting to the
> device when another is running.
> - I add much modification into snd-firewire-lib for full duplex
> synchronization of receive/transmit AMDTP stream.
>=20
> Requirement:
> - Linux kernel 3.11 or later because of Juju (nickname of Firewire
> stack) changing its API.
> - Dynamic Kernel Module Support (DKMS) is reccomended for safely
> installing/uninstalling
> (I work with Ubuntu 13.10)
>=20
> Bug report:
> - report with /proc/asound/cardX/#XXX
> - please send your experiences to me with the output
>=20
> How to install (DKMS):
> 1. $ git clone https://github.com/takaswie/snd-firewire-improve.git
> 2. $ ln -s $(pwd)/snd-firewire-improve/ /usr/src/alsa-firewire-3.11
> (superuser)
> 3. $ dkms install snd-firewire/3.11 (superuser)
>=20
> How to uninstall (DKMS):
> 1. $ modprobe -r snd-bebob snd-fireworks snd-firewire-lib (superuser)=

> 2. $ dkms remove ans-firewire/3.11 --all (superuser)
> 3. $ rm /usr/src/alsa-firewire-3.11 (superuser)
> 4. $ rm snd-firewire-improve
>=20
> How to install (Manual):
> 1. $ git clone https://github.com/takaswie/snd-firewire-improve.git
> 2. $ cd snd-firewire-improve
> 3. $ make
> 4, backup system snd-firewire-lib/snd-firewire-speakers/snd-isight
> (superuser)
> 5. install
> snd-firewire-lib/snd-firewire-speakers/snd-isight/snd-fireworks/snd-b=
ebob
> (superuser) 6. depmod -a (superuser)
>=20
> How to uninstall (Manual)
> 1. modprobe -r snd-firewire-lib snd-firewire-speakers snd-isight
> snd-fireworks snd-bebob (superuser)
> 2. remove
> snd-firewire-lib/snd-firewire-speakers/snd-isight/snd-fireworks/snd-b=
ebob
> (superuser) 3. recover snd-firewire-lib/snd-firewire-speakers/snd-isi=
ght
> (superuser) 4. depmod -a (superuser)
>=20
> Confirmed to work:
> - AudioFire4
> - AudioFirePre8
> - Ozonic
> - Firewire Solo
> - Firewire Audiophile
> - Firewire 410
>=20
> =3D=3D Fireworks based devices
> [Echo Audio]
> AudioFire2
> AudioFire4
> AudioFirePre8
> AudioFire8 (till 2009)
> AudioFire8 (since 2009)
> AudioFire12
>=20
> [Gibson]
> RIP
>=20
> [Mackie]
> Onyx 400F
> Onyx 1200F
>=20
> =3D=3D BeBoB based devices
> [Yamaha]
> GO44
> GO46
>=20
> [M-Audio]
> (to control mixer channels please use FFADO upstream)
> Ozonic
> Firewire 410
> Firewire Audiophile
> Firewire Solo
> NRV10
> ProFireLightbridge
>=20
> [Focusrite]
> SaffirePro 26 I/O
> SaffirePro 10 I/O
> Saffire(LE)
>=20
> [Edirol]
> FA-66
> FA-101
>=20
> [TerraTecElectronic GmbH]
> Phase88FW
> PhaseX24FW
>=20
> [PreSonus]
> FireBox
> FirePod
>=20
> [Mackie]
> OnyxFirewire
>=20
> [Tascam]
> IF-FW/DM
>=20
> [Behringer]
> X32
>=20
> [ApogeeElectronics]
> Rosetta200
>=20
> [ESI]
> Quatafire610
>=20
>=20
> Regards
>=20
> Takashi Sakamoto
> o-takashi@sakamocchi.jp
>=20
> ---------------------------------------------------------------------=
-------
> -- October Webinars: Code for Performance
> Free Intel webinars can help you accelerate application performance.
> Explore tips for MPI, OpenMP, advanced profiling, and more. Get the m=
ost
> from the latest Intel processors and coprocessors. See abstracts and
> register >
> http://pubads.g.doubleclick.net/gampad/clk?id=3D60134071&iu=3D/4140/o=
stg.clktrk
> _______________________________________________
> FFADO-devel mailing list
> FFADO-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ffado-devel


Hi Takashi,

Today I finally had some time to try your patches. I have a Terratec Ph=
ase=20
24FW Card. I did use the latest version (as of today) from=20
https://github.com/takaswie/snd-firewire-improve.git on a Debian testin=
g=20
system. I did not use dkms but loaded the driver manually:
$ cd sound/firewire
$ modprobe -r snd-firewire-lib
$ insmod ./snd-firewire-lib.ko
$ insmod ./bebob/snd-bebob.ko

First I have to say the driver does work and I can play music through t=
he=20
device, so thanks for your work.
Unfortunately I managed to crash my system with it. I was using mplayer=
2 to=20
play sound files and it seems that if I let mplayer2 play multiple file=
s the=20
system crashed somewhere between the end of the last file and the start=
 of the=20
new file (probably a race or something). I only did some quick testes b=
ecause=20
I hat to reboot after every crash (even sysrq doesn't work anymore), bu=
t I=20
think the crash doesn't happen every time mplayer2 switches to the next=
 file,=20
but most of the time. If I let it play only one file I didn't observe a=
ny=20
crashes.

Here is the mplayer2 command I did use for testing:
$ mplayer -ao alsa:device=3Dhw=3D1 <some files>

And here the output of /proc/asound/cardX/#XXX
$ cat /proc/asound/card1/#clock=20
Sampling rate: 48000
Clock Source: Internal
$ cat /proc/asound/card1/#firmware=20
Manufacturer:   bridgeCo
Protocol Ver:   1
Build Ver:      0
GUID:           0x000AAC04005F9C07
Model ID:       0x04
Model Rev:      1
Firmware Date:  20060420
Firmware Time:  105241
Firmware ID:    0x4
Firmware Ver:   18681119
Base Addr:      0x20080000
Max Size:       1572864
Loader Date:    20040719
Loader Time:    134002
$ cat /proc/asound/card1/#formation=20
Output Stream from device:
        Rate    PCM     MIDI
        22050   0       0
        24000   0       0
        32000   4       1
        44100   4       1
        48000   4       1
        88200   4       1
        96000   4       1
        176400  0       0
        192000  4       1
Input Stream to device:
        Rate    PCM     MIDI
        22050   0       0
        24000   0       0
        32000   6       1
        44100   6       1
        48000   6       1
        88200   6       1
        96000   6       1
        176400  0       0
        192000  6       1


Attached is the crash log as far as I could obtain it.

pulseaudio[4885]: [pulseaudio] module-alsa-card.c: Failed to find a wor=
king profile.
pulseaudio[4885]: [pulseaudio] module.c: Failed to load module "module-=
alsa-card" (argument: "device_id=3D"1" name=3D"firewire-0x000aac04005f9=
c07" card_name=3D"alsa_card.firewire-0x000aac04005f9c07" namereg_fail=3D=
false tsched=3Dyes fixed_latency_range=3Dno ignore_dB=3Dno deferred_vol=
ume=3Dyes use_ucm=3Dyes card_properties=3D"module-udev-detect.discovere=
d=3D1""): initialization failed.
kernel: [  334.172898] BUG: unable to handle kernel paging request at f=
fffffffffffffff
kernel: [  334.172934] IP: [<ffffffffa0154670>] fw_iso_context_queue_fl=
ush+0x10/0x10 [firewire_core]
kernel: [  334.172977] PGD 180f067 PUD 1811067 PMD 0=20
kernel: [  334.172998] Oops: 0000 [#1] SMP=20
kernel: [  334.173015] Modules linked in: snd_bebob(O) snd_firewire_lib=
(O) sit ebtable_nat tunnel4 ip_tunnel ebtables cpufreq_stats cpufreq_us=
erspace cpufreq_conservative parport_pc cpufreq_powersave ppdev lp ip6t=
able_raw parport nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_t=
ables xt_REDIRECT iptable_nat nf_nat_ipv4 nf_nat xt_CT iptable_raw ipt_=
REJECT xt_LOG xt_limit xt_tcpudp nf_conntrack_ipv4 nf_defrag_ipv4 xt_co=
nntrack nf_conntrack iptable_filter ip_tables x_tables binfmt_misc defl=
ate ctr twofish_generic twofish_avx_x86_64 twofish_x86_64_3way twofish_=
x86_64 twofish_common camellia_generic camellia_x86_64 serpent_avx_x86_=
64 serpent_sse2_x86_64 serpent_generic xts blowfish_generic blowfish_x8=
6_64 blowfish_common cast5_generic cast_common des_generic cbc cmac xcb=
c rmd160 sha512_generic sha256_generic crypto_null af_key xfrm_algo arc=
4 ecb md4 hmac nls_utf8 cifs rpcsec_gss_krb5 nfsv4 dns_resolver nfsd au=
th_rpcgss oid_registry nfs_acl nfs lockd fscache sunrpc w83627ehf hwmon=
_vid loop fuse ecryptfs isl6423 stv6110x stv090x snd_hda_codec_hdmi snd=
_hda_codec_realtek iTCO_wdt iTCO_vendor_support stv0299 rc_hauppauge mx=
m_wmi x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm crc3=
2_pclmul crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64 ablk_h=
elper cryptd lrw gf128mul glue_helper psmouse snd_hda_intel snd_hda_cod=
ec snd_hwdep snd_pcm_oss snd_mixer_oss snd_pcm snd_page_alloc snd_seq_m=
idi snd_seq_midi_event pcspkr snd_rawmidi budget budget_ci serio_raw bu=
dget_core ttpci_eeprom snd_seq i2c_i801 saa7146 snd_seq_device snd_time=
r rc_core dvb_core lpc_ich mfd_core snd soundcore evdev i915 drm_kms_he=
lper wmi drm i2c_algo_bit i2c_core video button processor mei_me mei ex=
t4 crc16 mbcache jbd2 btrfs xor raid6_pq crc32c libcrc32c dm_mod raid1 =
md_mod sg sd_mod sr_mod cdrom crc_t10dif crct10dif_common hid_generic u=
sbhid hid ahci firewire_ohci libahci firewire_core crc_itu_t libata scs=
i_mod ehci_pci ehci_hcd e1000e xhci_hcd ptp pps_core usbcore usb_common=
 thermal fan thermal_sys
kernel: [  334.173881] CPU: 0 PID: 5343 Comm: mplayer Tainted: G       =
    O 3.12-1-amd64 #1 Debian 3.12.6-2
kernel: [  334.173913] Hardware name:                  /DZ77BH-55K, BIO=
S BHZ7710H.86A.0100.2013.0517.0942 05/17/2013
kernel: [  334.173947] task: ffff88040da7a0c0 ti: ffff8803da2e4000 task=
.ti: ffff8803da2e4000
kernel: [  334.173973] RIP: 0010:[<ffffffffa0154670>]  [<ffffffffa01546=
70>] fw_iso_context_queue_flush+0x10/0x10 [firewire_core]
kernel: [  334.174015] RSP: 0018:ffff8803da2e5d70  EFLAGS: 00010002
kernel: [  334.174035] RAX: ffffffffa0acd040 RBX: ffff8800c99c95c8 RCX:=
 0000000000001c2c
kernel: [  334.174060] RDX: ffff88040dcff000 RSI: 0000000000000000 RDI:=
 ffffffffffffffff
kernel: [  334.174086] RBP: ffff8803da2e5de8 R08: 0000000000000000 R09:=
 00000000000031a1
kernel: [  334.174111] R10: 0000000052ed7c8e R11: 0000000000000246 R12:=
 00007fffa996f808
kernel: [  334.174137] R13: 00007fffa996f808 R14: 0000000000000000 R15:=
 ffff8803f70a8c00
kernel: [  334.174162] FS:  00007f286ae957c0(0000) GS:ffff88041f200000(=
0000) knlGS:0000000000000000
kernel: [  334.174190] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
kernel: [  334.174211] CR2: ffffffffffffffff CR3: 000000040c1d3000 CR4:=
 00000000001407f0
kernel: [  334.174236] Stack:
kernel: [  334.174245]  ffffffffa0abbca9 ffff8803da3a7000 ffffffffa0569=
bc4 0000000000000000
kernel: [  334.174277]  0000000c00000000 0000000081019435 0000000000000=
097 ffffffffa03e321b
kernel: [  334.174309]  ffff8803edca3558 ffff8803edca3530 ffff8803f70a8=
c00 00007fffa996f808
kernel: [  334.174340] Call Trace:
kernel: [  334.174352]  [<ffffffffa0abbca9>] ? amdtp_stream_pcm_pointer=
+0x29/0x40 [snd_firewire_lib]
kernel: [  334.174388]  [<ffffffffa0569bc4>] ? snd_pcm_update_hw_ptr0+0=
x34/0x3a0 [snd_pcm]
kernel: [  334.174419]  [<ffffffffa03e321b>] ? snd_timer_notify+0x6b/0x=
150 [snd_timer]
kernel: [  334.174448]  [<ffffffffa056363a>] ? snd_pcm_delay+0x5a/0x140=
 [snd_pcm]
kernel: [  334.174476]  [<ffffffffa0565623>] ? snd_pcm_common_ioctl1+0x=
5f3/0xc90 [snd_pcm]
kernel: [  334.174506]  [<ffffffffa056a5f3>] ? snd_pcm_lib_write1+0x3a3=
/0x3f0 [snd_pcm]
kernel: [  334.174536]  [<ffffffffa0567b80>] ? pcm_chmap_ctl_private_fr=
ee+0x30/0x30 [snd_pcm]
kernel: [  334.174567]  [<ffffffffa0565db0>] ? snd_pcm_playback_ioctl1+=
0xf0/0x240 [snd_pcm]
kernel: [  334.174597]  [<ffffffffa0565f26>] ? snd_pcm_playback_ioctl+0=
x26/0x30 [snd_pcm]
kernel: [  334.174625]  [<ffffffff81184d94>] ? do_vfs_ioctl+0x2d4/0x4b0=

kernel: [  334.174648]  [<ffffffff81184ff0>] ? SyS_ioctl+0x80/0xa0
kernel: [  334.174669]  [<ffffffff81499b39>] ? system_call_fastpath+0x1=
6/0x1b
kernel: [  334.174691] Code: 00 48 8b 40 60 ff e0 0f 1f 40 00 48 8b 07 =
48 8b 00 48 8b 40 70 ff e0 0f 1f 40 00 48 8b 07 48 8b 00 48 8b 40 78 ff=
 e0 0f 1f 40 00 <48> 8b 07 48 8b 00 48 8b 80 80 00 00 00 ff e0 90 48 8b=
 07 48 8b=20
kernel: [  334.174857] RIP  [<ffffffffa0154670>] fw_iso_context_queue_f=
lush+0x10/0x10 [firewire_core]
kernel: [  334.174893]  RSP <ffff8803da2e5d70>
kernel: [  334.174906] CR2: ffffffffffffffff
kernel: [  334.184706] ---[ end trace 4fd37a42001c8a5d ]---
kernel: [  355.198207] INFO: rcu_sched detected stalls on CPUs/tasks: {=
 0} (detected by 2, t=3D5252 jiffies, g=3D3743, c=3D3742, q=3D2720)
kernel: [  355.198212] sending NMI to all CPUs:
kernel: [  355.198213] NMI backtrace for cpu 2
kernel: [  355.198215] CPU: 2 PID: 3929 Comm: collectd Tainted: G      =
D    O 3.12-1-amd64 #1 Debian 3.12.6-2
kernel: [  355.198216] Hardware name:                  /DZ77BH-55K, BIO=
S BHZ7710H.86A.0100.2013.0517.0942 05/17/2013
kernel: [  355.198226] task: ffff88040bcad0c0 ti: ffff88040bf76000 task=
.ti: ffff88040bf76000
kernel: [  355.198227] RIP: 0010:[<ffffffff81275bdd>]  [<ffffffff81275b=
dd>] find_next_bit+0x4d/0xd0
kernel: [  355.198231] RSP: 0018:ffff88041f303df0  EFLAGS: 00000046
kernel: [  355.198231] RAX: 0000000000000000 RBX: ffff88041f30de00 RCX:=
 0000000000000001
kernel: [  355.198232] RDX: ffff88041f30de38 RSI: 0000000000000080 RDI:=
 0000000000000180
kernel: [  355.198233] RBP: ffff88041f20de40 R08: ffff88041f30de08 R09:=
 0000000000000008
kernel: [  355.198234] R10: 0000000000000000 R11: ffff88041f303bb6 R12:=
 000000000000de80
kernel: [  355.198234] R13: 0000000000080000 R14: 0000000000000055 R15:=
 0000000000000002
kernel: [  355.198235] FS:  00007f8149847700(0000) GS:ffff88041f300000(=
0000) knlGS:0000000000000000
kernel: [  355.198236] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
kernel: [  355.198237] CR2: 00007f8157da9000 CR3: 000000040d165000 CR4:=
 00000000001407e0
kernel: [  355.198238] Stack:
kernel: [  355.198239]  ffffffff81043637 0000000000000008 000000000000d=
e40 0000000200000002
kernel: [  355.198241]  0000000000000082 0000000000002710 ffffffff81841=
9c0 ffffffff818419c0
kernel: [  355.198242]  ffff88040bf76000 0000000000000aa0 ffff88041f30e=
d80 ffffffff8103f88e
kernel: [  355.198243] Call Trace:
kernel: [  355.198244]  <IRQ>=20
kernel: [  355.198245]  [<ffffffff81043637>] ? __x2apic_send_IPI_mask+0=
xb7/0x190
kernel: [  355.198251]  [<ffffffff8103f88e>] ? arch_trigger_all_cpu_bac=
ktrace+0x4e/0x80
kernel: [  355.198253]  [<ffffffff810e1b48>] ? rcu_check_callbacks+0x5b=
8/0x600
kernel: [  355.198256]  [<ffffffff810b4c30>] ? tick_sched_handle.isra.1=
5+0x60/0x60
kernel: [  355.198258]  [<ffffffff8106881b>] ? update_process_times+0x3=
b/0x70
kernel: [  355.198259]  [<ffffffff810b4beb>] ? tick_sched_handle.isra.1=
5+0x1b/0x60
kernel: [  355.198260]  [<ffffffff810b4c67>] ? tick_sched_timer+0x37/0x=
60
kernel: [  355.198263]  [<ffffffff8107ea22>] ? __run_hrtimer+0x62/0x1b0=

kernel: [  355.198264]  [<ffffffff8107f1c9>] ? hrtimer_interrupt+0xe9/0=
x220
kernel: [  355.198266]  [<ffffffff8103deb6>] ? smp_apic_timer_interrupt=
+0x36/0x50
kernel: [  355.198269]  [<ffffffff8149a71d>] ? apic_timer_interrupt+0x6=
d/0x80
kernel: [  355.198269]  <EOI>=20
kernel: [  355.198270]  [<ffffffff810ba548>] ? generic_exec_single+0x68=
/0x90
kernel: [  355.198273]  [<ffffffff810ba564>] ? generic_exec_single+0x84=
/0x90
kernel: [  355.198275]  [<ffffffff81287cb0>] ? ucs2_strncmp+0x60/0x60
kernel: [  355.198277]  [<ffffffff810ba655>] ? smp_call_function_single=
+0xe5/0x190
kernel: [  355.198278]  [<ffffffff81287cb0>] ? ucs2_strncmp+0x60/0x60
kernel: [  355.198280]  [<ffffffff81287dd6>] ? rdmsr_on_cpu+0x46/0x60
kernel: [  355.198295]  [<ffffffffa06561f3>] ? show_temp+0x93/0xd0 [cor=
etemp]
kernel: [  355.198298]  [<ffffffff81342157>] ? dev_attr_show+0x17/0x50
kernel: [  355.198300]  [<ffffffff811decc9>] ? sysfs_read_file+0x99/0x1=
70
kernel: [  355.198302]  [<ffffffff81172f94>] ? vfs_read+0x94/0x160
kernel: [  355.198304]  [<ffffffff81173a83>] ? SyS_read+0x43/0xa0
kernel: [  355.198306]  [<ffffffff81499b39>] ? system_call_fastpath+0x1=
6/0x1b
kernel: [  355.198306] Code: 3f 75 6b 48 f7 c6 c0 ff ff ff 0f 84 93 00 =
00 00 49 8b 00 49 8d 50 08 48 85 c0 74 0f eb 3f 48 83 c2 08 48 8b 42 f8=
 48 85 c0 75 32 <48> 83 ee 40 48 83 c7 40 48 f7 c6 c0 ff ff ff 75 e2 48=
 85 f6 48=20
kernel: [  355.198321] NMI backtrace for cpu 0
kernel: [  355.198324] CPU: 0 PID: 5343 Comm: mplayer Tainted: G      D=
    O 3.12-1-amd64 #1 Debian 3.12.6-2
kernel: [  355.198324] Hardware name:                  /DZ77BH-55K, BIO=
S BHZ7710H.86A.0100.2013.0517.0942 05/17/2013
kernel: [  355.198325] task: ffff88040da7a0c0 ti: ffff8803da2e4000 task=
.ti: ffff8803da2e4000
kernel: [  355.198326] RIP: 0010:[<ffffffff81492083>]  [<ffffffff814920=
83>] _raw_spin_lock+0x23/0x30
kernel: [  355.198329] RSP: 0018:ffff8803da2e5a30  EFLAGS: 00000097
kernel: [  355.198330] RAX: 0000000000001c2c RBX: ffff8803f70a8c00 RCX:=
 0000000000001c2d
kernel: [  355.198331] RDX: 0000000000001c2d RSI: ffff88040b1b5580 RDI:=
 ffff8803f70a8d70
kernel: [  355.198331] RBP: ffff8803da3a7000 R08: 0000000000000000 R09:=
 0000000000000000
kernel: [  355.198332] R10: ffff88040b1b5590 R11: 0000000000000117 R12:=
 ffff88040b1b5580
kernel: [  355.198333] R13: ffff88040dca7e40 R14: ffff88040b029d98 R15:=
 ffff8803d9156330
kernel: [  355.198334] FS:  0000000000000000(0000) GS:ffff88041f200000(=
0000) knlGS:0000000000000000
kernel: [  355.198335] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
kernel: [  355.198335] CR2: ffffffffffffffff CR3: 000000000180c000 CR4:=
 00000000001407f0
kernel: [  355.198336] Stack:
kernel: [  355.198337]  ffffffffa0563cb8 ffff8803f70a8c00 ffff88040b029=
c00 ffffffffa0563d2a
kernel: [  355.198338]  ffff8803f70a8c00 ffff88040b029c00 ffffffffa0563=
e68 ffff88040b1b5580
kernel: [  355.198340]  0000000000000008 ffff8803d9156330 ffff8803d3d7e=
780 ffff88040e6656e0
kernel: [  355.198341] Call Trace:
kernel: [  355.198351]  [<ffffffffa0563cb8>] ? snd_pcm_drop+0x48/0xb0 [=
snd_pcm]
kernel: [  355.198355]  [<ffffffffa0563d2a>] ? snd_pcm_release_substrea=
m.part.29+0xa/0x90 [snd_pcm]
kernel: [  355.198359]  [<ffffffffa0563e68>] ? snd_pcm_release+0x98/0xb=
0 [snd_pcm]
kernel: [  355.198361]  [<ffffffff81174a9a>] ? __fput+0xca/0x220
kernel: [  355.198363]  [<ffffffff81078904>] ? task_work_run+0xb4/0xd0
kernel: [  355.198365]  [<ffffffff8105d8c3>] ? do_exit+0x2b3/0xa40
kernel: [  355.198367]  [<ffffffff814932b8>] ? oops_end+0x98/0xe0
kernel: [  355.198369]  [<ffffffff81489540>] ? no_context+0x26a/0x276
kernel: [  355.198371]  [<ffffffff81495a0e>] ? __do_page_fault+0x2fe/0x=
500
kernel: [  355.198373]  [<ffffffff8111abea>] ? __alloc_pages_nodemask+0=
x14a/0xa30
kernel: [  355.198376]  [<ffffffff81127fcb>] ? shmem_find_get_pages_and=
_swap.part.18+0xcb/0x120
[some part missing...]

Greetings,
Maxi

--nextPart1515850.jJSNxuC9xH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABCgAGBQJS7YgGAAoJEIHqZH0kK9IVkpsQAKn6YC8y4PC05LQ2SScJPOVe
uxdfOWHiv0BoDU8mgtMsmK32+lKQeLRZOeAn4zhmlNx7XVH0MtEsbZYw0DZ3jj/U
bhd6kaUv6BA2NcV1TDbJStb/PXiPBlrgutnwfwrSegFmsp/LEQWGa38ufmERSiPp
5j3RjmkLLqR5PnOhEKhv2VPyi+IU7RdLS4fYJO0v6LcgwH7EJXvezJZntXYh2wOU
JyKkujiqEloiXTFMLxrlI8HRMxrIBLHd4bG7skwQ8LvA5jBukhfgvmMLiOBFvEbP
okb4pNMcxcdBlURY2euN6CVMRrl/gKsXCOjxDQ09OzoRIPXaRTPhIQy0iu18MTDD
TX+jTgw11EsDW3DrdOIUx2Gs2jOrHW0OgM00X2iV0esauyyKw3mkDGJ10LU72te5
kzH0OMA5TaGY2vqYYrv676mfBBKMvnQgVi/64YMmg6X1Rl0vnUn6/pp0UDpANpuU
PbYl1SXDrV1KRciCaj5oeRS/nhynvt8I/R3A9jDQfL0r/E6ejEpDL2ZJZFM4qx3b
MnERb/eYid0w2Nxl/RbQ9KTkrPHTt1IH9EKtejbtoWYl68LRFbJBQ13s9dVfofXc
t8x8pYgPa0Yn88uH1vzH1eKGHdwkn92PLaXfDyFuKDKSZewjJgMRSwQmVKHUt978
UZTYC8H72kEghILcKYJ2
=XqXR
-----END PGP SIGNATURE-----

--nextPart1515850.jJSNxuC9xH--



--===============5474534086610333356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
--===============5474534086610333356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5474534086610333356==--
