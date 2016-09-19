From: Marek Vasut <marex@denx.de>
Subject: [PATCH 5/5] ASoC: fsl_ssi: Remove
	.num_reg_defaults_raw from regmap_config
Date: Mon, 19 Sep 2016 21:30:29 +0200
Message-ID: <20160919193029.8119-5-marex@denx.de>
References: <20160919193029.8119-1-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F21C26655F
 for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2016 21:30:48 +0200 (CEST)
In-Reply-To: <20160919193029.8119-1-marex@denx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Marek Vasut <marex@denx.de>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

This driver provides no .reg_defaults_raw in regmap_config, so
the .num_reg_defaults_raw is useless, and, in fact harmful. It
triggers kernel crash in regmap_init which tries to access the
register defaults.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Timur Tabi <timur@tabi.org>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
--
fsl-ssi-dai 202c000.ssi: No cache defaults, reading back from HW
Unable to handle kernel paging request at virtual address 920bd77c
pgd = c0004000
[920bd77c] *pgd=00000000
Internal error: Oops: 805 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.7.3-00033-g54f2571 #3
Hardware name: Freescale i.MX6 SoloX (Device Tree)
task: db468000 ti: db462000 task.ti: db462000
PC is at regcache_flat_init+0x8c/0xb0
LR is at 0x2
pc : [<c04c8e84>]    lr : [<00000002>]    psr: 20000013
sp : db463bc8  ip : dac1afd8  fp : db463bdc
r10: 00000003  r9 : 00000017  r8 : 00000001
r7 : 00000009  r6 : 00000058  r5 : dac1ca00  r4 : dac1ca00
r3 : dac1afd0  r2 : 2da38bff  r1 : f6fafde8  r0 : db7da780
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 8000404a  DAC: 00000051
Process swapper/0 (pid: 1, stack limit = 0xdb462210)
Stack: (0xdb463bc8 to 0xdb464000)
3bc0:                   00000000 dac1ca00 db463c14 db463be0 c04c7068 c04c8e04
3be0: c01f1a80 00000000 db463d38 dac1ca00 db463d38 db4e2210 c0ea742c 00000000
3c00: dac1f000 00000001 db463c54 db463c18 c04c44cc c04c6eb0 c04c473c db4e2210
3c20: dac1f000 db463d38 e0b18000 c094fa2c dac1f090 db4e2210 dac1f000 db463d38
3c40: e0b18000 dac1c818 db463c84 db463c58 c04c47b8 c04c3acc 00000000 00000000
3c60: dac1c810 db4e2210 db463d38 db4e2200 dbbc58d4 db4e0840 db463ca4 db463c88
3c80: c04cac60 c04c4760 00000000 00000000 dac1c810 db4e2210 db463ddc db463ca8
3ca0: c06e85d4 c04cac24 00000000 00000000 db463d0c dbbc58d4 c0bca51c c0bc9dbc
3cc0: c0e5483c 00000000 db463cfc db463cd8 c069522c c06936d0 c03ba0ac 80000000
3ce0: db4e2210 dbbc58d4 c0ebaf98 00000000 db463d1c db463d00 c06936a0 c03be9f4
3d00: c0ebed00 dbbc58d4 a0000013 c0bca5d0 db463d44 db463d20 c069370c c08bcaec
3d20: db4e2210 dbbc58d4 c0ebaf98 00000000 c0e5483c 00000000 00000000 00000020
3d40: 00000004 00000000 00000020 c06e6ff4 c06e6d3c c06e6d68 c06e6ed4 00000000
3d60: 00000000 00000000 00000000 00000000 00000000 00000058 00000000 00000000
3d80: 00000000 00000000 00000000 00000000 00000003 00000000 00000017 00000000
3da0: 00000000 00000003 00000000 00000000 c0e5483c db4e2210 c0e5483c c0ebaf98
3dc0: 00000000 c0e5483c 00000000 c0d00618 db463df4 db463de0 c04bc578 c06e8410
3de0: db4e2210 c0ebaf90 db463e1c db463df8 c04bad04 c04bc548 db4e2210 c0e5483c
3e00: db4e2244 00000000 00000000 c0d5f83c db463e3c db463e20 c04bae7c c04bab58
3e20: 00000000 c0e5483c c04badb0 00000000 db463e64 db463e40 c04b9004 c04badbc
3e40: db42795c db4df3b4 db427970 c0e5483c dac1ae80 c0e27150 db463e74 db463e68
3e60: c04ba680 c04b8f9c db463e9c db463e78 c04ba1f0 c04ba66c c0bd70d4 db463e88
3e80: c0e5483c ffffe000 c0d5f834 c0c2d010 db463eb4 db463ea0 c04bb4d0 c04ba0f8
3ea0: c0d4c49c ffffe000 db463ec4 db463eb8 c04bc528 c04bb45c db463ed4 db463ec8
3ec0: c0d4c4b4 c04bc4fc db463f4c db463ed8 c01018c4 c0d4c4a8 c0c2dad8 dbfffac0
3ee0: db463f04 db463ef0 c013e200 c03beb8c 00000000 c0921520 db463f4c db463f08
3f00: c013e528 c0d00624 00000006 00000006 00000000 c0c2d010 c0bb17c0 00000000
3f20: 00000000 00000006 c0e60000 c0d71264 c0e60000 c0d5f834 c0c2d010 000000e9
3f40: db463f94 db463f50 c0d00e48 c010188c 00000006 00000006 00000000 c0d00618
3f60: 00000008 00000007 c08b8124 00000000 c08b8124 00000000 00000000 00000000
3f80: 00000000 00000000 db463fac db463f98 c08b8134 c0d00d30 00000000 c08b8124
3fa0: 00000000 db463fb0 c0107b18 c08b8130 00000000 00000000 00000000 00000000
3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 80110460 20000000
Backtrace:
[<c04c8df8>] (regcache_flat_init) from [<c04c7068>] (regcache_init+0x1c4/0x424)
 r5:dac1ca00 r4:00000000
