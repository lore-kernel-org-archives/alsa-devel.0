From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/31] ASoC: wm2000: Use WARN_ON() instead of
	BUG_ON()
Date: Tue,  5 Nov 2013 18:39:53 +0100
Message-ID: <1383673218-18405-7-git-send-email-tiwai@suse.de>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 18D7C2651F2
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:40:42 +0100 (CET)
In-Reply-To: <1383673218-18405-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

BUG_ON() is rather useless for debugging as it leads to panic().
Use WARN_ON() and handle the error cases accordingly.

Cc: patches@opensource.wolfsonmicro.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm2000.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index 7fefd766b582..8ae50274ea8f 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -137,7 +137,8 @@ static int wm2000_power_up(struct i2c_client *i2c, int analogue)
 	unsigned long rate;
 	int ret;
 
-	BUG_ON(wm2000->anc_mode != ANC_OFF);
+	if (WARN_ON(wm2000->anc_mode != ANC_OFF))
+		return -EINVAL;
 
 	dev_dbg(&i2c->dev, "Beginning power up\n");
 
@@ -277,7 +278,8 @@ static int wm2000_enter_bypass(struct i2c_client *i2c, int analogue)
 {
 	struct wm2000_priv *wm2000 = dev_get_drvdata(&i2c->dev);
 
-	BUG_ON(wm2000->anc_mode != ANC_ACTIVE);
+	if (WARN_ON(wm2000->anc_mode != ANC_ACTIVE))
+		return -EINVAL;
 
 	if (analogue) {
 		wm2000_write(i2c, WM2000_REG_SYS_MODE_CNTRL,
@@ -315,7 +317,8 @@ static int wm2000_exit_bypass(struct i2c_client *i2c, int analogue)
 {
 	struct wm2000_priv *wm2000 = dev_get_drvdata(&i2c->dev);
 
-	BUG_ON(wm2000->anc_mode != ANC_BYPASS);
+	if (WARN_ON(wm2000->anc_mode != ANC_BYPASS))
+		return -EINVAL;
 	
 	wm2000_write(i2c, WM2000_REG_SYS_CTL1, 0);
 
@@ -349,7 +352,8 @@ static int wm2000_enter_standby(struct i2c_client *i2c, int analogue)
 {
 	struct wm2000_priv *wm2000 = dev_get_drvdata(&i2c->dev);
 
-	BUG_ON(wm2000->anc_mode != ANC_ACTIVE);
+	if (WARN_ON(wm2000->anc_mode != ANC_ACTIVE))
+		return -EINVAL;
 
 	if (analogue) {
 		wm2000_write(i2c, WM2000_REG_ANA_VMID_PD_TIME, 248 / 4);
@@ -392,7 +396,8 @@ static int wm2000_exit_standby(struct i2c_client *i2c, int analogue)
 {
 	struct wm2000_priv *wm2000 = dev_get_drvdata(&i2c->dev);
 
-	BUG_ON(wm2000->anc_mode != ANC_STANDBY);
+	if (WARN_ON(wm2000->anc_mode != ANC_STANDBY))
+		return -EINVAL;
 
 	wm2000_write(i2c, WM2000_REG_SYS_CTL1, 0);
 
-- 
1.8.4.2
