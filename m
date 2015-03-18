From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 4/7 linux-next] ASoC: rt5631: constify of_device_id array
Date: Wed, 18 Mar 2015 17:48:59 +0100
Message-ID: <1426697344-4884-5-git-send-email-fabf@skynet.be>
References: <1426697344-4884-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426697344-4884-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

of_device_id is always used as const.
(See driver.of_match_table and open firmware functions)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 sound/soc/codecs/rt5631.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index c618527..2c10d77 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -1675,7 +1675,7 @@ static const struct i2c_device_id rt5631_i2c_id[] = {
 MODULE_DEVICE_TABLE(i2c, rt5631_i2c_id);
 
 #ifdef CONFIG_OF
-static struct of_device_id rt5631_i2c_dt_ids[] = {
+static const struct of_device_id rt5631_i2c_dt_ids[] = {
 	{ .compatible = "realtek,rt5631"},
 	{ .compatible = "realtek,alc5631"},
 	{ }
-- 
1.9.1
