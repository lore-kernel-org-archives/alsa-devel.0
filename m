From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: ASoC: MAX9877: fix write operation for register
Date: Thu, 23 Jul 2009 17:33:17 +0900
Message-ID: <4A68204D.7040201@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by alsa0.perex.cz (Postfix) with ESMTP id E67FA1039BE
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jul 2009 10:44:48 +0200 (CEST)
Received: from epmmp1 (mailout4.samsung.com [203.254.224.34])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KN800APZ7RHT3@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Thu, 23 Jul 2009 17:33:18 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KN8004367RH6R@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Thu, 23 Jul 2009 17:33:17 +0900 (KST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: kyungmin.park@samsung.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The MAX9877 needs an address of start register when we write values to
registers through i2c_master_send(), but the code for this was missed in
max9877_write_regs().

If the value of control is 0 in the max9877_set_out_mode(), the value is
not increased to 1, but actually the value to write to the register
should be 1.
And the register bits for out_mode and osc_mode should be cleared before
writing.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 sound/soc/codecs/max9877.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max9877.c b/sound/soc/codecs/max9877.c
index a1f1119..9e7e964 100644
--- a/sound/soc/codecs/max9877.c
+++ b/sound/soc/codecs/max9877.c
@@ -25,7 +25,14 @@ static u8 max9877_regs[5] = { 0x40, 0x00, 0x00, 0x00, 0x49 };
 
 static void max9877_write_regs(void)
 {
-	if (i2c_master_send(i2c, max9877_regs, 5) != 5)
+	unsigned int i;
+	u8 data[6];
+
+	data[0] = MAX9877_INPUT_MODE;
+	for (i = 0; i < ARRAY_SIZE(max9877_regs); i++)
+		data[i + 1] = max9877_regs[i];
+
+	if (i2c_master_send(i2c, data, 6) != 6)
 		dev_err(&i2c->dev, "i2c write failed\n");
 }
 
@@ -135,12 +142,12 @@ static int max9877_set_out_mode(struct snd_kcontrol *kcontrol,
 {
 	u8 value = ucontrol->value.integer.value[0];
 
-	if (value)
-		value += 1;
+	value += 1;
 
 	if ((max9877_regs[MAX9877_OUTPUT_MODE] & MAX9877_OUTMODE_MASK) == value)
 		return 0;
 
+	max9877_regs[MAX9877_OUTPUT_MODE] &= ~MAX9877_OUTMODE_MASK;
 	max9877_regs[MAX9877_OUTPUT_MODE] |= value;
 	max9877_write_regs();
 	return 1;
@@ -166,6 +173,7 @@ static int max9877_set_osc_mode(struct snd_kcontrol *kcontrol,
 	if ((max9877_regs[MAX9877_OUTPUT_MODE] & MAX9877_OSC_MASK) == value)
 		return 0;
 
+	max9877_regs[MAX9877_OUTPUT_MODE] &= ~MAX9877_OSC_MASK;
 	max9877_regs[MAX9877_OUTPUT_MODE] |= value;
 	max9877_write_regs();
 	return 1;
-- 
1.6.0.4
