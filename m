From: =?ISO-8859-1?Q?Rami_Autiom=E4ki?= <rami.autiomaki@gmail.com>
Subject: ali5451 - no sound after resuming from suspend
Date: Wed, 7 Apr 2010 07:47:50 +0300
Message-ID: <o2qbfc1d8661004062147l204fa4dct9831b11f3d931f02@mail.gmail.com>
References: <o2ybfc1d8661004052324o662319f8sb2d21734be87cb83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by alsa0.perex.cz (Postfix) with ESMTP id A86F9103896
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Apr 2010 06:47:51 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id d23so1206418fga.2
	for <alsa-devel@alsa-project.org>; Tue, 06 Apr 2010 21:47:51 -0700 (PDT)
In-Reply-To: <o2ybfc1d8661004052324o662319f8sb2d21734be87cb83@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

My laptop suspends and resumes find, but sound is not working after compute=
r is
suspended and resumed. I can fix sound
by running as root "alsa force-reload". This bug has been some time
ago reported to alsa bug tracker:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D959

I compiled vanilla kernel 2.6.33.2 from kernel.org,
after suspending sound fails similarly with this kernel also.

I looked my alsa-info logs (they are somewhere down there) before and
after suspend, and files differ much at where it says "Current setup".

--
Rami Autiom=E4ki


-- Package-specific info:
** Version:
Linux version 2.6.32-3-686 (Debian 2.6.32-9) (maks@debian.org) (gcc
version 4.3.4 (Debian 4.3.4-8) ) #1 SMP Thu Feb 25 06:14:20 UTC 2010

** Command line:
BOOT_IMAGE=3D/boot/vmlinuz-2.6.32-3-686
root=3DUUID=3Dd58ac20c-4ecb-4cc6-91b5-acad8448af76 ro quiet noapic nolapic

** Tainted: P (1)
* Proprietary module has been loaded.

** Kernel log:
[ =A0732.060050] ali_stimer_read: stimer is not ready.
[ =A0732.316048] ali_stimer_read: stimer is not ready.
[ =A0732.572049] ali_stimer_read: stimer is not ready.
[ =A0732.828049] ali_stimer_read: stimer is not ready.
[ =A0733.084080] ali_stimer_read: stimer is not ready.
[ =A0733.340048] ali_stimer_read: stimer is not ready.
[ =A0733.596050] ali_stimer_read: stimer is not ready.
[ =A0733.852459] ali_stimer_read: stimer is not ready.
[ =A0734.108050] ali_stimer_read: stimer is not ready.
[ =A0734.364048] ali_stimer_read: stimer is not ready.
[ =A0734.620048] ali_stimer_read: stimer is not ready.
[ =A0734.876053] ali_stimer_read: stimer is not ready.
[ =A0735.132051] ali_stimer_read: stimer is not ready.
[ =A0735.388049] ali_stimer_read: stimer is not ready.
[ =A0735.644051] ali_stimer_read: stimer is not ready.
[ =A0735.900050] ali_stimer_read: stimer is not ready.
[ =A0736.156202] ali_stimer_read: stimer is not ready.
[ =A0736.412074] ali_stimer_read: stimer is not ready.
[ =A0736.668060] ali_stimer_read: stimer is not ready.
[ =A0786.632050] ali_stimer_read: stimer is not ready.
[ =A0786.888049] ali_stimer_read: stimer is not ready.
[ =A0787.144051] ali_stimer_read: stimer is not ready.
[ =A0787.400048] ali_stimer_read: stimer is not ready.
[ =A0787.656097] ali_stimer_read: stimer is not ready.
[ =A0787.912048] ali_stimer_read: stimer is not ready.
[ =A0788.168049] ali_stimer_read: stimer is not ready.
[ =A0788.424049] ali_stimer_read: stimer is not ready.
[ =A0788.680049] ali_stimer_read: stimer is not ready.
[ =A0788.936068] ali_stimer_read: stimer is not ready.
[ =A0789.192047] ali_stimer_read: stimer is not ready.
[ =A0789.448049] ali_stimer_read: stimer is not ready.
[ =A0789.704049] ali_stimer_read: stimer is not ready.
[ =A0789.960071] ali_stimer_read: stimer is not ready.
[ =A0790.216049] ali_stimer_read: stimer is not ready.
[ =A0790.472071] ali_stimer_read: stimer is not ready.
[ =A0790.728049] ali_stimer_read: stimer is not ready.
[ =A0790.984048] ali_stimer_read: stimer is not ready.
[ =A0791.240053] ali_stimer_read: stimer is not ready.
[ =A0791.496072] ali_stimer_read: stimer is not ready.
[ =A0791.752059] ali_stimer_read: stimer is not ready.
[ =A0792.008049] ali_stimer_read: stimer is not ready.
[ =A0792.264082] ali_stimer_read: stimer is not ready.
[ =A0792.520080] ali_stimer_read: stimer is not ready.
[ =A0792.776110] ali_stimer_read: stimer is not ready.
[ =A0793.032050] ali_stimer_read: stimer is not ready.
[ =A0793.288138] ali_stimer_read: stimer is not ready.
[ =A0793.544111] ali_stimer_read: stimer is not ready.
[ =A0793.800114] ali_stimer_read: stimer is not ready.
[ =A0794.056049] ali_stimer_read: stimer is not ready.
[ =A0794.312049] ali_stimer_read: stimer is not ready.
[ =A0794.568049] ali_stimer_read: stimer is not ready.
[ =A0794.824049] ali_stimer_read: stimer is not ready.
[ =A0795.080048] ali_stimer_read: stimer is not ready.
[ =A0795.336073] ali_stimer_read: stimer is not ready.
[ =A0795.592064] ali_stimer_read: stimer is not ready.
[ =A0795.848049] ali_stimer_read: stimer is not ready.
[ =A0796.104080] ali_stimer_read: stimer is not ready.
[ =A0796.360068] ali_stimer_read: stimer is not ready.
[ =A0796.616209] ali_stimer_read: stimer is not ready.
[ =A0796.872049] ali_stimer_read: stimer is not ready.
[ =A0797.128049] ali_stimer_read: stimer is not ready.
[ =A0797.384049] ali_stimer_read: stimer is not ready.
[ =A0797.640052] ali_stimer_read: stimer is not ready.
[ =A0797.896113] ali_stimer_read: stimer is not ready.
[ =A0798.152048] ali_stimer_read: stimer is not ready.
[ =A0798.408048] ali_stimer_read: stimer is not ready.
[ =A0798.664213] ali_stimer_read: stimer is not ready.
[ =A0798.920083] ali_stimer_read: stimer is not ready.
[ =A0799.176054] ali_stimer_read: stimer is not ready.
[ =A0799.433427] ali_stimer_read: stimer is not ready.
[ =A0799.688051] ali_stimer_read: stimer is not ready.
[ =A0799.944082] ali_stimer_read: stimer is not ready.
[ =A0800.200047] ali_stimer_read: stimer is not ready.
[ =A0800.456050] ali_stimer_read: stimer is not ready.
[ =A0800.712082] ali_stimer_read: stimer is not ready.
[ =A0800.968109] ali_stimer_read: stimer is not ready.
[ =A0801.224049] ali_stimer_read: stimer is not ready.
[ =A0801.480090] ali_stimer_read: stimer is not ready.
[ =A0801.736051] ali_stimer_read: stimer is not ready.
[ =A0801.992071] ali_stimer_read: stimer is not ready.
[ =A0802.248052] ali_stimer_read: stimer is not ready.
[ =A0802.504109] ali_stimer_read: stimer is not ready.
[ =A0802.760048] ali_stimer_read: stimer is not ready.
[ =A0803.016049] ali_stimer_read: stimer is not ready.
[ =A0803.272049] ali_stimer_read: stimer is not ready.
[ =A0803.528052] ali_stimer_read: stimer is not ready.
[ =A0803.784080] ali_stimer_read: stimer is not ready.
[ =A0804.040048] ali_stimer_read: stimer is not ready.
[ =A0804.296050] ali_stimer_read: stimer is not ready.
[ =A0804.552049] ali_stimer_read: stimer is not ready.
[ =A0804.808050] ali_stimer_read: stimer is not ready.
[ =A0805.064049] ali_stimer_read: stimer is not ready.
[ =A0805.320048] ali_stimer_read: stimer is not ready.
[ =A0805.576049] ali_stimer_read: stimer is not ready.
[ =A0805.832048] ali_stimer_read: stimer is not ready.
[ =A0806.088049] ali_stimer_read: stimer is not ready.
[ =A0806.344049] ali_stimer_read: stimer is not ready.
[ =A0806.600077] ali_stimer_read: stimer is not ready.
[ 1337.820270] reportbug[3574]: segfault at 78 ip b66212ab sp b5fc9460
error 4 in libpango-1.0.so.0.2600.2[b6602000+41000]
[ 1370.688336] reportbug[3629]: segfault at 7c ip b65ea6f5 sp b5f905b0
error 4 in libpango-1.0.so.0.2600.2[b65c9000+41000]

