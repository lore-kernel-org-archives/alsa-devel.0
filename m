From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 06/17] Documentation: Define the MOP500 Audio
	Machine Driver Device Tree bindings
Date: Fri, 24 Aug 2012 15:01:42 +0100
Message-ID: <1345816913-4113-7-git-send-email-lee.jones@linaro.org>
References: <1345816913-4113-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
 [209.85.212.173])
 by alsa0.perex.cz (Postfix) with ESMTP id A57AB265EC0
 for <alsa-devel@alsa-project.org>; Fri, 24 Aug 2012 16:02:22 +0200 (CEST)
Received: by wibhm6 with SMTP id hm6so746017wib.2
 for <alsa-devel@alsa-project.org>; Fri, 24 Aug 2012 07:02:22 -0700 (PDT)
In-Reply-To: <1345816913-4113-1-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, roger.xr.nilsson@stericsson.com, broonie@opensource.wolfsonmicro.com, STEricsson_nomadik_linux@list.st.com, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

Here we add the required documentation for the new Device Tree
bindings pertaining to the MOP500 Audio Machine driver.

CC: alsa-devel@alsa-project.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/sound/ux500-mop500.txt     |   39 ++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ux500-mop500.txt

diff --git a/Documentation/devicetree/bindings/sound/ux500-mop500.txt b/Documentation/devicetree/bindings/sound/ux500-mop500.txt
new file mode 100644
index 0000000..48e071c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ux500-mop500.txt
@@ -0,0 +1,39 @@
+* MOP500 Audio Machine Driver
+
+This node is responsible for linking together all ux500 Audio Driver components.
+
+Required properties:
+ - compatible              : "stericsson,snd-soc-mop500"
+
+Non-standard properties:
+ - stericsson,cpu-dai      : Phandle to the CPU-side DAI
+ - stericsson,audio-codec  : Phandle to the Audio CODEC
+ - stericsson,card-name    : Over-ride default card name
+
+Example:
+
+	sound {
+		compatible = "stericsson,snd-soc-mop500";
+
+		stericsson,cpu-dai = <&msp1 &msp3>;
+		stericsson,audio-codec = <&codec>;
+	};
+
+	msp1: msp@80124000 {
+		compatible = "stericsson,ux500-msp-i2s";
+		reg = <0x80124000 0x1000>;
+		interrupts = <0 62 0x4>;
+		v-ape-supply = <&db8500_vape_reg>;
+	};
+
+	msp3: msp@80125000 {
+		compatible = "stericsson,ux500-msp-i2s";
+		reg = <0x80125000 0x1000>;
+		interrupts = <0 62 0x4>;
+		v-ape-supply = <&db8500_vape_reg>;
+	};
+
+	codec: ab8500-codec {
+		compatible = "stericsson,ab8500-codec";
+		stericsson,earpeice-cmv = <950>; /* Units in mV. */
+	};
-- 
1.7.9.5
