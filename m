From: pbruskispam@op.pl
Subject: [PATCH - ctxfi driver 1/4] Fix: microphone boost was
	set at +12dB,
	not +20dB (like in Windows driver and in adc_conf structure
	declaration), some comments added
Date: Sun, 13 Mar 2011 16:18:55 +0100
Message-ID: <1300029538-3147-1-git-send-email-pbruskispam@op.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Przemyslaw Bruski <pbruskispam@op.pl>
List-Id: alsa-devel@alsa-project.org

From: Przemyslaw Bruski <pbruskispam@op.pl>


Signed-off-by: Przemyslaw Bruski <pbruskispam@op.pl>

diff --git a/pci/ctxfi/cthw20k2.c b/pci/ctxfi/cthw20k2.c
index b6b11bf..5364164 100644
--- a/pci/ctxfi/cthw20k2.c
+++ b/pci/ctxfi/cthw20k2.c
@@ -1307,10 +1307,10 @@ static int hw_pll_init(struct hw *hw, unsigned int rsr)
 	set_field(&pllctl, PLLCTL_B, 0);
 	if (48000 == rsr) {
 		set_field(&pllctl, PLLCTL_FD, 16 - 2);
-		set_field(&pllctl, PLLCTL_RD, 1 - 1);
+		set_field(&pllctl, PLLCTL_RD, 1 - 1); /* 3000*16/1 = 48000 */
 	} else { /* 44100 */
 		set_field(&pllctl, PLLCTL_FD, 147 - 2);
-		set_field(&pllctl, PLLCTL_RD, 10 - 1);
+		set_field(&pllctl, PLLCTL_RD, 10 - 1); /* 3000*147/10 = 44100 */
 	}
 	hw_write_20kx(hw, PLL_CTL, pllctl);
 	mdelay(40);
@@ -1740,6 +1740,10 @@ static int hw_is_adc_input_selected(struct hw *hw, enum ADCSRC type)
 	return data;
 }
 
+#define MIC_BOOST_0DB 0xCF
+#define MIC_BOOST_STEPS_PER_DB 2
+#define MIC_BOOST_20DB (MIC_BOOST_0DB + 20 * MIC_BOOST_STEPS_PER_DB)
+
 static int hw_adc_input_select(struct hw *hw, enum ADCSRC type)
 {
 	u32 data;
@@ -1751,10 +1755,12 @@ static int hw_adc_input_select(struct hw *hw, enum ADCSRC type)
 		hw_write_20kx(hw, GPIO_DATA, data);
 		hw20k2_i2c_write(hw, MAKE_WM8775_ADDR(WM8775_ADCMC, 0x101),
 				MAKE_WM8775_DATA(0x101)); /* Mic-in */
-		hw20k2_i2c_write(hw, MAKE_WM8775_ADDR(WM8775_AADCL, 0xE7),
-				MAKE_WM8775_DATA(0xE7)); /* +12dB boost */
-		hw20k2_i2c_write(hw, MAKE_WM8775_ADDR(WM8775_AADCR, 0xE7),
-				MAKE_WM8775_DATA(0xE7)); /* +12dB boost */
+		hw20k2_i2c_write(hw,
+				MAKE_WM8775_ADDR(WM8775_AADCL, MIC_BOOST_20DB),
+				MAKE_WM8775_DATA(MIC_BOOST_20DB)); /* +20dB */
+		hw20k2_i2c_write(hw,
+				MAKE_WM8775_ADDR(WM8775_AADCR, MIC_BOOST_20DB),
+				MAKE_WM8775_DATA(MIC_BOOST_20DB)); /* +20dB */
 		break;
 	case ADC_LINEIN:
 		data &= ~(0x1 << 14);
@@ -1827,10 +1833,12 @@ static int hw_adc_init(struct hw *hw, const struct adc_conf *info)
 
 		hw20k2_i2c_write(hw, MAKE_WM8775_ADDR(WM8775_ADCMC, 0x101),
 				MAKE_WM8775_DATA(0x101)); /* Mic-in */
-		hw20k2_i2c_write(hw, MAKE_WM8775_ADDR(WM8775_AADCL, 0xE7),
-				MAKE_WM8775_DATA(0xE7)); /* +12dB boost */
-		hw20k2_i2c_write(hw, MAKE_WM8775_ADDR(WM8775_AADCR, 0xE7),
-				MAKE_WM8775_DATA(0xE7)); /* +12dB boost */
+		hw20k2_i2c_write(hw,
+				MAKE_WM8775_ADDR(WM8775_AADCL, MIC_BOOST_20DB),
+				MAKE_WM8775_DATA(MIC_BOOST_20DB)); /* +20dB */
+		hw20k2_i2c_write(hw,
+				MAKE_WM8775_ADDR(WM8775_AADCR, MIC_BOOST_20DB),
+				MAKE_WM8775_DATA(MIC_BOOST_20DB)); /* +20dB */
 	} else if (mux == 2) {
 		/* Configures GPIO data to select Line-in */
 		data &= ~(0x1 << 14);
-- 
1.7.1
