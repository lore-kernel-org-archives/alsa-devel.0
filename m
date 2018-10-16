From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v4 4/9] ASoC: dt-binding: Add bindings for
	Allwinner A64 codec's analog path controls
Date: Mon, 15 Oct 2018 20:02:34 -0700
Message-ID: <20181016030239.15449-5-anarsoul@gmail.com>
References: <20181016030239.15449-1-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E5302677F5
 for <alsa-devel@alsa-project.org>; Tue, 16 Oct 2018 05:02:52 +0200 (CEST)
Received: by mail-pg1-f193.google.com with SMTP id c10-v6so10109560pgq.4
 for <alsa-devel@alsa-project.org>; Mon, 15 Oct 2018 20:02:52 -0700 (PDT)
In-Reply-To: <20181016030239.15449-1-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Marcus Cooper <codekipper@gmail.com>, Mylene JOSSERAND <mylene.josserand@free-electrons.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
List-Id: alsa-devel@alsa-project.org

The internal codec on Allwinner A64 is split into 2 parts. The
analog path controls are routed through an embedded custom register
bus accessed through the PRCM block just as on A23/A33/H3.

Add a binding for this hardware.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../bindings/sound/sun50i-codec-analog.txt           | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt

diff --git a/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt b/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt
new file mode 100644
index 000000000000..4f8ad0e04d20
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt
@@ -0,0 +1,12 @@
+* Allwinner A64 Codec Analog Controls
+
+Required properties:
+- compatible: must be one of the following compatibles:
+		- "allwinner,sun50i-a64-codec-analog"
+- reg: must contain the registers location and length
+
+Example:
+	codec_analog: codec-analog@1f015c0 {
+		compatible = "allwinner,sun50i-a64-codec-analog";
+		reg = <0x01f015c0 0x4>;
+	};
-- 
2.19.0
