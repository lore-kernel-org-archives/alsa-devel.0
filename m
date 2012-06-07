From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm2000: Always use a 4s timeout for the
	firmware
Date: Fri,  8 Jun 2012 06:54:44 +0800
Message-ID: <1339109684-23743-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DB981045FA
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2012 02:53:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Rather than having varying timeouts depending on the transition always
use a 4s timeout. This provides better diagnostics for clocking errors
and ensures compatibility with current calibration firmwares.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm2000.c |   59 ++++++++++++++++-----------------------------
 1 file changed, 21 insertions(+), 38 deletions(-)

diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index 78a148f..3fd5b29 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -99,8 +99,9 @@ static void wm2000_reset(struct wm2000_priv *wm2000)
 }
 
 static int wm2000_poll_bit(struct i2c_client *i2c,
-			   unsigned int reg, u8 mask, int timeout)
+			   unsigned int reg, u8 mask)
 {
+	int timeout = 4000;
 	int val;
 
 	val = wm2000_read(i2c, reg);
@@ -119,7 +120,7 @@ static int wm2000_poll_bit(struct i2c_client *i2c,
 static int wm2000_power_up(struct i2c_client *i2c, int analogue)
 {
 	struct wm2000_priv *wm2000 = dev_get_drvdata(&i2c->dev);
-	int ret, timeout;
+	int ret;
 
 	BUG_ON(wm2000->anc_mode != ANC_OFF);
 
@@ -140,13 +141,13 @@ static int wm2000_power_up(struct i2c_client *i2c, int analogue)
 
 	/* Wait for ANC engine to become ready */
 	if (!wm2000_poll_bit(i2c, WM2000_REG_ANC_STAT,
-			     WM2000_ANC_ENG_IDLE, 1)) {
+			     WM2000_ANC_ENG_IDLE)) {
 		dev_err(&i2c->dev, "ANC engine failed to reset\n");
 		return -ETIMEDOUT;
 	}
 
 	if (!wm2000_poll_bit(i2c, WM2000_REG_SYS_STATUS,
-			     WM2000_STATUS_BOOT_COMPLETE, 1)) {
+			     WM2000_STATUS_BOOT_COMPLETE)) {
 		dev_err(&i2c->dev, "ANC engine failed to initialise\n");
 		return -ETIMEDOUT;
 	}
@@ -173,16 +174,13 @@ static int wm2000_power_up(struct i2c_client *i2c, int analogue)
 	dev_dbg(&i2c->dev, "Download complete\n");
 
 	if (analogue) {
-		timeout = 248;
-		wm2000_write(i2c, WM2000_REG_ANA_VMID_PU_TIME, timeout / 4);
+		wm2000_write(i2c, WM2000_REG_ANA_VMID_PU_TIME, 248 / 4);
 
 		wm2000_write(i2c, WM2000_REG_SYS_MODE_CNTRL,
 			     WM2000_MODE_ANA_SEQ_INCLUDE |
 			     WM2000_MODE_MOUSE_ENABLE |
 			     WM2000_MODE_THERMAL_ENABLE);
 	} else {
-		timeout = 10;
-
 		wm2000_write(i2c, WM2000_REG_SYS_MODE_CNTRL,
 			     WM2000_MODE_MOUSE_ENABLE |
 			     WM2000_MODE_THERMAL_ENABLE);
@@ -201,9 +199,8 @@ static int wm2000_power_up(struct i2c_client *i2c, int analogue)
 	wm2000_write(i2c, WM2000_REG_SYS_CTL2, WM2000_ANC_INT_N_CLR);
 
 	if (!wm2000_poll_bit(i2c, WM2000_REG_SYS_STATUS,
-			     WM2000_STATUS_MOUSE_ACTIVE, timeout)) {
-		dev_err(&i2c->dev, "Timed out waiting for device after %dms\n",
-			timeout * 10);
+			     WM2000_STATUS_MOUSE_ACTIVE)) {
+		dev_err(&i2c->dev, "Timed out waiting for device\n");
 		return -ETIMEDOUT;
 	}
 
@@ -218,28 +215,25 @@ static int wm2000_power_up(struct i2c_client *i2c, int analogue)
 static int wm2000_power_down(struct i2c_client *i2c, int analogue)
 {
 	struct wm2000_priv *wm2000 = dev_get_drvdata(&i2c->dev);
-	int timeout;
 
 	if (analogue) {
-		timeout = 248;
-		wm2000_write(i2c, WM2000_REG_ANA_VMID_PD_TIME, timeout / 4);
+		wm2000_write(i2c, WM2000_REG_ANA_VMID_PD_TIME, 248 / 4);
 		wm2000_write(i2c, WM2000_REG_SYS_MODE_CNTRL,
 			     WM2000_MODE_ANA_SEQ_INCLUDE |
 			     WM2000_MODE_POWER_DOWN);
 	} else {
-		timeout = 10;
 		wm2000_write(i2c, WM2000_REG_SYS_MODE_CNTRL,
 			     WM2000_MODE_POWER_DOWN);
 	}
 
 	if (!wm2000_poll_bit(i2c, WM2000_REG_SYS_STATUS,
-			     WM2000_STATUS_POWER_DOWN_COMPLETE, timeout)) {
+			     WM2000_STATUS_POWER_DOWN_COMPLETE)) {
 		dev_err(&i2c->dev, "Timeout waiting for ANC power down\n");
 		return -ETIMEDOUT;
 	}
 
 	if (!wm2000_poll_bit(i2c, WM2000_REG_ANC_STAT,
-			     WM2000_ANC_ENG_IDLE, 1)) {
+			     WM2000_ANC_ENG_IDLE)) {
 		dev_err(&i2c->dev, "Timeout waiting for ANC engine idle\n");
 		return -ETIMEDOUT;
 	}
