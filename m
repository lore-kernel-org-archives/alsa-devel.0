From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v2 3/5] ASoC: tda998x: add DT documentation
Date: Thu, 30 Jan 2014 11:32:48 +0100
Message-ID: <5c20133f084ba9e41c00120b8a7c8d5ed8a23ffa.1391081934.git.moinejf@free.fr>
References: <cover.1391081933.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <cover.1391081933.git.moinejf@free.fr>
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

This patch adds the DT documentation of the NXP TDA998x CODEC.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 Documentation/devicetree/bindings/sound/tda998x.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tda998x.txt

diff --git a/Documentation/devicetree/bindings/sound/tda998x.txt b/Documentation/devicetree/bindings/sound/tda998x.txt
new file mode 100644
index 0000000..13b73ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tda998x.txt
@@ -0,0 +1,16 @@
+Device-Tree bindings for the NXP TDA998x HDMI transmitter
+
+Required properties:
+	- compatible: must be "nxp,tda998x-codec".
+	- audio-ports: one or two values corresponding to entries in
+		the audio-port-names property.
+	- audio-port-names: must contain "i2s", "spdif" entries
+		matching entries in the audio-ports property.
+
+Example node:
+
+	hdmi_codec: hdmi-codec {
+		compatible = "nxp,tda998x-codec";
+		audio-ports = <0x03>, <0x04>;
+		audio-port-names = "i2s", "spdif";
+	};
-- 
1.9.rc1
