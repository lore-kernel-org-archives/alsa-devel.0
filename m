From: RongJun Ying <rjying@gmail.com>
Subject: [PATCH 2/2] Documentation: Describe the SiRF audio hub
	Device Tree bindings
Date: Thu, 13 Mar 2014 18:38:31 +0800
Message-ID: <1394707111-9539-3-git-send-email-rongjun.ying@csr.com>
References: <1394707111-9539-1-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
 [209.85.220.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E9BF265173
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 11:39:52 +0100 (CET)
Received: by mail-pa0-f50.google.com with SMTP id kq14so938668pab.9
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 03:39:51 -0700 (PDT)
In-Reply-To: <1394707111-9539-1-git-send-email-rongjun.ying@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, rjying@gmail.com
Cc: Takashi Iwai <tiwai@suse.de>, Rongjun Ying <rongjun.ying@csr.com>, alsa-devel@alsa-project.org, workgroup.linux@csr.com
List-Id: alsa-devel@alsa-project.org

From: Rongjun Ying <rongjun.ying@csr.com>

Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
---
 .../devicetree/bindings/sound/sirf-audio-hub.txt   |   52 ++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/sirf-audio-hub.txt

diff --git a/Documentation/devicetree/bindings/sound/sirf-audio-hub.txt b/Documentation/devicetree/bindings/sound/sirf-audio-hub.txt
new file mode 100644
index 0000000..4f148a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sirf-audio-hub.txt
@@ -0,0 +1,52 @@
+SiRF audio hub
+
+The audio hub is the consist of an internal audio codec, internal
+audio port and i2s controller. There are sharing same register
+address space.
+
+Required properties:
+- compatible: Must be "sirf,audio-hub"
+- reg : The register address of the device
+- #address-cells: Must be 1
+- #size-cells: Must be 1
+
+Nodes:
+Internal audio codec:
+- compatible : "sirf,atlas6-audio-codec" or "sirf,prima2-audio-codec"
+- clocks: A phandle reference to the SiRF internal audio codec clock
+
+Internal audio port:
+- compatible: "sirf,audio-port"
+
+I2S controller:
+- compatible: "sirf,prima2-i2s"
+- clocks: A phandle reference to the SiRF I2S controller clock
+
+Example:
+sirf_audio_hub: audio_hub@b0040000 {
+	compatible = "sirf,audio-hub";
+	reg = <0xb0040000 0x10000>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	audiocodec: audiocodec {
+		compatible = "sirf,atlas6-audio-codec";
+		interrupts = <35>;
+		clocks = <&clks 27>;
+	};
+
+	audioport: audioport {
+		compatible = "sirf,audio-port";
+		dmas = <&dmac1 3>, <&dmac1 8>;
+		dma-names = "rx", "tx";
+	};
+
+	i2s: i2s {
+		compatible = "sirf,prima2-i2s";
+		dmas = <&dmac1 6>, <&dmac1 12>;
+		dma-names = "rx", "tx";
+		clocks = <&clks 27>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s_pins_a>;
+	};
+};
-- 
1.7.5.4