** Loaded modules:
Module =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Size =A0Used by
radeon =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0398727 =A02
ttm =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A026172 =A01 radeon
drm_kms_helper =A0 =A0 =A0 =A0 17247 =A01 radeon
drm =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 107671 =A05 radeon,ttm,drm_kms_help=
er
i2c_algo_bit =A0 =A0 =A0 =A0 =A0 =A03497 =A01 radeon
ppdev =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 4058 =A00
lp =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A05570 =A00
parport =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A022554 =A02 ppdev,lp
sco =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 5837 =A02
bridge =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 32983 =A00
stp =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0996 =A01 bridge
bnep =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A07444 =A02
rfcomm =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 25131 =A00
l2cap =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A021677 =A04 bnep,rfcomm
crc16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1027 =A01 l2cap
bluetooth =A0 =A0 =A0 =A0 =A0 =A0 =A036327 =A06 sco,bnep,rfcomm,l2cap
cisco_ipsec =A0 =A0 =A0 =A0 =A0 572479 =A00
acpi_cpufreq =A0 =A0 =A0 =A0 =A0 =A04943 =A00
speedstep_lib =A0 =A0 =A0 =A0 =A0 2468 =A00
cpufreq_conservative =A0 =A0 4018 =A00
cpufreq_stats =A0 =A0 =A0 =A0 =A0 1940 =A00
cpufreq_powersave =A0 =A0 =A0 =A0602 =A00
cpufreq_userspace =A0 =A0 =A0 1476 =A00
binfmt_misc =A0 =A0 =A0 =A0 =A0 =A0 4907 =A01
uinput =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A04796 =A01
fuse =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 43750 =A01
loop =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A09753 =A00
arc4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 974 =A02
ecb =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1405 =A02
rt61pci =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A015720 =A00
snd_ali5451 =A0 =A0 =A0 =A0 =A0 =A011793 =A01
crc_itu_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 1035 =A01 rt61pci
snd_ac97_codec =A0 =A0 =A0 =A0 79140 =A01 snd_ali5451
ac97_bus =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 710 =A01 snd_ac97_codec
rt2x00pci =A0 =A0 =A0 =A0 =A0 =A0 =A0 3773 =A01 rt61pci
snd_pcm_oss =A0 =A0 =A0 =A0 =A0 =A028671 =A00
rt2x00lib =A0 =A0 =A0 =A0 =A0 =A0 =A019025 =A02 rt61pci,rt2x00pci
snd_mixer_oss =A0 =A0 =A0 =A0 =A010461 =A01 snd_pcm_oss
led_class =A0 =A0 =A0 =A0 =A0 =A0 =A0 1757 =A01 rt2x00lib
snd_pcm =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A047362 =A03 snd_ali5451,snd_ac97_code=
c,snd_pcm_oss
mac80211 =A0 =A0 =A0 =A0 =A0 =A0 =A0122750 =A02 rt2x00pci,rt2x00lib
snd_seq_midi =A0 =A0 =A0 =A0 =A0 =A03576 =A00
snd_rawmidi =A0 =A0 =A0 =A0 =A0 =A012505 =A01 snd_seq_midi
cfg80211 =A0 =A0 =A0 =A0 =A0 =A0 =A0 87581 =A02 rt2x00lib,mac80211
rfkill =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 10260 =A04 bluetooth,cfg80211
snd_seq_midi_event =A0 =A0 =A03684 =A01 snd_seq_midi
eeprom_93cx6 =A0 =A0 =A0 =A0 =A0 =A0 963 =A01 rt61pci
snd_seq =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A035459 =A02 snd_seq_midi,snd_seq_midi=
_event
snd_timer =A0 =A0 =A0 =A0 =A0 =A0 =A012258 =A02 snd_pcm,snd_seq
i2c_ali1535 =A0 =A0 =A0 =A0 =A0 =A0 3974 =A00
i2c_ali15x3 =A0 =A0 =A0 =A0 =A0 =A0 4202 =A00
i2c_core =A0 =A0 =A0 =A0 =A0 =A0 =A0 12648 =A05 radeon,drm,i2c_algo_bit,i2c=
_ali1535,i2c_ali15x3
snd_seq_device =A0 =A0 =A0 =A0 =A03673 =A03 snd_seq_midi,snd_rawmidi,snd_seq
pcmcia =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 17442 =A00
snd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A034363 =A011
snd_ali5451,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_rawmidi,sn=
d_seq,snd_timer,snd_seq_device
container =A0 =A0 =A0 =A0 =A0 =A0 =A0 1833 =A00
joydev =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A06771 =A00
ac =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01640 =A00
battery =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 3782 =A00
shpchp =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 21220 =A00
alim1535_wdt =A0 =A0 =A0 =A0 =A0 =A02110 =A00
soundcore =A0 =A0 =A0 =A0 =A0 =A0 =A0 3450 =A01 snd
processor =A0 =A0 =A0 =A0 =A0 =A0 =A026571 =A01 acpi_cpufreq
yenta_socket =A0 =A0 =A0 =A0 =A0 16403 =A02
pci_hotplug =A0 =A0 =A0 =A0 =A0 =A018065 =A01 shpchp
snd_page_alloc =A0 =A0 =A0 =A0 =A05041 =A01 snd_pcm
rsrc_nonstatic =A0 =A0 =A0 =A0 =A07057 =A01 yenta_socket
pcmcia_core =A0 =A0 =A0 =A0 =A0 =A020446 =A03 pcmcia,yenta_socket,rsrc_nons=
tatic
pcspkr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01207 =A00
evdev =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 5609 =A023
psmouse =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A044413 =A00
serio_raw =A0 =A0 =A0 =A0 =A0 =A0 =A0 2916 =A00
ext3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 94192 =A02
jbd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A032161 =A01 ext3
mbcache =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 3762 =A01 ext3
ide_cd_mod =A0 =A0 =A0 =A0 =A0 =A0 21076 =A00
cdrom =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A026487 =A01 ide_cd_mod
ide_gd_mod =A0 =A0 =A0 =A0 =A0 =A0 17171 =A04
ide_pci_generic =A0 =A0 =A0 =A0 1924 =A00
ata_generic =A0 =A0 =A0 =A0 =A0 =A0 2015 =A00
libata =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0114408 =A01 ata_generic
scsi_mod =A0 =A0 =A0 =A0 =A0 =A0 =A0101297 =A01 libata
8139cp =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 13417 =A00
ohci_hcd =A0 =A0 =A0 =A0 =A0 =A0 =A0 16904 =A00
ehci_hcd =A0 =A0 =A0 =A0 =A0 =A0 =A0 27574 =A00
alim15x3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A04280 =A03
8139too =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A014945 =A00
video =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A014605 =A00
ali_agp =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 3046 =A01
usbcore =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A098126 =A03 ohci_hcd,ehci_hcd
floppy =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 40923 =A00
output =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01204 =A01 video
mii =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 2714 =A02 8139cp,8139too
ide_core =A0 =A0 =A0 =A0 =A0 =A0 =A0 64146 =A04 ide_cd_mod,ide_gd_mod,ide_p=
ci_generic,alim15x3
nls_base =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A04541 =A01 usbcore
agpgart =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A019516 =A03 ttm,drm,ali_agp
button =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A03598 =A00
thermal =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 9206 =A00
fan =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 2586 =A00
thermal_sys =A0 =A0 =A0 =A0 =A0 =A0 9378 =A04 processor,video,thermal,fan

** PCI devices:
00:00.0 Host bridge [0600]: ALi Corporation M1671 Super P4 Northbridge
[AGP4X,PCI and SDR/DDR] [10b9:1671] (rev 02)
Subsystem: Hewlett-Packard Company Device [103c:0027]
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR+ INTx-
Latency: 0
Region 0: Memory at f0000000 (32-bit, prefetchable) [size=3D128M]
Capabilities: <access denied>
Kernel driver in use: agpgart-ali

