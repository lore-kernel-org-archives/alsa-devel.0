From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH v3 3/4] ASoC: binding: add widgets.txt
Date: Sat, 8 Feb 2014 15:59:54 +0800
Message-ID: <1391846395-10193-4-git-send-email-Li.Xiubo@freescale.com>
References: <1391846395-10193-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 9ADD32616FF
 for <alsa-devel@alsa-project.org>; Sat,  8 Feb 2014 10:03:48 +0100 (CET)
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

Suggested-by: Mark Brown <broonie@linaro.org>
Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 Documentation/devicetree/bindings/sound/widgets.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/widgets.txt

diff --git a/Documentation/devicetree/bindings/sound/widgets.txt b/Documentation/devicetree/bindings/sound/widgets.txt
new file mode 100644
index 0000000..b6de5ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/widgets.txt
@@ -0,0 +1,20 @@
+Widgets:
+
+This mainly specifies audio off-codec DAPM widgets.
+
+Each entry is a pair of strings in DT:
+
+	"template-wname", "user-supplied-wname"
+
+The "template-wname" being the template widget name and currently includes:
+"Microphone", "Line", "Headphone" and "Speaker".
+
+The "user-supplied-wname" being the user specified widget name.
+
+For instance:
+	simple-audio-widgets =
+		"Microphone", "Microphone Jack",
+		"Line", "Line In Jack",
+		"Line", "Line Out Jack",
+		"Headphone", "Headphone Jack",
+		"Speaker", "Speaker External";
-- 
1.8.4
