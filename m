From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-scu-card: tidyup
	"convert-rate/channels" parsing on Doc" to the asoc tree
Date: Fri, 23 Nov 2018 14:12:07 +0000 (GMT)
Message-ID: <20181123141207.C2618440078@finisterre.ee.mobilebroadband>
References: <87sgzulyzm.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 632FA267A7E
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2018 15:12:09 +0100 (CET)
In-Reply-To: <87sgzulyzm.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: audio-graph-scu-card: tidyup "convert-rate/channels" parsing on Doc

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

>From df976517733e34e9c12828357c19bafea5c90cf5 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Nov 2018 00:56:41 +0000
Subject: [PATCH] ASoC: audio-graph-scu-card: tidyup "convert-rate/channels"
 parsing on Doc

audio-graph-scu-card.c is supporting "convert-rate/channels" which is
used for DPCM.
But, sound card might have multi codecs, and each codec might need
each convert-rate/channels.

This patch supports each codec's convert-rate/channles support.
top node convert-rate/channels will overwrite settings if exist.

It can't support each codec's convert-rate/channels if sound card had
multi codecs without this patch.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/audio-graph-scu-card.txt          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt b/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt
index a3610888e121..62d42768a00b 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt
+++ b/Documentation/devicetree/bindings/sound/audio-graph-scu-card.txt
@@ -80,7 +80,6 @@ Example 2. 2 CPU 1 Codec (Mixing)
 		routing = "codec Playback", "DAI0 Playback",
 			  "codec Playback", "DAI1 Playback",
 			  "DAI0 Capture",   "codec Capture";
-		convert-rate = <48000>;
 
 		dais = <&cpu_port0
 			&cpu_port1>;
@@ -90,6 +89,7 @@ Example 2. 2 CPU 1 Codec (Mixing)
 		...
 
 		audio-graph-card,prefix = "codec";
+		audio-graph-card,convert-rate = <48000>;
 		port {
 			codec_endpoint0: endpoint {
 				remote-endpoint = <&cpu_endpoint0>;
-- 
2.19.1