00:01.0 PCI bridge [0604]: ALi Corporation PCI to AGP Controller
[10b9:5247] (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
I/O behind bridge: 00009000-00009fff
Memory behind bridge: e0100000-e01fffff
Prefetchable memory behind bridge: e8000000-efffffff
Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-

00:02.0 USB Controller [0c03]: ALi Corporation USB 1.1 Controller
[10b9:5237] (rev 03) (prog-if 10 [OHCI])
Subsystem: Hewlett-Packard Company Device [103c:0027]
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 64 (20000ns max), Cache Line Size: 32 bytes
Interrupt: pin A routed to IRQ 10
Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=3D4K]
Capabilities: <access denied>
Kernel driver in use: ohci_hcd

00:04.0 Multimedia audio controller [0401]: ALi Corporation M5451 PCI
AC-Link Controller Audio Device [10b9:5451] (rev 02)
Subsystem: Hewlett-Packard Company Device [103c:0027]
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR+ <PERR+ INTx-
Latency: 64 (500ns min, 6000ns max)
Interrupt: pin A routed to IRQ 11
Region 0: I/O ports at 1000 [size=3D256]
Region 1: Memory at e0001000 (32-bit, non-prefetchable) [size=3D4K]
Capabilities: <access denied>
Kernel driver in use: ALI 5451

00:06.0 Bridge [0680]: ALi Corporation M7101 Power Management
Controller [PMU] [10b9:7101]
Subsystem: Hewlett-Packard Company Device [103c:0027]
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Kernel driver in use: ali1535_smbus

00:07.0 ISA bridge [0601]: ALi Corporation M1533/M1535/M1543 PCI to
ISA Bridge [Aladdin IV/V/V+] [10b9:1533]
Subsystem: Hewlett-Packard Company Device [103c:0027]
Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Capabilities: <access denied>

00:08.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ [10ec:8139] (rev 10)
Subsystem: Hewlett-Packard Company Device [103c:0027]
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+ INTx-
Latency: 64 (8000ns min, 16000ns max)
Interrupt: pin A routed to IRQ 10
Region 0: I/O ports at 1400 [size=3D256]
Region 1: Memory at e0002000 (32-bit, non-prefetchable) [size=3D256]
Capabilities: <access denied>
Kernel driver in use: 8139too

00:0a.0 CardBus bridge [0607]: Texas Instruments PCI1410 PC card
Cardbus Controller [104c:ac50] (rev 02)
Subsystem: Hewlett-Packard Company Device [103c:0027]
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 168, Cache Line Size: 32 bytes
Interrupt: pin A routed to IRQ 11
Region 0: Memory at 28000000 (32-bit, non-prefetchable) [size=3D4K]
Bus: primary=3D00, secondary=3D02, subordinate=3D05, sec-latency=3D176
Memory window 0: 20000000-23fff000 (prefetchable)
Memory window 1: 24000000-27fff000
I/O window 0: 00001c00-00001cff
I/O window 1: 00002000-000020ff
BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
16-bit legacy interface ports at 0001
Kernel driver in use: yenta_cardbus

00:0f.0 IDE interface [0101]: ALi Corporation M5229 IDE [10b9:5229]
(rev c4) (prog-if fa)
Subsystem: Hewlett-Packard Company Device [103c:0027]
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 64 (500ns min, 1000ns max)
Interrupt: pin A routed to IRQ 255
Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [size=3D8]
Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable) [size=3D1]
Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [size=3D8]
Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [size=3D1]
Region 4: I/O ports at 1800 [size=3D16]
Capabilities: <access denied>
Kernel driver in use: ALI15x3_IDE

01:00.0 VGA compatible controller [0300]: ATI Technologies Inc Radeon
Mobility M6 LY [1002:4c59] (prog-if 00 [VGA controller])
Subsystem: Hewlett-Packard Company Device [103c:0027]
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR+ FastB2B+ DisINTx-
Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 66 (2000ns min), Cache Line Size: 32 bytes
Interrupt: pin A routed to IRQ 11
Region 0: Memory at e8000000 (32-bit, prefetchable) [size=3D128M]
Region 1: I/O ports at 9000 [size=3D256]
Region 2: Memory at e0100000 (32-bit, non-prefetchable) [size=3D64K]
[virtual] Expansion ROM at e0120000 [disabled] [size=3D128K]
Capabilities: <access denied>

02:00.0 Network controller [0280]: RaLink RT2561/RT61 802.11g PCI [1814:030=
1]
Subsystem: RaLink EW-7108PCg [1814:2561]
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 64, Cache Line Size: 128 bytes
Interrupt: pin A routed to IRQ 11
Region 0: Memory at 24000000 (32-bit, non-prefetchable) [size=3D32K]
Capabilities: <access denied>
Kernel driver in use: rt61pci


** USB devices:
Bus 001 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub


-- System Information:
Debian Release: squeeze/sid
=A0APT prefers testing
=A0APT policy: (500, 'testing')
Architecture: i386 (i686)

Kernel: Linux 2.6.32-3-686 (SMP w/1 CPU core)
Locale: LANG=3Dfi_FI.UTF-8, LC_CTYPE=3Dfi_FI.UTF-8 (charmap=3DUTF-8)
Shell: /bin/sh linked to /bin/dash



*** /home/rami/Desktop/alsa-info_before_suspend.txt
upload=3Dtrue&script=3Dtrue&cardinfo=3D
!!################################
!!ALSA Information Script v 0.4.59
!!################################

!!Script ran on: Mon Apr =A05 16:31:34 UTC 2010


!!Linux Distribution
!!------------------

Debian GNU/Linux squeeze/sid \n \l


!!DMI Information
!!---------------

Manufacturer: =A0 =A0 =A0Hewlett-Packard
Product Name: =A0 =A0 =A0HP OmniBook PC


!!Kernel Information
!!------------------

Kernel release: =A0 =A02.6.32-3-686
Operating System: =A0GNU/Linux
Architecture: =A0 =A0 =A0i686
Processor: =A0 =A0 =A0 =A0 unknown
SMP Enabled: =A0 =A0 =A0 Yes


!!ALSA Version
!!------------

Driver version: =A0 =A0 1.0.21
Library version: =A0 =A01.0.22
Utilities version: =A01.0.22


!!Loaded ALSA modules
!!-------------------

snd_ali5451


!!Sound Servers on this system
!!----------------------------

No sound servers found.


!!Soundcards recognised by ALSA
!!-----------------------------

0 [A5451 =A0 =A0 =A0 =A0 =A0]: ALI5451 - ALI 5451
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ALI 5451 at 0x1000, irq 11


!!PCI Soundcards installed in the system
!!--------------------------------------

00:04.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link
Controller Audio Device (rev 02)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:04.0 0401: 10b9:5451 (rev 02)
Subsystem: 103c:0027


!!Modprobe options (Sound related)
!!--------------------------------

snd-atiixp-modem: index=3D-2
snd-intel8x0m: index=3D-2
snd-via82xx-modem: index=3D-2
snd-pcsp: index=3D-2
snd-atiixp-modem: index=3D-2
snd-intel8x0m: index=3D-2
snd-via82xx-modem: index=3D-2
snd-pcsp: index=3D-2


!!Loaded sound module options
!!--------------------------

!!Module: snd_ali5451
enable : N
id : <NULL>
index : -1
pcm_channels : 32
spdif : N


!!AC97 Codec information
!!---------------------------
--startcollapse--

0-0/0: Realtek ALC200,200P rev 0

PCI Subsys Vendor: 0x0000
PCI Subsys Device: 0x0000

Flags: 0
Capabilities =A0 =A0 : -headphone out-
DAC resolution =A0 : 18-bit
ADC resolution =A0 : 18-bit
3D enhancement =A0 : Realtek 3D Stereo Enhancement

