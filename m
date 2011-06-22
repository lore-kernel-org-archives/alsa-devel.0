From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ASoC: core - Fix dai usage in pcm_new()
	platform handlers
Date: Wed, 22 Jun 2011 20:21:06 +0200
Message-ID: <BANLkTi=xrqpcTvJJpz0dwVAOQ0ZXict4Pw@mail.gmail.com>
References: <1308765929-14482-1-git-send-email-zonque@gmail.com>
	<20110622181023.GA18574@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f49.google.com (mail-pz0-f49.google.com
	[209.85.210.49]) by alsa0.perex.cz (Postfix) with ESMTP id A04172483D
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 20:21:09 +0200 (CEST)
Received: by pzk28 with SMTP id 28so837348pzk.8
	for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2011 11:21:06 -0700 (PDT)
In-Reply-To: <20110622181023.GA18574@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 22, 2011 at 8:10 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Jun 22, 2011 at 08:05:29PM +0200, Daniel Mack wrote:
>> Commit 552d1ef ("ASoC: core - Optimise and refactor pcm_new() to pass
>> only rtd") refactored the ASoC internal core to only pass a pointer
>> to a runtime as argument to individual pcm_new() functions. However, the
>> new code that was added to the handlers to get access to the dai now
>> uses rtd->cpu_dai, while before this patch, rtd->codec_dai was used.
>
> Which is a problem because...
>
>> diff --git a/sound/soc/atmel/atmel-pcm.c b/sound/soc/atmel/atmel-pcm.c
>> index f81d4c3..d1140c1 100644
>> --- a/sound/soc/atmel/atmel-pcm.c
>> +++ b/sound/soc/atmel/atmel-pcm.c
>> @@ -367,7 +367,7 @@ static u64 atmel_pcm_dmamask =3D 0xffffffff;
>> =A0static int atmel_pcm_new(struct snd_soc_pcm_runtime *rtd)
>> =A0{
>> =A0 =A0 =A0 struct snd_card *card =3D rtd->card->snd_card;
>> - =A0 =A0 struct snd_soc_dai *dai =3D rtd->cpu_dai;
>> + =A0 =A0 struct snd_soc_dai *dai =3D rtd->codec_dai;
>> =A0 =A0 =A0 struct snd_pcm *pcm =3D rtd->pcm;
>> =A0 =A0 =A0 int ret =3D 0;
>>
>
> The original code doesn't look obviously wrong while if the CPU driver
> is peering at the CODEC driver that smells very bad. =A0What's the actual
> problem here?

I thought so too, but I'm facing an Ooops on 3.0.0-rc4, while the same
platform code was running fine on 2.6.39. And while searching for
potential reasons for this regression, this commit was quite obvious.
But maybe that's indeed fixing the wrong side. What happens is that
pxa2xx_pcm_preallocate_dma_buffer() is called for
SNDRV_PCM_STREAM_CAPTURE, but pcm->streams[1].substream is NULL.

[    2.959735] Unable to handle kernel NULL pointer dereference at
virtual address 00000050
[    2.967792] pgd =3D c0004000
[    2.970481] [00000050] *pgd=3D00000000
[    2.974064] Internal error: Oops: 805 [#1]
[    2.978133] Modules linked in:
[    2.981171] CPU: 0    Not tainted  (3.0.0-rc4+ #207)
[    2.986124] PC is at pxa2xx_pcm_preallocate_dma_buffer+0x38/0x8c
[    2.992093] LR is at pxa2xx_pcm_preallocate_dma_buffer+0x34/0x8c
[    2.998067] pc : [<c0296110>]    lr : [<c029610c>]    psr: 60000013
[    2.998078] sp : c6033df0  ip : 000033db  fp : c61f6e40
[    3.009467] r10: 00000000  r9 : c6175a00  r8 : 00000001
[    3.014655] r7 : c61dd340  r6 : c61e7000  r5 : 00000000  r4 : c6175e00
[    3.021134] r3 : 00000002  r2 : 60000013  r1 : 00000000  r0 : 0000004b
[    3.027615] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
Segment kernel
[    3.034875] Control: 0000397f  Table: a0004018  DAC: 00000035
[    3.040578] Process swapper (pid: 1, stack limit =3D 0xc6032278)
[    3.046369] Stack: (0xc6033df0 to 0xc6034000)
[    3.050699] 3de0:                                     00000001
c02a0dcc 00000000 00000000
[    3.058827] 3e00: c61e7000 c029f188 00000000 c6033e5c c6033e48
c61cfba0 00000000 79616c50
[    3.066961] 3e20: 6b636162 41545320 2d583233 c61e0030 c6033e68
c00fca2c 00000000 c00fcc8c
[    3.075094] 3e40: c61cfba0 c61e9ea0 c6033e68 c00fcb68 c61cfba0
c61e9ea0 00000000 c6175e00
[    3.083226] 3e60: c61f6e40 c61cfba0 c0555328 00000000 c61dd340
c61f6e40 00000002 c61e7000
[    3.091360] 3e80: 00000000 c02990a8 c0555338 c501e480 c0555400
c0555348 c6175a00 c0555700
[    3.099492] 3ea0: c05553d8 c05553e0 00000000 00000000 c6175d08
c0555340 00000000 c0555328
[    3.107625] 3ec0: c0554450 00000000 00000000 c6175d10 00000000
c0299ad0 c6175d08 c6175d08
[    3.115758] 3ee0: c6175d08 c0299b34 c6175d10 00000000 c6175d08
c01e4e28 c6175d08 c01e3b0c
[    3.123891] 3f00: c6175d08 00000000 c01e3c74 c6175d08 c6033f18
c01e304c c602a108 c61f6334
[    3.132024] 3f20: c04ceff2 c6175d08 c6175d08 c6175d3c 00000013
c01e3d50 c6175d00 c6175d08
[    3.140156] 3f40: 00000000 c01e2e74 00000000 c01e1dfc 00000000
c0548978 00000000 00000021
[    3.148289] 3f60: c001bd54 c019c5e0 00000000 c6175d00 00000000
00000000 00000013 c001bd54
[    3.156423] 3f80: 00000000 00000000 00000000 c01e5428 c6175d08
c00228d0 c0022954 c004985c
[    3.164555] 3fa0: 00000013 c001be6c c004985c 00000013 c001bd48
c00483e0 00000033 00000000
[    3.172688] 3fc0: 00000013 00000120 c05401c8 c00228d0 c0022954
c004985c 00000013 00000000
[    3.180821] 3fe0: 00000000 c00083e4 00000000 00000000 c0008370
c004985c ffffffff ffffffff
[    3.189000] [<c0296110>]
(pxa2xx_pcm_preallocate_dma_buffer+0x38/0x8c) from [<c029f188>]
(soc_new_pcm+0x190/0x1f0)
[    3.199302] [<c029f188>] (soc_new_pcm+0x190/0x1f0) from
[<c02990a8>] (snd_soc_instantiate_cards+0x644/0x9b4)
[    3.209076] [<c02990a8>] (snd_soc_instantiate_cards+0x644/0x9b4)
from [<c0299ad0>] (snd_soc_register_card+0x180/0x1bc)
[    3.219715] [<c0299ad0>] (snd_soc_register_card+0x180/0x1bc) from
[<c0299b34>] (soc_probe+0x28/0x4c)
[    3.228805] [<c0299b34>] (soc_probe+0x28/0x4c) from [<c01e4e28>]
(platform_drv_probe+0x1c/0x24)
[    3.237465] [<c01e4e28>] (platform_drv_probe+0x1c/0x24) from
[<c01e3b0c>] (driver_probe_device+0xb4/0x198)
[    3.247069] [<c01e3b0c>] (driver_probe_device+0xb4/0x198) from
[<c01e304c>] (bus_for_each_drv+0x4c/0x8c)
[    3.256501] [<c01e304c>] (bus_for_each_drv+0x4c/0x8c) from
[<c01e3d50>] (device_attach+0x60/0x80)
[    3.265323] [<c01e3d50>] (device_attach+0x60/0x80) from
[<c01e2e74>] (bus_probe_device+0x28/0x54)
[    3.274167] [<c01e2e74>] (bus_probe_device+0x28/0x54) from
[<c01e1dfc>] (device_add+0x408/0x58c)
[    3.282914] [<c01e1dfc>] (device_add+0x408/0x58c) from [<c01e5428>]
(platform_device_add+0x108/0x168)
[    3.292099] [<c01e5428>] (platform_device_add+0x108/0x168) from
[<c001be6c>] (raumfeld_audio_init+0x118/0x170)
[    3.302069] [<c001be6c>] (raumfeld_audio_init+0x118/0x170) from
[<c00483e0>] (do_one_initcall+0x94/0x164)
[    3.311592] [<c00483e0>] (do_one_initcall+0x94/0x164) from
[<c00083e4>] (kernel_init+0x74/0x11c)
[    3.320335] [<c00083e4>] (kernel_init+0x74/0x11c) from [<c004985c>]
(kernel_thread_exit+0x0/0x8)
[    3.329074] Code: e1a02005 e59f0054 eb040ce2 e3a03002 (e5853050)
[    3.335251] ---[ end trace b4ec1505aa8093ea ]---
[    3.339870] Kernel panic - not syncing: Attempted to kill init!
[    3.345830] [<c004d438>] (unwind_backtrace+0x0/0xec) from
[<c039935c>] (panic+0x4c/0x188)
[    3.354011] [<c039935c>] (panic+0x4c/0x188) from [<c005ef5c>]
(do_exit+0xac/0x630)
[    3.361544] [<c005ef5c>] (do_exit+0xac/0x630) from [<c004bfb4>]
(die+0x1b0/0x1e0)
[    3.369022] [<c004bfb4>] (die+0x1b0/0x1e0) from [<c004e5a0>]
(__do_kernel_fault+0x64/0x88)
[    3.377282] [<c004e5a0>] (__do_kernel_fault+0x64/0x88) from
[<c004e77c>] (do_page_fault+0x1b8/0x1d0)
[    3.386406] [<c004e77c>] (do_page_fault+0x1b8/0x1d0) from
[<c00482c0>] (do_DataAbort+0x34/0x94)
[    3.395100] [<c00482c0>] (do_DataAbort+0x34/0x94) from [<c0048b4c>]
(__dabt_svc+0x4c/0x60)
[    3.403313] Exception stack(0xc6033da8 to 0xc6033df0)
[    3.408360] 3da0:                   0000004b 00000000 60000013
00000002 c6175e00 00000000
[    3.416518] 3dc0: c61e7000 c61dd340 00000001 c6175a00 00000000
c61f6e40 000033db c6033df0
[    3.424671] 3de0: c029610c c0296110 60000013 ffffffff
[    3.429708] [<c0048b4c>] (__dabt_svc+0x4c/0x60) from [<c0296110>]
(pxa2xx_pcm_preallocate_dma_buffer+0x38/0x8c)
[    3.439791] [<c0296110>]
(pxa2xx_pcm_preallocate_dma_buffer+0x38/0x8c) from [<c029f188>]
(soc_new_pcm+0x190/0x1f0)
[    3.450114] [<c029f188>] (soc_new_pcm+0x190/0x1f0) from
[<c02990a8>] (snd_soc_instantiate_cards+0x644/0x9b4)
[    3.459924] [<c02990a8>] (snd_soc_instantiate_cards+0x644/0x9b4)
from [<c0299ad0>] (snd_soc_register_card+0x180/0x1bc)
[    3.470590] [<c0299ad0>] (snd_soc_register_card+0x180/0x1bc) from
[<c0299b34>] (soc_probe+0x28/0x4c)
[    3.479711] [<c0299b34>] (soc_probe+0x28/0x4c) from [<c01e4e28>]
(platform_drv_probe+0x1c/0x24)
[    3.488401] [<c01e4e28>] (platform_drv_probe+0x1c/0x24) from
[<c01e3b0c>] (driver_probe_device+0xb4/0x198)
[    3.498040] [<c01e3b0c>] (driver_probe_device+0xb4/0x198) from
[<c01e304c>] (bus_for_each_drv+0x4c/0x8c)
[    3.507496] [<c01e304c>] (bus_for_each_drv+0x4c/0x8c) from
[<c01e3d50>] (device_attach+0x60/0x80)
[    3.516353] [<c01e3d50>] (device_attach+0x60/0x80) from
[<c01e2e74>] (bus_probe_device+0x28/0x54)
[    3.525223] [<c01e2e74>] (bus_probe_device+0x28/0x54) from
[<c01e1dfc>] (device_add+0x408/0x58c)
[    3.534005] [<c01e1dfc>] (device_add+0x408/0x58c) from [<c01e5428>]
(platform_device_add+0x108/0x168)
[    3.543189] [<c01e5428>] (platform_device_add+0x108/0x168) from
[<c001be6c>] (raumfeld_audio_init+0x118/0x170)
[    3.553192] [<c001be6c>] (raumfeld_audio_init+0x118/0x170) from
[<c00483e0>] (do_one_initcall+0x94/0x164)
[    3.562747] [<c00483e0>] (do_one_initcall+0x94/0x164) from
[<c00083e4>] (kernel_init+0x74/0x11c)
[    3.571519] [<c00083e4>] (kernel_init+0x74/0x11c) from [<c004985c>]
(kernel_thread_exit+0x0/0x8)
[    3.793639] pxa27x-ohci pxa27x-ohci: auto-stop root hub
