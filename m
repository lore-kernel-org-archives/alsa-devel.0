From: Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v4 0/5] Add HDMI jack support on RK3288
Date: Tue, 16 Jul 2019 19:57:20 +0800
Message-ID: <20190716115725.66558-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Russell King <rmk+kernel@armlinux.org.uk>, Andrzej Hajda <a.hajda@samsung.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, dgreid@chromium.org, tzungbi@chromium.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org

This patch series supports HDMI jack reporting on RK3288, which uses
DRM dw-hdmi driver and hdmi-codec codec driver.

The previous discussion about reporting jack status using hdmi-notifier
and drm_audio_component is at

https://lore.kernel.org/patchwork/patch/1083027/

The new approach is to use a callback mechanism that is
specific to hdmi-codec.

Changes from v3 to v4:
- hdmi-codec.h: Modify the hook_plugged_cb ops to take an additional argument,
  that is, the pointer to struct device for codec device.
- dw-hdmi-i2s-audio.c: Simplify the registration of callback so it uses
  dw_hdmi_set_plugged_cb exported by dw-hdmi.c.
- dw-hdmi.c: Simplify the flow to invoke callback since now dw_hdmi has a
  pointer to codec device as callback argument. There is no need to rely
  on driver data of other driver.
- dw-hdmi.c: Minor change for readability.
- synopsys/Kconfig: Fix the dependency of hdmi-codec in Kconfig.
- Fixed the incorrect FROMLIST title of patch 5/5.

Cheng-Yi Chiang (5):
  ASoC: hdmi-codec: Add an op to set callback function for plug event
  drm: bridge: dw-hdmi: Report connector status using callback
  drm: dw-hdmi-i2s: Use fixed id for codec device
  ASoC: rockchip_max98090: Add dai_link for HDMI
  ASoC: rockchip_max98090: Add HDMI jack support

 drivers/gpu/drm/bridge/synopsys/Kconfig       |   2 +-
 .../drm/bridge/synopsys/dw-hdmi-i2s-audio.c   |  13 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |  41 ++++++-
 include/drm/bridge/dw_hdmi.h                  |   4 +
 include/sound/hdmi-codec.h                    |  17 +++
 sound/soc/codecs/hdmi-codec.c                 |  46 +++++++
 sound/soc/rockchip/Kconfig                    |   3 +-
 sound/soc/rockchip/rk3288_hdmi_analog.c       |   3 +-
 sound/soc/rockchip/rockchip_max98090.c        | 116 ++++++++++++++----
 9 files changed, 217 insertions(+), 28 deletions(-)

-- 
2.22.0.510.g264f2c817a-goog