Current setup
Mic gain =A0 =A0 =A0 =A0 : +0dB [+0dB]
POP path =A0 =A0 =A0 =A0 : pre 3D
Sim. stereo =A0 =A0 =A0: off
3D enhancement =A0 : off
Loudness =A0 =A0 =A0 =A0 : off
Mono output =A0 =A0 =A0: MIX
Mic select =A0 =A0 =A0 : Mic2
ADC/DAC loopback : off
Extended ID =A0 =A0 =A0: codec=3D0 rev=3D1 AMAP DSA=3D0 SPDIF VRA
Extended status =A0: SPCV SPDIF=3D3/4 VRA
PCM front DAC =A0 =A0: 48000Hz
PCM ADC =A0 =A0 =A0 =A0 =A0: 48000Hz
SPDIF Control =A0 =A0: Consumer PCM Category=3D0x2 Generation=3D1 Rate=3D48=
kHz

0:00 =3D 5950
0:02 =3D 0a0a
0:04 =3D 0000
0:06 =3D 000e
0:08 =3D 0000
0:0a =3D 000e
0:0c =3D 801f
0:0e =3D 801f
0:10 =3D 9f1f
0:12 =3D 8808
0:14 =3D 9f1f
0:16 =3D 9f1f
0:18 =3D 0808
0:1a =3D 0000
0:1c =3D 8000
0:1e =3D 0000
0:20 =3D 0100
0:22 =3D 0000
0:24 =3D 0000
0:26 =3D 800f
0:28 =3D 0605
0:2a =3D 0401
0:2c =3D bb80
0:2e =3D 0000
0:30 =3D 0000
0:32 =3D bb80
0:34 =3D 0000
0:36 =3D 0000
0:38 =3D 0000
0:3a =3D 2824
0:3c =3D 0000
0:3e =3D 0000
0:40 =3D 0000
0:42 =3D 0000
0:44 =3D 0000
0:46 =3D 0000
0:48 =3D 0000
0:4a =3D 0000
0:4c =3D 0000
0:4e =3D 0000
0:50 =3D 0000
0:52 =3D 0000
0:54 =3D 0000
0:56 =3D 0000
0:58 =3D 0000
0:5a =3D 0000
0:5c =3D 0000
0:5e =3D 0000
0:60 =3D 0000
0:62 =3D 0000
0:64 =3D 0000
0:66 =3D 0000
0:68 =3D 0000
0:6a =3D 0000
0:6c =3D 0000
0:6e =3D 0013
0:70 =3D 8210
0:72 =3D 6aa9
0:74 =3D 0062
0:76 =3D 1f0f
0:78 =3D 0000
0:7a =3D 57c2
0:7c =3D 414c
0:7e =3D 4710
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116, 6 Apr =A05 19:22 /dev/snd/controlC0
crw-rw----+ 1 root audio 116, 5 Apr =A05 19:22 /dev/snd/pcmC0D0c
crw-rw----+ 1 root audio 116, 4 Apr =A05 19:22 /dev/snd/pcmC0D0p
crw-rw----+ 1 root audio 116, 3 Apr =A05 19:22 /dev/snd/seq
crw-rw----+ 1 root audio 116, 2 Apr =A05 19:22 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root =A060 Apr =A05 19:22 .
drwxr-xr-x 3 root root 160 Apr =A05 19:22 ..
lrwxrwxrwx 1 root root =A012 Apr =A05 19:22 pci-0000:00:04.0 -> ../controlC0


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: A5451 [ALI 5451], device 0: ALI 5451 [ALI 5451]
=A0Subdevices: 32/32
=A0Subdevice #0: subdevice #0
=A0Subdevice #1: subdevice #1
=A0Subdevice #2: subdevice #2
=A0Subdevice #3: subdevice #3
=A0Subdevice #4: subdevice #4
=A0Subdevice #5: subdevice #5
=A0Subdevice #6: subdevice #6
=A0Subdevice #7: subdevice #7
=A0Subdevice #8: subdevice #8
=A0Subdevice #9: subdevice #9
=A0Subdevice #10: subdevice #10
=A0Subdevice #11: subdevice #11
=A0Subdevice #12: subdevice #12
=A0Subdevice #13: subdevice #13
=A0Subdevice #14: subdevice #14
=A0Subdevice #15: subdevice #15
=A0Subdevice #16: subdevice #16
=A0Subdevice #17: subdevice #17
=A0Subdevice #18: subdevice #18
=A0Subdevice #19: subdevice #19
=A0Subdevice #20: subdevice #20
=A0Subdevice #21: subdevice #21
=A0Subdevice #22: subdevice #22
=A0Subdevice #23: subdevice #23
=A0Subdevice #24: subdevice #24
=A0Subdevice #25: subdevice #25
=A0Subdevice #26: subdevice #26
=A0Subdevice #27: subdevice #27
=A0Subdevice #28: subdevice #28
=A0Subdevice #29: subdevice #29
=A0Subdevice #30: subdevice #30
=A0Subdevice #31: subdevice #31

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: A5451 [ALI 5451], device 0: ALI 5451 [ALI 5451]
=A0Subdevices: 1/1
=A0Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [A5451]

Card hw:0 'A5451'/'ALI 5451 at 0x1000, irq 11'
=A0Mixer name : 'Realtek ALC200,200P rev 0'
=A0Components : 'AC97a:414c4710'
=A0Controls =A0 =A0 =A0: 37
=A0Simple ctrls =A0: 23
Simple mixer control 'Master',0
=A0Capabilities: pvolume pswitch pswitch-joined penum
=A0Playback channels: Front Left - Front Right
=A0Limits: Playback 0 - 31
=A0Mono:
=A0Front Left: Playback 21 [68%] [-15.00dB] [on]
=A0Front Right: Playback 21 [68%] [-15.00dB] [on]
Simple mixer control 'Master Mono',0
=A0Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
=A0Playback channels: Mono
=A0Limits: Playback 0 - 31
=A0Mono: Playback 17 [55%] [-21.00dB] [on]
Simple mixer control 'Headphone',0
=A0Capabilities: pvolume pswitch pswitch-joined penum
=A0Playback channels: Front Left - Front Right
=A0Limits: Playback 0 - 31
=A0Mono:
=A0Front Left: Playback 31 [100%] [0.00dB] [on]
=A0Front Right: Playback 31 [100%] [0.00dB] [on]
Simple mixer control '3D Control - Center',0
=A0Capabilities: volume volume-joined penum
=A0Playback channels: Mono
=A0Capture channels: Mono
=A0Limits: 0 - 15
=A0Mono: 0 [0%]
Simple mixer control '3D Control - Depth',0
=A0Capabilities: volume volume-joined penum
=A0Playback channels: Mono
=A0Capture channels: Mono
=A0Limits: 0 - 15
=A0Mono: 0 [0%]
Simple mixer control '3D Control - Switch',0
=A0Capabilities: pswitch pswitch-joined penum
=A0Playback channels: Mono
=A0Mono: Playback [off]
Simple mixer control 'PCM',0
=A0Capabilities: pvolume pswitch pswitch-joined penum
=A0Playback channels: Front Left - Front Right
=A0Limits: Playback 0 - 31
=A0Mono:
=A0Front Left: Playback 23 [74%] [0.00dB] [on]
=A0Front Right: Playback 23 [74%] [0.00dB] [on]
Simple mixer control 'Line',0
=A0Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive p=
enum
=A0Capture exclusive group: 0
=A0Playback channels: Front Left - Front Right
=A0Capture channels: Front Left - Front Right
=A0Limits: Playback 0 - 31
=A0Front Left: Playback 0 [0%] [-34.50dB] [off] Capture [off]
=A0Front Right: Playback 0 [0%] [-34.50dB] [off] Capture [off]
Simple mixer control 'CD',0
=A0Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive p=
enum
=A0Capture exclusive group: 0
=A0Playback channels: Front Left - Front Right
=A0Capture channels: Front Left - Front Right
=A0Limits: Playback 0 - 31
=A0Front Left: Playback 23 [74%] [0.00dB] [off] Capture [off]
=A0Front Right: Playback 23 [74%] [0.00dB] [off] Capture [off]
Simple mixer control 'Mic',0
=A0Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch
cswitch-exclusive penum
=A0Capture exclusive group: 0
=A0Playback channels: Mono
=A0Capture channels: Front Left - Front Right
=A0Limits: Playback 0 - 31
=A0Mono: Playback 0 [0%] [-34.50dB] [off]
=A0Front Left: Capture [on]
=A0Front Right: Capture [on]
Simple mixer control 'Mic Boost (+20dB)',0
=A0Capabilities: pswitch pswitch-joined penum
=A0Playback channels: Mono
=A0Mono: Playback [off]
Simple mixer control 'Mic Select',0
=A0Capabilities: enum
=A0Items: 'Mic1' 'Mic2'
=A0Item0: 'Mic2'
Simple mixer control 'Video',0
=A0Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive p=
enum
=A0Capture exclusive group: 0
=A0Playback channels: Front Left - Front Right
=A0Capture channels: Front Left - Front Right
=A0Limits: Playback 0 - 31
=A0Front Left: Playback 0 [0%] [-34.50dB] [off] Capture [off]
=A0Front Right: Playback 0 [0%] [-34.50dB] [off] Capture [off]
Simple mixer control 'Phone',0
=A0Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch
cswitch-exclusive penum
=A0Capture exclusive group: 0
=A0Playback channels: Mono
=A0Capture channels: Front Left - Front Right
=A0Limits: Playback 0 - 31
=A0Mono: Playback 0 [0%] [-34.50dB] [off]
=A0Front Left: Capture [off]
=A0Front Right: Capture [off]
Simple mixer control 'IEC958',0
=A0Capabilities: pswitch pswitch-joined penum
=A0Playback channels: Mono
=A0Mono: Playback [off]
Simple mixer control 'IEC958 Playback AC97-SPSA',0
=A0Capabilities: volume volume-joined penum
=A0Playback channels: Mono
=A0Capture channels: Mono
=A0Limits: 0 - 3
=A0Mono: 0 [0%]
Simple mixer control 'PC Speaker',0
=A0Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
=A0Playback channels: Mono
=A0Limits: Playback 0 - 15
=A0Mono: Playback 8 [53%] [-21.00dB] [on]
Simple mixer control 'Aux',0
=A0Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive p=
enum
=A0Capture exclusive group: 0
=A0Playback channels: Front Left - Front Right
=A0Capture channels: Front Left - Front Right
=A0Limits: Playback 0 - 31
=A0Front Left: Playback 0 [0%] [-34.50dB] [off] Capture [off]
=A0Front Right: Playback 0 [0%] [-34.50dB] [off] Capture [off]
Simple mixer control 'Mono Output Select',0
=A0Capabilities: enum
=A0Items: 'Mix' 'Mic'
=A0Item0: 'Mix'
Simple mixer control 'Capture',0
=A0Capabilities: cvolume cswitch cswitch-joined penum
=A0Capture channels: Front Left - Front Right
=A0Limits: Capture 0 - 15
=A0Front Left: Capture 0 [0%] [0.00dB] [off]
=A0Front Right: Capture 0 [0%] [0.00dB] [off]
Simple mixer control 'Mix',0
=A0Capabilities: cswitch cswitch-exclusive penum
=A0Capture exclusive group: 0
=A0Capture channels: Front Left - Front Right
=A0Front Left: Capture [off]
=A0Front Right: Capture [off]
Simple mixer control 'Mix Mono',0
=A0Capabilities: cswitch cswitch-exclusive penum
=A0Capture exclusive group: 0
=A0Capture channels: Front Left - Front Right
=A0Front Left: Capture [off]
=A0Front Right: Capture [off]
Simple mixer control 'External Amplifier',0
=A0Capabilities: pswitch pswitch-joined penum
=A0Playback channels: Mono
=A0Mono: Playback [off]


