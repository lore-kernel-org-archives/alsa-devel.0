From: Felix Homann <fexpop@web.de>
Subject: Re: [PATCH - Fix Fast Track Ultra series: 44.1/88.1
 kHz 1/Fix playback/capture issues and related chrashes at 44100 Hz and
 88200 Hz for M-Audio Fast Track Ultra series.
Date: Thu, 08 Jul 2010 10:35:17 +0200
Message-ID: <4C358DC5.4010403@web.de>
References: <4C32E3B2.5080707@web.de>	<4C344340.8060804@web.de>	<4C3476BD.4090702@ladisch.de>	<4C347EF7.2030401@web.de>
	<4C348DC6.7070602@ladisch.de>	<4C34B177.1090500@web.de>
	<4C356F56.6010804@ladisch.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040701060204080802040509"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wp188.webpack.hosteurope.de (wp188.webpack.hosteurope.de
	[80.237.132.195])
	by alsa0.perex.cz (Postfix) with ESMTP id B6F06103892
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Jul 2010 10:35:18 +0200 (CEST)
In-Reply-To: <4C356F56.6010804@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Felix Homann <fexpop@web.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040701060204080802040509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I've attached the excerpts from /var/log/syslog with and without the 
FIXED_ENDPOINT quirk.

Please, let me know if you need further information.

Kind regards,

Felix



--------------040701060204080802040509
Content-Type: text/plain;
 name="log-fixed_endpoint_quirk.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="log-fixed_endpoint_quirk.txt"

