From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-scu-card: tidyup "prefix"
	parsing on Doc" to the asoc tree
Date: Fri, 23 Nov 2018 14:12:50 +0000 (GMT)
Message-ID: <20181123141250.93E6B440078@finisterre.ee.mobilebroadband>
References: <87y39mlz1s.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 448F22678DF
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2018 15:12:52 +0100 (CET)
In-Reply-To: <87y39mlz1s.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-scu-card: tidyup "prefix" parsing on Doc

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

>From f94b0f7f9246013ac158ae3adf194c1bfa1d1847 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Nov 2018 00:55:24 +0000
Subject: [PATCH] ASoC: simple-scu-card: tidyup "prefix" parsing on Doc

simple-scu-card.c is supporting "prefix" which is used to avoid
DAI naming conflict when CPU/Codec matching.
But, sound card might have multi sub-devices, and each codec might need
each prefix.

Now, ASoC is supporting snd_soc_of_parse_node_prefix(), let's support
it on audio-graph-scu-card, too. It is keeping existing DT style.

It can't support each codec's prefix if sound card had multi sub-devices
without this patch.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/simple-scu-card.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-scu-card.txt b/Documentation/devicetree/bindings/sound/simple-scu-card.txt
index 32f8dbce5241..3a2f71616cda 100644
--- a/Documentation/devicetree/bindings/sound/simple-scu-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-scu-card.txt
@@ -75,7 +75,6 @@ sound {
 	simple-audio-card,bitclock-master = <&dpcmcpu>;
 	simple-audio-card,frame-master = <&dpcmcpu>;
 
-	simple-audio-card,prefix = "ak4642";
 	simple-audio-card,routing = "ak4642 Playback", "DAI0 Playback",
 			"ak4642 Playback", "DAI1 Playback";
 
@@ -88,6 +87,7 @@ sound {
 	};
 
 	codec {
+		prefix = "ak4642";
 		sound-dai = <&ak4643>;
 		clocks = <&audio_clock>;
 	};
-- 
2.19.1
