From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] ASoC: core: fix devres parameter in
	devm_snd_soc_register_card()
Date: Mon, 2 Dec 2013 13:26:50 +0800
Message-ID: <1385962010-8951-1-git-send-email-shawn.guo@linaro.org>
References: <20131129140153.GA10843@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 by alsa0.perex.cz (Postfix) with ESMTP id A52C5261663
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 06:23:55 +0100 (CET)
In-Reply-To: <20131129140153.GA10843@S2101-09.ap.freescale.net>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Since devm_card_release() expects parameter 'res' to be a pointer to
struct snd_soc_card, devm_snd_soc_register_card() should really pass
such a pointer rather than the one to struct device.

This bug causes the kernel Oops below with imx-sgtl500 driver when we
remove the module.  It happens because with 'card' pointing to the wrong
structure, card->num_rtd becomes 0 in function soc_remove_dai_links().
Consequently, soc_remove_link_components() and in turn
soc_cleanup_codec[platform]_debugfs() will not be called on card
removal.  It results in that debugfs_card_root is being removed while
its child entries debugfs_codec_root and debugfs_platform_root are still
there, and thus the kernel Oops.

Fix the bug by correcting the parameter 'res' to be the pointer to
struct snd_soc_card.

$ lsmod
Module                  Size  Used by
snd_soc_imx_sgtl5000     3506  0
snd_soc_sgtl5000       13677  2
snd_soc_imx_audmux      5324  1 snd_soc_imx_sgtl5000
snd_soc_fsl_ssi         8139  2
imx_pcm_dma             1380  1 snd_soc_fsl_ssi
$ rmmod snd_soc_imx_sgtl5000
Unable to handle kernel paging request at virtual address e594025c
pgd = be134000
[e594025c] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in: snd_soc_imx_sgtl5000(-) snd_soc_sgtl5000 snd_soc_imx_audmux snd_soc_fsl_ssi imx_pcm_dma
CPU: 0 PID: 1793 Comm: rmmod Not tainted 3.13.0-rc1 #1570
task: bee28900 ti: bfbec000 task.ti: bfbec000
PC is at debugfs_remove_recursive+0x28/0x154
LR is at snd_soc_unregister_card+0xa0/0xcc
pc : [<80252b38>]    lr : [<80496ac4>]    psr: a0000013
sp : bfbede00  ip : bfbede28  fp : bfbede24
r10: 803281d4  r9 : bfbec000  r8 : 803271ac
r7 : bef54440  r6 : 00000004  r5 : bf9a4010  r4 : bf9a4010
r3 : e5940224  r2 : 00000000  r1 : bef54450  r0 : 803271ac
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c53c7d  Table: 4e13404a  DAC: 00000015
Process rmmod (pid: 1793, stack limit = 0xbfbec240)
Stack: (0xbfbede00 to 0xbfbee000)
de00: 00000000 bf9a4010 bf9a4010 00000004 bef54440 bec89000 bfbede44 bfbede28
de20: 80496ac4 80252b1c 804a4b60 bfbede60 bf9a4010 00000004 bfbede54 bfbede48
de40: 804a4b74 80496a30 bfbede94 bfbede58 80328728 804a4b6c bfbede94 a0000013
de60: bf1b5800 bef54440 00000002 bf9a4010 7f0169f8 bf9a4044 00000081 8000e9c4
de80: bfbec000 00000000 bfbedeac bfbede98 80328cb0 80328618 7f016000 bf9a4010
dea0: bfbedec4 bfbedeb0 8032561c 80328c84 bf9a4010 7f0169f8 bfbedee4 bfbedec8
dec0: 80325e84 803255a8 bee28900 7f0169f8 00000000 78208d30 bfbedefc bfbedee8
dee0: 80325410 80325dd4 beca8100 7f0169f8 bfbedf14 bfbedf00 803264f8 803253c8
df00: 7f01635c 7f016a3c bfbedf24 bfbedf18 80327098 803264d4 bfbedf34 bfbedf28
df20: 7f016370 80327090 bfbedfa4 bfbedf38 80085ef0 7f016368 bfbedf54 5f646e73
df40: 5f636f73 5f786d69 6c746773 30303035 00000000 78208008 bfbedf84 bfbedf68
df60: 800613b0 80061194 fffffffe 78208d00 7efc2f07 00000081 7f016a3c 00000800
df80: bfbedf84 00000000 00000000 fffffffe 78208d00 7efc2f07 00000000 bfbedfa8
dfa0: 8000e800 80085dcc fffffffe 78208d00 78208d30 00000800 a8c82400 a8c82400
dfc0: fffffffe 78208d00 7efc2f07 00000081 00000002 00000000 78208008 00000800
dfe0: 7efc2e1c 7efc2ba8 76f5ca47 76edec7c 80000010 78208d30 00000000 00000000
Backtrace:
[<80252b10>] (debugfs_remove_recursive+0x0/0x154) from [<80496ac4>] (snd_soc_unregister_card+0xa0/0xcc)
 r8:bec89000 r7:bef54440 r6:00000004 r5:bf9a4010 r4:bf9a4010
r3:00000000
[<80496a24>] (snd_soc_unregister_card+0x0/0xcc) from [<804a4b74>] (devm_card_release+0x14/0x18)
 r6:00000004 r5:bf9a4010 r4:bfbede60 r3:804a4b60
[<804a4b60>] (devm_card_release+0x0/0x18) from [<80328728>] (release_nodes+0x11c/0x1dc)
[<8032860c>] (release_nodes+0x0/0x1dc) from [<80328cb0>] (devres_release_all+0x38/0x54)
[<80328c78>] (devres_release_all+0x0/0x54) from [<8032561c>] (__device_release_driver+0x80/0xd4)
 r4:bf9a4010 r3:7f016000
[<8032559c>] (__device_release_driver+0x0/0xd4) from [<80325e84>] (driver_detach+0xbc/0xc0)
 r5:7f0169f8 r4:bf9a4010
[<80325dc8>] (driver_detach+0x0/0xc0) from [<80325410>] (bus_remove_driver+0x54/0x98)
 r6:78208d30 r5:00000000 r4:7f0169f8 r3:bee28900
[<803253bc>] (bus_remove_driver+0x0/0x98) from [<803264f8>] (driver_unregister+0x30/0x50)
 r4:7f0169f8 r3:beca8100
[<803264c8>] (driver_unregister+0x0/0x50) from [<80327098>] (platform_driver_unregister+0x14/0x18)
 r4:7f016a3c r3:7f01635c
[<80327084>] (platform_driver_unregister+0x0/0x18) from [<7f016370>] (imx_sgtl5000_driver_exit+0x14/0x1c [snd_soc_imx_sgtl5000])
[<7f01635c>] (imx_sgtl5000_driver_exit+0x0/0x1c [snd_soc_imx_sgtl5000]) from [<80085ef0>] (SyS_delete_module+0x130/0x18c)
[<80085dc0>] (SyS_delete_module+0x0/0x18c) from [<8000e800>] (ret_fast_syscall+0x0/0x48)
 r6:7efc2f07 r5:78208d00 r4:fffffffe
Code: 889da9f8 e5983020 e3530000 089da9f8 (e5933038)
---[ end trace 825e7e125251a225 ]---

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/soc-devres.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-devres.c b/sound/soc/soc-devres.c
index 9998619..7ac745d 100644
--- a/sound/soc/soc-devres.c
+++ b/sound/soc/soc-devres.c
@@ -67,7 +67,7 @@ static void devm_card_release(struct device *dev, void *res)
  */
 int devm_snd_soc_register_card(struct device *dev, struct snd_soc_card *card)
 {
-	struct device **ptr;
+	struct snd_soc_card **ptr;
 	int ret;
 
 	ptr = devres_alloc(devm_card_release, sizeof(*ptr), GFP_KERNEL);
@@ -76,7 +76,7 @@ int devm_snd_soc_register_card(struct device *dev, struct snd_soc_card *card)
 
 	ret = snd_soc_register_card(card);
 	if (ret == 0) {
-		*ptr = dev;
+		*ptr = card;
 		devres_add(dev, ptr);
 	} else {
 		devres_free(ptr);
-- 
1.7.9.5
