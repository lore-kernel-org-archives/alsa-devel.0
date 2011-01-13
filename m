From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: [PATCH] ASoC: WL1273 FM radio: Access I2C IO functions
	through pointers.
Date: Thu, 13 Jan 2011 15:22:45 +0200
Message-ID: <1294924965-6358-1-git-send-email-matti.j.aaltonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da02.nokia.com (smtp.nokia.com [147.243.128.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 6EB3610382F
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 14:23:00 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
List-Id: alsa-devel@alsa-project.org

These changes are needed to keep up with the changes in the
MFD core and V4L2 parts of the wl1273 FM radio driver.

Use function pointers instead of exported functions for I2C IO.
Also move all preprocessor constants from the wl1273.h to
include/linux/mfd/wl1273-core.h.

Signed-off-by: Matti J. Aaltonen <matti.j.aaltonen@nokia.com>
---
 sound/soc/codecs/Kconfig  |    2 +-
 sound/soc/codecs/wl1273.c |   29 +++++++-----------
 sound/soc/codecs/wl1273.h |   71 ---------------------------------------------
 3 files changed, 13 insertions(+), 89 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 3b5690d..937517a 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -43,7 +43,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_TWL6040 if TWL4030_CORE
 	select SND_SOC_UDA134X
 	select SND_SOC_UDA1380 if I2C
-	select SND_SOC_WL1273 if WL1273_CORE
+	select SND_SOC_WL1273 if RADIO_WL1273
 	select SND_SOC_WM2000 if I2C
 	select SND_SOC_WM8350 if MFD_WM8350
 	select SND_SOC_WM8400 if MFD_WM8400
diff --git a/sound/soc/codecs/wl1273.c b/sound/soc/codecs/wl1273.c
index 0c47c78..4c22ae9 100644
--- a/sound/soc/codecs/wl1273.c
+++ b/sound/soc/codecs/wl1273.c
@@ -43,7 +43,7 @@ struct wl1273_priv {
 static int snd_wl1273_fm_set_i2s_mode(struct wl1273_core *core,
 				      int rate, int width)
 {
-	struct device *dev = &core->i2c_dev->dev;
+	struct device *dev = &core->client->dev;
 	int r = 0;
 	u16 mode;
 
@@ -124,13 +124,13 @@ static int snd_wl1273_fm_set_i2s_mode(struct wl1273_core *core,
 	dev_dbg(dev, "mode: 0x%04x\n", mode);
 
 	if (core->i2s_mode != mode) {
-		r = wl1273_fm_write_cmd(core, WL1273_I2S_MODE_CONFIG_SET, mode);
+		r = core->write(core, WL1273_I2S_MODE_CONFIG_SET, mode);
 		if (r)
 			goto out;
 
 		core->i2s_mode = mode;
-		r = wl1273_fm_write_cmd(core, WL1273_AUDIO_ENABLE,
-					WL1273_AUDIO_ENABLE_I2S);
+		r = core->write(core, WL1273_AUDIO_ENABLE,
+				WL1273_AUDIO_ENABLE_I2S);
 		if (r)
 			goto out;
 	}
@@ -143,8 +143,7 @@ out:
 static int snd_wl1273_fm_set_channel_number(struct wl1273_core *core,
 					    int channel_number)
 {
-	struct i2c_client *client = core->i2c_dev;
-	struct device *dev = &client->dev;
+	struct device *dev = &core->client->dev;
 	int r = 0;
 
 	dev_dbg(dev, "%s\n", __func__);
@@ -155,17 +154,13 @@ static int snd_wl1273_fm_set_channel_number(struct wl1273_core *core,
 		goto out;
 
 	if (channel_number == 1 && core->mode == WL1273_MODE_RX)
-		r = wl1273_fm_write_cmd(core, WL1273_MOST_MODE_SET,
-					WL1273_RX_MONO);
+		r = core->write(core, WL1273_MOST_MODE_SET, WL1273_RX_MONO);
 	else if (channel_number == 1 && core->mode == WL1273_MODE_TX)
-		r = wl1273_fm_write_cmd(core, WL1273_MONO_SET,
-					WL1273_TX_MONO);
+		r = core->write(core, WL1273_MONO_SET, WL1273_TX_MONO);
 	else if (channel_number == 2 && core->mode == WL1273_MODE_RX)
-		r = wl1273_fm_write_cmd(core, WL1273_MOST_MODE_SET,
-					WL1273_RX_STEREO);
+		r = core->write(core, WL1273_MOST_MODE_SET, WL1273_RX_STEREO);
 	else if (channel_number == 2 && core->mode == WL1273_MODE_TX)
-		r = wl1273_fm_write_cmd(core, WL1273_MONO_SET,
-					WL1273_TX_STEREO);
+		r = core->write(core, WL1273_MONO_SET, WL1273_TX_STEREO);
 	else
 		r = -EINVAL;
 out:
@@ -238,7 +233,7 @@ static int snd_wl1273_fm_audio_put(struct snd_kcontrol *kcontrol,
 	if (wl1273->core->audio_mode == val)
 		return 0;
 
-	r = wl1273_fm_set_audio(wl1273->core, val);
+	r = wl1273->core->set_audio(wl1273->core, val);
 	if (r < 0)
 		return r;
 
@@ -273,8 +268,8 @@ static int snd_wl1273_fm_volume_put(struct snd_kcontrol *kcontrol,
 
 	dev_dbg(codec->dev, "%s: enter.\n", __func__);
 
-	r = wl1273_fm_set_volume(wl1273->core,
-				 ucontrol->value.integer.value[0]);
+	r = wl1273->core->set_volume(wl1273->core,
+				     ucontrol->value.integer.value[0]);
 	if (r)
 		return r;
 
diff --git a/sound/soc/codecs/wl1273.h b/sound/soc/codecs/wl1273.h
index 14ed027..43ec7e6 100644
--- a/sound/soc/codecs/wl1273.h
+++ b/sound/soc/codecs/wl1273.h
@@ -25,77 +25,6 @@
 #ifndef __WL1273_CODEC_H__
 #define __WL1273_CODEC_H__
 
-/* I2S protocol, left channel first, data width 16 bits */
-#define WL1273_PCM_DEF_MODE		0x00
-
-/* Rx */
-#define WL1273_AUDIO_ENABLE_I2S		(1 << 0)
-#define WL1273_AUDIO_ENABLE_ANALOG	(1 << 1)
-
-/* Tx */
-#define WL1273_AUDIO_IO_SET_ANALOG	0
-#define WL1273_AUDIO_IO_SET_I2S		1
-
-#define WL1273_POWER_SET_OFF		0
-#define WL1273_POWER_SET_FM		(1 << 0)
-#define WL1273_POWER_SET_RDS		(1 << 1)
-#define WL1273_POWER_SET_RETENTION	(1 << 4)
-
-#define WL1273_PUPD_SET_OFF		0x00
-#define WL1273_PUPD_SET_ON		0x01
-#define WL1273_PUPD_SET_RETENTION	0x10
-
-/* I2S mode */
-#define WL1273_IS2_WIDTH_32	0x0
-#define WL1273_IS2_WIDTH_40	0x1
-#define WL1273_IS2_WIDTH_22_23	0x2
-#define WL1273_IS2_WIDTH_23_22	0x3
-#define WL1273_IS2_WIDTH_48	0x4
-#define WL1273_IS2_WIDTH_50	0x5
-#define WL1273_IS2_WIDTH_60	0x6
-#define WL1273_IS2_WIDTH_64	0x7
-#define WL1273_IS2_WIDTH_80	0x8
-#define WL1273_IS2_WIDTH_96	0x9
-#define WL1273_IS2_WIDTH_128	0xa
-#define WL1273_IS2_WIDTH	0xf
-
-#define WL1273_IS2_FORMAT_STD	(0x0 << 4)
-#define WL1273_IS2_FORMAT_LEFT	(0x1 << 4)
-#define WL1273_IS2_FORMAT_RIGHT	(0x2 << 4)
-#define WL1273_IS2_FORMAT_USER	(0x3 << 4)
-
-#define WL1273_IS2_MASTER	(0x0 << 6)
-#define WL1273_IS2_SLAVEW	(0x1 << 6)
-
-#define WL1273_IS2_TRI_AFTER_SENDING	(0x0 << 7)
-#define WL1273_IS2_TRI_ALWAYS_ACTIVE	(0x1 << 7)
-
-#define WL1273_IS2_SDOWS_RR	(0x0 << 8)
-#define WL1273_IS2_SDOWS_RF	(0x1 << 8)
-#define WL1273_IS2_SDOWS_FR	(0x2 << 8)
-#define WL1273_IS2_SDOWS_FF	(0x3 << 8)
-
-#define WL1273_IS2_TRI_OPT	(0x0 << 10)
-#define WL1273_IS2_TRI_ALWAYS	(0x1 << 10)
-
-#define WL1273_IS2_RATE_48K	(0x0 << 12)
-#define WL1273_IS2_RATE_44_1K	(0x1 << 12)
-#define WL1273_IS2_RATE_32K	(0x2 << 12)
-#define WL1273_IS2_RATE_22_05K	(0x4 << 12)
-#define WL1273_IS2_RATE_16K	(0x5 << 12)
-#define WL1273_IS2_RATE_12K	(0x8 << 12)
-#define WL1273_IS2_RATE_11_025	(0x9 << 12)
-#define WL1273_IS2_RATE_8K	(0xa << 12)
-#define WL1273_IS2_RATE		(0xf << 12)
-
-#define WL1273_I2S_DEF_MODE	(WL1273_IS2_WIDTH_32 | \
-				 WL1273_IS2_FORMAT_STD | \
-				 WL1273_IS2_MASTER | \
-				 WL1273_IS2_TRI_AFTER_SENDING | \
-				 WL1273_IS2_SDOWS_RR | \
-				 WL1273_IS2_TRI_OPT | \
-				 WL1273_IS2_RATE_48K)
-
 int wl1273_get_format(struct snd_soc_codec *codec, unsigned int *fmt);
 
 #endif	/* End of __WL1273_CODEC_H__ */
-- 
1.6.1.3
