From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 8/8] Documentation: Add WM8998/WM1814 device tree bindings
Date: Tue, 21 Apr 2015 13:33:56 +0100
Message-ID: <1429619636-25478-9-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1429619636-25478-1-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429619636-25478-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com
Cc: ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 Documentation/devicetree/bindings/mfd/arizona.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/arizona.txt b/Documentation/devicetree/bindings/mfd/arizona.txt
index 7665aa9..a3cb34b 100644
--- a/Documentation/devicetree/bindings/mfd/arizona.txt
+++ b/Documentation/devicetree/bindings/mfd/arizona.txt
@@ -10,6 +10,9 @@ Required properties:
         "wlf,wm5110"
         "wlf,wm8280"
         "wlf,wm8997"
+        "wlf,WM8998"
+        "wlf,wm1814"
+
   - reg : I2C slave address when connected using I2C, chip select number when
     using SPI.
 
-- 
1.7.2.5
