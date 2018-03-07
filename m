From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8524: Remove unit address" to the
	asoc tree
Date: Wed, 07 Mar 2018 14:22:44 +0000
Message-ID: <E1etZxs-0002sg-9C@debutante>
References: <1520393053-24132-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 506732673F6
 for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2018 15:22:45 +0100 (CET)
In-Reply-To: <1520393053-24132-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8524: Remove unit address

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

>From 09f7fcfa727966361d576fcfdb9c5ad77ddf5092 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 7 Mar 2018 00:24:13 -0300
Subject: [PATCH] ASoC: wm8524: Remove unit address

WM8524 does not use I2C nor SPI, hence no 'reg' property is used,
so remove the unit address from the bindings example to conform.

This avoids users getting dtc warnings when they copy the
binding example to a real dts file.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/wm8524.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/wm8524.txt b/Documentation/devicetree/bindings/sound/wm8524.txt
index 20c62002cbcd..0f0553563fc1 100644
--- a/Documentation/devicetree/bindings/sound/wm8524.txt
+++ b/Documentation/devicetree/bindings/sound/wm8524.txt
@@ -10,7 +10,7 @@ Required properties:
 
 Example:
 
-codec: wm8524@0 {
+codec: wm8524 {
 	compatible = "wlf,wm8524";
 	wlf,mute-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
 };
-- 
2.16.2
