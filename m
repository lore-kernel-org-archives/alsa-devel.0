From: Stephen Waters <swaters@luy.info>
Subject: Intel 865G -- no sound
Date: 21 Jul 2003 09:00:25 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1058796025.478.6.camel@geidiprime>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Z3nv3wh7wDeaJqEK9fxH"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-Z3nv3wh7wDeaJqEK9fxH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I'm running Linux 2.4.20 with ALSA 0.9.4 on Intel 865G (Dell GX270, if
you wanna look up the machine at http://support.dell.com). Although the
snd-intel8x0 driver,  etc. load fine, no sound actually comes out of the
card. I've got all the meters (mono, stereo, PCM, etc.) on 100 in both
ALSA and OSS mixer land...   everything *looks* fine in XMMS, etc. but
no sound actually comes out of the speakers.

Thanks for any help and thanks for all the good work over the years!
-s

Kernel message
------------------
intel8x0: clocking to 48000

lspci
--------------
00:00.0 Host bridge: Intel Corp.: Unknown device 2570 (rev 02)
00:01.0 PCI bridge: Intel Corp.: Unknown device 2571 (rev 02)
00:1d.0 USB Controller: Intel Corp.: Unknown device 24d2 (rev 02)
00:1d.1 USB Controller: Intel Corp.: Unknown device 24d4 (rev 02)
00:1d.2 USB Controller: Intel Corp.: Unknown device 24d7 (rev 02)
00:1d.3 USB Controller: Intel Corp.: Unknown device 24de (rev 02)
00:1d.7 USB Controller: Intel Corp.: Unknown device 24dd (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corp.: Unknown device 24d0 (rev 02)
00:1f.1 IDE interface: Intel Corp.: Unknown device 24db (rev 02)
00:1f.2 IDE interface: Intel Corp.: Unknown device 24d1 (rev 02)
00:1f.3 SMBus: Intel Corp.: Unknown device 24d3 (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp.: Unknown device 24d5 (rev =
02)
01:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 440=
 AGP 8x] (rev a2)
02:0c.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controlle=
r (rev 02)

lsmod
-----------
Module                  Size  Used by    Tainted: P
ipv6                  151604  -1 (autoclean)
uhci                   25980   0 (unused)
usbcore                62924   0 [uhci]
snd-seq-oss            29408   0 (unused)
snd-seq-midi-event      2984   0 [snd-seq-oss]
snd-seq                36496   2 [snd-seq-oss snd-seq-midi-event]
snd-pcm-oss            39972   0
snd-mixer-oss          13592   0 [snd-pcm-oss]
snd-intel8x0           18212   1
snd-pcm                60836   1 [snd-pcm-oss snd-intel8x0]
snd-timer              14212   0 [snd-seq snd-pcm]
snd-ac97-codec         39752   0 [snd-intel8x0]
snd-page-alloc          5020   0 [snd-intel8x0 snd-pcm]
snd-mpu401-uart         3296   0 [snd-intel8x0]
snd-rawmidi            13312   0 [snd-mpu401-uart]
snd-seq-device          4192   0 [snd-seq-oss snd-seq snd-rawmidi]
snd                    30244   0 [snd-seq-oss snd-seq-midi-event snd-seq sn=
d-pcm-oss snd-mixer-oss snd-intel8x0 snd-pcm snd-timer snd-ac97-codec snd-m=
pu401-uart snd-rawmidi snd-seq-device]
soundcore               3940   5 [snd]
sr_mod                 14776   0 (autoclean)
cdrom                  29152   0 (autoclean) [sr_mod]
input                   3648   0 (autoclean)
nvidia               1545440  10 (autoclean)
apm                    10088   1 (autoclean)
af_packet              13640   1 (autoclean)
ide-scsi                8848   0
scsi_mod               94656   2 [sr_mod ide-scsi]
parport_pc             23816   1 (autoclean)
lp                      7168   0 (autoclean)
parport                26536   1 (autoclean) [parport_pc lp]
e1000                  52204   1
rtc                     6760   0 (autoclean)
ext3                   64640   3 (autoclean)
jbd                    42148   3 (autoclean) [ext3]
ide-disk               12608   3 (autoclean)
ide-probe-mod           9840   0 (autoclean)
ide-mod               169336   3 (autoclean) [ide-scsi ide-disk ide-probe-m=
od]
unix                   15276 120 (autoclean)


--=-Z3nv3wh7wDeaJqEK9fxH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/G/H5vSyJ32tBS68RAh/qAJ9pQzJmbDARK6z0ws0EdejcuU6UFgCgg9kW
I1sSrBiII8C8EdWnRaqKIYo=
=qkx+
-----END PGP SIGNATURE-----

--=-Z3nv3wh7wDeaJqEK9fxH--



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