!!Alsactl output
!!-------------

--startcollapse--
state.A5451 {
control.1 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name 'Master Playback Switch'
value true
}
control.2 {
comment.access 'read write'
comment.type INTEGER
comment.count 2
comment.range '0 - 31'
comment.dbmin -4650
comment.dbmax 0
iface MIXER
name 'Master Playback Volume'
value.0 21
value.1 21
}
control.3 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name 'Headphone Playback Switch'
value true
}
control.4 {
comment.access 'read write'
comment.type INTEGER
comment.count 2
comment.range '0 - 31'
comment.dbmin -4650
comment.dbmax 0
iface MIXER
name 'Headphone Playback Volume'
value.0 31
value.1 31
}
control.5 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name 'Master Mono Playback Switch'
value true
}
control.6 {
comment.access 'read write'
comment.type INTEGER
comment.count 1
comment.range '0 - 31'
comment.dbmin -4650
comment.dbmax 0
iface MIXER
name 'Master Mono Playback Volume'
value 17
}
control.7 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name 'PC Speaker Playback Switch'
value true
}
control.8 {
comment.access 'read write'
comment.type INTEGER
comment.count 1
comment.range '0 - 15'
comment.dbmin -4500
comment.dbmax 0
iface MIXER
name 'PC Speaker Playback Volume'
value 8
}
control.9 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name 'Phone Playback Switch'
value false
}
control.10 {
comment.access 'read write'
comment.type INTEGER
comment.count 1
comment.range '0 - 31'
comment.dbmin -3450
comment.dbmax 1200
iface MIXER
name 'Phone Playback Volume'
value 0
}
control.11 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name 'Mic Playback Switch'
value false
}
control.12 {
comment.access 'read write'
comment.type INTEGER
comment.count 1
comment.range '0 - 31'
comment.dbmin -3450
comment.dbmax 1200
iface MIXER
name 'Mic Playback Volume'
value 0
}
control.13 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name 'Mic Boost (+20dB)'
value false
}
control.14 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name 'Line Playback Switch'
value false
}
control.15 {
comment.access 'read write'
comment.type INTEGER
comment.count 2
comment.range '0 - 31'
comment.dbmin -3450
comment.dbmax 1200
iface MIXER
name 'Line Playback Volume'
value.0 0
value.1 0
}
control.16 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name 'CD Playback Switch'
value false
}
control.17 {
comment.access 'read write'
comment.type INTEGER
comment.count 2
comment.range '0 - 31'
comment.dbmin -3450
comment.dbmax 1200
iface MIXER
name 'CD Playback Volume'
value.0 23
value.1 23
}
control.18 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name 'Video Playback Switch'
value false
}
control.19 {
comment.access 'read write'
comment.type INTEGER
comment.count 2
comment.range '0 - 31'
comment.dbmin -3450
comment.dbmax 1200
iface MIXER
name 'Video Playback Volume'
value.0 0
value.1 0
}
control.20 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name 'Aux Playback Switch'
value false
}
control.21 {
comment.access 'read write'
comment.type INTEGER
comment.count 2
comment.range '0 - 31'
comment.dbmin -3450
comment.dbmax 1200
iface MIXER
name 'Aux Playback Volume'
value.0 0
value.1 0
}
control.22 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name 'PCM Playback Switch'
value true
}
control.23 {
comment.access 'read write'
comment.type INTEGER
comment.count 2
comment.range '0 - 31'
comment.dbmin -3450
comment.dbmax 1200
iface MIXER
name 'PCM Playback Volume'
value.0 23
value.1 23
}
control.24 {
comment.access 'read write'
comment.type ENUMERATED
comment.count 2
comment.item.0 Mic
comment.item.1 CD
comment.item.2 Video
comment.item.3 Aux
comment.item.4 Line
comment.item.5 Mix
comment.item.6 'Mix Mono'
comment.item.7 Phone
iface MIXER
name 'Capture Source'
value.0 Mic
value.1 Mic
}
control.25 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name 'Capture Switch'
value false
}
control.26 {
comment.access 'read write'
comment.type INTEGER
comment.count 2
comment.range '0 - 15'
comment.dbmin 0
comment.dbmax 2250
iface MIXER
name 'Capture Volume'
value.0 0
value.1 0
}
control.27 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name '3D Control - Switch'
value false
}
control.28 {
comment.access 'read write'
comment.type ENUMERATED
comment.count 1
comment.item.0 Mix
comment.item.1 Mic
iface MIXER
name 'Mono Output Select'
value Mix
}
control.29 {
comment.access 'read write'
comment.type ENUMERATED
comment.count 1
comment.item.0 Mic1
comment.item.1 Mic2
iface MIXER
name 'Mic Select'
value Mic2
}
control.30 {
comment.access 'read write'
comment.type INTEGER
comment.count 1
comment.range '0 - 15'
iface MIXER
name '3D Control - Center'
value 0
}
control.31 {
comment.access 'read write'
comment.type INTEGER
comment.count 1
comment.range '0 - 15'
iface MIXER
name '3D Control - Depth'
value 0
}
control.32 {
comment.access read
comment.type IEC958
comment.count 1
iface MIXER
name 'IEC958 Playback Con Mask'
value '0fff000f000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000'
}
control.33 {
comment.access read
comment.type IEC958
comment.count 1
iface MIXER
name 'IEC958 Playback Pro Mask'
value cf0000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000
}
control.34 {
comment.access 'read write'
comment.type IEC958
comment.count 1
iface MIXER
name 'IEC958 Playback Default'
value '00820002000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000'
}
control.35 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name 'IEC958 Playback Switch'
value false
}
control.36 {
comment.access 'read write'
comment.type INTEGER
comment.count 1
comment.range '0 - 3'
iface MIXER
name 'IEC958 Playback AC97-SPSA'
value 0
}
control.37 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name 'External Amplifier'
value false
}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
radeon
ttm
drm_kms_helper
drm
i2c_algo_bit
ppdev
lp
parport
sco
bridge
stp
bnep
rfcomm
l2cap
crc16
bluetooth
cisco_ipsec
acpi_cpufreq
speedstep_lib
cpufreq_conservative
cpufreq_stats
cpufreq_powersave
cpufreq_userspace
binfmt_misc
uinput
fuse
loop
arc4
ecb
rt61pci
snd_ali5451
crc_itu_t
snd_ac97_codec
ac97_bus
rt2x00pci
snd_pcm_oss
rt2x00lib
snd_mixer_oss
led_class
snd_pcm
mac80211
snd_seq_midi
snd_rawmidi
cfg80211
rfkill
snd_seq_midi_event
eeprom_93cx6
snd_seq
snd_timer
i2c_ali1535
i2c_ali15x3
i2c_core
snd_seq_device
pcmcia
snd
container
joydev
ac
battery
shpchp
alim1535_wdt
soundcore
processor
yenta_socket
pci_hotplug
snd_page_alloc
rsrc_nonstatic
pcmcia_core
pcspkr
evdev
psmouse
serio_raw
ext3
jbd
mbcache
ide_cd_mod
cdrom
ide_gd_mod
ide_pci_generic
ata_generic
libata
scsi_mod
8139cp
ohci_hcd
ehci_hcd
alim15x3
8139too
video
ali_agp
usbcore
floppy
output
mii
ide_core
nls_base
agpgart
button
thermal
fan
thermal_sys


