From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 4/5] ASoC: fsl_ssi: use flat regmap cache
Date: Thu, 22 Sep 2016 17:23:57 +0200
Message-ID: <4908dba0-ce75-8551-5395-5357d0a918f5@denx.de>
References: <20160919193029.8119-1-marex@denx.de>
 <20160919193029.8119-4-marex@denx.de>
 <57E2B53C.6080708@maciej.szmigiero.name>
 <b54cd59a-97d0-e02d-16be-7aa6752bbb35@denx.de>
 <57E3074E.4070601@maciej.szmigiero.name>
 <8d5ad78b-3850-93bd-e299-215f001da9c2@denx.de>
 <57E318DB.3040600@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C379265B3E
 for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2016 17:24:01 +0200 (CEST)
In-Reply-To: <57E318DB.3040600@maciej.szmigiero.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

On 09/22/2016 01:33 AM, Maciej S. Szmigiero wrote:
> On 22.09.2016 00:45, Marek Vasut wrote:
>> On 09/22/2016 12:18 AM, Maciej S. Szmigiero wrote:
>>> On 21.09.2016 21:32, Marek Vasut wrote:
>>>> On 09/21/2016 06:28 PM, Maciej S. Szmigiero wrote:
>>>>> Hi Marek,
>>>>
>>>> Hi!
>>>>
>>>>> On 19.09.2016 21:30, Marek Vasut wrote:
>>> (..)
>>>>>> The RB-tree regmap cache needs to allocate new space on first
>>>>>> writes.
>>>>>
>>>>> That's why SSI driver had .num_reg_defaults_raw set in regmap config.
>>>>> With this set and .reg_defaults_raw unset regcache_hw_init() will read
>>>>> existing register content which then will be used to populate cache
>>>>> (and so allocate RB tree nodes) at regcache initialization time.
>>>>
>>>> OK
>>>>
>>>>> This means that allocation of new cache RB tree nodes should never happen
>>>>> during actual write.
>>>>> If you get a warning that it happened then maybe there is a write to
>>>>> some register not covered by .num_reg_defaults_raw - this should be
>>>>> fixed.
>>>>
>>>> I might be blind, but I really don't see that. I just discussed it with
>>>> Mark and he thinks the same. I will revisit this one more time.
>>>
>>> Maybe it would be possible to get a backtrace when that warning was
>>> generated so we know which register write or update triggers new cache
>>> allocation?
>>
>> See patch 5/5 .
> 
> In you patch 5/5 there is backtrace with flat cache, but I meant a
> backtrace with original RB tree cache code when warning about allocation
> being done in atomic context was generated.

Here you go:

