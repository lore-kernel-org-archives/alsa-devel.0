From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 2/2] ASoC: simple-card: keep the property's name the same pattern
Date: Tue, 7 Jan 2014 09:15:16 +0800
Message-ID: <1389057316-16787-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Even though we might not have rigor rule for the simple card property names,
according to the existing ones, they are all in a same pattern:

[simple-audio-card,]XXX;

Rename simple-audio-routing to simple-audio-card,routing, and make the simple
card's properties has one unified name.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 Documentation/devicetree/bindings/sound/simple-card.txt | 2 +-
 sound/soc/generic/simple-card.c                         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index 2ee80c76..e9e20ec 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -11,7 +11,7 @@ Optional properties:
 - simple-audio-card,format		: CPU/CODEC common audio format.
 					  "i2s", "right_j", "left_j" , "dsp_a"
 					  "dsp_b", "ac97", "pdm", "msb", "lsb"
-- simple-audio-routing			: A list of the connections between audio components.
+- simple-audio-card,routing		: A list of the connections between audio components.
 					  Each entry is a pair of strings, the first being the
 					  connection's sink, the second being the connection's
 					  source.
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 33c816c..d007760 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -138,9 +138,9 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 		(SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_INV_MASK);
 
 	/* DAPM routes */
-	if (of_property_read_bool(node, "simple-audio-routing")) {
+	if (of_property_read_bool(node, "simple-audio-card,routing")) {
 		ret = snd_soc_of_parse_audio_routing(&info->snd_card,
-					"simple-audio-routing");
+					"simple-audio-card,routing");
 		if (ret)
 			return ret;
 	}
-- 
1.8.4