Jul  8 10:18:41 yerbouti kernel: [  639.088015] usb 2-3: new high speed USB device using ehci_hcd and address 4
Jul  8 10:18:41 yerbouti kernel: [  639.221630] usb 2-3: config 1 interface 3 altsetting 0 bulk endpoint 0x7 has invalid maxpacket 8
Jul  8 10:18:41 yerbouti kernel: [  639.221635] usb 2-3: config 1 interface 3 altsetting 0 bulk endpoint 0x87 has invalid maxpacket 8
Jul  8 10:18:41 yerbouti kernel: [  639.222494] usb 2-3: New USB device found, idVendor=0763, idProduct=2081
Jul  8 10:18:41 yerbouti kernel: [  639.222497] usb 2-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Jul  8 10:18:41 yerbouti kernel: [  639.222500] usb 2-3: Product: Fast Track Ultra 8R
Jul  8 10:18:41 yerbouti kernel: [  639.222503] usb 2-3: Manufacturer: M-Audio
Jul  8 10:18:41 yerbouti kernel: [  639.222640] usb 2-3: configuration #1 chosen from 1 choice
Jul  8 10:18:41 yerbouti kernel: [  639.283129] rates 00000000: 44 ac 00 00 80 bb 00 00 88 58 01 00 00 77 01 00  D........X...w..
Jul  8 10:18:41 yerbouti kernel: [  639.283155] format 00000000: 78 aa 7b be 00 88 ff ff 78 aa 7b be 00 88 ff ff  x.{.....x.{.....
Jul  8 10:18:41 yerbouti kernel: [  639.283158] format 00000010: 00 00 00 00 01 00 00 00 08 00 00 00 00 00 00 00  ................
Jul  8 10:18:41 yerbouti kernel: [  639.283161] format 00000020: 00 00 00 00 01 00 00 00 01 01 01 01 01 00 00 00  ................
Jul  8 10:18:41 yerbouti kernel: [  639.283164] format 00000030: 38 01 00 00 c0 06 00 00 44 ac 00 00 00 77 01 00  8.......D....w..
Jul  8 10:18:41 yerbouti kernel: [  639.283167] format 00000040: 04 00 00 00 00 00 00 00 e8 b3 36 74 00 88 ff ff  ..........6t....
Jul  8 10:18:41 yerbouti kernel: [  639.283169] format 00000050: 00 00 00 00 00 00 00 00                          ........
Jul  8 10:18:41 yerbouti kernel: [  639.286004] rates 00000000: 44 ac 00 00 80 bb 00 00 88 58 01 00 00 77 01 00  D........X...w..
Jul  8 10:18:41 yerbouti kernel: [  639.286027] format 00000000: 00 ad 7b be 00 88 ff ff 00 ad 7b be 00 88 ff ff  ..{.......{.....
Jul  8 10:18:41 yerbouti kernel: [  639.286030] format 00000010: 00 00 00 00 01 00 00 00 08 00 00 00 00 00 00 00  ................
Jul  8 10:18:41 yerbouti kernel: [  639.286033] format 00000020: 00 00 00 00 02 00 00 00 01 01 01 81 01 00 00 00  ................
Jul  8 10:18:41 yerbouti kernel: [  639.286036] format 00000030: 38 01 00 00 c0 06 00 00 44 ac 00 00 00 77 01 00  8.......D....w..
Jul  8 10:18:41 yerbouti kernel: [  639.286039] format 00000040: 04 00 00 00 00 00 00 00 a8 bc 36 74 00 88 ff ff  ..........6t....
Jul  8 10:18:41 yerbouti kernel: [  639.286041] format 00000050: 00 00 00 00 00 00 00 00                          ........
Jul  8 10:18:41 yerbouti kernel: [  639.288261] usbcore: registered new interface driver snd-usb-audio


--------------040701060204080802040509
Content-Type: text/plain;
 name="log-without_fixed_endpoint_quirk.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="log-without_fixed_endpoint_quirk.txt"

Jul  8 09:56:19 yerbouti kernel: [ 2421.972028] usb 3-3: new high speed U=
SB device using ehci_hcd and address 4
Jul  8 09:56:20 yerbouti kernel: [ 2422.105561] usb 3-3: config 1 interfa=
ce 3 altsetting 0 bulk endpoint 0x7 has invalid maxpacket 8
Jul  8 09:56:20 yerbouti kernel: [ 2422.105566] usb 3-3: config 1 interfa=
ce 3 altsetting 0 bulk endpoint 0x87 has invalid maxpacket 8
Jul  8 09:56:20 yerbouti kernel: [ 2422.106425] usb 3-3: New USB device f=
ound, idVendor=3D0763, idProduct=3D2081
Jul  8 09:56:20 yerbouti kernel: [ 2422.106429] usb 3-3: New USB device s=
trings: Mfr=3D1, Product=3D2, SerialNumber=3D0
Jul  8 09:56:20 yerbouti kernel: [ 2422.106432] usb 3-3: Product: Fast Tr=
ack Ultra 8R
Jul  8 09:56:20 yerbouti kernel: [ 2422.106434] usb 3-3: Manufacturer: M-=
Audio
Jul  8 09:56:20 yerbouti kernel: [ 2422.106567] usb 3-3: configuration #1=
 chosen from 1 choice
Jul  8 09:56:20 yerbouti kernel: [ 2422.352132] BUG: unable to handle ker=
nel NULL pointer dereference at 00000000000006c0
Jul  8 09:56:20 yerbouti kernel: [ 2422.352139] IP: [<ffffffff81195868>] =
hex_dump_to_buffer+0x194/0x26e
Jul  8 09:56:20 yerbouti kernel: [ 2422.352150] PGD 87009067 PUD 96915067=
 PMD 0=20
Jul  8 09:56:20 yerbouti kernel: [ 2422.352154] Oops: 0000 [#1] SMP=20
Jul  8 09:56:20 yerbouti kernel: [ 2422.352158] last sysfs file: /sys/dev=
ices/pci0000:00/0000:00:1d.7/usb3/3-3/3-3:1.2/bInterfaceProtocol
Jul  8 09:56:20 yerbouti kernel: [ 2422.352166] CPU 1=20
Jul  8 09:56:20 yerbouti kernel: [ 2422.352168] Modules linked in: snd_us=
b_audio(+) snd_usbmidi_lib kvm_intel kvm nfsd lockd nfs_acl auth_rpcgss s=
unrpc exportfs deflate zlib_deflate ctr twofish twofish_common camellia s=
erpent blowfish cast5 des_generic cbc aes_x86_64 aes_generic xcbc cpufreq=
_userspace cpufreq_conservative rmd160 cpufreq_powersave sha256_generic c=
pufreq_stats sha1_generic hmac crypto_null af_key parport_pc ppdev lp par=
port sco bridge stp bnep rfcomm l2cap crc16 bluetooth rfkill uinput binfm=
t_misc dlm configfs fuse ide_generic ide_cd_mod ide_core vboxdrv videodev=
 v4l1_compat v4l2_compat_ioctl32 snd_seq_virmidi snd_seq_midi_emul acpi_c=
pufreq eeprom loop snd_hda_codec_atihdmi snd_hda_codec_idt snd_hda_intel =
snd_hda_codec snd_hwdep snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_dummy s=
nd_seq_oss snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_timer =
snd_seq_device snd i2c_i801 tpm_tis soundcore fglrx(P) i2c_core usblp psm=
ouse snd_page_alloc evdev button processor tpm tpm_bios dcdbas serio_raw =
ext3 j
Jul  8 09:56:20 yerbouti kernel: d mbcache dm_mod usb_storage sg sr_mod u=
sbhid sd_mod cdrom crc_t10dif hid ata_generic uhci_hcd thermal thermal_sy=
s ata_piix firewire_ohci firewire_core crc_itu_t e1000e ehci_hcd libata s=
csi_mod usbcore nls_base [last unloaded: scsi_wait_scan]
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254] Pid: 8230, comm: modprobe=
 Tainted: P           2.6.32-5-amd64 #1 Dell DM061                  =20
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254] RIP: 0010:[<ffffffff81195=
868>]  [<ffffffff81195868>] hex_dump_to_buffer+0x194/0x26e
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254] RSP: 0018:ffff8800615fb9e=
8  EFLAGS: 00010203
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254] RAX: 00000000000006c0 RBX=
: 0000000000000000 RCX: 0000000000000000
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254] RDX: 0000000000000000 RSI=
: 0000000000000001 RDI: 0000000000000010                                 =
          =20
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254] RBP: 00000000000006c0 R08=
: 0000000000000003 R09: 00000000000000c8                                 =
          =20
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254] R10: 0000000000000018 R11=
: dead000000100100 R12: 0000000000000000                                 =
          =20
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254] R13: 0000000000000010 R14=
: ffff8800615fba78 R15: ffffffff813a2755                                 =
          =20
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254] FS:  00007fcb78068700(000=
0) GS:ffff880001840000(0000) knlGS:0000000000000000                      =
          =20
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254] CS:  0010 DS: 0000 ES: 00=
00 CR0: 000000008005003b                                                 =
          =20
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254] CR2: 00000000000006c0 CR3=
: 0000000095236000 CR4: 00000000000026e0                                 =
          =20
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254] DR0: 0000000000000000 DR1=
: 0000000000000000 DR2: 0000000000000000
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254] DR3: 0000000000000000 DR6=
: 00000000ffff0ff0 DR7: 0000000000000400
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254] Process modprobe (pid: 82=
30, threadinfo ffff8800615fa000, task ffff88007539a350)
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254] Stack:
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254]  ffff880001855640 ffff880=
001855640 01ff88007539a350 00000000000000c8
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254] <0> 00000000000006c0 0000=
000000000010 00000000000006c0 0000000000000000
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254] <0> 0000000000000000 ffff=
ffffa04f8437 ffffffff813a2755 ffffffff811959dc
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254] Call Trace:
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254]  [<ffffffff811959dc>] ? p=
rint_hex_dump+0x9a/0x153
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254]  [<ffffffff8105a534>] ? t=
ry_to_del_timer_sync+0x63/0x6c
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254]  [<ffffffff8105a549>] ? d=
el_timer_sync+0xc/0x16
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254]  [<ffffffff812f98ab>] ? s=
chedule_timeout+0xad/0xdd
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254]  [<ffffffff8105a5c8>] ? p=
rocess_timeout+0x0/0x5
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254]  [<ffffffff810e7335>] ? _=
_kmalloc+0x12f/0x141
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254]  [<ffffffff81195ac4>] ? p=
rint_hex_dump_bytes+0x2f/0x37

