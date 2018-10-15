From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 2/4] ASoC: dt-bindings: add mclk support to
	cs42l51
Date: Mon, 15 Oct 2018 16:03:34 +0200
Message-ID: <1539612216-12602-3-git-send-email-olivier.moysan@st.com>
References: <1539612216-12602-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 58155267737
 for <alsa-devel@alsa-project.org>; Mon, 15 Oct 2018 16:03:42 +0200 (CEST)
In-Reply-To: <1539612216-12602-1-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

Add clocks properties to cs42l51 Cirrus codec,
to support master clock provider.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 Documentation/devicetree/bindings/sound/cs42l51.txt   | 17 +++++++++++++++++
 Documentation/devicetree/bindings/trivial-devices.txt |  1 -
 2 files changed, 17 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/cs42l51.txt

diff --git a/Documentation/devicetree/bindings/sound/cs42l51.txt b/Documentation/devicetree/bindings/sound/cs42l51.txt
new file mode 100644
index 000000000000..4b5de33ce377
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cs42l51.txt
@@ -0,0 +1,17 @@
+CS42L51 audio CODEC
+
+Optional properties:
+
+  - clocks : a list of phandles + clock-specifiers, one for each entry in
+    clock-names
+
+  - clock-names : must contain "MCLK"
+
+Example:
+
+cs42l51: cs42l51@4a {
+	compatible = "cirrus,cs42l51";
+	reg = <0x4a>;
+	clocks = <&mclk_prov>;
+	clock-names = "MCLK";
+};
diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
index 763a2808a95c..69c934aec13b 100644
--- a/Documentation/devicetree/bindings/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/trivial-devices.txt
@@ -35,7 +35,6 @@ at,24c08		i2c serial eeprom  (24cxx)
 atmel,at97sc3204t	i2c trusted platform module (TPM)
 capella,cm32181		CM32181: Ambient Light Sensor
 capella,cm3232		CM3232: Ambient Light Sensor
-cirrus,cs42l51		Cirrus Logic CS42L51 audio codec
 dallas,ds1374		I2C, 32-Bit Binary Counter Watchdog RTC with Trickle Charger and Reset Input/Output
 dallas,ds1631		High-Precision Digital Thermometer
 dallas,ds1672		Dallas DS1672 Real-time Clock
-- 
2.7.4
