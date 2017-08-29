From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: Update description of
	rockchip, codec" to the asoc tree
Date: Tue, 29 Aug 2017 20:25:47 +0100 (BST)
Message-ID: <20170829192547.A15614400E7@finisterre.ee.mobilebroadband>
References: <20170822153555.20735-9-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E206A266E37
 for <alsa-devel@alsa-project.org>; Tue, 29 Aug 2017 21:25:50 +0200 (CEST)
In-Reply-To: <20170822153555.20735-9-jeffy.chen@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org, heiko@sntech.de, devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, briannorris@chromium.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, dianders@chromium.org, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, dgreid@chromium.org, mka@chromium.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip: Update description of rockchip, codec

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

>From aa71fba41b6fdcfe7d7772b057b76177304775dd Mon Sep 17 00:00:00 2001
From: Jeffy Chen <jeffy.chen@rock-chips.com>
Date: Thu, 24 Aug 2017 12:52:27 +0800
Subject: [PATCH] ASoC: rockchip: Update description of rockchip, codec

Update description for newly added optional audio codecs.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
index eac91db07178..72d3cf4c2606 100644
--- a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
@@ -4,7 +4,7 @@ Required properties:
 - compatible: "rockchip,rk3399-gru-sound"
 - rockchip,cpu: The phandle of the Rockchip I2S controller that's
   connected to the codecs
-- rockchip,codec: The phandle of the MAX98357A/RT5514/DA7219 codecs
+- rockchip,codec: The phandle of the audio codecs
 
 Optional properties:
 - dmic-wakeup-delay-ms : specify delay time (ms) for DMIC ready.
-- 
2.13.2
