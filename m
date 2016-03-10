From: Petr Kulhavy <petr@barix.com>
Subject: [PATCH 3/5] Sound: SOC: TAS571x: implemented digital
	mute
Date: Thu, 10 Mar 2016 12:22:39 +0100
Message-ID: <1457608960-16913-3-git-send-email-petr@barix.com>
References: <1457608960-16913-1-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
 by alsa0.perex.cz (Postfix) with ESMTP id E18342612AC
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 12:24:01 +0100 (CET)
Received: by mail-wm0-f53.google.com with SMTP id p65so24183818wmp.1
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 03:24:01 -0800 (PST)
In-Reply-To: <1457608960-16913-1-git-send-email-petr@barix.com>
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

The driver did not have a mute function. The amplifier was brought out of
shutdown mode (hard-mute) once for ever in probe(), which was causing
clicks and pops when altering the I2C register configuration later.

This adds the digital_mute() function. The amplifier unmute in probe()
was removed.

Signed-off-by: Petr Kulhavy <petr@barix.com>
Tested-by: Petr Kulhavy <petr@barix.com>
---
 sound/soc/codecs/tas571x.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index 2a63069..431dffa 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -171,6 +171,23 @@ static int tas571x_hw_params(struct snd_pcm_substream *substream,
 				  TAS571X_SDI_FMT_MASK, val);
 }
 
+static int tas571x_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	u8 sysctl2;
+	int ret;
+
+	sysctl2 = mute ? TAS571X_SYS_CTRL_2_SDN_MASK : 0;
+
+	ret = snd_soc_update_bits(codec,
+			    TAS571X_SYS_CTRL_2_REG,
+		     TAS571X_SYS_CTRL_2_SDN_MASK,
+		     sysctl2);
+	usleep_range(1000, 2000);
+
+	return ret;
+}
+
 static int tas571x_set_bias_level(struct snd_soc_codec *codec,
 				  enum snd_soc_bias_level level)
 {
@@ -218,6 +235,7 @@ static int tas571x_set_bias_level(struct snd_soc_codec *codec,
 static const struct snd_soc_dai_ops tas571x_dai_ops = {
 	.set_fmt	= tas571x_set_dai_fmt,
 	.hw_params	= tas571x_hw_params,
+	.digital_mute	= tas571x_mute,
 };
 
 static const char *const tas5711_supply_names[] = {
@@ -448,10 +466,6 @@ static int tas571x_i2c_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
-	ret = regmap_update_bits(priv->regmap, TAS571X_SYS_CTRL_2_REG,
-				 TAS571X_SYS_CTRL_2_SDN_MASK, 0);
-	if (ret)
-		return ret;
 
 	memcpy(&priv->codec_driver, &tas571x_codec, sizeof(priv->codec_driver));
 	priv->codec_driver.controls = priv->chip->controls;
-- 
1.9.1
