From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/2] ASoC: tpa6130a2: Fix for the custom
	kcontrol functions
Date: Fri,  7 May 2010 14:24:11 +0300
Message-ID: <1273231451-6697-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1273231451-6697-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 2903310388D
	for <alsa-devel@alsa-project.org>;
	Fri,  7 May 2010 13:24:49 +0200 (CEST)
In-Reply-To: <1273231451-6697-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Since the functions arre only used for volume register,
change their name, and also fix them to properly
handle the cases, when via soc core the volume is
limited.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tpa6130a2.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 0cf3e38..fa4fa33 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -176,7 +176,7 @@ exit:
 	return ret;
 }
 
-static int tpa6130a2_get_reg(struct snd_kcontrol *kcontrol,
+static int tpa6130a2_get_volsw(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
 	struct soc_mixer_control *mc =
@@ -184,7 +184,8 @@ static int tpa6130a2_get_reg(struct snd_kcontrol *kcontrol,
 	struct tpa6130a2_data *data;
 	unsigned int reg = mc->reg;
 	unsigned int shift = mc->shift;
-	unsigned int mask = mc->max;
+	int max = mc->max;
+	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
 
 	BUG_ON(tpa6130a2_client == NULL);
@@ -197,13 +198,13 @@ static int tpa6130a2_get_reg(struct snd_kcontrol *kcontrol,
 
 	if (invert)
 		ucontrol->value.integer.value[0] =
-			mask - ucontrol->value.integer.value[0];
+			max - ucontrol->value.integer.value[0];
 
 	mutex_unlock(&data->mutex);
 	return 0;
 }
 
-static int tpa6130a2_set_reg(struct snd_kcontrol *kcontrol,
+static int tpa6130a2_put_volsw(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
 	struct soc_mixer_control *mc =
@@ -211,7 +212,8 @@ static int tpa6130a2_set_reg(struct snd_kcontrol *kcontrol,
 	struct tpa6130a2_data *data;
 	unsigned int reg = mc->reg;
 	unsigned int shift = mc->shift;
-	unsigned int mask = mc->max;
+	int max = mc->max;
+	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
 	unsigned int val = (ucontrol->value.integer.value[0] & mask);
 	unsigned int val_reg;
@@ -220,7 +222,7 @@ static int tpa6130a2_set_reg(struct snd_kcontrol *kcontrol,
 	data = i2c_get_clientdata(tpa6130a2_client);
 
 	if (invert)
-		val = mask - val;
+		val = max - val;
 
 	mutex_lock(&data->mutex);
 
@@ -260,7 +262,7 @@ static const unsigned int tpa6130_tlv[] = {
 static const struct snd_kcontrol_new tpa6130a2_controls[] = {
 	SOC_SINGLE_EXT_TLV("TPA6130A2 Headphone Playback Volume",
 		       TPA6130A2_REG_VOL_MUTE, 0, 0x3f, 0,
-		       tpa6130a2_get_reg, tpa6130a2_set_reg,
+		       tpa6130a2_get_volsw, tpa6130a2_put_volsw,
 		       tpa6130_tlv),
 };
 
@@ -274,7 +276,7 @@ static const unsigned int tpa6140_tlv[] = {
 static const struct snd_kcontrol_new tpa6140a2_controls[] = {
 	SOC_SINGLE_EXT_TLV("TPA6140A2 Headphone Playback Volume",
 		       TPA6130A2_REG_VOL_MUTE, 1, 0x1f, 0,
-		       tpa6130a2_get_reg, tpa6130a2_set_reg,
+		       tpa6130a2_get_volsw, tpa6130a2_put_volsw,
 		       tpa6140_tlv),
 };
 
-- 
1.7.1
