From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: 2.6.32-gitX: oops in ac97 codec registration
Date: Thu, 17 Dec 2009 09:40:50 +0100
Message-ID: <f861ec6f0912170040m57874014s7b1a6bb3b863c0f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 14D8D103827
	for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2009 09:40:51 +0100 (CET)
Received: by fxm4 with SMTP id 4so6541431fxm.32
	for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2009 00:40:50 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

current 2.6.32-git spits out the following oops when I load my machine
driver with the generic AC97 codec:

No device for DAI au1xpsc_ac97
AC97 SoC Audio Codec 0.6
asoc: AC97 HiFi <-> au1xpsc_ac97 mapping ok
CPU 0 Unable to handle kernel paging request at virtual address
000001f0, epc == 80366320, ra == 803662c0
Oops[#1]:
Cpu 0
$ 0   : 00000000 10003c00 00000000 00000000
$ 4   : 00000000 00004b39 00000001 00004b39
$ 8   : 00000000 00000002 8041a7a0 8d140af0
$12   : 00000004 ad55ad55 00000003 00000001
$16   : 00000000 c1179a94 8d1f2520 c007b420
$20   : 8d49cfe0 8d1f2520 804fc03c 804fc130
$24   : 00000000 0000ad55
$28   : 8d590000 8d591af0 00000000 803662c0
Hi    : 00000000
Lo    : 00000004
epc   : 80366320 snd_soc_new_pcms+0x300/0x358
    Not tainted
ra    : 803662c0 snd_soc_new_pcms+0x2a0/0x358
Status: 10003c03    KERNEL EXL IE
Cause : 0080800c
BadVA : 000001f0
PrId  : 04030202 (Au1250)
Modules linked in: snd_soc_exm32cexx(+) snd_soc_cs4251x snd_soc_ac97
snd_ac97_codec snd_soc_au1xpsc_ac97 snd_soc_au1xpsc_i2s
Process modprobe (pid: 673, threadinfo=8d590000, task=8d430938, tls=2aacf2d0)
Stack : 8d591b30 c007b3c4 c0074afc 00010000 00000001 8d591b08 8d17d1c0 37394341
        46694820 43412069 48203739 2d694669 8d170030 804fc16c 8d17d2c8 0000001c
        10003c01 8d17d2c8 804fc16c 8d17d2c8 10003c01 8d17d2d0 00000024 80500000
        c0074b58 00000001 c11799f4 00000000 8d1f2528 00000001 fffffff4 8d1f2520
        c11798f0 00000001 8d17d0c0 00000001 804fc130 00000000 804f4980 c007b288
        ...
Call Trace:
[<80366320>] snd_soc_new_pcms+0x300/0x358
[<c007b288>] ac97_soc_probe+0x108/0x1d0 [snd_soc_ac97]
[<80365108>] snd_soc_instantiate_cards+0x22c/0x694
[<803655ec>] soc_probe+0x7c/0xc4
[<802c73b8>] driver_probe_device+0xbc/0x194
[<802c6748>] bus_for_each_drv+0x60/0xb0
[<802c7638>] device_attach+0x60/0x88
[<802c6524>] bus_probe_device+0x30/0x54
[<802c4d74>] device_add+0x3a4/0x53c
[<802c8e48>] platform_device_add+0x14c/0x1b8
[<c11794ec>] cexx_audio_probe+0x310/0x374 [snd_soc_exm32cexx]
[<802c73b8>] driver_probe_device+0xbc/0x194
[<802c74fc>] __driver_attach+0x6c/0xa4
[<802c6afc>] bus_for_each_dev+0x60/0xb0
[<802c6264>] bus_add_driver+0xc8/0x268
[<802c78ac>] driver_register+0xdc/0x194
[<8010a010>] do_one_initcall+0x68/0x1f4
[<80154268>] sys_init_module+0xec/0x23c
[<801022a0>] stack_done+0x20/0x3c


Oops is inside snd_ac97_dev_add_pdata() call: seems ac97->dev is NULL.

I'm not entirely sure that this isn't somehow the fault of my machine driver;
has the procedure to register the asoc device changed since 2.6.32?

Thanks!
     Manuel Lauss
