From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 04/32] Documentation: Add the AB8500 CODEC
	device to the MFD AB8500 doc
Date: Thu, 20 Sep 2012 14:12:22 +0200
Message-ID: <1348143170-2130-5-git-send-email-lee.jones@linaro.org>
References: <1348143170-2130-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id E42862652E6
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2012 14:13:08 +0200 (CEST)
Received: by wgbed3 with SMTP id ed3so1317052wgb.20
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2012 05:13:08 -0700 (PDT)
In-Reply-To: <1348143170-2130-1-git-send-email-lee.jones@linaro.org>
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
Cc: alsa-devel@alsa-project.org, olof.johansson@gmail.com, linus.walleij@stericsson.com, arnd@arndb.de, STEricsson_nomadik_linux@list.st.com, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

Here we document the AB8500 Audio CODEC in the existing MFD AB8500 document.

CC: alsa-devel@alsa-project.org
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/mfd/ab8500.txt |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/ab8500.txt b/Documentation/devicetree/bindings/mfd/ab8500.txt
index 69e757a..ce83c8d 100644
--- a/Documentation/devicetree/bindings/mfd/ab8500.txt
+++ b/Documentation/devicetree/bindings/mfd/ab8500.txt
@@ -23,6 +23,7 @@ Device                     IRQ Names              Supply Names   Description
 ab8500-bm                :                      :              : Battery Manager
 ab8500-btemp             :                      :              : Battery Temperature
 ab8500-charger           :                      :              : Battery Charger
+ab8500-codec             :                      :              : Audio Codec
 ab8500-fg                :                      :              : Fuel Gauge
 ab8500-gpadc             : HW_CONV_END          : vddadc       : Analogue to Digital Converter
                            SW_CONV_END          :              :
@@ -52,6 +53,14 @@ Optional child device properties:
                            supplied in the interrupts property
 - <supply_name>-supply   : contains a phandle to the regulator supply node in Device Tree
 
+Non-standard child device properties:
+ - Audio CODEC:
+   - stericsson,amic[1|2]-type-single-ended : Single-ended Analoge Mic (default: differential)
+   - stericsson,amic1a-bias-vamic2          : Analoge Mic wishes to use a non-standard Vamic
+   - stericsson,amic1b-bias-vamic2          : Analoge Mic wishes to use a non-standard Vamic
+   - stericsson,amic2-bias-vamic1           : Analoge Mic wishes to use a non-standard Vamic
+   - stericsson,earpeice-cmv                : Earpeice voltage (only: 950 | 1100 | 1270 | 1580)
+
 ab8500@5 {
          compatible = "stericsson,ab8500";
          reg = <5>; /* mailbox 5 is i2c */
@@ -110,6 +119,12 @@ ab8500@5 {
                 compatible = "stericsson,ab8500-pwm";
         };
 
+	codec: ab8500-codec {
+		compatible = "stericsson,ab8500-codec";
+
+		stericsson,earpeice-cmv = <950>; /* Units in mV. */
+	};
+
         ab8500-regulators {
                 compatible = "stericsson,ab8500-regulator";
 
-- 
1.7.9.5