[<c04c6ea4>] (regcache_init) from [<c04c44cc>] (__regmap_init+0xa0c/0xbc8)
 r10:00000001 r9:dac1f000 r8:00000000 r7:c0ea742c r6:db4e2210 r5:db463d38
 r4:dac1ca00
[<c04c3ac0>] (__regmap_init) from [<c04c47b8>] (__devm_regmap_init+0x64/0xa0)
 r10:dac1c818 r9:e0b18000 r8:db463d38 r7:dac1f000 r6:db4e2210 r5:dac1f090
 r4:c094fa2c
[<c04c4754>] (__devm_regmap_init) from [<c04cac60>] (__devm_regmap_init_mmio_clk+0x48/0x54)
 r8:db4e0840 r7:dbbc58d4 r6:db4e2200 r5:db463d38 r4:db4e2210
[<c04cac18>] (__devm_regmap_init_mmio_clk) from [<c06e85d4>] (fsl_ssi_probe+0x1d0/0x798)
 r5:db4e2210 r4:dac1c810
[<c06e8404>] (fsl_ssi_probe) from [<c04bc578>] (platform_drv_probe+0x3c/0x74)
 r10:c0d00618 r9:00000000 r8:c0e5483c r7:00000000 r6:c0ebaf98 r5:c0e5483c
 r4:db4e2210
[<c04bc53c>] (platform_drv_probe) from [<c04bad04>] (really_probe+0x1b8/0x264)
 r5:c0ebaf90 r4:db4e2210
[<c04bab4c>] (really_probe) from [<c04bae7c>] (__driver_attach+0xcc/0xd0)
 r9:c0d5f83c r8:00000000 r7:00000000 r6:db4e2244 r5:c0e5483c r4:db4e2210
[<c04badb0>] (__driver_attach) from [<c04b9004>] (bus_for_each_dev+0x74/0xa8)
 r7:00000000 r6:c04badb0 r5:c0e5483c r4:00000000
[<c04b8f90>] (bus_for_each_dev) from [<c04ba680>] (driver_attach+0x20/0x28)
 r6:c0e27150 r5:dac1ae80 r4:c0e5483c
[<c04ba660>] (driver_attach) from [<c04ba1f0>] (bus_add_driver+0x104/0x214)
[<c04ba0ec>] (bus_add_driver) from [<c04bb4d0>] (driver_register+0x80/0xfc)
 r7:c0c2d010 r6:c0d5f834 r5:ffffe000 r4:c0e5483c
[<c04bb450>] (driver_register) from [<c04bc528>] (__platform_driver_register+0x38/0x4c)
 r5:ffffe000 r4:c0d4c49c
[<c04bc4f0>] (__platform_driver_register) from [<c0d4c4b4>] (fsl_ssi_driver_init+0x18/0x20)
[<c0d4c49c>] (fsl_ssi_driver_init) from [<c01018c4>] (do_one_initcall+0x44/0x174)
[<c0101880>] (do_one_initcall) from [<c0d00e48>] (kernel_init_freeable+0x124/0x1e8)
 r8:000000e9 r7:c0c2d010 r6:c0d5f834 r5:c0e60000 r4:c0d71264
[<c0d00d24>] (kernel_init_freeable) from [<c08b8134>] (kernel_init+0x10/0x11c)
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c08b8124
 r4:00000000
[<c08b8124>] (kernel_init) from [<c0107b18>] (ret_from_fork+0x14/0x3c)
 r5:c08b8124 r4:00000000
Code: e5931004 e4932008 e15c0003 e1a02e32 (e7801102)
---[ end trace b0f9b6e515f8132b ]---
mmc0: host does not support reading read-only switch, assuming write-enable
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
---
 sound/soc/fsl/fsl_ssi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 5034943..b73c102 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -177,7 +177,6 @@ static const struct regmap_config fsl_ssi_regconfig = {
 	.val_bits = 32,
 	.reg_stride = 4,
 	.val_format_endian = REGMAP_ENDIAN_NATIVE,
-	.num_reg_defaults_raw = CCSR_SSI_SACCDIS / sizeof(uint32_t) + 1,
 	.readable_reg = fsl_ssi_readable_reg,
 	.volatile_reg = fsl_ssi_volatile_reg,
 	.precious_reg = fsl_ssi_precious_reg,
@@ -1501,8 +1500,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		 * don't have SACC{ST,EN,DIS} regs.
 		 */
 		regconfig.max_register = CCSR_SSI_SRMSK;
-		regconfig.num_reg_defaults_raw =
-			CCSR_SSI_SRMSK / sizeof(uint32_t) + 1;
 	}
 
 	ret = of_property_match_string(np, "clock-names", "ipg");
-- 
2.9.3