> fsl-ssi-dai 202c000.ssi: No cache defaults, reading back from HW
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:2871 lockdep_trace_alloc+0x104/0x128
> DEBUG_LOCKS_WARN_ON(irqs_disabled_flags(flags))
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.7.4-00041-g0260041 #2
> Hardware name: Freescale i.MX6 SoloX (Device Tree)
> Backtrace: 
> [<c010c188>] (dump_backtrace) from [<c010c380>] (show_stack+0x18/0x1c)
>  r7:00000000 r6:60000093 r5:00000000 r4:c0f1e77c
> [<c010c368>] (show_stack) from [<c03f8184>] (dump_stack+0xb4/0xe8)
> [<c03f80d0>] (dump_stack) from [<c0123638>] (__warn+0xd8/0x104)
>  r9:c016f054 r8:00000b37 r7:00000009 r6:c0c59f68 r5:00000000 r4:db453b10
> [<c0123560>] (__warn) from [<c01236a0>] (warn_slowpath_fmt+0x3c/0x44)
>  r9:00000012 r8:024000c0 r7:024000c0 r6:00000040 r5:024000c0 r4:c0c570f0
> [<c0123668>] (warn_slowpath_fmt) from [<c016f054>] (lockdep_trace_alloc+0x104/0x128)
>  r3:c0c5b07c r2:c0c570f0
>  r4:60000093
> [<c016ef50>] (lockdep_trace_alloc) from [<c0215e24>] (__kmalloc_track_caller+0x44/0x230)
>  r5:024000c0 r4:db401e80
> [<c0215de0>] (__kmalloc_track_caller) from [<c01f01d0>] (krealloc+0x54/0xc0)
>  r10:00000058 r9:00000012 r8:c050d4f0 r7:024000c0 r6:00000040 r5:0000004c
>  r4:dacd7d80
> [<c01f017c>] (krealloc) from [<c050d4f0>] (regcache_rbtree_write+0x364/0x608)
>  r9:00000012 r8:00000004 r7:00000010 r6:dacd9a00 r5:dacd7d50 r4:00000010
> [<c050d18c>] (regcache_rbtree_write) from [<c050c230>] (regcache_write+0x5c/0x64)
>  r10:dacd9818 r9:dacd9964 r8:00000000 r7:dacd9a00 r6:000000ff r5:00000058
>  r4:dacd9a00
> [<c050c1d4>] (regcache_write) from [<c050a3ac>] (_regmap_write+0x74/0x9c)
>  r7:dacd9a00 r6:000000ff r5:00000058 r4:dacd9a00
> [<c050a338>] (_regmap_write) from [<c050b5bc>] (regmap_write+0x44/0x64)
>  r7:00000006 r6:000000ff r5:00000058 r4:dacd9a00
> [<c050b578>] (regmap_write) from [<c0731090>] (_fsl_ssi_set_dai_fmt+0x31c/0x4fc)
>  r7:00000006 r6:00000000 r5:dacd9a00 r4:dacd9810
> [<c0730d74>] (_fsl_ssi_set_dai_fmt) from [<c0731f94>] (fsl_ssi_probe+0x58c/0x7b4)
>  r9:dacd9964 r8:00000000 r7:dbbbf164 r6:db4f0000 r5:db4f0010 r4:dacd9810
> [<c0731a08>] (fsl_ssi_probe) from [<c0501994>] (platform_drv_probe+0x3c/0x74)
>  r10:c0e00618 r9:00000000 r8:c0f608b4 r7:00000000 r6:c1753a70 r5:c0f608b4                                                                        
>  r4:db4f0010                                                                                                                                     
> [<c0501958>] (platform_drv_probe) from [<c0500134>] (really_probe+0x1b8/0x264)                                                                   
>  r5:c1753a68 r4:db4f0010                                                                                                                         
> [<c04fff7c>] (really_probe) from [<c05002b4>] (__driver_attach+0xd4/0xd8)                                                                        
>  r9:c0e58858 r8:00000000 r7:00000000 r6:db4f0044 r5:c0f608b4 r4:db4f0010                                                                         
> [<c05001e0>] (__driver_attach) from [<c04fe2c4>] (bus_for_each_dev+0x74/0xa8)
>  r7:00000000 r6:c05001e0 r5:c0f608b4 r4:00000000
> [<c04fe250>] (bus_for_each_dev) from [<c04ffaa4>] (driver_attach+0x20/0x28)
>  r6:c0f2ef08 r5:dacd6480 r4:c0f608b4
> [<c04ffa84>] (driver_attach) from [<c04ff5f4>] (bus_add_driver+0x104/0x214)
> [<c04ff4f0>] (bus_add_driver) from [<c05008e0>] (driver_register+0x80/0xfc)
>  r7:c0d498e0 r6:c0e58850 r5:ffffe000 r4:c0f608b4
> [<c0500860>] (driver_register) from [<c0501944>] (__platform_driver_register+0x38/0x4c)
>  r5:ffffe000 r4:c0e4cdf8
> [<c050190c>] (__platform_driver_register) from [<c0e4ce10>] (fsl_ssi_driver_init+0x18/0x20)
> [<c0e4cdf8>] (fsl_ssi_driver_init) from [<c0101924>] (do_one_initcall+0x44/0x178)
> [<c01018e0>] (do_one_initcall) from [<c0e00e74>] (kernel_init_freeable+0x124/0x1e8)
>  r8:000000ed r7:c0d498e0 r6:c0e58850 r5:c0f6e000 r4:c0e6b590
> [<c0e00d50>] (kernel_init_freeable) from [<c0958080>] (kernel_init+0x10/0x11c)
>  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0958070
>  r4:00000000
> [<c0958070>] (kernel_init) from [<c0107c70>] (ret_from_fork+0x14/0x24)
>  r5:c0958070 r4:00000000
> ---[ end trace 4907f763bc504c04 ]---
> imx-wm9712 sound: wm9712-hifi <-> 202c000.ssi mapping ok
> wm9712-codec wm9712-codec: ASoC: mux Capture Phone Mux has no paths
> wm9712-codec wm9712-codec: ASoC: mux Differential Source has no paths


-- 
Best regards,
Marek Vasut
