From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add fault detect recovery property to
	DT bindings" to the asoc tree
Date: Thu,  4 Oct 2018 11:42:15 +0100 (BST)
Message-ID: <20181004104215.6BF891121BA8@debutante.sirena.org.uk>
References: <20181003193234.5049-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9ADA02676A7
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2018 12:42:17 +0200 (CEST)
In-Reply-To: <20181003193234.5049-1-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: add fault detect recovery property to DT bindings

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 466dee75b3364d05b43ddfe41ef2e8887b6a3ea7 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@zonque.org>
Date: Wed, 3 Oct 2018 21:32:34 +0200
Subject: [PATCH] ASoC: add fault detect recovery property to DT bindings

The driver already has support for setting the FDRB bit in the CONFA
register through platform data, but there was no property to set it
in the device-tree bindings.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/st,sta32x.txt | 3 +++
 sound/soc/codecs/sta32x.c                             | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/st,sta32x.txt b/Documentation/devicetree/bindings/sound/st,sta32x.txt
index 255de3ae5b2f..ff4a685a4303 100644
--- a/Documentation/devicetree/bindings/sound/st,sta32x.txt
+++ b/Documentation/devicetree/bindings/sound/st,sta32x.txt
@@ -39,6 +39,9 @@ Optional properties:
   -  st,thermal-warning-recover:
 	If present, thermal warning recovery is enabled.
 
+  - st,fault-detect-recovery:
+	If present, fault detect recovery is enabled.
+
   -  st,thermal-warning-adjustment:
 	If present, thermal warning adjustment is enabled.
 
diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index d5035f2f2b2b..22de1593443c 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -1038,6 +1038,8 @@ static int sta32x_probe_dt(struct device *dev, struct sta32x_priv *sta32x)
 	of_property_read_u8(np, "st,ch3-output-mapping",
 			    &pdata->ch3_output_mapping);
 
+	if (of_get_property(np, "st,fault-detect-recovery", NULL))
+		pdata->fault_detect_recovery = 1;
 	if (of_get_property(np, "st,thermal-warning-recovery", NULL))
 		pdata->thermal_warning_recovery = 1;
 	if (of_get_property(np, "st,thermal-warning-adjustment", NULL))
-- 
2.19.0.rc2
