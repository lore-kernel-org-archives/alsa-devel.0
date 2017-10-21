From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-scu-card: remove
	unnecessary route patch from Example 1" to the asoc tree
Date: Sat, 21 Oct 2017 11:27:40 +0100 (BST)
Message-ID: <20171021102740.EA390440057@finisterre.ee.mobilebroadband>
References: <87a80q6zg8.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C8468266DCF
 for <alsa-devel@alsa-project.org>; Sat, 21 Oct 2017 12:27:44 +0200 (CEST)
In-Reply-To: <87a80q6zg8.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: audio-graph-scu-card: remove unnecessary route patch from Example 1

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

>From 86d5b2c20d8ec255ef7646533b81dabc935e0eff Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 17 Oct 2017 06:57:49 +0000
Subject: [PATCH] ASoC: audio-graph-scu-card: remove unnecessary route patch
 from Example 1

Example 1 is for "Sampling Rate Conversion",
sample has only 1 CPU, 1 Codec.
Thus, "codec Playback", "DAI1 Playback" route is unnecessary.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt b/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt
index a10daf54aa0c..441dd6f29df1 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt
+++ b/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt
@@ -43,7 +43,6 @@ Example 1. Sampling Rate Conversion
 		label = "sound-card";
 		prefix = "codec";
 		routing = "codec Playback", "DAI0 Playback",
-			  "codec Playback", "DAI1 Playback",
 			  "DAI0 Capture",   "codec Capture";
 		convert-rate = <48000>;
 
-- 
2.14.1
