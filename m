From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH] ASoC/multi-component: fix au1x platform
Date: Thu, 19 Aug 2010 18:21:54 +0200
Message-ID: <AANLkTik10R5N=12n7o+hd7=k4xYbCaxdcrWVWxZPKtzD@mail.gmail.com>
References: <AANLkTikyZKhs6t8RRRd36KjW_Enb-+NGvUCraxEakHO5@mail.gmail.com>
	<20100819140649.GA29395@opensource.wolfsonmicro.com>
	<AANLkTik_VdzUEZ0+079iZciOryRbFNDyjE-jdzJXztcW@mail.gmail.com>
	<20100819143555.GB29453@opensource.wolfsonmicro.com>
	<AANLkTikUN0xDGnDPk7Jxk9YihOD3mPxRzxhv+s+A5Fsz@mail.gmail.com>
	<20100819144841.GC29453@opensource.wolfsonmicro.com>
	<AANLkTimbasVqtJLeg-F+M9Ry9AzLgy8EG213vy_rEbc=@mail.gmail.com>
	<20100819155244.GB9307@sirena.org.uk>
	<AANLkTikMknoV5GDOCw1_B8jwXy6S7zZ7OidcXAjS_FBf@mail.gmail.com>
	<20100819160654.GC9307@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 30EEE244A8
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Aug 2010 18:21:55 +0200 (CEST)
Received: by gwb17 with SMTP id 17so861489gwb.38
	for <alsa-devel@alsa-project.org>; Thu, 19 Aug 2010 09:21:54 -0700 (PDT)
In-Reply-To: <20100819160654.GC9307@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, alsa-devel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 19, 2010 at 6:06 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Aug 19, 2010 at 05:59:24PM +0200, Manuel Lauss wrote:
>> On Thu, Aug 19, 2010 at 5:52 PM, Mark Brown
>
>> > This is the only embedded device I've ever seen where anyone wanted to
>> > use multiple AC97 controllers so not directly. ?If you look at the SoC
>> > core you can see how the various ALSA structures are converted into AS=
oC
>> > specific ones, though.
>
>> I figured out how to access platform data in dai_ops, =A0however I see a=
bsolutely
>> no way to get at it from the ac97_ops.
>
> The snd_card has private data...

Thanks.  However there's another problem:  the ac97 codec accesses the
snd_ac97_ops() before the AC97 controller has been set up, which, naturally,
results in an oops.  I'll keep the current crutch for ac97 in place for now.

AC97 SoC Audio Codec 0.6
CPU 0 Unable to handle kernel paging request at virtual address
00000050, epc =3D=3D 803a42dc, ra =3D=3D 80396ad0
Call Trace:
[<803a42dc>] au1xpsc_ac97_cold_reset+0x1c/0x14c
[<80396ad0>] snd_ac97_mixer+0x1dc/0x198c
[<803a2ea4>] ac97_soc_probe+0xa8/0xd4
[<8039db20>] snd_soc_instantiate_cards+0x4c8/0xb10
[<8039e27c>] soc_probe+0x114/0x154
[<802ef0fc>] driver_probe_device+0xe4/0x1a0
[<802ee404>] bus_for_each_drv+0x60/0xb0
[<802ef370>] device_attach+0x74/0xa8
[<802ee1e8>] bus_probe_device+0x30/0x54
[<802ec9a0>] device_add+0x384/0x534
[<802f09a4>] platform_device_add+0x15c/0x1c8
[<805ccb04>] db1200_audio_load+0x70/0x9c
[<801004fc>] do_one_initcall+0xfc/0x1e0
[<805ba32c>] kernel_init+0xc8/0x168
[<80105904>] kernel_thread_helper+0x10/0x18


Manuel
