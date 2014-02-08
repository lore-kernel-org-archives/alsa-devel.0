From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH v3 4/4] ASoC: binding: for new properties
	documenting and usage
Date: Sat, 8 Feb 2014 15:59:55 +0800
Message-ID: <1391846395-10193-5-git-send-email-Li.Xiubo@freescale.com>
References: <1391846395-10193-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 by alsa0.perex.cz (Postfix) with ESMTP id C49A3261696
 for <alsa-devel@alsa-project.org>; Sat,  8 Feb 2014 10:04:09 +0100 (CET)
In-Reply-To: <1391846395-10193-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This add the following three new properties documenting and usage
for simple card:

"simple-audio-card,name",
"simple-audio-card,widgets",

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 Documentation/devicetree/bindings/sound/simple-card.txt | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index 19c84df..0527358 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -8,9 +8,12 @@ Required properties:
 
 Optional properties:
 
+- simple-audio-card,name		: User specified audio sound card name, one string
+					  property.
 - simple-audio-card,format		: CPU/CODEC common audio format.
 					  "i2s", "right_j", "left_j" , "dsp_a"
 					  "dsp_b", "ac97", "pdm", "msb", "lsb"
+- simple-audio-card,widgets		: Please refer to widgets.txt.
 - simple-audio-card,routing		: A list of the connections between audio components.
 					  Each entry is a pair of strings, the first being the
 					  connection's sink, the second being the connection's
@@ -42,11 +45,16 @@ Example:
 
 sound {
 	compatible = "simple-audio-card";
+	simple-audio-card,name = "VF610-Tower-Sound-Card";
 	simple-audio-card,format = "left_j";
+	simple-audio-card,widgets =
+		"Microphone", "Microphone Jack",
+		"Headphone", "Headphone Jack",
+		"Speaker", "External Speaker";
 	simple-audio-card,routing =
-		"MIC_IN", "Mic Jack",
+		"MIC_IN", "Microphone Jack",
 		"Headphone Jack", "HP_OUT",
-		"Ext Spk", "LINE_OUT";
+		"External Speaker", "LINE_OUT";
 
 	simple-audio-card,cpu {
 		sound-dai = <&sh_fsi2 0>;
-- 
1.8.4
