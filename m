From: =?UTF-8?B?UmFwaGHDq2wgRG91cnNlbmF1ZA==?= <rdoursenaud@free.fr>
Subject: Re: snd-usb-audio for Radikal Technologies SAC-2K
Date: Wed, 20 Oct 2010 13:10:04 +0200
Message-ID: <4CBECE0C.5050101@free.fr>
References: <4CBEA2A5.7070902@free.fr> <4CBEB66A.5040005@ladisch.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070402060301010109070904"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1-v.mail.gandi.net (relay1-v.mail.gandi.net
	[217.70.178.75])
	by alsa0.perex.cz (Postfix) with ESMTP id BA4E7103A17
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Oct 2010 13:12:44 +0200 (CEST)
In-Reply-To: <4CBEB66A.5040005@ladisch.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070402060301010109070904
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Le 20/10/2010 11:29, Clemens Ladisch a =C3=A9crit :
> Rapha=C3=ABl Doursenaud wrote:
>> First, I more or less get the picture of what the code is doing but
>> there's one part I fiddled with that I don't understand fully. What ar=
e
>> the .out_cables and .in_cables bitmasks doing besides defining the
>> number of ports ?
>=20
> The also define the port numbers.

Could you be more explicit ? What's the format ? How is it interpreted ?
I just don't have a clue of how it works, I just set it by trial and
errors=E2=80=A6 Not really good.

>> Next, the input part seem to work flawlessly on all ports, but I have
>> what seems to be a buffer overflow on the device when outputting midi
>> data. Comparing the windows and linux usb traffic, something obvious
>> shows up : the windows driver seem to be waiting for the device's
>> acknowledgment after each sent byte before sending the next one while
>> the snd-usb-audio module sends a bunch of bytes at once that ends up
>> confusing the device _and_ module.
>=20
> Do you mean that the Windows driver does not submit more than one URB
> at once?  And that it never puts more than one byte for a port into
> one packet?  Is it possible that the device want a F5 port number at
> the beginning of every packet?

AFAIK the F5 pn is only sent once. Everything seems good to that respect.

> Anyway, all bulk packets must be explicitly accepted by a device,
> so if the SAC-2K accepts a packet and then does something wrong,
> it's the device's fault.
>=20
> To force the driver to submit no more than one packet at once,
> replace OUTPUT_URBS with a variable and set it to 1 for this device.

I've investigated with OUTPUT_URBS set to "1" and while the transfer
pattern now looks like the windows one, the device still reacts the same.

Please find the wireshark sniffed USB transfers playing the same MIDI
file from both midi-ox on windows under QEMU and aplaymidi on linux at :
http://raphael.doursenaud.fr/wp-content/uploads/Midi-file-playing-windows=
.txt
http://raphael.doursenaud.fr/wp-content/uploads/Midi-file-playing-linux.t=
xt

See how the transfers look the same until the device throws a "FE0100"
message at frame 88. From there the device goes wild blinking and
displaying a cryptic error message on its numerical display and stops
outputting midi signal.
If playing long enough, the module throws "MIDI output buffer overrun"
messages before the device disconnects to finally error and lock with tha=
t :

