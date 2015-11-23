From: Damien Horsley <Damien.Horsley@imgtec.com>
Subject: [PATCH 1/2] ASoC: img: Add binding document for
	Pistachio internal DAC
Date: Mon, 23 Nov 2015 17:24:58 +0000
Message-ID: <1448299499-18435-2-git-send-email-Damien.Horsley@imgtec.com>
References: <1448299499-18435-1-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 5991A26572D
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 18:28:09 +0100 (CET)
In-Reply-To: <1448299499-18435-1-git-send-email-Damien.Horsley@imgtec.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, "Damien.Horsley" <Damien.Horsley@imgtec.com>
List-Id: alsa-devel@alsa-project.org

From: "Damien.Horsley" <Damien.Horsley@imgtec.com>

Add binding document for Pistachio Internal DAC

Signed-off-by: Damien.Horsley <Damien.Horsley@imgtec.com>
---
 .../bindings/sound/img,pistachio-internal-dac.txt      | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/img,pistachio-internal-dac.txt

diff --git a/Documentation/devicetree/bindings/sound/img,pistachio-internal-dac.txt b/Documentation/devicetree/bindings/sound/img,pistachio-internal-dac.txt
new file mode 100644
index 0000000..4cc18fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/img,pistachio-internal-dac.txt
@@ -0,0 +1,18 @@
+Pistachio internal DAC DT bindings
+
+Required properties:
+
+  - compatible: "img,pistachio-internal-dac"
+
+  - img,cr-top : Must contain a phandle to the top level control syscon
+		 node which contains the internal dac control registers
+
+  - VDD-supply : Digital power supply regulator (+1.8V or +3.3V)
+
+Examples:
+
+internal_dac: internal-dac {
+	compatible = "img,pistachio-internal-dac";
+	img,cr-top = <&cr_top>;
+	VDD-supply = <&supply3v3>;
+};
-- 
2.1.4
