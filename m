From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH v2 2/3] arm: dts: rockchip: Don't set otp-gpio
	pinctrl by default in rk3288.dtsi
Date: Mon, 23 Jan 2017 14:47:46 +0100
Message-ID: <20170123134747.1385-3-romain.perier@collabora.com>
References: <20170123134747.1385-1-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by alsa0.perex.cz (Postfix) with ESMTP id 68C9D26686A
 for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2017 14:47:56 +0100 (CET)
In-Reply-To: <20170123134747.1385-1-romain.perier@collabora.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: Romain Perier <romain.perier@collabora.com>, linux-rockchip@lists.infradead.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The tsadc supports two reset methods: the cru and the otp_gpio. All
boards except veyron and the evb simply use the cru-method and reuse the
pin for something else. On the Firefly-RK3288 this is for example the
case with the headphone. To prevent pinctrl-conflicts with these don't
set the otp-gpio pinctrl by default but only in the boards using it.

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---

Changes in v2:
- Added this patch

 arch/arm/boot/dts/rk3288-evb.dtsi    | 4 ++++
 arch/arm/boot/dts/rk3288-veyron.dtsi | 4 ++++
 arch/arm/boot/dts/rk3288.dtsi        | 4 ----
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index bf7ccfa..7160d07 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -290,6 +290,10 @@
 };
 
 &tsadc {
+	pinctrl-names = "init", "default", "sleep";
+	pinctrl-0 = <&otp_gpio>;
+	pinctrl-1 = <&otp_out>;
+	pinctrl-2 = <&otp_gpio>;
 	rockchip,hw-tshut-mode = <0>; /* tshut mode 0:CRU 1:GPIO */
 	rockchip,hw-tshut-polarity = <0>; /* tshut polarity 0:LOW 1:HIGH */
 	status = "okay";
diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 2251d28..e7801d8 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -393,6 +393,10 @@
 &tsadc {
 	status = "okay";
 
+	pinctrl-names = "init", "default", "sleep";
+	pinctrl-0 = <&otp_gpio>;
+	pinctrl-1 = <&otp_out>;
+	pinctrl-2 = <&otp_gpio>;
 	rockchip,hw-tshut-mode = <1>; /* tshut mode 0:CRU 1:GPIO */
 	rockchip,hw-tshut-polarity = <1>; /* tshut polarity 0:LOW 1:HIGH */
 };
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 4fad133..f419e4d 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -532,10 +532,6 @@
 		clock-names = "tsadc", "apb_pclk";
 		resets = <&cru SRST_TSADC>;
 		reset-names = "tsadc-apb";
-		pinctrl-names = "init", "default", "sleep";
-		pinctrl-0 = <&otp_gpio>;
-		pinctrl-1 = <&otp_out>;
-		pinctrl-2 = <&otp_gpio>;
 		#thermal-sensor-cells = <1>;
 		rockchip,hw-tshut-temp = <95000>;
 		status = "disabled";
-- 
2.9.3