seq_lock: timeout [1 left] in sound/core/seq/seq_ports.c:263
rawmidi drain error (avail =3D 28, buffer_size =3D 4096)
general protection fault: 0000 [#5] PREEMPT SMP
last sysfs file:
/sys/devices/pci0000:00/0000:00:1f.2/host3/target3:0:0/3:0:0:0/block/sdf/=
sdf1/stat
CPU 2
Modules linked in: snd_usb_audio snd_usbmidi_lib blackmagic(P) [last
unloaded: snd_usbmidi_lib]

Pid: 27, comm: khubd Tainted: P      D     2.6.36-rc8 #1
EP35C-DS3R/EP35C-DS3R
RIP: 0010:[<ffffffff8162d35f>]  [<ffffffff8162d35f>]
clear_subscriber_list+0x19f/0x200
RSP: 0018:ffff88011fe3d890  EFLAGS: 00010246
RAX: ffff8800c0910a80 RBX: ffff8800c68afb40 RCX: dead000000100100
RDX: dead000000200200 RSI: 0000000000000282 RDI: ffff8800c0910a80
RBP: ffff8800c0910a00 R08: 0000000000000000 R09: dead000000100100
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8800c0aa62b8
R13: 0000000000000001 R14: ffff8800c0aa62b8 R15: ffff8800c0aa6200
FS:  0000000000000000(0000) GS:ffff880001f00000(0000) knlGS:0000000000000=
000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00007fb37da18000 CR3: 000000011ddc9000 CR4: 00000000000006f0
DR0: 0000000000000003 DR1: 00000000000000b0 DR2: 0000000000000001
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process khubd (pid: 27, threadinfo ffff88011fe3c000, task ffff88011fe3b8d=
0)
Stack:
 ffff88011fe3d8f0 ffff8800c0910a80 ffff8800c0910a68 ffff88011bbd1880
<0> ffff88011bab0c00 ffff88011b2a9cc0 ffffffff819a94c3 ffff8800c0aa6200
<0> ffff88011bbd1880 0000000000000002 ffff88011bab0c50 0000000000000006
Call Trace:
 [<ffffffff8162d410>] ? port_delete+0x50/0x80
 [<ffffffff81628f1c>] ? snd_seq_ioctl_delete_port+0x4c/0x70
 [<ffffffff81625e60>] ? snd_seq_kernel_client_ctl+0x60/0x70
 [<ffffffff8162c940>] ? snd_seq_event_port_detach+0x30/0x40
 [<ffffffff81633ae8>] ? snd_seq_midisynth_delete+0x18/0x40
 [<ffffffff81633ba3>] ? snd_seq_midisynth_unregister_port+0x93/0x120
 [<ffffffff8162dd64>] ? free_device+0x34/0xb0
 [<ffffffff8162e3b5>] ? snd_seq_device_dev_disconnect+0x35/0x50
 [<ffffffff816068e2>] ? snd_device_disconnect+0x42/0x80
 [<ffffffff81606954>] ? snd_device_disconnect_all+0x34/0x60
 [<ffffffff816019af>] ? snd_card_disconnect+0x19f/0x230
 [<ffffffffa002117c>] ? usb_audio_disconnect+0xac/0x1c0 [snd_usb_audio]
 [<ffffffff8155bdb4>] ? usb_unbind_interface+0xc4/0x120
 [<ffffffff814d0560>] ? __device_release_driver+0x60/0xd0
 [<ffffffff814d06a5>] ? device_release_driver+0x25/0x40
 [<ffffffff814cf7ad>] ? bus_remove_device+0x9d/0xe0
 [<ffffffff814cd720>] ? device_del+0x120/0x1c0
 [<ffffffff8155945a>] ? usb_disable_device+0x9a/0x120
 [<ffffffff815530db>] ? usb_disconnect+0x8b/0x130
 [<ffffffff815531d9>] ? hub_quiesce+0x59/0xc0
 [<ffffffff8155325a>] ? hub_pre_reset+0x1a/0x30
 [<ffffffff81554135>] ? usb_reset_device+0x45/0x160
 [<ffffffff81555072>] ? hub_thread+0xcd2/0x10e0
 [<ffffffff810618af>] ? dequeue_task_fair+0x4f/0x190
 [<ffffffff81082ac0>] ? autoremove_wake_function+0x0/0x30
 [<ffffffff815543a0>] ? hub_thread+0x0/0x10e0
 [<ffffffff815543a0>] ? hub_thread+0x0/0x10e0
 [<ffffffff81082646>] ? kthread+0x96/0xa0
 [<ffffffff8102ad94>] ? kernel_thread_helper+0x4/0x10
 [<ffffffff810825b0>] ? kthread+0x0/0xa0
 [<ffffffff8102ad90>] ? kernel_thread_helper+0x0/0x10
Code: 48 89 44 24 10 48 8d 85 80 00 00 00 48 89 c7 48 89 44 24 08 e8 23
d3 15 00 48 8b 4b 50 48 8b 53 58 49 b9 00 01 10 00 00 00 ad de <48> 89
51 08 49 b8 00 02 20 00 00 00 ad de 48 89 0a 4c 89 4b 50
RIP  [<ffffffff8162d35f>] clear_subscriber_list+0x19f/0x200
 RSP <ffff88011fe3d890>
- ---[ end trace 4d12c4e83f4f7bf8 ]---
seq_lock: timeout [1 left] in sound/core/seq/seq_clientmgr.c:277

I'm scratching my head now=E2=80=A6 Any clues on what might be going on ?

Thanks !

- --=20
Rapha=C3=ABl Doursenaud
http://raphael.doursenaud.fr
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAky+zgsACgkQaZKmNAdXaVVibQCcDVMf+pgQsMQ9ji4WSwZr0OpT
0xgAn339wFljNSX1LXPZsUQYo/sYUNXN
=3DgY01
-----END PGP SIGNATURE-----

--------------070402060301010109070904
Content-Type: text/x-vcard; charset=utf-8;
 name="rdoursenaud.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="rdoursenaud.vcf"

YmVnaW46dmNhcmQNCmZuO3F1b3RlZC1wcmludGFibGU6UmFwaGE9QzM9QUJsIERvdXJzZW5h
dWQNCm47cXVvdGVkLXByaW50YWJsZTpEb3Vyc2VuYXVkO1JhcGhhPUMzPUFCbA0KZW1haWw7
aW50ZXJuZXQ6cmFwaGFlbEBkb3Vyc2VuYXVkLmZyDQp1cmw6aHR0cDovL3JhcGhhZWwuZG91
cnNlbmF1ZC5mcg0KdmVyc2lvbjoyLjENCmVuZDp2Y2FyZA0KDQo=
--------------070402060301010109070904
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------070402060301010109070904--
