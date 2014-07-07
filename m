From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] ASoC: sgtl5000: Fix driver unbound
Date: Mon, 7 Jul 2014 14:26:48 -0300
Message-ID: <1404754008-31861-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0209.outbound.protection.outlook.com [207.46.163.209])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BCDE2652C6
 for <alsa-devel@alsa-project.org>; Mon,  7 Jul 2014 19:27:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Julia.Lawall@lip6.fr, alsa-devel@alsa-project.org, rmk@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

Using the sgtl5000 codec driver as a module and trying to remove it causes the
followig kernel oops:

root@freescale /$ rmmod snd-soc-imx-sgtl5000                                    
[  117.122920] ------------[ cut here ]------------                             
[  117.127609] WARNING: CPU: 0 PID: 631 at drivers/regulator/core.c:3604 regula)
[  117.137046] Modules linked in: snd_soc_imx_sgtl5000(-) snd_soc_sgtl5000 evbug
[  117.144315] CPU: 0 PID: 631 Comm: rmmod Not tainted 3.16.0-rc3-next-201407043
[  117.153366] Backtrace:                                                       
[  117.155865] [<80011e5c>] (dump_backtrace) from [<80011ff8>] (show_stack+0x18)
[  117.163484]  r6:802fcc48 r5:00000000 r4:00000000 r3:00000000                 
[  117.169228] [<80011fe0>] (show_stack) from [<80668cc0>] (dump_stack+0x88/0xa)
[  117.176508] [<80668c38>] (dump_stack) from [<80029a38>] (warn_slowpath_commo)
[  117.184696]  r5:00000009 r4:00000000                                         
[  117.188322] [<800299c8>] (warn_slowpath_common) from [<80029a80>] (warn_slow)
[  117.197150]  r8:dd60d600 r7:ddfa6d00 r6:dd5d9064 r5:dd5e0f90 r4:dd5d9400     
[  117.203983] [<80029a5c>] (warn_slowpath_null) from [<802fcc48>] (regulator_u)
[  117.212828] [<802fcb74>] (regulator_unregister) from [<7f0047c4>] (ldo_regul)
[  117.223475]  r4:dd59e300 r3:dd5e0f90                                         
[  117.227100] [<7f00479c>] (ldo_regulator_remove [snd_soc_sgtl5000]) from [<7f)
[  117.238959]  r4:dd5d8000 r3:ddd51420                                         
[  117.242623] [<7f0047dc>] (sgtl5000_remove [snd_soc_sgtl5000]) from [<804e5b1)
[  117.252489]  r5:00000000 r4:dd5d8000                                         
[  117.256111] [<804e5af8>] (soc_remove_codec) from [<804e5ed4>] (soc_remove_da)
[  117.264933]  r4:ddfb640c r3:00000000                                         
[  117.268555] [<804e5c10>] (soc_remove_dai_links) from [<804e5fbc>] (snd_soc_u)
[  117.277810]  r10:80359e48 r9:dd684000 r8:dd5ca800 r7:dd685e60 r6:00000001 r5c
[  117.285761]  r4:dd5d9064                                                     
[  117.288329] [<804e5f28>] (snd_soc_unregister_card) from [<804f29f0>] (devm_c)
[  117.297324]  r6:00000004 r5:ddd0fc10 r4:dd5a7980 r3:804f29dc                 
[  117.303095] [<804f29dc>] (devm_card_release) from [<8035a418>] (release_node)
[  117.311369] [<8035a2a8>] (release_nodes) from [<8035aab4>] (devres_release_a)
[  117.319583]  r10:00000000 r9:dd684000 r8:8000ed64 r7:00000081 r6:ddd0fc44 r54
[  117.327543]  r4:ddd0fc10                                                     
[  117.330108] [<8035aa7c>] (devres_release_all) from [<803571c8>] (__device_re)
[  117.339214]  r4:ddd0fc10 r3:dd5d9010                                         
[  117.342989] [<80357148>] (__device_release_driver) from [<80357a48>] (driver)
[  117.351607]  r5:7f00c9e4 r4:ddd0fc10                                         
[  117.355285] [<8035798c>] (driver_detach) from [<80357030>] (bus_remove_drive)
[  117.363454]  r6:00000880 r5:00000000 r4:7f00c9e4 r3:dd6c3a80                 
[  117.369195] [<80356fdc>] (bus_remove_driver) from [<803580b8>] (driver_unreg)
[  117.377683]  r4:7f00c9e4 r3:dd60d480                                         
[  117.381305] [<80358088>] (driver_unregister) from [<80358bb4>] (platform_dri)
[  117.390642]  r4:7f00ca28 r3:7f00c35c                                         
[  117.394309] [<80358ba0>] (platform_driver_unregister) from [<7f00c370>] (imx)
[  117.406188] [<7f00c35c>] (imx_sgtl5000_driver_exit [snd_soc_imx_sgtl5000]) f)
[  117.417452] [<8008c2b8>] (SyS_delete_module) from [<8000eba0>] (ret_fast_sys)
[  117.425753]  r6:5f636f73 r5:5f646e73 r4:00016f40                             
[  117.430428] ---[ end trace 8fd8a5cb39e46d0e ]---                             

