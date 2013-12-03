From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] ASoC: sgtl5000: drop sgtl5000_set_bias_level()
	call from sgtl5000_remove()
Date: Tue, 3 Dec 2013 09:26:51 +0800
Message-ID: <1386034012-18677-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 460A32650D3
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2013 02:23:55 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

As shown below, there will be a kernel Oops with imx-sgtl5000 module
in the sequence of install -> remove -> install again.  It happens
because during the removal of module imx-sgtl5000, the following calls
will set sgtl5000 regmap into cache only mode.

    sgtl5000_remove(codec)
        sgtl5000_set_bias_level(codec, SND_SOC_BIAS_OFF)
            regcache_cache_only(sgtl5000->regmap, true)

This will cause the follow calls fail with -EBUSY error code in the
next imx-sgtl5000 module installation.

    sgtl5000_probe(codec)
        sgtl5000_enable_regulators(codec)
            regmap_read(sgtl5000->regmap, SGTL5000_CHIP_ID, &reg)
                _regmap_read(map, reg, val)
                    if (map->cache_only)
                        return -EBUSY;

Looking at function sgtl5000_set_bias_level(), we can find it
essentially does the following 3 things in case of SND_SOC_BIAS_OFF.

 1. Set regmap into cache only mode with regcache_cache_only() call
 2. Disable supplies by calling regulator_bulk_disable()
 3. Set codec->dapm.bias_level as SND_SOC_BIAS_OFF

For 1, it's clearly incorrect and that's why we see the failure here.
For 2, it's unnecessary since sgtl5000_remove() already calls
regulator_bulk_disable() to disable supplies.  For 3, it does not make
any sense either, since the bias level will be initialized to
SND_SOC_BIAS_STANDBY in the next probe anyway.

Let's drop the sgtl5000_set_bias_level() call from sgtl5000_remove() to
fix the kernel Oops below.

