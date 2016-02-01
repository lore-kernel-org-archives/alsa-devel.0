From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] regmap: cache: Fall back to register by register read
 for cache defaults
Date: Mon, 1 Feb 2016 19:58:54 -0200
Message-ID: <CAOMZO5BSbFo7xMEHY9s5YNitKFq8gJ83W6oDnS8PYBBDu2+ykQ@mail.gmail.com>
References: <1454362695-10682-1-git-send-email-broonie@kernel.org>
	<1454362695-10682-2-git-send-email-broonie@kernel.org>
	<20160201214139.GI4455@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160201214139.GI4455@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nicolin Chen <nicoleotsuka@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Mon, Feb 1, 2016 at 7:41 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Feb 01, 2016 at 09:38:15PM +0000, Mark Brown wrote:
>> If we are unable to read the cache defaults for a regmap then fall back
>> on attempting to read them word by word. This is going to be painfully
>> slow for large regmaps but might be adequate for smaller ones.
>
> Competely untested, hopefully it helps fix the issues with the SSI.

After applying this series I get:

[    2.070023] fsl-asoc-card sound: ASoC: CPU DAI (null) not registered
[    2.076440] fsl-asoc-card sound: snd_soc_register_card failed (-517)
[    2.085572] fsl-ssi-dai 202c000.ssi: No cache defaults, reading back from HW
[    2.092998] Unable to handle kernel NULL pointer dereference at
virtual address 00000004
[    2.101121] pgd = c0004000
[    2.103847] [00000004] *pgd=00000000
[    2.107470] Internal error: Oops: 5 [#1] SMP ARM
[    2.112105] Modules linked in:
[    2.115208] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
4.5.0-rc1-next-20160201-dirty #232
[    2.123315] Hardware name: Freescale i.MX6 SoloLite (Device Tree)
[    2.129429] task: ef060000 ti: ef04a000 task.ti: ef04a000
[    2.134868] PC is at regcache_rbtree_lookup+0x14/0x110
[    2.140032] LR is at regcache_rbtree_read+0x1c/0xd0
[    2.144932] pc : [<c03edce0>]    lr : [<c03ee09c>]    psr: 60000093
[    2.144932] sp : ef04bb2c  ip : ef04bb58  fp : ef04bb54
[    2.156428] r10: ef04bd30  r9 : 00000001  r8 : 00000000
[    2.161670] r7 : ef04bbdc  r6 : 00000000  r5 : eead5e00  r4 : eead5e00
[    2.168213] r3 : c03ee080  r2 : eead5e00  r1 : 00000010  r0 : eead5e00
[    2.174760] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment none
[    2.182001] Control: 10c5387d  Table: 8000404a  DAC: 00000051
[    2.187764] Process swapper/0 (pid: 1, stack limit = 0xef04a210)
[    2.193788] Stack: (0xef04bb2c to 0xef04c000)
[    2.198171] bb20:                            eead5e00 eead5e00
00000010 ef04bbdc 00000000
[    2.206376] bb40: 00000001 ef04bd30 ef04bb74 ef04bb58 c03ee09c
c03edcd8 eead5e00 00000010
[    2.214580] bb60: ef04bbdc ef04bbdc ef04bb94 ef04bb78 c03ed150
c03ee08c 00000000 eead5e00
[    2.222783] bb80: 00000010 eead5e00 ef04bbb4 ef04bb98 c03eae78
c03ed108 eead5e00 00000010
[    2.230985] bba0: ef04bbdc 00000010 ef04bbd4 ef04bbb8 c03eaef0
c03eadf8 00000000 00000004
[    2.239188] bbc0: 00000004 eead5e00 ef04bc0c ef04bbd8 c03ed614
c03eaeb8 ef0bd380 eead5c18
[    2.247391] bbe0: ef04bc0c eead5e00 c0820498 ef04bd30 ef0ddc10
00000000 ef0bd380 eead5c18
[    2.255594] bc00: ef04bc4c ef04bc10 c03ea978 c03ed2ec c03e9d28
ef0ddc10 eead2540 c0820498
[    2.263796] bc20: ef0bd380 ef04bd30 eead25d0 ef0ddc10 eead2540
c0820498 ef0bd380 eead5c18
[    2.271999] bc40: ef04bc7c ef04bc50 c03eabc8 c03e9fe4 c13891f4
c0a36258 ef04bd30 ef04bd30
[    2.280201] bc60: ef0ddc10 ef0ddc10 ef7dc188 f0a80000 ef04bc9c
ef04bc80 c03f0f84 c03eab70
[    2.288404] bc80: c13891f4 c0a36258 eead5c10 ef0ddc00 ef04bdd4
ef04bca0 c05be9fc c03f0f48
[    2.296607] bca0: c13891f4 c0a36258 ef04bcdc ef04bcb8 ef7dc188
00000000 00000000 00000000
[    2.304809] bcc0: 00000000 fffffffe 00000000 ef04bd58 c0b69e94
ef0ddc10 000000df 00000000
[    2.313011] bce0: ef04bd4c ef04bcf0 c056fba0 c056f8bc 00000000
ef04bcf8 ef7dc188 00000000
[    2.321214] bd00: c0b5f424 00000000 ef04bd3c 00000000 00000000
ef04bd58 c0b69e94 ef0ddc10
[    2.329415] bd20: 000000df 00000000 ef04bd4c ef04bd38 00000000
00000020 00000004 00000000
[    2.337618] bd40: 00000020 c05bd708 c05bd598 c05bd5c0 c05bd5e8
00000000 00000000 00000000
[    2.345819] bd60: 00000000 00000000 00000000 00000058 00000000
00000000 00000000 00000000
[    2.354021] bd80: 00000000 00000000 00000001 00000000 00000017
00000000 00000000 00000003
[    2.362223] bda0: 00000000 00000000 c1382240 fffffffe ef0ddc10
fffffdfb c0b69e94 c0b69e94
[    2.370425] bdc0: 000000df 00000000 ef04bdf4 ef04bdd8 c03d48dc
c05be838 ef0ddc10 c1382238
[    2.378627] bde0: c1382240 00000000 ef04be1c ef04bdf8 c03d30a4
c03d4890 ef0ddc10 c0b69e94
[    2.386829] be00: ef0ddc44 00000000 c0add850 00000000 ef04be3c
ef04be20 c03d31fc c03d2eb8
[    2.395031] be20: ef0b8a5c 00000000 c0b69e94 c03d3160 ef04be64
ef04be40 c03d1488 c03d316c
[    2.403234] be40: ef02c4a4 ef0b8a50 eeb22b58 c0b69e94 eeb22b80
c0b35a48 ef04be74 ef04be68
[    2.411437] be60: c03d28b4 c03d1438 ef04be9c ef04be78 c03d25b4
c03d28a0 c0a363b0 ef04be88
[    2.419640] be80: c0b69e94 c0b0c188 eead23c0 c0aec84c ef04beb4
ef04bea0 c03d3aa0 c03d24d4
[    2.427842] bea0: c0b0c188 c0b0c188 ef04bec4 ef04beb8 c03d47a0
c03d3a2c ef04bed4 ef04bec8
[    2.436044] bec0: c0add868 c03d4774 ef04bf54 ef04bed8 c00098dc
c0add85c c0071cac c0071ab4
[    2.444248] bee0: ef04bf0c ef04bef0 c0a91600 c02e5af8 00000000
efffccad c07f3df0 000000df
[    2.452450] bf00: ef04bf54 ef04bf10 c004a8bc c0a915f8 00000006
00000006 00000000 c0a8dba8
[    2.460652] bf20: c0a0fabc 00000000 ef04bf54 c0aff038 00000006
c0b78000 c0aec84c 00000000
[    2.468853] bf40: 000000df c0aec858 ef04bf94 ef04bf58 c0a91e84
c0009860 00000006 00000006
[    2.477055] bf60: 00000000 c0a915ec 537bcf5a 00000000 c07c9c40
00000000 00000000 00000000
[    2.485258] bf80: 00000000 00000000 ef04bfac ef04bf98 c07c9c50
c0a91d74 00000000 00000000
[    2.493459] bfa0: 00000000 ef04bfb0 c000ff30 c07c9c4c 00000000
00000000 00000000 00000000
[    2.501660] bfc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    2.509862] bfe0: 00000000 00000000 00000000 00000000 00000013
00000000 b7ffaffb ffbbffff
[    2.518049] Backtrace:
[    2.520553] [<c03edccc>] (regcache_rbtree_lookup) from [<c03ee09c>]
(regcache_rbtree_read+0x1c/0xd0)
[    2.529702]  r10:ef04bd30 r9:00000001 r8:00000000 r7:ef04bbdc
r6:00000010 r5:eead5e00
[    2.537662]  r4:eead5e00
[    2.540246] [<c03ee080>] (regcache_rbtree_read) from [<c03ed150>]
(regcache_read+0x54/0x6c)
[    2.548612]  r7:ef04bbdc r6:ef04bbdc r5:00000010 r4:eead5e00
[    2.554392] [<c03ed0fc>] (regcache_read) from [<c03eae78>]
(_regmap_read+0x8c/0xc0)
[    2.562062]  r6:eead5e00 r5:00000010 r4:eead5e00 r3:00000000
[    2.567839] [<c03eadec>] (_regmap_read) from [<c03eaef0>]
(regmap_read+0x44/0x64)
[    2.575336]  r7:00000010 r6:ef04bbdc r5:00000010 r4:eead5e00
[    2.581114] [<c03eaeac>] (regmap_read) from [<c03ed614>]
(regcache_init+0x334/0x404)
[    2.588871]  r6:eead5e00 r5:00000004 r4:00000004 r3:00000000
[    2.594647] [<c03ed2e0>] (regcache_init) from [<c03ea978>]
(__regmap_init+0x9a0/0xb8c)
[    2.602578]  r10:eead5c18 r9:ef0bd380 r8:00000000 r7:ef0ddc10
r6:ef04bd30 r5:c0820498
[    2.610536]  r4:eead5e00
[    2.613118] [<c03e9fd8>] (__regmap_init) from [<c03eabc8>]
(__devm_regmap_init+0x64/0xa0)
[    2.621310]  r10:eead5c18 r9:ef0bd380 r8:c0820498 r7:eead2540
r6:ef0ddc10 r5:eead25d0
[    2.629268]  r4:ef04bd30
[    2.631849] [<c03eab64>] (__devm_regmap_init) from [<c03f0f84>]
(__devm_regmap_init_mmio_clk+0x48/0x5c)
[    2.641257]  r8:f0a80000 r7:ef7dc188 r6:ef0ddc10 r5:ef0ddc10 r4:ef04bd30
[    2.648108] [<c03f0f3c>] (__devm_regmap_init_mmio_clk) from
[<c05be9fc>] (fsl_ssi_probe+0x1d0/0x7c4)
[    2.657255]  r5:ef0ddc00 r4:eead5c10
[    2.660905] [<c05be82c>] (fsl_ssi_probe) from [<c03d48dc>]
(platform_drv_probe+0x58/0xb8)
[    2.669096]  r10:00000000 r9:000000df r8:c0b69e94 r7:c0b69e94
r6:fffffdfb r5:ef0ddc10
[    2.677055]  r4:fffffffe
[    2.679647] [<c03d4884>] (platform_drv_probe) from [<c03d30a4>]
(driver_probe_device+0x1f8/0x2b4)
[    2.688535]  r7:00000000 r6:c1382240 r5:c1382238 r4:ef0ddc10
[    2.694315] [<c03d2eac>] (driver_probe_device) from [<c03d31fc>]
(__driver_attach+0x9c/0xa0)
[    2.702767]  r10:00000000 r8:c0add850 r7:00000000 r6:ef0ddc44
r5:c0b69e94 r4:ef0ddc10
[    2.710743] [<c03d3160>] (__driver_attach) from [<c03d1488>]
(bus_for_each_dev+0x5c/0x90)
[    2.718935]  r6:c03d3160 r5:c0b69e94 r4:00000000 r3:ef0b8a5c
[    2.724712] [<c03d142c>] (bus_for_each_dev) from [<c03d28b4>]
(driver_attach+0x20/0x28)
[    2.732730]  r6:c0b35a48 r5:eeb22b80 r4:c0b69e94
[    2.737442] [<c03d2894>] (driver_attach) from [<c03d25b4>]
(bus_add_driver+0xec/0x1fc)
[    2.745391] [<c03d24c8>] (bus_add_driver) from [<c03d3aa0>]
(driver_register+0x80/0xfc)
[    2.753409]  r7:c0aec84c r6:eead23c0 r5:c0b0c188 r4:c0b69e94
[    2.759186] [<c03d3a20>] (driver_register) from [<c03d47a0>]
(__platform_driver_register+0x38/0x4c)
[    2.768246]  r5:c0b0c188 r4:c0b0c188
[    2.771904] [<c03d4768>] (__platform_driver_register) from
[<c0add868>] (fsl_ssi_driver_init+0x18/0x20)
[    2.781331] [<c0add850>] (fsl_ssi_driver_init) from [<c00098dc>]
(do_one_initcall+0x88/0x1e4)
[    2.789897] [<c0009854>] (do_one_initcall) from [<c0a91e84>]
(kernel_init_freeable+0x11c/0x1f0)
[    2.798610]  r10:c0aec858 r9:000000df r8:00000000 r7:c0aec84c
r6:c0b78000 r5:00000006
[    2.806569]  r4:c0aff038
[    2.809160] [<c0a91d68>] (kernel_init_freeable) from [<c07c9c50>]
(kernel_init+0x10/0xf8)
[    2.817352]  r10:00000000 r9:00000000 r8:00000000 r7:00000000
r6:00000000 r5:c07c9c40
[    2.825310]  r4:00000000
[    2.827898] [<c07c9c40>] (kernel_init) from [<c000ff30>]
(ret_from_fork+0x14/0x24)
[    2.835481]  r4:00000000 r3:00000000
[    2.839124] Code: e92ddff0 e24cb004 e59061ac e1a02000 (e5960004)
[    2.845280] ---[ end trace 333f720f66676368 ]---
[    2.850119] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
[    2.850119]
[    2.859308] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=0x0000000b
