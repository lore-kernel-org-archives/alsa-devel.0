From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-card: update bindings for
	amplifier support" to the asoc tree
Date: Fri, 30 Jun 2017 12:58:57 +0100
Message-ID: <E1dQuZd-0007yL-PG@finisterre>
References: <1498742798-3128-2-git-send-email-shawnguo@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E5E772674F1
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 13:59:08 +0200 (CEST)
In-Reply-To: <1498742798-3128-2-git-send-email-shawnguo@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Baoyou Xie <xie.baoyou@sanechips.com.cn>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Xin Zhou <zhou.xin8@sanechips.com.cn>, Jun Nie <jun.nie@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: audio-graph-card: update bindings for amplifier support

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

>From a0c683d734e0b3589892c17d0e1187f20d2c3a54 Mon Sep 17 00:00:00 2001
From: Shawn Guo <shawn.guo@linaro.org>
Date: Thu, 29 Jun 2017 21:26:37 +0800
Subject: [PATCH] ASoC: audio-graph-card: update bindings for amplifier support

The audio-graph-card should be able to support widgets and routing in
the same way as what simple-audio-card does.  The patch adds the
properties into audio-graph-card bindings.  Then an optional property
'pa-gpios' for controlling external amplifier, which depends on DAPM
widgets and routing, is added.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/audio-graph-card.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-card.txt b/Documentation/devicetree/bindings/sound/audio-graph-card.txt
index bac4b1b1060f..6e6720aa33f1 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-card.txt
+++ b/Documentation/devicetree/bindings/sound/audio-graph-card.txt
@@ -10,6 +10,8 @@ see ${LINUX}/Documentation/devicetree/bindings/sound/simple-card.txt
 Below are same as Simple-Card.
 
 - label
+- widgets
+- routing
 - dai-format
 - frame-master
 - bitclock-master
@@ -24,6 +26,9 @@ Required properties:
 - compatible				: "audio-graph-card";
 - dais					: list of CPU DAI port{s}
 
+Optional properties:
+- pa-gpios: GPIO used to control external amplifier.
+
 Example: Single DAI case
 
 	sound_card {
-- 
2.13.2