!!ALSA/HDA dmesg
!!------------------




*** /home/rami/Desktop/alsa-info_after_suspend.txt
upload=3Dtrue&script=3Dtrue&cardinfo=3D
!!################################
!!ALSA Information Script v 0.4.59
!!################################

!!Script ran on: Mon Apr =A05 16:35:46 UTC 2010


!!Linux Distribution
!!------------------

Debian GNU/Linux squeeze/sid \n \l


!!DMI Information
!!---------------

Manufacturer: =A0 =A0 =A0Hewlett-Packard
Product Name: =A0 =A0 =A0HP OmniBook PC


!!Kernel Information
!!------------------

Kernel release: =A0 =A02.6.32-3-686
Operating System: =A0GNU/Linux
Architecture: =A0 =A0 =A0i686
Processor: =A0 =A0 =A0 =A0 unknown
SMP Enabled: =A0 =A0 =A0 Yes


!!ALSA Version
!!------------

Driver version: =A0 =A0 1.0.21
Library version: =A0 =A01.0.22
Utilities version: =A01.0.22


!!Loaded ALSA modules
!!-------------------

snd_ali5451


!!Sound Servers on this system
!!----------------------------

No sound servers found.


!!Soundcards recognised by ALSA
!!-----------------------------

0 [A5451 =A0 =A0 =A0 =A0 =A0]: ALI5451 - ALI 5451
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ALI 5451 at 0x1000, irq 11


!!PCI Soundcards installed in the system
!!--------------------------------------

00:04.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link
Controller Audio Device (rev 02)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:04.0 0401: 10b9:5451 (rev 02)
Subsystem: 103c:0027


!!Modprobe options (Sound related)
!!--------------------------------

snd-atiixp-modem: index=3D-2
snd-intel8x0m: index=3D-2
snd-via82xx-modem: index=3D-2
snd-pcsp: index=3D-2
snd-atiixp-modem: index=3D-2
snd-intel8x0m: index=3D-2
snd-via82xx-modem: index=3D-2
snd-pcsp: index=3D-2


!!Loaded sound module options
!!--------------------------

!!Module: snd_ali5451
enable : N
id : <NULL>
index : -1
pcm_channels : 32
spdif : N


!!AC97 Codec information
!!---------------------------
--startcollapse--

0-0/0: Realtek ALC200,200P rev 0

PCI Subsys Vendor: 0x0000
PCI Subsys Device: 0x0000

Flags: 0
Capabilities =A0 =A0 : -headphone out-
DAC resolution =A0 : 18-bit
ADC resolution =A0 : 18-bit
3D enhancement =A0 : Realtek 3D Stereo Enhancement

Current setup
Mic gain =A0 =A0 =A0 =A0 : +20dB [+0dB]
POP path =A0 =A0 =A0 =A0 : post 3D
Sim. stereo =A0 =A0 =A0: on
3D enhancement =A0 : on
Loudness =A0 =A0 =A0 =A0 : on
Mono output =A0 =A0 =A0: Mic
Mic select =A0 =A0 =A0 : Mic2
ADC/DAC loopback : on
Extended ID =A0 =A0 =A0: codec=3D3 rev=3D3 AMAP LDAC SDAC CDAC DSA=3D3 VRM =
SPDIF DRA VRA
Extended status =A0: PRL PRK PRJ PRI SPCV MADC LDAC SDAC CDAC
SPDIF=3D10/11 VRM SPDIF DRA VRA
PCM front DAC =A0 =A0: 65535Hz
PCM Surr DAC =A0 =A0 : 65535Hz
PCM LFE DAC =A0 =A0 =A0: 65535Hz
PCM ADC =A0 =A0 =A0 =A0 =A0: 65535Hz
PCM MIC ADC =A0 =A0 =A0: 65535Hz
SPDIF Control =A0 =A0: PRO Non-audio Preemph50/15 Category=3D0x7f
Generation=3D1 Rate=3D32kHz DRS Validity
Extended modem ID: codec=3D3 CID2 CID1 HSET LIN2 LIN1
Modem status =A0 =A0 : GPIO MREF ADC1 DAC1 ADC2 DAC2 HADC HDAC PRA(GPIO)
PRB(res) PRC(ADC1) PRD(DAC1) PRE(ADC2) PRF(DAC2) PRG(HADC) PRH(HDAC)
Line1 rate =A0 =A0 =A0 : 65535Hz
Line2 rate =A0 =A0 =A0 : 65535Hz
Headset rate =A0 =A0 : 65535Hz

