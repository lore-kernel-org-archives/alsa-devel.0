From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 1/7] ASoC: dt-bindings: update cs42l51 bindings
Date: Wed, 3 Apr 2019 15:23:31 +0200
Message-ID: <1554297817-14154-2-git-send-email-olivier.moysan@st.com>
References: <1554297817-14154-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1554297817-14154-1-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com, apatard@mandriva.com
List-Id: alsa-devel@alsa-project.org

Add compatible, reg, regulator, and reset
to Cirrus CS42L51 audio codec bindings.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 Documentation/devicetree/bindings/sound/cs42l51.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/cs42l51.txt b/Documentation/devicetree/bindings/sound/cs42l51.txt
index 4b5de33ce377..acbd68ddd2cb 100644
--- a/Documentation/devicetree/bindings/sound/cs42l51.txt
+++ b/Documentation/devicetree/bindings/sound/cs42l51.txt
@@ -1,6 +1,17 @@
 CS42L51 audio CODEC
 
+Required properties:
+
+  - compatible : "cirrus,cs42l51"
+
+  - reg : the I2C address of the device for I2C.
+
 Optional properties:
+  - VL-supply, VD-supply, VA-supply, VAHP-supply: power supplies for the device,
+    as covered in Documentation/devicetree/bindings/regulator/regulator.txt.
+
+  - reset-gpios : GPIO specification for the reset pin. If specified, it will be
+    deasserted before starting the communication with the codec.
 
   - clocks : a list of phandles + clock-specifiers, one for each entry in
     clock-names
@@ -14,4 +25,9 @@ cs42l51: cs42l51@4a {
 	reg = <0x4a>;
 	clocks = <&mclk_prov>;
 	clock-names = "MCLK";
+	VL-supply = <&reg_audio>;
+	VD-supply = <&reg_audio>;
+	VA-supply = <&reg_audio>;
+	VAHP-supply = <&reg_audio>;
+	reset-gpios = <&gpiog 9 GPIO_ACTIVE_LOW>;
 };
-- 
2.7.4
