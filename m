From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Atmel: ClassD: add GCK's parent clock
	in DT binding" to the asoc tree
Date: Mon, 23 Nov 2015 11:40:59 +0000
Message-ID: <E1a0pUR-0005RD-Qd@debutante>
References: <1448270399-28728-1-git-send-email-songjun.wu@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 94C5A26524F
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 12:41:09 +0100 (CET)
In-Reply-To: <1448270399-28728-1-git-send-email-songjun.wu@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Songjun Wu <songjun.wu@atmel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Atmel: ClassD: add GCK's parent clock in DT binding

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 0f611e2551deeedaafc0f01b8607eb580622b7bb Mon Sep 17 00:00:00 2001
From: Songjun Wu <songjun.wu@atmel.com>
Date: Mon, 23 Nov 2015 17:19:58 +0800
Subject: [PATCH] ASoC: Atmel: ClassD: add GCK's parent clock in DT binding

Set GCK's parent as audio clock.

Signed-off-by: Songjun Wu <songjun.wu@atmel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/atmel-classd.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/atmel-classd.txt b/Documentation/devicetree/bindings/sound/atmel-classd.txt
index 0018451c4351..549e701cb7a1 100644
--- a/Documentation/devicetree/bindings/sound/atmel-classd.txt
+++ b/Documentation/devicetree/bindings/sound/atmel-classd.txt
@@ -16,6 +16,10 @@ Required properties:
 	Required elements: "pclk", "gclk" and "aclk".
 - clocks
 	Please refer to clock-bindings.txt.
+- assigned-clocks
+	Should be <&classd_gclk>.
+- assigned-clock-parents
+	Should be <&audio_pll_pmc>.
 
 Optional properties:
 - pinctrl-names, pinctrl-0
@@ -43,6 +47,8 @@ classd: classd@fc048000 {
 		dma-names = "tx";
 		clocks = <&classd_clk>, <&classd_gclk>, <&audio_pll_pmc>;
 		clock-names = "pclk", "gclk", "aclk";
+		assigned-clocks = <&classd_gclk>;
+		assigned-clock-parents = <&audio_pll_pmc>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_classd_default>;
-- 
2.6.2