@@ -268,13 +262,13 @@ static int wm2000_enter_bypass(struct i2c_client *i2c, int analogue)
 	}
 
 	if (!wm2000_poll_bit(i2c, WM2000_REG_SYS_STATUS,
-			     WM2000_STATUS_ANC_DISABLED, 10)) {
+			     WM2000_STATUS_ANC_DISABLED)) {
 		dev_err(&i2c->dev, "Timeout waiting for ANC disable\n");
 		return -ETIMEDOUT;
 	}
 
 	if (!wm2000_poll_bit(i2c, WM2000_REG_ANC_STAT,
-			     WM2000_ANC_ENG_IDLE, 1)) {
+			     WM2000_ANC_ENG_IDLE)) {
 		dev_err(&i2c->dev, "Timeout waiting for ANC engine idle\n");
 		return -ETIMEDOUT;
 	}
@@ -311,7 +305,7 @@ static int wm2000_exit_bypass(struct i2c_client *i2c, int analogue)
 	wm2000_write(i2c, WM2000_REG_SYS_CTL2, WM2000_ANC_INT_N_CLR);
 
 	if (!wm2000_poll_bit(i2c, WM2000_REG_SYS_STATUS,
-			     WM2000_STATUS_MOUSE_ACTIVE, 10)) {
+			     WM2000_STATUS_MOUSE_ACTIVE)) {
 		dev_err(&i2c->dev, "Timed out waiting for MOUSE\n");
 		return -ETIMEDOUT;
 	}
@@ -325,38 +319,32 @@ static int wm2000_exit_bypass(struct i2c_client *i2c, int analogue)
 static int wm2000_enter_standby(struct i2c_client *i2c, int analogue)
 {
 	struct wm2000_priv *wm2000 = dev_get_drvdata(&i2c->dev);
-	int timeout;
 
 	BUG_ON(wm2000->anc_mode != ANC_ACTIVE);
 
 	if (analogue) {
-		timeout = 248;
-		wm2000_write(i2c, WM2000_REG_ANA_VMID_PD_TIME, timeout / 4);
+		wm2000_write(i2c, WM2000_REG_ANA_VMID_PD_TIME, 248 / 4);
 
 		wm2000_write(i2c, WM2000_REG_SYS_MODE_CNTRL,
 			     WM2000_MODE_ANA_SEQ_INCLUDE |
 			     WM2000_MODE_THERMAL_ENABLE |
 			     WM2000_MODE_STANDBY_ENTRY);
 	} else {
-		timeout = 10;
-
 		wm2000_write(i2c, WM2000_REG_SYS_MODE_CNTRL,
 			     WM2000_MODE_THERMAL_ENABLE |
 			     WM2000_MODE_STANDBY_ENTRY);
 	}
 
 	if (!wm2000_poll_bit(i2c, WM2000_REG_SYS_STATUS,
-			     WM2000_STATUS_ANC_DISABLED, timeout)) {
+			     WM2000_STATUS_ANC_DISABLED)) {
 		dev_err(&i2c->dev,
 			"Timed out waiting for ANC disable after 1ms\n");
 		return -ETIMEDOUT;
 	}
 
-	if (!wm2000_poll_bit(i2c, WM2000_REG_ANC_STAT, WM2000_ANC_ENG_IDLE,
-			     1)) {
+	if (!wm2000_poll_bit(i2c, WM2000_REG_ANC_STAT, WM2000_ANC_ENG_IDLE)) {
 		dev_err(&i2c->dev,
-			"Timed out waiting for standby after %dms\n",
-			timeout * 10);
+			"Timed out waiting for standby\n");
 		return -ETIMEDOUT;
 	}
 
@@ -374,23 +362,19 @@ static int wm2000_enter_standby(struct i2c_client *i2c, int analogue)
 static int wm2000_exit_standby(struct i2c_client *i2c, int analogue)
 {
 	struct wm2000_priv *wm2000 = dev_get_drvdata(&i2c->dev);
-	int timeout;
 
 	BUG_ON(wm2000->anc_mode != ANC_STANDBY);
 
 	wm2000_write(i2c, WM2000_REG_SYS_CTL1, 0);
 
 	if (analogue) {
-		timeout = 248;
-		wm2000_write(i2c, WM2000_REG_ANA_VMID_PU_TIME, timeout / 4);
+		wm2000_write(i2c, WM2000_REG_ANA_VMID_PU_TIME, 248 / 4);
 
 		wm2000_write(i2c, WM2000_REG_SYS_MODE_CNTRL,
 			     WM2000_MODE_ANA_SEQ_INCLUDE |
 			     WM2000_MODE_THERMAL_ENABLE |
 			     WM2000_MODE_MOUSE_ENABLE);
 	} else {
-		timeout = 10;
-
 		wm2000_write(i2c, WM2000_REG_SYS_MODE_CNTRL,
 			     WM2000_MODE_THERMAL_ENABLE |
 			     WM2000_MODE_MOUSE_ENABLE);
@@ -400,9 +384,8 @@ static int wm2000_exit_standby(struct i2c_client *i2c, int analogue)
 	wm2000_write(i2c, WM2000_REG_SYS_CTL2, WM2000_ANC_INT_N_CLR);
 
 	if (!wm2000_poll_bit(i2c, WM2000_REG_SYS_STATUS,
-			     WM2000_STATUS_MOUSE_ACTIVE, timeout)) {
-		dev_err(&i2c->dev, "Timed out waiting for MOUSE after %dms\n",
-			timeout * 10);
+			     WM2000_STATUS_MOUSE_ACTIVE)) {
+		dev_err(&i2c->dev, "Timed out waiting for MOUSE\n");
 		return -ETIMEDOUT;
 	}
 
-- 
1.7.10
