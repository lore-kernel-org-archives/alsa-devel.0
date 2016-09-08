From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 2/2] ASoC: cs4341: Add DT bindings
	documentation for CS4341 CODEC
Date: Thu,  8 Sep 2016 19:30:28 +0300
Message-ID: <1473352228-24044-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp18.mail.ru (smtp18.mail.ru [94.100.176.155])
 by alsa0.perex.cz (Postfix) with ESMTP id 50B4F266B67
 for <alsa-devel@alsa-project.org>; Thu,  8 Sep 2016 18:30:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Brian Austin <brian.austin@cirrus.com>, Alexander Shiyan <shc_work@mail.ru>, Takashi Iwai <tiwai@suse.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

This patch adds DT bindings documentation for Cirrus Logic
CS4341 CODEC.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 Documentation/devicetree/bindings/sound/cs4341.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cs4341.txt

diff --git a/Documentation/devicetree/bindings/sound/cs4341.txt b/Documentation/devicetree/bindings/sound/cs4341.txt
new file mode 100644
index 0000000..78d45be
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cs4341.txt
@@ -0,0 +1,15 @@
+Cirrus Logic CS4341 DT bindings
+
+Required properties:
+ - compatible: "cirrus,cs4341a"
+
+For required properties on SPI, please consult
+Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Example:
+	codec: cs4341@0 {
+		#sound-dai-cells = <0>;
+		compatible = "cirrus,cs4341a";
+		reg = <0>;
+		spi-max-frequency = <6000000>;
+	};
-- 
2.7.3
