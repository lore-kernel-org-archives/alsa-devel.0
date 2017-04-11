From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Improve hi6210-i2s DT bindings" to the
	asoc tree
Date: Tue, 11 Apr 2017 19:37:32 +0100
Message-ID: <E1cy0fU-00049g-CF@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3458B26680F
 for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2017 20:37:40 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Stultz <john.stultz@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Improve hi6210-i2s DT bindings

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

>From 86666c083a4eacb798754f2485bbecfedc9fc7d7 Mon Sep 17 00:00:00 2001
From: John Stultz <john.stultz@linaro.org>
Date: Mon, 10 Apr 2017 12:35:11 -0700
Subject: [PATCH] ASoC: Improve hi6210-i2s DT bindings

This patch improves the previously submitted hi6210-i2s DT
binding, adding extra details to how the multi-dai index
value maps to the potential interfaces.
(Currently just index 0 -> the S2 interface, as there is
only one supported, but in the future other interfaces may
be enabled.)

Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/hisilicon,hi6210-i2s.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/hisilicon,hi6210-i2s.txt b/Documentation/devicetree/bindings/sound/hisilicon,hi6210-i2s.txt
index 680bb03577ef..7a296784eb37 100644
--- a/Documentation/devicetree/bindings/sound/hisilicon,hi6210-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/hisilicon,hi6210-i2s.txt
@@ -17,6 +17,10 @@ Required properties:
 - dma-names: should be "tx" and "rx"
 - hisilicon,sysctrl-syscon: phandle to sysctrl syscon
 - #sound-dai-cells: Should be set to 1 (for multi-dai)
+   - The dai cell indexes reference the following interfaces:
+       0: S2 interface
+       (Currently that is the only one available, but more may be
+        supported in the future)
 
 Example for the hi6210 i2s controller:
 
@@ -32,3 +36,7 @@ i2s0: i2s@f7118000{
 	hisilicon,sysctrl-syscon = <&sys_ctrl>;
 	#sound-dai-cells = <1>;
 };
+
+Then when referencing the i2s controller:
+	sound-dai = <&i2s0 0>; /* index 0 => S2 interface */
+
-- 
2.11.0
