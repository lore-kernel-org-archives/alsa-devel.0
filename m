From: Petr Kulhavy <petr@barix.com>
Subject: [PATCH 1/5] Sound: SOC: TAS571x: added missing
	register literals
Date: Thu, 10 Mar 2016 12:22:37 +0100
Message-ID: <1457608960-16913-1-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
 by alsa0.perex.cz (Postfix) with ESMTP id C86CA260711
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 12:23:59 +0100 (CET)
Received: by mail-wm0-f42.google.com with SMTP id p65so24167532wmp.0
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 03:23:59 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: cernekee@chromium.org, lgirdwood@gmail.com
Cc: petr@barix.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The list of TAS571x registers was incomplete.
Added the missing register definitions up to register 0x25

Signed-off-by: Petr Kulhavy <petr@barix.com>
Tested-by: Petr Kulhavy <petr@barix.com>
---
 sound/soc/codecs/tas571x.c |  4 ++++
 sound/soc/codecs/tas571x.h | 22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index 39307ad..346d3da 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -57,6 +57,10 @@ static int tas571x_register_size(struct tas571x_private *priv, unsigned int reg)
 	case TAS571X_CH1_VOL_REG:
 	case TAS571X_CH2_VOL_REG:
 		return priv->chip->vol_reg_size;
+	case TAS571X_INPUT_MUX_REG:
+	case TAS571X_CH4_SRC_SELECT_REG:
+	case TAS571X_PWM_MUX_REG:
+		return 4;
 	default:
 		return 1;
 	}
diff --git a/sound/soc/codecs/tas571x.h b/sound/soc/codecs/tas571x.h
index 0aee471..cf800c3 100644
--- a/sound/soc/codecs/tas571x.h
+++ b/sound/soc/codecs/tas571x.h
@@ -13,6 +13,10 @@
 #define _TAS571X_H
 
 /* device registers */
+#define TAS571X_CLK_CTRL_REG		0x00
+#define TAS571X_DEV_ID_REG		0x01
+#define TAS571X_ERR_STATUS_REG		0x02
+#define TAS571X_SYS_CTRL_1_REG		0x03
 #define TAS571X_SDI_REG			0x04
 #define TAS571X_SDI_FMT_MASK		0x0f
 
@@ -27,7 +31,25 @@
 #define TAS571X_MVOL_REG		0x07
 #define TAS571X_CH1_VOL_REG		0x08
 #define TAS571X_CH2_VOL_REG		0x09
+#define TAS571X_CH3_VOL_REG		0x0a
+#define TAS571X_VOL_CFG_REG		0x0e
+#define TAS571X_MODULATION_LIMIT_REG	0x10
+#define TAS571X_IC_DELAY_CH1_REG	0x11
+#define TAS571X_IC_DELAY_CH2_REG	0x12
+#define TAS571X_IC_DELAY_CH3_REG	0x13
+#define TAS571X_IC_DELAY_CH4_REG	0x14
 
+#define TAS571X_PWM_CH_SDN_GROUP_REG	0x19	/* N/A on TAS5717, TAS5719 */
+#define TAS571X_PWM_CH1_SDN_MASK	(1<<0)
+#define TAS571X_PWM_CH2_SDN_SHIFT	(1<<1)
+#define TAS571X_PWM_CH3_SDN_SHIFT	(1<<2)
+#define TAS571X_PWM_CH4_SDN_SHIFT	(1<<3)
+
+#define TAS571X_START_STOP_PERIOD_REG	0x1a
 #define TAS571X_OSC_TRIM_REG		0x1b
+#define TAS571X_BKND_ERR_REG		0x1c
+#define TAS571X_INPUT_MUX_REG		0x20
+#define TAS571X_CH4_SRC_SELECT_REG	0x21
+#define TAS571X_PWM_MUX_REG		0x25
 
 #endif /* _TAS571X_H */
-- 
1.9.1