This problem is well explained by Russell King:

"The sgtl5000 uses a two-stage initialisation process.  The first stage
is when the platform driver is probed, where some resources are found
and initialised.  The second stage is via the codec driver's probe
function, where regulators are found and initialised using the managed
resource support.

The problem here is that this works fine until the codec driver is
unbound.  When this occurs, sgtl5000_remove() is called which is a no-op
as far as the managed resource code is concerned.  The regulators remain
allocated, and their pointers in sgtl5000_priv remain valid.

If the codec is now re-probed, it will again try and find the regulators,
which will now be busy.  This will fail.

That's not the only problem - if using the LDO regulator, the regulator
is unregistered from the regulator core code, but it still has a user.
When the user is cleaned up (eg, by removing the module) it hits the
free'd regulator, and this can oops the kernel.

This bug was originally introduced by 63e54cd9caa3ce ("ASoC: sgtl5000:
Use devm_regulator_bulk_get()")."

This reverts commit 63e54cd9caa3ce.

Tested on a imx53-qsb board.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/sgtl5000.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 249fadb..d739f83 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1275,7 +1275,7 @@ static int sgtl5000_enable_regulators(struct snd_soc_codec *codec)
 			return ret;
 	}
 
-	ret = devm_regulator_bulk_get(codec->dev, ARRAY_SIZE(sgtl5000->supplies),
+	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(sgtl5000->supplies),
 				 sgtl5000->supplies);
 	if (ret)
 		goto err_ldo_remove;
@@ -1283,13 +1283,16 @@ static int sgtl5000_enable_regulators(struct snd_soc_codec *codec)
 	ret = regulator_bulk_enable(ARRAY_SIZE(sgtl5000->supplies),
 					sgtl5000->supplies);
 	if (ret)
-		goto err_ldo_remove;
+		goto err_regulator_free;
 
 	/* wait for all power rails bring up */
 	udelay(10);
 
 	return 0;
 
+err_regulator_free:
+	regulator_bulk_free(ARRAY_SIZE(sgtl5000->supplies),
+				sgtl5000->supplies);
 err_ldo_remove:
 	if (!external_vddd)
 		ldo_regulator_remove(codec);
@@ -1359,6 +1362,8 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
 err:
 	regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
 						sgtl5000->supplies);
+	regulator_bulk_free(ARRAY_SIZE(sgtl5000->supplies),
+				sgtl5000->supplies);
 	ldo_regulator_remove(codec);
 
 	return ret;
@@ -1372,6 +1377,8 @@ static int sgtl5000_remove(struct snd_soc_codec *codec)
 
 	regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
 						sgtl5000->supplies);
+	regulator_bulk_free(ARRAY_SIZE(sgtl5000->supplies),
+				sgtl5000->supplies);
 	ldo_regulator_remove(codec);
 
 	return 0;
-- 
1.8.3.2