0:00 =3D ffff
0:02 =3D ffff
0:04 =3D ffff
0:06 =3D ffff
0:08 =3D ffff
0:0a =3D ffff
0:0c =3D ffff
0:0e =3D ffff
0:10 =3D ffff
0:12 =3D ffff
0:14 =3D ffff
0:16 =3D ffff
0:18 =3D ffff
0:1a =3D ffff
0:1c =3D ffff
0:1e =3D ffff
0:20 =3D ffff
0:22 =3D ffff
0:24 =3D ffff
0:26 =3D ffff
0:28 =3D ffff
0:2a =3D ffff
0:2c =3D ffff
0:2e =3D ffff
0:30 =3D ffff
0:32 =3D ffff
0:34 =3D ffff
0:36 =3D ffff
0:38 =3D ffff
0:3a =3D ffff
0:3c =3D ffff
0:3e =3D ffff
0:40 =3D ffff
0:42 =3D ffff
0:44 =3D ffff
0:46 =3D ffff
0:48 =3D ffff
0:4a =3D ffff
0:4c =3D ffff
0:4e =3D ffff
0:50 =3D ffff
0:52 =3D ffff
0:54 =3D ffff
0:56 =3D ffff
0:58 =3D ffff
0:5a =3D ffff
0:5c =3D ffff
0:5e =3D ffff
0:60 =3D ffff
0:62 =3D ffff
0:64 =3D ffff
0:66 =3D ffff
0:68 =3D ffff
0:6a =3D ffff
0:6c =3D ffff
0:6e =3D ffff
0:70 =3D ffff
0:72 =3D ffff
0:74 =3D ffff
0:76 =3D ffff
0:78 =3D ffff
0:7a =3D ffff
0:7c =3D ffff
0:7e =3D ffff
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116, 6 Apr =A05 19:22 /dev/snd/controlC0
crw-rw----+ 1 root audio 116, 5 Apr =A05 19:22 /dev/snd/pcmC0D0c
crw-rw----+ 1 root audio 116, 4 Apr =A05 19:33 /dev/snd/pcmC0D0p
crw-rw----+ 1 root audio 116, 3 Apr =A05 19:22 /dev/snd/seq
crw-rw----+ 1 root audio 116, 2 Apr =A05 19:22 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root =A060 Apr =A05 19:22 .
drwxr-xr-x 3 root root 160 Apr =A05 19:22 ..
lrwxrwxrwx 1 root root =A012 Apr =A05 19:22 pci-0000:00:04.0 -> ../controlC0


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: A5451 [ALI 5451], device 0: ALI 5451 [ALI 5451]
=A0Subdevices: 32/32
=A0Subdevice #0: subdevice #0
=A0Subdevice #1: subdevice #1
=A0Subdevice #2: subdevice #2
=A0Subdevice #3: subdevice #3
=A0Subdevice #4: subdevice #4
=A0Subdevice #5: subdevice #5
=A0Subdevice #6: subdevice #6
=A0Subdevice #7: subdevice #7
=A0Subdevice #8: subdevice #8
=A0Subdevice #9: subdevice #9
=A0Subdevice #10: subdevice #10
=A0Subdevice #11: subdevice #11
=A0Subdevice #12: subdevice #12
=A0Subdevice #13: subdevice #13
=A0Subdevice #14: subdevice #14
=A0Subdevice #15: subdevice #15
=A0Subdevice #16: subdevice #16
=A0Subdevice #17: subdevice #17
=A0Subdevice #18: subdevice #18
=A0Subdevice #19: subdevice #19
=A0Subdevice #20: subdevice #20
=A0Subdevice #21: subdevice #21
=A0Subdevice #22: subdevice #22
=A0Subdevice #23: subdevice #23
=A0Subdevice #24: subdevice #24
=A0Subdevice #25: subdevice #25
=A0Subdevice #26: subdevice #26
=A0Subdevice #27: subdevice #27
=A0Subdevice #28: subdevice #28
=A0Subdevice #29: subdevice #29
=A0Subdevice #30: subdevice #30
=A0Subdevice #31: subdevice #31

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: A5451 [ALI 5451], device 0: ALI 5451 [ALI 5451]
=A0Subdevices: 1/1
=A0Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [A5451]

Card hw:0 'A5451'/'ALI 5451 at 0x1000, irq 11'
=A0Mixer name : 'Realtek ALC200,200P rev 0'
=A0Components : 'AC97a:414c4710'
=A0Controls =A0 =A0 =A0: 37
=A0Simple ctrls =A0: 23
Simple mixer control 'Master',0
=A0Capabilities: pvolume pswitch pswitch-joined penum
=A0Playback channels: Front Left - Front Right
=A0Limits: Playback 0 - 31
=A0Mono:
=A0Front Left: Playback 21 [68%] [-15.00dB] [on]
=A0Front Right: Playback 21 [68%] [-15.00dB] [on]
Simple mixer control 'Master Mono',0
=A0Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
=A0Playback channels: Mono
=A0Limits: Playback 0 - 31
=A0Mono: Playback 17 [55%] [-21.00dB] [on]
Simple mixer control 'Headphone',0
=A0Capabilities: pvolume pswitch pswitch-joined penum
=A0Playback channels: Front Left - Front Right
=A0Limits: Playback 0 - 31
=A0Mono:
=A0Front Left: Playback 31 [100%] [0.00dB] [on]
=A0Front Right: Playback 31 [100%] [0.00dB] [on]
Simple mixer control '3D Control - Center',0
=A0Capabilities: volume volume-joined penum
=A0Playback channels: Mono
=A0Capture channels: Mono
=A0Limits: 0 - 15
=A0Mono: 0 [0%]
Simple mixer control '3D Control - Depth',0
=A0Capabilities: volume volume-joined penum
=A0Playback channels: Mono
=A0Capture channels: Mono
=A0Limits: 0 - 15
=A0Mono: 0 [0%]
Simple mixer control '3D Control - Switch',0
=A0Capabilities: pswitch pswitch-joined penum
=A0Playback channels: Mono
=A0Mono: Playback [off]
Simple mixer control 'PCM',0
=A0Capabilities: pvolume pswitch pswitch-joined penum
=A0Playback channels: Front Left - Front Right
=A0Limits: Playback 0 - 31
=A0Mono:
=A0Front Left: Playback 23 [74%] [0.00dB] [on]
=A0Front Right: Playback 23 [74%] [0.00dB] [on]
Simple mixer control 'Line',0
=A0Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive p=
enum
=A0Capture exclusive group: 0
=A0Playback channels: Front Left - Front Right
=A0Capture channels: Front Left - Front Right
=A0Limits: Playback 0 - 31
=A0Front Left: Playback 0 [0%] [-34.50dB] [off] Capture [off]
=A0Front Right: Playback 0 [0%] [-34.50dB] [off] Capture [off]
Simple mixer control 'CD',0
=A0Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive p=
enum
=A0Capture exclusive group: 0
=A0Playback channels: Front Left - Front Right
=A0Capture channels: Front Left - Front Right
=A0Limits: Playback 0 - 31
=A0Front Left: Playback 23 [74%] [0.00dB] [off] Capture [off]
=A0Front Right: Playback 23 [74%] [0.00dB] [off] Capture [off]
Simple mixer control 'Mic',0
=A0Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch
cswitch-exclusive penum
=A0Capture exclusive group: 0
=A0Playback channels: Mono
=A0Capture channels: Front Left - Front Right
=A0Limits: Playback 0 - 31
=A0Mono: Playback 0 [0%] [-34.50dB] [off]
=A0Front Left: Capture [on]
=A0Front Right: Capture [on]
Simple mixer control 'Mic Boost (+20dB)',0
=A0Capabilities: pswitch pswitch-joined penum
=A0Playback channels: Mono
=A0Mono: Playback [off]
Simple mixer control 'Mic Select',0
=A0Capabilities: enum
=A0Items: 'Mic1' 'Mic2'
=A0Item0: 'Mic2'
Simple mixer control 'Video',0
=A0Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive p=
enum
=A0Capture exclusive group: 0
=A0Playback channels: Front Left - Front Right
=A0Capture channels: Front Left - Front Right
=A0Limits: Playback 0 - 31
=A0Front Left: Playback 0 [0%] [-34.50dB] [off] Capture [off]
=A0Front Right: Playback 0 [0%] [-34.50dB] [off] Capture [off]
Simple mixer control 'Phone',0
=A0Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch
cswitch-exclusive penum
=A0Capture exclusive group: 0
=A0Playback channels: Mono
=A0Capture channels: Front Left - Front Right
=A0Limits: Playback 0 - 31
=A0Mono: Playback 0 [0%] [-34.50dB] [off]
=A0Front Left: Capture [off]
=A0Front Right: Capture [off]
Simple mixer control 'IEC958',0
=A0Capabilities: pswitch pswitch-joined penum
=A0Playback channels: Mono
=A0Mono: Playback [off]
Simple mixer control 'IEC958 Playback AC97-SPSA',0
=A0Capabilities: volume volume-joined penum
=A0Playback channels: Mono
=A0Capture channels: Mono
=A0Limits: 0 - 3
=A0Mono: 0 [0%]
Simple mixer control 'PC Speaker',0
=A0Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
=A0Playback channels: Mono
=A0Limits: Playback 0 - 15
=A0Mono: Playback 8 [53%] [-21.00dB] [on]
Simple mixer control 'Aux',0
=A0Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive p=
enum
=A0Capture exclusive group: 0
=A0Playback channels: Front Left - Front Right
=A0Capture channels: Front Left - Front Right
=A0Limits: Playback 0 - 31
=A0Front Left: Playback 0 [0%] [-34.50dB] [off] Capture [off]
=A0Front Right: Playback 0 [0%] [-34.50dB] [off] Capture [off]
Simple mixer control 'Mono Output Select',0
=A0Capabilities: enum
=A0Items: 'Mix' 'Mic'
=A0Item0: 'Mix'
Simple mixer control 'Capture',0
=A0Capabilities: cvolume cswitch cswitch-joined penum
=A0Capture channels: Front Left - Front Right
=A0Limits: Capture 0 - 15
=A0Front Left: Capture 0 [0%] [0.00dB] [off]
=A0Front Right: Capture 0 [0%] [0.00dB] [off]
Simple mixer control 'Mix',0
=A0Capabilities: cswitch cswitch-exclusive penum
=A0Capture exclusive group: 0
=A0Capture channels: Front Left - Front Right
=A0Front Left: Capture [off]
=A0Front Right: Capture [off]
Simple mixer control 'Mix Mono',0
=A0Capabilities: cswitch cswitch-exclusive penum
=A0Capture exclusive group: 0
=A0Capture channels: Front Left - Front Right
=A0Front Left: Capture [off]
=A0Front Right: Capture [off]
Simple mixer control 'External Amplifier',0
=A0Capabilities: pswitch pswitch-joined penum
=A0Playback channels: Mono
=A0Mono: Playback [off]


