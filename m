From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH v2 7/7] ASoC: binding: for new properties documenting and usage
Date: Fri, 24 Jan 2014 15:43:06 +0800
Message-ID: <1390549386-4702-8-git-send-email-Li.Xiubo@freescale.com>
References: <1390549386-4702-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390549386-4702-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
Cc: rob@landley.net, perex@perex.cz, moinejf@free.fr, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

This add the following three new properties documenting and usage
for simple card:

	"simple-audio-card,name",
	"simple-audio-card,widgets",
	"simple-audio-card,tdm-slot".

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 Documentation/devicetree/bindings/sound/simple-card.txt | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index 19c84df..dea1229 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -8,13 +8,19 @@ Required properties:
 
 Optional properties:
 
+- simple-audio-card,name		: User specified audio sound card name, one string
+					  property.
 - simple-audio-card,format		: CPU/CODEC common audio format.
 					  "i2s", "right_j", "left_j" , "dsp_a"
 					  "dsp_b", "ac97", "pdm", "msb", "lsb"
+- simple-audio-card,widgets		: A list of the off-CODEC widgets, each entry is a pair
+					  of strings, the first being the template widget name,
+					  the second being the user specified widget name.
 - simple-audio-card,routing		: A list of the connections between audio components.
 					  Each entry is a pair of strings, the first being the
 					  connection's sink, the second being the connection's
 					  source.
+- simple-audio-card,tdm-slot		: The configuration of TDM operation for CPU/CODEC DAI.
 
 Required subnodes:
 
@@ -42,11 +48,18 @@ Example:
 
 sound {
 	compatible = "simple-audio-card";
+	simple-audio-card,name = "VF610-Tower-Sound-Card";
 	simple-audio-card,format = "left_j";
+	simple-audio-card,widgets =
+		"Mic", "Microphone Jack",
+		"Hp", "Headphone Jack",
+		"Spk", "External Speaker";
 	simple-audio-card,routing =
-		"MIC_IN", "Mic Jack",
+		"MIC_IN", "Microphone Jack",
 		"Headphone Jack", "HP_OUT",
-		"Ext Spk", "LINE_OUT";
+		"External Speaker", "LINE_OUT";
+
+	simple-audio-card,tdm-slot = <0xffffffc 0xffffffc 2 0>;
 
 	simple-audio-card,cpu {
 		sound-dai = <&sh_fsi2 0>;
-- 
1.8.4