$ lsmod
Module                  Size  Used by
snd_soc_imx_sgtl5000     3514  0
snd_soc_sgtl5000       13677  2
snd_soc_imx_audmux      5324  1 snd_soc_imx_sgtl5000
snd_soc_fsl_ssi         8091  2
imx_pcm_dma             1132  1 snd_soc_fsl_ssi
$ rmmod snd_soc_imx_sgtl5000
$ lsmod
Module                  Size  Used by
snd_soc_sgtl5000       13677  0
snd_soc_imx_audmux      5324  0
snd_soc_fsl_ssi         8091  0
imx_pcm_dma             1132  1 snd_soc_fsl_ssi
$ insmod snd-soc-imx-sgtl5000.ko
0-000a supply VDDD not found, using dummy regulator
Unable to handle kernel NULL pointer dereference at virtual address 000000d0
pgd = beec8000
[000000d0] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in: snd_soc_imx_sgtl5000(+) snd_soc_sgtl5000 snd_soc_imx_audmux snd_soc_fsl_ssi imx_pcm_dma [last unloaded: snd_soc_imx_sgtl5000]
CPU: 0 PID: 1814 Comm: insmod Not tainted 3.13.0-rc1+ #1571
task: bed8da00 ti: bdc94000 task.ti: bdc94000
PC is at __lock_acquire+0x6c/0x1cd8
LR is at lock_acquire+0x68/0x7c
pc : [<8005e8d0>]    lr : [<80060a44>]    psr: 20000093
sp : bdc95a78  ip : 80d86bfc  fp : bdc95af4
r10: 00000000  r9 : 00000000  r8 : 00000000
r7 : 000000d0  r6 : 8085e560  r5 : 00000080  r4 : 00000002
r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : 000000d0
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c53c7d  Table: 4eec804a  DAC: 00000015
Process insmod (pid: 1814, stack limit = 0xbdc94240)
Stack: (0xbdc95a78 to 0xbdc96000)
5a60:                                                       000003e8 00000003
5a80: 8086d388 bed8dde8 00000000 00000008 bdc95b1c bdc95aa0 bdc94000 bed8da00
5aa0: bdc95b14 80d86bfc 6c13633a 00000002 00000000 000000a1 6c6740a1 00004d82
5ac0: bdc94000 00000003 bed8da00 00000000 bdc94000 60000013 00000000 bf6a8e60
5ae0: bed8da00 bdc94000 bdc95b2c bdc95af8 80060a44 8005e870 00000002 00000000
5b00: 00000000 80252b58 00000000 bf3e841c 00000098 80252b58 80d86bfc 00000000
5b20: bdc95b84 bdc95b30 8060603c 800609e8 00000002 00000000 80252b58 bdc95b48
5b40: 8006149c 800612c8 bdc95bac bdc95b58 806062c4 80061494 00000002 bf6a8e60
5b60: bf3e8410 fffffff0 bf3e8410 bf6a8e60 8086ad70 00000001 bdc95bac bdc95b88
5b80: 80252b58 80605fec bed8da00 bf11b000 bf3e8410 fffffff0 bf3e8410 bf3e841c
5ba0: bdc95bc4 bdc95bb0 802d72d4 80252b1c bed8da00 bf3e8680 bdc95bdc bdc95bc8
5bc0: 7f00e8a8 802d7278 bed8da00 bed92000 bdc95c1c bdc95be0 7f00f240 7f00e88c
5be0: 00000000 00000000 00000000 00000000 00000000 bed92000 bec52064 7f010718
5c00: 8088cc54 8088cd20 8088cd18 bed92118 bdc95c4c bdc95c20 804979f0 7f00eec8
5c20: 8064fb28 bdc95c30 bec52064 00000000 bed9340c beec6b00 8088ccc8 00000000
5c40: bdc95cbc bdc95c50 804985d4 80497880 bec52074 80296618 bddabf40 00000003
5c60: 00000005 816105c4 bec521a4 bec521b4 bec521cc bec52084 bec521ac bec521dc
5c80: 8088cd28 00000000 00000054 00000000 bdc95cbc bf9a4010 00000000 bec52010
5ca0: 81605c30 8160e880 80dca5e8 bec52064 bdc95cec bdc95cc0 7f01a278 80497b84
5cc0: 00000000 00000003 bf9a4010 7f01aa00 bf9a4044 00000000 7f01aa00 00000000
5ce0: bdc95d04 bdc95cf0 80327758 7f01a03c 80ddc868 bf9a4010 bdc95d2c bdc95d08
5d00: 80325bcc 80327744 00000000 bf9a4010 7f01aa00 bf9a4044 00000000 7f01c000
5d20: bdc95d4c bdc95d30 80325d7c 80325ac0 bf9917dc 7f01aa00 80325ce0 00000000
5d40: bdc95d74 bdc95d50 80324320 80325cec bf8048a8 bf9917d0 bf3e8ed8 7f01aa00
5d60: bef38680 80875a40 bdc95d84 bdc95d78 803256c4 803242d0 bdc95dac bdc95d88
5d80: 803252c4 803256b0 7f01a974 bdc95d98 7f01aa00 00000001 80000000 7f01aa50
5da0: bdc95dc4 bdc95db0 80326434 803251f0 bdc94000 00000001 bdc95dd4 bdc95dc8
5dc0: 803270ec 803263c0 bdc95de4 bdc95dd8 7f01c018 803270a8 bdc95e7c bdc95de8
5de0: 800088b8 7f01c00c 8006149c 800612c8 7f01c000 bdc95e00 800a7854 80061494
5e00: 815b85b0 815b85a0 00000000 00000000 00000000 00005c0b bdc95e44 00000003
5e20: bddab140 00000001 00000000 7f01aa44 80dca5e8 bddabd80 bdc95e64 bdc95e48
5e40: 800ccc4c 800d6584 bdc95f48 00000001 00000001 bdc95f48 00000001 00000001
5e60: 7f01aa50 7f01aa44 80dca5e8 bddabd80 bdc95f44 bdc95e80 80087788 80008884
5e80: 7f01aa50 00007fff 80085684 000002d2 ffffffff 00000000 7f01aa50 00000000
5ea0: c1934720 bdc95eb0 7f01ab80 00000000 7f01aa8c bdc94000 7f01ab70 bdc95f20
5ec0: 6e72656b 00006c65 00000000 00000000 00000000 00000000 00000000 00000000
5ee0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5f00: 00000000 00000000 00000000 00000000 00000000 807d1008 20000013 000021a2
5f20: 76f19000 76ef6d50 00000080 8000e9c4 bdc94000 00000000 bdc95fa4 bdc95f48
5f40: 80088004 80086064 c1933000 000021a2 c19343b0 c19342d4 c1934e28 00000b80
5f60: 00000cd0 00000000 00000000 00000000 00000016 00000017 0000000e 0000000b
5f80: 00000009 00000000 00000000 00000000 785d2d98 785d2088 00000000 bdc95fa8
5fa0: 8000e800 80087f2c 00000000 785d2d98 76f19000 000021a2 76ef6d50 00000002
5fc0: 00000000 785d2d98 785d2088 00000080 00000000 76ef6d50 000021a2 00000000
5fe0: 00000000 7eb3cc0c 76ef0b07 76e72d94 80000010 76f19000 ffffffff fffbdff7
Backtrace:
[<8005e864>] (__lock_acquire+0x0/0x1cd8) from [<80060a44>] (lock_acquire+0x68/0x7c)
[<800609dc>] (lock_acquire+0x0/0x7c) from [<8060603c>] (mutex_lock_nested+0x5c/0x3b8)
 r7:00000000 r6:80d86bfc r5:80252b58 r4:00000098
[<80605fe0>] (mutex_lock_nested+0x0/0x3b8) from [<80252b58>] (debugfs_remove_recursive+0x48/0x154)
[<80252b10>] (debugfs_remove_recursive+0x0/0x154) from [<802d72d4>] (regulator_unregister+0x68/0xec)
 r8:bf3e841c r7:bf3e8410 r6:fffffff0 r5:bf3e8410 r4:bf11b000
r3:bed8da00
[<802d726c>] (regulator_unregister+0x0/0xec) from [<7f00e8a8>] (ldo_regulator_remove+0x28/0x40 [snd_soc_sgtl5000])
 r4:bf3e8680 r3:bed8da00
[<7f00e880>] (ldo_regulator_remove+0x0/0x40 [snd_soc_sgtl5000]) from [<7f00f240>] (sgtl5000_probe+0x384/0x4ac [snd_soc_sgtl5000])
 r4:bed92000 r3:bed8da00
[<7f00eebc>] (sgtl5000_probe+0x0/0x4ac [snd_soc_sgtl5000]) from [<804979f0>] (soc_probe_codec+0x17c/0x304)
[<80497874>] (soc_probe_codec+0x0/0x304) from [<804985d4>] (snd_soc_register_card+0xa5c/0x14f8)
[<80497b78>] (snd_soc_register_card+0x0/0x14f8) from [<7f01a278>] (imx_sgtl5000_probe+0x248/0x2ec [snd_soc_imx_sgtl5000])
[<7f01a030>] (imx_sgtl5000_probe+0x0/0x2ec [snd_soc_imx_sgtl5000]) from [<80327758>] (platform_drv_probe+0x20/0x50)
[<80327738>] (platform_drv_probe+0x0/0x50) from [<80325bcc>] (driver_probe_device+0x118/0x22c)
 r5:bf9a4010 r4:80ddc868
[<80325ab4>] (driver_probe_device+0x0/0x22c) from [<80325d7c>] (__driver_attach+0x9c/0xa0)
 r8:7f01c000 r7:00000000 r6:bf9a4044 r5:7f01aa00 r4:bf9a4010
r3:00000000
[<80325ce0>] (__driver_attach+0x0/0xa0) from [<80324320>] (bus_for_each_dev+0x5c/0x90)
 r6:00000000 r5:80325ce0 r4:7f01aa00 r3:bf9917dc
[<803242c4>] (bus_for_each_dev+0x0/0x90) from [<803256c4>] (driver_attach+0x20/0x28)
 r6:80875a40 r5:bef38680 r4:7f01aa00
[<803256a4>] (driver_attach+0x0/0x28) from [<803252c4>] (bus_add_driver+0xe0/0x1d8)
[<803251e4>] (bus_add_driver+0x0/0x1d8) from [<80326434>] (driver_register+0x80/0xfc)
 r7:7f01aa50 r6:80000000 r5:00000001 r4:7f01aa00
[<803263b4>] (driver_register+0x0/0xfc) from [<803270ec>] (__platform_driver_register+0x50/0x64)
 r5:00000001 r4:bdc94000
[<8032709c>] (__platform_driver_register+0x0/0x64) from [<7f01c018>] (imx_sgtl5000_driver_init+0x18/0x24 [snd_soc_imx_sgtl5000])
[<7f01c000>] (imx_sgtl5000_driver_init+0x0/0x24 [snd_soc_imx_sgtl5000]) from [<800088b8>] (do_one_initcall+0x40/0x170)
[<80008878>] (do_one_initcall+0x0/0x170) from [<80087788>] (load_module+0x1730/0x1ec8)
[<80086058>] (load_module+0x0/0x1ec8) from [<80088004>] (SyS_init_module+0xe4/0xe8)
[<80087f20>] (SyS_init_module+0x0/0xe8) from [<8000e800>] (ret_fast_syscall+0x0/0x48)
 r6:785d2088 r5:785d2d98 r4:00000000
Code: e59fcdd4 e59c3000 e3530000 0a00002e (e5973000)
---[ end trace 30f8d1c16c188524 ]---

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/codecs/sgtl5000.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 1f4093f..9aa63ca 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1455,8 +1455,6 @@ static int sgtl5000_remove(struct snd_soc_codec *codec)
 {
 	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
 
-	sgtl5000_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
 	regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
 						sgtl5000->supplies);
 	regulator_bulk_free(ARRAY_SIZE(sgtl5000->supplies),
-- 
1.7.9.5