!!Alsactl output
!!-------------

--startcollapse--
state.A5451 {
control.1 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name 'Master Playback Switch'
value true
}
control.2 {
comment.access 'read write'
comment.type INTEGER
comment.count 2
comment.range '0 - 31'
comment.dbmin -4650
comment.dbmax 0
iface MIXER
name 'Master Playback Volume'
value.0 21
value.1 21
}
control.3 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name 'Headphone Playback Switch'
value true
}
control.4 {
comment.access 'read write'
comment.type INTEGER
comment.count 2
comment.range '0 - 31'
comment.dbmin -4650
comment.dbmax 0
iface MIXER
name 'Headphone Playback Volume'
value.0 31
value.1 31
}
control.5 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name 'Master Mono Playback Switch'
value true
}
control.6 {
comment.access 'read write'
comment.type INTEGER
comment.count 1
comment.range '0 - 31'
comment.dbmin -4650
comment.dbmax 0
iface MIXER
name 'Master Mono Playback Volume'
value 17
}
control.7 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name 'PC Speaker Playback Switch'
value true
}
control.8 {
comment.access 'read write'
comment.type INTEGER
comment.count 1
comment.range '0 - 15'
comment.dbmin -4500
comment.dbmax 0
iface MIXER
name 'PC Speaker Playback Volume'
value 8
}
control.9 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name 'Phone Playback Switch'
value false
}
control.10 {
comment.access 'read write'
comment.type INTEGER
comment.count 1
comment.range '0 - 31'
comment.dbmin -3450
comment.dbmax 1200
iface MIXER
name 'Phone Playback Volume'
value 0
}
control.11 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name 'Mic Playback Switch'
value false
}
control.12 {
comment.access 'read write'
comment.type INTEGER
comment.count 1
comment.range '0 - 31'
comment.dbmin -3450
comment.dbmax 1200
iface MIXER
name 'Mic Playback Volume'
value 0
}
control.13 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name 'Mic Boost (+20dB)'
value false
}
control.14 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name 'Line Playback Switch'
value false
}
control.15 {
comment.access 'read write'
comment.type INTEGER
comment.count 2
comment.range '0 - 31'
comment.dbmin -3450
comment.dbmax 1200
iface MIXER
name 'Line Playback Volume'
value.0 0
value.1 0
}
control.16 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name 'CD Playback Switch'
value false
}
control.17 {
comment.access 'read write'
comment.type INTEGER
comment.count 2
comment.range '0 - 31'
comment.dbmin -3450
comment.dbmax 1200
iface MIXER
name 'CD Playback Volume'
value.0 23
value.1 23
}
control.18 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name 'Video Playback Switch'
value false
}
control.19 {
comment.access 'read write'
comment.type INTEGER
comment.count 2
comment.range '0 - 31'
comment.dbmin -3450
comment.dbmax 1200
iface MIXER
name 'Video Playback Volume'
value.0 0
value.1 0
}
control.20 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name 'Aux Playback Switch'
value false
}
control.21 {
comment.access 'read write'
comment.type INTEGER
comment.count 2
comment.range '0 - 31'
comment.dbmin -3450
comment.dbmax 1200
iface MIXER
name 'Aux Playback Volume'
value.0 0
value.1 0
}
control.22 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name 'PCM Playback Switch'
value true
}
control.23 {
comment.access 'read write'
comment.type INTEGER
comment.count 2
comment.range '0 - 31'
comment.dbmin -3450
comment.dbmax 1200
iface MIXER
name 'PCM Playback Volume'
value.0 23
value.1 23
}
control.24 {
comment.access 'read write'
comment.type ENUMERATED
comment.count 2
comment.item.0 Mic
comment.item.1 CD
comment.item.2 Video
comment.item.3 Aux
comment.item.4 Line
comment.item.5 Mix
comment.item.6 'Mix Mono'
comment.item.7 Phone
iface MIXER
name 'Capture Source'
value.0 Mic
value.1 Mic
}
control.25 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name 'Capture Switch'
value false
}
control.26 {
comment.access 'read write'
comment.type INTEGER
comment.count 2
comment.range '0 - 15'
comment.dbmin 0
comment.dbmax 2250
iface MIXER
name 'Capture Volume'
value.0 0
value.1 0
}
control.27 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name '3D Control - Switch'
value false
}
control.28 {
comment.access 'read write'
comment.type ENUMERATED
comment.count 1
comment.item.0 Mix
comment.item.1 Mic
iface MIXER
name 'Mono Output Select'
value Mix
}
control.29 {
comment.access 'read write'
comment.type ENUMERATED
comment.count 1
comment.item.0 Mic1
comment.item.1 Mic2
iface MIXER
name 'Mic Select'
value Mic2
}
control.30 {
comment.access 'read write'
comment.type INTEGER
comment.count 1
comment.range '0 - 15'
iface MIXER
name '3D Control - Center'
value 0
}
control.31 {
comment.access 'read write'
comment.type INTEGER
comment.count 1
comment.range '0 - 15'
iface MIXER
name '3D Control - Depth'
value 0
}
control.32 {
comment.access read
comment.type IEC958
comment.count 1
iface MIXER
name 'IEC958 Playback Con Mask'
value '0fff000f000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000'
}
control.33 {
comment.access read
comment.type IEC958
comment.count 1
iface MIXER
name 'IEC958 Playback Pro Mask'
value cf0000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000
}
control.34 {
comment.access 'read write'
comment.type IEC958
comment.count 1
iface MIXER
name 'IEC958 Playback Default'
value '00820002000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000'
}
control.35 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name 'IEC958 Playback Switch'
value false
}
control.36 {
comment.access 'read write'
comment.type INTEGER
comment.count 1
comment.range '0 - 3'
iface MIXER
name 'IEC958 Playback AC97-SPSA'
value 0
}
control.37 {
comment.access 'read write'
comment.type BOOLEAN
comment.count 1
iface MIXER
name 'External Amplifier'
value false
}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
radeon
ttm
drm_kms_helper
drm
i2c_algo_bit
ppdev
lp
parport
sco
bridge
stp
bnep
rfcomm
l2cap
crc16
bluetooth
cisco_ipsec
acpi_cpufreq
speedstep_lib
cpufreq_conservative
cpufreq_stats
cpufreq_powersave
cpufreq_userspace
binfmt_misc
uinput
fuse
loop
arc4
ecb
rt61pci
snd_ali5451
crc_itu_t
snd_ac97_codec
ac97_bus
rt2x00pci
snd_pcm_oss
rt2x00lib
snd_mixer_oss
led_class
snd_pcm
mac80211
snd_seq_midi
snd_rawmidi
cfg80211
rfkill
snd_seq_midi_event
eeprom_93cx6
snd_seq
snd_timer
i2c_ali1535
i2c_ali15x3
i2c_core
snd_seq_device
pcmcia
snd
container
joydev
ac
battery
shpchp
alim1535_wdt
soundcore
processor
yenta_socket
pci_hotplug
snd_page_alloc
rsrc_nonstatic
pcmcia_core
pcspkr
evdev
psmouse
serio_raw
ext3
jbd
mbcache
ide_cd_mod
cdrom
ide_gd_mod
ide_pci_generic
ata_generic
libata
scsi_mod
8139cp
ohci_hcd
ehci_hcd
alim15x3
8139too
video
ali_agp
usbcore
floppy
output
mii
ide_core
nls_base
agpgart
button
thermal
fan
thermal_sys


!!ALSA/HDA dmesg
!!------------------
