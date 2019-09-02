From: Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v2] drm: dw-hdmi-i2s: enable audio clock in audio_startup
Date: Mon,  2 Sep 2019 11:54:35 +0800
Message-ID: <20190902035435.44463-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com, airlied@linux.ie, daniel@ffwll.ch, kuninori.morimoto.gx@renesas.com, sam@ravnborg.org, cychiang@chromium.org, dianders@chromium.org, dgreid@chromium.org, tzungbi@chromium.org, zhengxing@rock-chips.com, cain.cai@rock-chips.com, eddie.cai@rock-chips.com, jeffy.chen@rock-chips.com, enric.balletbo@collabora.com, dri-devel@lists.freedesktop.org, Jonas Karlman <jonas@kwiboo.se>
List-Id: alsa-devel@alsa-project.org

In the designware databook, the sequence of enabling audio clock and
setting format is not clearly specified.
Currently, audio clock is enabled in the end of hw_param ops after
setting format.

On some monitors, there is a possibility that audio does not come out.
Fix this by enabling audio clock in audio_startup ops
before hw_param ops setting format.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
Tested-by: Douglas Anderson <dianders@chromium.org>
---
 Changes from v1:
 1. Move audio_startup to the front of audio_shutdown.
 2. Fix the indentation of audio_startup equal sign using tab.
 3. Rebase the patch on linux-next/master.
 4. Add Reviewed-by and Tested-by fields from dianders@chromium.org.
 5. Add Reviewed-by field from jonas@kwiboo.se.

 drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
index 1d15cf9b6821..34d8e837555f 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
@@ -109,6 +109,14 @@ static int dw_hdmi_i2s_hw_params(struct device *dev, void *data,
 	hdmi_write(audio, conf0, HDMI_AUD_CONF0);
 	hdmi_write(audio, conf1, HDMI_AUD_CONF1);
 
+	return 0;
+}
+
+static int dw_hdmi_i2s_audio_startup(struct device *dev, void *data)
+{
+	struct dw_hdmi_i2s_audio_data *audio = data;
+	struct dw_hdmi *hdmi = audio->hdmi;
+
 	dw_hdmi_audio_enable(hdmi);
 
 	return 0;
@@ -153,6 +161,7 @@ static int dw_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
 
 static struct hdmi_codec_ops dw_hdmi_i2s_ops = {
 	.hw_params	= dw_hdmi_i2s_hw_params,
+	.audio_startup  = dw_hdmi_i2s_audio_startup,
 	.audio_shutdown	= dw_hdmi_i2s_audio_shutdown,
 	.get_eld	= dw_hdmi_i2s_get_eld,
 	.get_dai_id	= dw_hdmi_i2s_get_dai_id,
-- 
2.23.0.187.g17f5b7556c-goog
