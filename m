From: Andreas Dannenberg <dannenberg@ti.com>
Subject: [PATCH v3 1/2] ASoC: codecs: add TA5720 digital
	amplifier DT bindings
Date: Mon, 25 Apr 2016 15:17:35 -0500
Message-ID: <1461615456-19510-2-git-send-email-dannenberg@ti.com>
References: <1461615456-19510-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id E71052650D4
 for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2016 22:17:54 +0200 (CEST)
In-Reply-To: <1461615456-19510-1-git-send-email-dannenberg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Kumar Gala <galak@codeaurora.org>, Andreas Dannenberg <dannenberg@ti.com>
List-Id: alsa-devel@alsa-project.org

The Texas Instruments TAS5720L/M device is a high-efficiency mono
Class-D audio power amplifier optimized for high transient power
capability to use the dynamic power headroom of small loudspeakers.
Its digital time division multiplexed (TDM) interface enables up to
16 devices to share the same bus.

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
---
 .../devicetree/bindings/sound/tas5720.txt          | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tas5720.txt

diff --git a/Documentation/devicetree/bindings/sound/tas5720.txt b/Documentation/devicetree/bindings/sound/tas5720.txt
new file mode 100644
index 0000000..439451e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tas5720.txt
@@ -0,0 +1,26 @@
+Texas Instruments TAS5720 Mono Audio amplifier
+
+The TAS5720 serial control bus communicates through the I2C protocol only. The
+serial bus is also used for periodic codec fault checking/reporting during
+audio playback. For more product information please see the links below:
+
+http://www.ti.com/product/TAS5720L
+http://www.ti.com/product/TAS5720M
+
+Required properties:
+
+- compatible : "ti,tas5720"
+- reg : I2C slave address
+
+Optional properties:
+
+- dvdd-supply : phandle to a 3.3-V supply for the digital circuitry
+- pvdd-supply : phandle to a supply used for the Class-D amp and the analog
+
+Example:
+
+tas5720: tas5720@6c {
+	status = "okay";
+	compatible = "ti,tas5720";
+	reg = <0x6c>;
+};
-- 
2.6.4
