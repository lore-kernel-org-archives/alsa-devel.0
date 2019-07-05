From: Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH 0/4] Add HDMI jack support on RK3288
Date: Fri,  5 Jul 2019 12:26:19 +0800
Message-ID: <20190705042623.129541-1-cychiang@chromium.org>
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

Cheng-Yi Chiang (4):
  ASoC: hdmi-codec: Add an op to set callback function for plug event
  drm: bridge: dw-hdmi: Report connector status using callback
  ASoC: rockchip_max98090: Add dai_link for HDMI
  ASoC: rockchip_max98090: Add HDMI jack support

 .../gpu/drm/bridge/synopsys/dw-hdmi-audio.h   |   3 +
 .../drm/bridge/synopsys/dw-hdmi-i2s-audio.c   |  10 ++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |  32 ++++-
 include/sound/hdmi-codec.h                    |  16 +++
 sound/soc/codecs/hdmi-codec.c                 |  52 ++++++++
 sound/soc/rockchip/rockchip_max98090.c        | 112 ++++++++++++++----
 6 files changed, 201 insertions(+), 24 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog
