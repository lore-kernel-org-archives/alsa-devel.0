From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH] ASoC: hdmi-codec: fix oops on re-probe
Date: Thu, 17 Jan 2019 17:32:05 +0000
Message-ID: <E1gkBWP-0007Xd-DQ@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
 by alsa0.perex.cz (Postfix) with ESMTP id 32D42266A89
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2019 18:32:14 +0100 (CET)
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

hdmi-codec oopses the kernel when it is unbound from a successfully
bound audio subsystem, and is then rebound:

Unable to handle kernel NULL pointer dereference at virtual address 0000001c
pgd = ee3f0000
[0000001c] *pgd=3cc59831
Internal error: Oops: 817 [#1] PREEMPT ARM
Modules linked in: ext2 snd_soc_spdif_tx vmeta dove_thermal snd_soc_kirkwood ofpart marvell_cesa m25p80 orion_wdt mtd spi_nor des_generic gpio_ir_recv snd_soc_kirkwood_spdif bmm_dmabuf auth_rpcgss nfsd autofs4 etnaviv thermal_sys hwmon gpu_sched tda9950
CPU: 0 PID: 1005 Comm: bash Not tainted 4.20.0+ #1762
Hardware name: Marvell Dove (Cubox)
PC is at hdmi_dai_probe+0x68/0x80
LR is at find_held_lock+0x20/0x94
pc : [<c04c7de0>]    lr : [<c0063bf4>]    psr: 600f0013
sp : ee15bd28  ip : eebd8b1c  fp : c093b488
r10: ee048000  r9 : eebdab18  r8 : ee048600
r7 : 00000001  r6 : 00000000  r5 : 00000000  r4 : ee82c100
r3 : 00000006  r2 : 00000001  r1 : c067e38c  r0 : ee82c100
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none[  297.318599] Control: 10c5387d  Table: 2e3f0019  DAC: 00000051
Process bash (pid: 1005, stack limit = 0xee15a248)
...
[<c04c7de0>] (hdmi_dai_probe) from [<c04b7060>] (soc_probe_dai.part.9+0x34/0x70)
[<c04b7060>] (soc_probe_dai.part.9) from [<c04b81a8>] (snd_soc_instantiate_card+0x734/0xc9c)
[<c04b81a8>] (snd_soc_instantiate_card) from [<c04b8b6c>] (snd_soc_add_component+0x29c/0x378)
[<c04b8b6c>] (snd_soc_add_component) from [<c04b8c8c>] (snd_soc_register_component+0x44/0x54)
[<c04b8c8c>] (snd_soc_register_component) from [<c04c64b4>] (devm_snd_soc_register_component+0x48/0x84)
[<c04c64b4>] (devm_snd_soc_register_component) from [<c04c7be8>] (hdmi_codec_probe+0x150/0x260)
[<c04c7be8>] (hdmi_codec_probe) from [<c0373124>] (platform_drv_probe+0x48/0x98)

This happens because hdmi_dai_probe() attempts to access the HDMI
codec private data, but this has not been assigned by hdmi_dai_probe()
before it calls devm_snd_soc_register_component().  Move the call to
dev_set_drvdata() before devm_snd_soc_register_component() to avoid
this oops.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
Discovered and patched on 4.20.

 sound/soc/codecs/hdmi-codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 1c628af373eb..6bec7f36eb4c 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -799,6 +799,8 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 	if (hcd->spdif)
 		hcp->daidrv[i] = hdmi_spdif_dai;
 
+	dev_set_drvdata(dev, hcp);
+
 	ret = devm_snd_soc_register_component(dev, &hdmi_driver, hcp->daidrv,
 				     dai_count);
 	if (ret) {
@@ -806,8 +808,6 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 			__func__, ret);
 		return ret;
 	}
-
-	dev_set_drvdata(dev, hcp);
 	return 0;
 }
 
-- 
2.7.4
