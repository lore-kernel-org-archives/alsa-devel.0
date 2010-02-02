From: Jani Frilander <j.frilander@gmail.com>
Subject: Re: Zoom R16 (USB), will a quirk make it work
Date: Tue, 2 Feb 2010 18:51:01 +0200
Message-ID: <e53c6f621002020851r446c2b76t502d1c346ee62a20@mail.gmail.com>
References: <e53c6f621002012146n71ac0f7enb7e9f6e9c3b098d2@mail.gmail.com>
	<4B67DB5E.9080208@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 03E6F1037EA
	for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2010 17:51:10 +0100 (CET)
Received: by ewy23 with SMTP id 23so311779ewy.4
	for <alsa-devel@alsa-project.org>; Tue, 02 Feb 2010 08:51:10 -0800 (PST)
In-Reply-To: <4B67DB5E.9080208@ladisch.de>
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

2010/2/2 Clemens Ladisch <clemens@ladisch.de>:
>
> Thanks. =A0Please try the following quirk entry:
>

>
> HTH

Recompiled, rebooted and plugged the device. dmesg trace:

[ 1874.615303] usb 1-6: new high speed USB device using ehci_hcd and addres=
s 3
[ 1874.951036] usb 1-6: config 1 interface 3 altsetting 0 bulk
endpoint 0x1 has invalid maxpacket 64
[ 1874.951047] usb 1-6: config 1 interface 3 altsetting 0 bulk
endpoint 0x82 has invalid maxpacket 64
[ 1874.952380] usb 1-6: configuration #1 chosen from 1 choice
[ 1876.044143] ALSA usbaudio.c:1293: 3:1:1: cannot get freq at ep 0x3
[ 1882.045108] ALSA usbaudio.c:1293: 3:2:1: cannot get freq at ep 0x84
[ 1887.045410] snd: bad kfree (called from ffffffffa0dbba4f)
[ 1887.045420] Pid: 3190, comm: modprobe Tainted: P
2.6.31-9-rt #152-Ubuntu
[ 1887.045425] Call Trace:
[ 1887.045464]  [<ffffffffa0aca28c>] snd_hidden_kfree+0x8c/0x90 [snd]
[ 1887.045492]  [<ffffffffa0dbba4f>] free_substream+0x4f/0x70 [snd_usb_audi=
o]
[ 1887.045506]  [<ffffffffa0dbba96>] snd_usb_audio_pcm_free+0x26/0x70
[snd_usb_audio]
[ 1887.045530]  [<ffffffffa0b262e3>] snd_pcm_free+0x53/0x90 [snd_pcm]
[ 1887.045548]  [<ffffffffa0b2632d>] snd_pcm_dev_free+0xd/0x10 [snd_pcm]
[ 1887.045569]  [<ffffffffa0ad1ac9>] snd_device_free+0x79/0x160 [snd]
[ 1887.045587]  [<ffffffffa0ad1c14>] snd_device_free_all+0x64/0xa0 [snd]
[ 1887.045605]  [<ffffffffa0acae7e>] snd_card_do_free+0x3e/0x140 [snd]
[ 1887.045623]  [<ffffffffa0acbfa9>] snd_card_free+0xa9/0xd0 [snd]
[ 1887.045638]  [<ffffffffa0dbbda8>] ? snd_usb_create_quirk+0x18/0x50
[snd_usb_audio]
[ 1887.045655]  [<ffffffffa0dbe38b>] ?
create_composite_quirk+0x6b/0xb0 [snd_usb_audio]
[ 1887.045670]  [<ffffffffa0dc0845>] usb_audio_probe+0x775/0xad0 [snd_usb_a=
udio]
[ 1887.045682]  [<ffffffff8118b579>] ? sysfs_addrm_finish+0x49/0x150
[ 1887.045689]  [<ffffffff8118b926>] ? __sysfs_add_one+0x26/0xf0
[ 1887.045696]  [<ffffffff8118ba17>] ? sysfs_add_one+0x27/0x150
[ 1887.045706]  [<ffffffff813ac747>] usb_probe_interface+0xb7/0x1a0
[ 1887.045714]  [<ffffffff81329037>] really_probe+0x67/0x170
[ 1887.045720]  [<ffffffff81329170>] ? __driver_attach+0x0/0xa0
[ 1887.045726]  [<ffffffff81329163>] driver_probe_device+0x23/0x30
[ 1887.045732]  [<ffffffff81329203>] __driver_attach+0x93/0xa0
[ 1887.045738]  [<ffffffff81329170>] ? __driver_attach+0x0/0xa0
[ 1887.045745]  [<ffffffff81328488>] bus_for_each_dev+0x68/0x90
[ 1887.045751]  [<ffffffff81328eb9>] driver_attach+0x19/0x20
[ 1887.045757]  [<ffffffff81328739>] bus_add_driver+0xc9/0x2e0
[ 1887.045763]  [<ffffffff813294f8>] driver_register+0x78/0x140
[ 1887.045772]  [<ffffffff81541047>] ? notifier_call_chain+0x47/0x90
[ 1887.045782]  [<ffffffff813abb4c>] usb_register_driver+0xdc/0x150
[ 1887.045796]  [<ffffffffa007c000>] ? snd_usb_audio_init+0x0/0x43
[snd_usb_audio]
[ 1887.045810]  [<ffffffffa007c041>] snd_usb_audio_init+0x41/0x43
[snd_usb_audio]
[ 1887.045821]  [<ffffffff8100a047>] do_one_initcall+0x37/0x1a0
[ 1887.045829]  [<ffffffff81097497>] sys_init_module+0xd7/0x230
[ 1887.045839]  [<ffffffff81012102>] system_call_fastpath+0x16/0x1b
[ 1887.045932] snd-usb-audio: probe of 1-6:1.0 failed with error -5
[ 1887.046056] usbcore: registered new interface driver snd-usb-audio

$ cat /proc/asound/cards
 0 [Audigy         ]: Audigy - SB Audigy 1 [SB0090]
                      SB Audigy 1 [SB0090] (rev.3, serial:0x511102) at
0x9c00, irq 17
 1 [NVidia         ]: HDA-Intel - HDA NVidia
                      HDA NVidia at 0xfe024000 irq 27

Alsa driver version is 1.0.22.1.

-Jani
