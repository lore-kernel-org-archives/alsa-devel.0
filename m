From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7219: Correct IRQ level in DT binding
	example" to the asoc tree
Date: Mon, 27 Nov 2017 18:52:23 +0000
Message-ID: <E1eJOVz-0006xG-TP@debutante>
References: <e21b3fdd673d9baf8b4872d251df57b32b6149f6.1510930791.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D1F002675F5
 for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2017 19:52:58 +0100 (CET)
In-Reply-To: <e21b3fdd673d9baf8b4872d251df57b32b6149f6.1510930791.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org, Support Opensource <support.opensource@diasemi.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7219: Correct IRQ level in DT binding example

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

>From d3b0535216f04e7e149eaebe8e967c46bdf88dc3 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Fri, 17 Nov 2017 15:09:27 +0000
Subject: [PATCH] ASoC: da7219: Correct IRQ level in DT binding example

Current DT binding documentation shows an example where the IRQ
for the device is chosen to be ACTIVE_HIGH. This is incorrect as
the device only supports ACTIVE_LOW, so this commit fixes that
discrepancy.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/da7219.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/da7219.txt b/Documentation/devicetree/bindings/sound/da7219.txt
index cf61681826b6..5b54d2d045c3 100644
--- a/Documentation/devicetree/bindings/sound/da7219.txt
+++ b/Documentation/devicetree/bindings/sound/da7219.txt
@@ -77,7 +77,7 @@ Example:
 		reg = <0x1a>;
 
 		interrupt-parent = <&gpio6>;
-		interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
 
 		VDD-supply = <&reg_audio>;
 		VDDMIC-supply = <&reg_audio>;
-- 
2.15.0
