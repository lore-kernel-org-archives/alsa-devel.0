From: Mark Brown <broonie@kernel.org>
Subject: Applied "dt-bindings: sound: add dmicen property in
	dmic driver" to the asoc tree
Date: Thu, 17 Aug 2017 18:13:23 +0100
Message-ID: <E1diOMF-0008U6-9b@debutante>
References: <1502436689-21123-2-git-send-email-hl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D5F4A266FED
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 19:13:29 +0200 (CEST)
In-Reply-To: <1502436689-21123-2-git-send-email-hl@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Lin Huang <hl@rock-chips.com>, arnaud.pouliquen@st.com, briannorris@chromium.org, dgreif@chromium.org, lgirdwood@gmail.com, dianders@chromium.org, broonie@kernel.org, tiwai@suse.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   dt-bindings: sound: add dmicen property in dmic driver

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

>From 8c9741b1b91d9fb4f094bfa66f0ae02c9a495f48 Mon Sep 17 00:00:00 2001
From: huang lin <hl@rock-chips.com>
Date: Thu, 17 Aug 2017 10:24:45 +0800
Subject: [PATCH] dt-bindings: sound: add dmicen property in dmic driver

there may use enable pin to control dmic start and stop,
so add this property in dt-bindings.

Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/dmic.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/dmic.txt b/Documentation/devicetree/bindings/sound/dmic.txt
index a0c58f2a162a..54c8ef6498a8 100644
--- a/Documentation/devicetree/bindings/sound/dmic.txt
+++ b/Documentation/devicetree/bindings/sound/dmic.txt
@@ -5,8 +5,12 @@ This device support generic PDM digital microphone.
 Required properties:
 	- compatible: should be "dmic-codec".
 
+Optional properties:
+	- dmicen-gpios: GPIO specifier for dmic to control start and stop
+
 Example node:
 
 	dmic_codec: dmic@0 {
 		compatible = "dmic-codec";
+		dmicen-gpios = <&gpio4 3 GPIO_ACTIVE_HIGH>;
 	};
-- 
2.13.3
