From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH 3/4] ASoC: tda998x: add DT documentation
Date: Mon, 27 Jan 2014 09:34:49 +0100
Message-ID: <22fafd7e11771ffc25c84ff609d18039f07b7295.1390813481.git.moinejf@free.fr>
References: <cover.1390813480.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <cover.1390813480.git.moinejf@free.fr>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces@lists.freedesktop.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, broonie@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Add devicetree documentation about the NXP TDA998x CODEC.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 Documentation/devicetree/bindings/sound/tda998x.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tda998x.txt

diff --git a/Documentation/devicetree/bindings/sound/tda998x.txt b/Documentation/devicetree/bindings/sound/tda998x.txt
new file mode 100644
index 0000000..30273a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tda998x.txt
@@ -0,0 +1,14 @@
+Device-Tree bindings for the NXP TDA998x HDMI transmitter
+
+Required properties:
+	- compatible: must be "nxp,tda998x-codec".
+	- audio-ports: one or two values.
+		The first value defines the I2S input port.
+		The second one, if present, defines the S/PDIF input port.
+
+Example node:
+
+	hdmi_codec: hdmi-codec {
+		compatible = "nxp,tda998x-codec";
+		audio-ports = <0x03>, <0x04>;
+	};
-- 
1.8.5.3
