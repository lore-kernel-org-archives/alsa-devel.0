From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 17/19] Documentation: Define the MOP500
 Audio Machine Driver Device Tree bindings
Date: Thu, 2 Aug 2012 13:12:56 +0100
Message-ID: <20120802121255.GA22201@gmail.com>
References: <1343741953-17828-1-git-send-email-lee.jones@linaro.org>
 <1343741953-17828-18-git-send-email-lee.jones@linaro.org>
 <20120731135337.GM4468@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 57037265029
 for <alsa-devel@alsa-project.org>; Thu,  2 Aug 2012 14:12:58 +0200 (CEST)
Received: by eeke50 with SMTP id e50so1881802eek.38
 for <alsa-devel@alsa-project.org>; Thu, 02 Aug 2012 05:13:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120731135337.GM4468@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, linux-kernel@vger.kernel.org, olalilja@yahoo.se, STEricsson_nomadik_linux@list.st.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 31 Jul 2012 11:56:51 +0100
Subject: [PATCH 1/1] Documentation: Define the MOP500 Audio Machine Driver
 Device Tree bindings

Here we add the required documentation for the new Device Tree
bindings pertaining to the MOP500 Audio Machine driver.

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
