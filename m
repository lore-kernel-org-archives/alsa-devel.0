From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: 2.6.37,
 snd-hda-intel: BUG: unable to handle kernel paging request at
 ffffc90011c08000
Date: Sun, 06 Mar 2011 14:55:11 +0100
Message-ID: <1299419711.3838.40.camel@mattotaupa>
References: <1298072905.1864.24.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0146531923801700004=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 463B92442D
	for <alsa-devel@alsa-project.org>; Sun,  6 Mar 2011 14:55:14 +0100 (CET)
Received: from f053033200.adsl.alicedsl.de ([78.53.33.200]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1PwEQS-0004VE-91
	for alsa-devel@alsa-project.org; Sun, 06 Mar 2011 13:55:12 +0000
In-Reply-To: <1298072905.1864.24.camel@mattotaupa>
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


--===============0146531923801700004==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-4KFo/wOAlb3uFkLOLstv"


--=-4KFo/wOAlb3uFkLOLstv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear ALSA folks,


Am Samstag, den 19.02.2011, 00:48 +0100 schrieb Paul Menzel:

> is the following oops already known to you [1]?
>=20
>         ** Kernel log:
>         [   41.265636] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE=
]
>         [   41.680357] HDA Intel 0000:20:01.0: PCI INT A -> GSI 17 (level=
, low) -> IRQ 17
>         [   41.680444] HDA Intel 0000:20:01.0: setting latency timer to 6=
4
>         [   41.680462] BUG: unable to handle kernel paging request at fff=
fc90011c08000
>         [   41.680617] IP: [<ffffffffa0578402>] azx_probe+0x3ad/0x86b [sn=
d_hda_intel]
>         [   41.680728] PGD 13781a067 PUD 13781b067 PMD 1300ba067 PTE 8000=
00fd00000173
>         [   41.680956] Oops: 0009 [#1] SMP=20
>         [   41.681098] last sysfs file: /sys/module/snd_pcm/initstate
>         [   41.681159] CPU 0=20
>         [   41.681203] Modules linked in: snd_hda_intel(+) snd_hda_codec =
snd_hwdep snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_midi snd_rawmidi snd_se=
q_midi_event tpm_tis tpm snd_seq tpm_bios psmouse parport_pc snd_timer snd_=
seq_device parport processor evdev snd i2c_viapro thermal_sys amd64_edac_mo=
d k8temp i2c_core soundcore shpchp pcspkr serio_raw asus_atk0110 pci_hotplu=
g edac_core button snd_page_alloc edac_mce_amd ext3 jbd mbcache sha256_gene=
ric cryptd aes_x86_64 aes_generic cbc dm_crypt dm_mod raid1 md_mod usbhid h=
id sg sd_mod crc_t10dif sr_mod cdrom ata_generic uhci_hcd sata_via pata_via=
 libata ehci_hcd usbcore scsi_mod via_rhine mii nls_base [last unloaded: sc=
si_wait_scan]
>         [   41.684180]=20
>         [   41.684180] Pid: 1153, comm: work_for_cpu Not tainted 2.6.37-1=
-amd64 #1 M2V-MX SE/System Product Name
>         [   41.684180] RIP: 0010:[<ffffffffa0578402>]  [<ffffffffa0578402=
>] azx_probe+0x3ad/0x86b [snd_hda_intel]
>         [   41.684180] RSP: 0018:ffff88013153fe50  EFLAGS: 00010286
>         [   41.684180] RAX: ffffc90011c08000 RBX: ffff88013029ec00 RCX: 0=
000000000000006
>         [   41.684180] RDX: 0000000000000000 RSI: 0000000000000246 RDI: 0=
000000000000246
>         [   41.684180] RBP: ffff88013341d000 R08: 0000000000000000 R09: 0=
000000000000040
>         [   41.684180] R10: 0000000000000286 R11: 0000000000003731 R12: f=
fff88013029c400
>         [   41.684180] R13: 0000000000000000 R14: 0000000000000000 R15: f=
fff88013341d090
>         [   41.684180] FS:  0000000000000000(0000) GS:ffff8800bfc00000(00=
00) knlGS:00000000f7610ab0
>         [   41.684180] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
>         [   41.684180] CR2: ffffc90011c08000 CR3: 0000000132f57000 CR4: 0=
0000000000006f0
>         [   41.684180] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0=
000000000000000
>         [   41.684180] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0=
000000000000400
>         [   41.684180] Process work_for_cpu (pid: 1153, threadinfo ffff88=
013153e000, task ffff8801303c86c0)
>         [   41.684180] Stack:
>         [   41.684180]  0000000000000005 ffffffff8123ad65 00000000000136c=
0 ffff88013029c400
>         [   41.684180]  ffff8801303c8998 ffff88013341d000 ffff88013341d09=
0 ffff8801322d9dc8
>         [   41.684180]  ffff88013341d208 0000000000000000 000000000000000=
0 ffffffff811ad232
>         [   41.684180] Call Trace:
>         [   41.684180]  [<ffffffff8123ad65>] ? __pm_runtime_set_status+0x=
162/0x186
>         [   41.684180]  [<ffffffff811ad232>] ? local_pci_probe+0x49/0x92
>         [   41.684180]  [<ffffffff8105afc5>] ? do_work_for_cpu+0x0/0x1b
>         [   41.684180]  [<ffffffff8105afc5>] ? do_work_for_cpu+0x0/0x1b
>         [   41.684180]  [<ffffffff8105afd0>] ? do_work_for_cpu+0xb/0x1b
>         [   41.684180]  [<ffffffff8105fd3f>] ? kthread+0x7a/0x82
>         [   41.684180]  [<ffffffff8100a824>] ? kernel_thread_helper+0x4/0=
x10
>         [   41.684180]  [<ffffffff8105fcc5>] ? kthread+0x0/0x82
>         [   41.684180]  [<ffffffff8100a820>] ? kernel_thread_helper+0x0/0=
x10
>         [   41.684180] Code: f4 01 00 00 ef 31 f6 48 89 df e8 29 dd ff ff=
 85 c0 0f 88 2b 03 00 00 48 89 ef e8 b4 39 c3 e0 8b 7b 40 e8 fc 9d b1 e0 48=
 8b 43 38 <66> 8b 10 66 89 14 24 8b 43 14 83 e8 03 83 f8 01 77 32 31 d2 be=
=20
>         [   41.684180] RIP  [<ffffffffa0578402>] azx_probe+0x3ad/0x86b [s=
nd_hda_intel]
>         [   41.684180]  RSP <ffff88013153fe50>
>         [   41.684180] CR2: ffffc90011c08000
>         [   41.684180] ---[ end trace 8d1f3ebc136437fd ]---
>         [   42.127750] input: ImPS/2 Logitech Wheel Mouse as /devices/pla=
tform/i8042/serio1/input/input5
>         [   63.455908] EXT3-fs (dm-1): using internal journal
>=20
> Searching the Web a comment to a report [2] says that such problems are
> hard to debug. Can you give me any hints? I will try to provide the
> output of `alsa-info.sh` in some hours.

Ticket 30552 tracks this in the Linux kernel bug tracking system [3].


Thanks,

Paul


> [1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D613979
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=3D9305
[3] https://bugzilla.kernel.org/show_bug.cgi?id=3D30552

--=-4KFo/wOAlb3uFkLOLstv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk1zkj8ACgkQPX1aK2wOHVjCOwCfR0fnsxqErWHjJmilxiIvJGcU
Y/cAnj8hwiPrVj7Gqt/8RucLlPWwD8CH
=xyvd
-----END PGP SIGNATURE-----

--=-4KFo/wOAlb3uFkLOLstv--


--===============0146531923801700004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0146531923801700004==--
