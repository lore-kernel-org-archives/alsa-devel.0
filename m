From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: 2.6.37,
 snd-hda-intel: BUG: unable to handle kernel paging request at
 ffffc90011c08000
Date: Sat, 19 Feb 2011 00:48:25 +0100
Message-ID: <1298072905.1864.24.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8303272439813050804=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E3E8244BE
	for <alsa-devel@alsa-project.org>; Sat, 19 Feb 2011 00:48:27 +0100 (CET)
Received: from f053032163.adsl.alicedsl.de ([78.53.32.163]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1Pqa3m-0000c6-Hp
	for alsa-devel@alsa-project.org; Fri, 18 Feb 2011 23:48:26 +0000
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


--===============8303272439813050804==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-cLk9MaiN8oK4vVFG5Jsm"


--=-cLk9MaiN8oK4vVFG5Jsm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear ALSA folks,


is the following oops already known to you [1]?

        ** Kernel log:
        [   41.265636] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
        [   41.680357] HDA Intel 0000:20:01.0: PCI INT A -> GSI 17 (level, =
low) -> IRQ 17
        [   41.680444] HDA Intel 0000:20:01.0: setting latency timer to 64
        [   41.680462] BUG: unable to handle kernel paging request at ffffc=
90011c08000
        [   41.680617] IP: [<ffffffffa0578402>] azx_probe+0x3ad/0x86b [snd_=
hda_intel]
        [   41.680728] PGD 13781a067 PUD 13781b067 PMD 1300ba067 PTE 800000=
fd00000173
        [   41.680956] Oops: 0009 [#1] SMP=20
        [   41.681098] last sysfs file: /sys/module/snd_pcm/initstate
        [   41.681159] CPU 0=20
        [   41.681203] Modules linked in: snd_hda_intel(+) snd_hda_codec sn=
d_hwdep snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_midi snd_rawmidi snd_seq_=
midi_event tpm_tis tpm snd_seq tpm_bios psmouse parport_pc snd_timer snd_se=
q_device parport processor evdev snd i2c_viapro thermal_sys amd64_edac_mod =
k8temp i2c_core soundcore shpchp pcspkr serio_raw asus_atk0110 pci_hotplug =
edac_core button snd_page_alloc edac_mce_amd ext3 jbd mbcache sha256_generi=
c cryptd aes_x86_64 aes_generic cbc dm_crypt dm_mod raid1 md_mod usbhid hid=
 sg sd_mod crc_t10dif sr_mod cdrom ata_generic uhci_hcd sata_via pata_via l=
ibata ehci_hcd usbcore scsi_mod via_rhine mii nls_base [last unloaded: scsi=
_wait_scan]
        [   41.684180]=20
        [   41.684180] Pid: 1153, comm: work_for_cpu Not tainted 2.6.37-1-a=
md64 #1 M2V-MX SE/System Product Name
        [   41.684180] RIP: 0010:[<ffffffffa0578402>]  [<ffffffffa0578402>]=
 azx_probe+0x3ad/0x86b [snd_hda_intel]
        [   41.684180] RSP: 0018:ffff88013153fe50  EFLAGS: 00010286
        [   41.684180] RAX: ffffc90011c08000 RBX: ffff88013029ec00 RCX: 000=
0000000000006
        [   41.684180] RDX: 0000000000000000 RSI: 0000000000000246 RDI: 000=
0000000000246
        [   41.684180] RBP: ffff88013341d000 R08: 0000000000000000 R09: 000=
0000000000040
        [   41.684180] R10: 0000000000000286 R11: 0000000000003731 R12: fff=
f88013029c400
        [   41.684180] R13: 0000000000000000 R14: 0000000000000000 R15: fff=
f88013341d090
        [   41.684180] FS:  0000000000000000(0000) GS:ffff8800bfc00000(0000=
) knlGS:00000000f7610ab0
        [   41.684180] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
        [   41.684180] CR2: ffffc90011c08000 CR3: 0000000132f57000 CR4: 000=
00000000006f0
        [   41.684180] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
        [   41.684180] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 000=
0000000000400
        [   41.684180] Process work_for_cpu (pid: 1153, threadinfo ffff8801=
3153e000, task ffff8801303c86c0)
        [   41.684180] Stack:
        [   41.684180]  0000000000000005 ffffffff8123ad65 00000000000136c0 =
ffff88013029c400
        [   41.684180]  ffff8801303c8998 ffff88013341d000 ffff88013341d090 =
ffff8801322d9dc8
        [   41.684180]  ffff88013341d208 0000000000000000 0000000000000000 =
ffffffff811ad232
        [   41.684180] Call Trace:
        [   41.684180]  [<ffffffff8123ad65>] ? __pm_runtime_set_status+0x16=
2/0x186
        [   41.684180]  [<ffffffff811ad232>] ? local_pci_probe+0x49/0x92
        [   41.684180]  [<ffffffff8105afc5>] ? do_work_for_cpu+0x0/0x1b
        [   41.684180]  [<ffffffff8105afc5>] ? do_work_for_cpu+0x0/0x1b
        [   41.684180]  [<ffffffff8105afd0>] ? do_work_for_cpu+0xb/0x1b
        [   41.684180]  [<ffffffff8105fd3f>] ? kthread+0x7a/0x82
        [   41.684180]  [<ffffffff8100a824>] ? kernel_thread_helper+0x4/0x1=
0
        [   41.684180]  [<ffffffff8105fcc5>] ? kthread+0x0/0x82
        [   41.684180]  [<ffffffff8100a820>] ? kernel_thread_helper+0x0/0x1=
0
        [   41.684180] Code: f4 01 00 00 ef 31 f6 48 89 df e8 29 dd ff ff 8=
5 c0 0f 88 2b 03 00 00 48 89 ef e8 b4 39 c3 e0 8b 7b 40 e8 fc 9d b1 e0 48 8=
b 43 38 <66> 8b 10 66 89 14 24 8b 43 14 83 e8 03 83 f8 01 77 32 31 d2 be=
=20
        [   41.684180] RIP  [<ffffffffa0578402>] azx_probe+0x3ad/0x86b [snd=
_hda_intel]
        [   41.684180]  RSP <ffff88013153fe50>
        [   41.684180] CR2: ffffc90011c08000
        [   41.684180] ---[ end trace 8d1f3ebc136437fd ]---
        [   42.127750] input: ImPS/2 Logitech Wheel Mouse as /devices/platf=
orm/i8042/serio1/input/input5
        [   63.455908] EXT3-fs (dm-1): using internal journal

Searching the Web a comment to a report [2] says that such problems are
hard to debug. Can you give me any hints? I will try to provide the
output of `alsa-info.sh` in some hours.


Thanks,

Paul


[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D613979
[2] https://bugzilla.kernel.org/show_bug.cgi?id=3D9305=20

--=-cLk9MaiN8oK4vVFG5Jsm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk1fBTwACgkQPX1aK2wOHVjkxACgiAHqXD4B79q5gDvWuuvPeR2l
BAAAn3NindhEtlD8QJi2etNh7JsQSFeB
=y5bI
-----END PGP SIGNATURE-----

--=-cLk9MaiN8oK4vVFG5Jsm--


--===============8303272439813050804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8303272439813050804==--