Message from syslogd@yerbouti at Thu Jul  8 09:56:20 2010 ...
yerbouti kernel: [ 2422.352254] Call Trace:
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254]  [<ffffffffa04f0b51>] ? p=
arse_audio_format_rates_v1+0x1c1/0x223 [snd_usb_audio]
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254]  [<ffffffffa04f11ea>] ? s=
nd_usb_parse_audio_format+0x290/0x48a [snd_usb_audio]
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254]  [<ffffffffa04f1a82>] ? s=
nd_usb_parse_audio_endpoints+0x3b0/0x62e [snd_usb_audio]
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254]  [<ffffffffa04f1c52>] ? s=
nd_usb_parse_audio_endpoints+0x580/0x62e [snd_usb_audio]
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254]  [<ffffffffa04f0466>] ? c=
reate_standard_audio_quirk+0x13/0x58 [snd_usb_audio]
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254]  [<ffffffffa04f04ff>] ? c=
reate_composite_quirk+0x54/0x87 [snd_usb_audio]
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254]  [<ffffffffa04ec7ae>] ? u=
sb_audio_probe+0x463/0x661 [snd_usb_audio]
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254]  [<ffffffffa00107be>] ? u=
sb_match_one_id+0x23/0x7f [usbcore]
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254]  [<ffffffffa001174d>] ? u=
sb_probe_interface+0x107/0x156 [usbcore]
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254]  [<ffffffff8121f298>] ? d=
river_probe_device+0xa3/0x14b
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254]  [<ffffffff8121f38f>] ? _=
_driver_attach+0x4f/0x6f

Message from syslogd@yerbouti at Thu Jul  8 09:56:20 2010 ...
yerbouti kernel: [ 2422.352254] Stack:
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254]  [<ffffffff8121f340>] ? _=
_driver_attach+0x0/0x6f
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254]  [<ffffffff8121eb67>] ? b=
us_for_each_dev+0x43/0x74
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254]  [<ffffffff8121e527>] ? b=
us_add_driver+0xaf/0x1f8
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254]  [<ffffffff8121f647>] ? d=
river_register+0xa7/0x111
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254]  [<ffffffffa0011502>] ? u=
sb_register_driver+0x7e/0xdf [usbcore]
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254]  [<ffffffffa05e5000>] ? s=
nd_usb_audio_init+0x0/0x43 [snd_usb_audio]
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254]  [<ffffffff8100a065>] ? d=
o_one_initcall+0x64/0x174
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254]  [<ffffffff8107a4fc>] ? s=
ys_init_module+0xc5/0x21a
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254]  [<ffffffff81010b42>] ? s=
ystem_call_fastpath+0x16/0x1b
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254] Code: 31 c0 48 29 fe 49 8=
d 3c 3e ff c5 49 83 c4 02 e8 75 e8 ff ff 01 c3 44 39 fd 7c bd 43 8d 04 bf=
 eb 63 48 8b 44 24 20 48 63 cb ff c6 <8a> 14 10 88 d0 83 e2 0f c0 e8 04 8=
a 92 60 9f 32 81 0f b6 c0 8a=20
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254] RIP  [<ffffffff81195868>]=
 hex_dump_to_buffer+0x194/0x26e
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254]  RSP <ffff8800615fb9e8>
Jul  8 09:56:20 yerbouti kernel: [ 2422.352254] CR2: 00000000000006c0
Jul  8 09:56:20 yerbouti kernel: [ 2422.352603] ---[ end trace 83c483e466=
783985 ]---
Jul  8 09:56:20 yerbouti udevd-work[5315]: '/sbin/modprobe -b usb:v0763p2=
081d0151dcEFdsc02dp01icFFisc02ip00' unexpected exit with status 0x0009=20

Message from syslogd@yerbouti at Thu Jul  8 09:56:20 2010 ...
yerbouti kernel: [ 2422.352158] last sysfs file: /sys/devices/pci0000:00/=
0000:00:1d.7/usb3/3-3/3-3:1.2/bInterfaceProtocol

Message from syslogd@yerbouti at Thu Jul  8 09:56:20 2010 ...
yerbouti kernel: [ 2422.352154] Oops: 0000 [#1] SMP=20

Message from syslogd@yerbouti at Thu Jul  8 09:56:20 2010 ...
yerbouti kernel: [ 2422.352254] Code: 31 c0 48 29 fe 49 8d 3c 3e ff c5 49=
 83 c4 02 e8 75 e8 ff ff 01 c3 44 39 fd 7c bd 43 8d 04 bf eb 63 48 8b 44 =
24 20 48 63 cb ff c6 <8a> 14 10 88 d0 83 e2 0f c0 e8 04 8a 92 60 9f 32 81=
 0f b6 c0 8a=20

Message from syslogd@yerbouti at Thu Jul  8 09:56:20 2010 ...
yerbouti kernel: [ 2422.352254] CR2: 00000000000006c0


--------------040701060204080802040509
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------040701060204080802040509--
